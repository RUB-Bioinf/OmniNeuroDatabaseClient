package de.rub.bph.omnineuro.client.imported.log;

import de.rub.bph.omnineuro.client.Client;
import de.rub.bph.omnineuro.client.core.db.QueryExecutor;
import de.rub.bph.omnineuro.client.imported.filemanager.FileManager;

import java.io.*;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

import static de.rub.bph.omnineuro.client.imported.log.Log.TIME_PATTERN;

public abstract class Log {
	
	public static final int DATE_DETAIL = -1;
	public static final String TIME_PATTERN = "hh:mm:ss"; //TODO: Your own date pattern here
	public static final String VERSION = "VERSION: " + Client.VERSION; //TODO: Your own version here
	private static ExecutorService logger;
	private static LogLevel myLevel;
	
	public static void i(String text, Throwable throwable) {
		log(LogLevel.INFORMATION, text, throwable);
	}
	
	public static void i(String text) {
		i(text, null);
	}
	
	public static void v(String text, Throwable throwable) {
		log(LogLevel.VERBOSE, text, throwable);
	}
	
	public static void v(String text) {
		v(text, null);
	}
	
	public static void w(String text, Throwable throwable) {
		log(LogLevel.WARNING, text, throwable);
	}
	
	public static void w(String text) {
		w(text, null);
	}
	
	public static void e(String text, Throwable throwable) {
		log(LogLevel.ERROR, text, throwable);
	}
	
	public static void e(Throwable throwable) {
		e("An Exception occurred: " + throwable.getClass().getSimpleName() + ": '" + throwable.getMessage() + "'.", throwable);
	}
	
	public static void e(String text) {
		e(text, null);
	}
	
	public static boolean isLoggable(LogLevel level) {
		if (myLevel == null) {
			myLevel = LogLevel.INFORMATION;
		}
		
		return myLevel.level <= level.level;
	}
	
	public static void log(LogLevel level, String text, Throwable throwable) {
		StackTraceElement[] stack = Thread.currentThread().getStackTrace();
		StackTraceElement element = null;
		String classPath = "";
		
		for (StackTraceElement e : stack) {
			String n = e.getClassName();
			if (!n.equals(Log.class.getName()) && !n.equals(Thread.class.getName())) {
				element = e;
				break;
			}
		}
		
		if (element != null) {
			classPath = " - " + element.getClassName() + "#" + element.getMethodName() + "():" + element.getLineNumber();
		}
		
		text = "V" + VERSION + " +" + level.getSign() + classPath + " - " + text;
		if (throwable != null) {
			text = text + "\n" + throwable.getClass().getName() + ": '" + throwable.getMessage() + "'";
			if (throwable instanceof SQLException) {
				String cachedQuery = QueryExecutor.getLastCachedQuery();
				text = text + "\nLast known SQL query: '" + cachedQuery + "'";
			}
			
			for (StackTraceElement trace : throwable.getStackTrace()) {
				text = text + "\n\t" + trace.toString();
			}
		}
		
		if (logger == null) {
			logger = Executors.newSingleThreadExecutor();
		}
		logger.submit(new LogWriter(text, getLogFile()));
		
		if (isLoggable(level)) {
			text = LogWriter.getTimeTag() + text;
			if (level.level >= 2)
				System.err.println(text);
			else
				System.out.println(text);
		}
	}
	
	public static LogLevel parseLogLevel(int i) {
		Object[] enums = LogLevel.values();
		for (Object o : enums) {
			LogLevel level = (LogLevel) o;
			
			if (level.level == i) {
				return level;
			}
		}
		return null;
	}
	
	public static File getLogFile() {
		File dir = new FileManager().getLogDir();
		String dateTag = new SimpleDateFormat("MM-dd").format(new Date());
		return new File(dir, dateTag + "-log.txt");
	}
	
	public static LogLevel getLogLevel() {
		return myLevel;
	}
	
	public static void setLogLevel(LogLevel level) {
		if (myLevel != null && myLevel.level == level.level) {
			return;
		}
		LogLevel oldLoglevel = myLevel;
		myLevel = level;
		
		v("LogLevel has changed: " + oldLoglevel + " -> " + level);
	}
	
	public enum LogLevel {
		VERBOSE(0, 'v', "Verbose"), INFORMATION(1, 'i', "Information"), WARNING(2, 'w', "Warning"), ERROR(3, 'e',
				"Error");
		
		private final int level;
		private final char sign;
		private final String name;
		
		LogLevel(int level, char sign, String name) {
			this.level = level;
			this.sign = sign;
			this.name = name;
		}
		
		@Override
		public String toString() {
			return getName();
		}
		
		public int getLevel() {
			return level;
		}
		
		public String getName() {
			return name;
		}
		
		public char getSign() {
			return sign;
		}
	}
	
}

class LogWriter implements Runnable {
	
	private String text;
	private File file;
	
	public LogWriter(String text, File file) {
		super();
		this.text = text;
		this.file = file;
	}
	
	@Override
	public void run() {
		if (text == null) {
			text = "<null>";
		}
		text = getTimeTag() + text;
		
		if (!file.exists()) {
			try {
				file.getParentFile().mkdirs();
				file.createNewFile();
			} catch (IOException e) {
				Log.e("Failed to write '" + text + "' into logfile " + file.getAbsolutePath()
						+ ". The log file could not be created because '" + e.getMessage() + "'", e);
				return;
			}
		}
		
		try (FileWriter fw = new FileWriter(file.getAbsolutePath(), true);
		     BufferedWriter bw = new BufferedWriter(fw);
		     PrintWriter out = new PrintWriter(bw)) {
			out.println(text);
		} catch (IOException e) {
			System.err.println("Failed to write '" + text + "' into logfile " + file.getAbsolutePath() + " because '"
					+ e.getMessage() + "'");
		}
	}
	
	public static synchronized String getTimeTag() {
		String n = new SimpleDateFormat(TIME_PATTERN).format(new Date());
		return "[" + n + "] ";
	}
}