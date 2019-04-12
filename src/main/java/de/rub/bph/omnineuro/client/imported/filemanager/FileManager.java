package de.rub.bph.omnineuro.client.imported.filemanager;


import de.rub.bph.omnineuro.client.imported.log.Log;

import java.awt.*;
import java.io.*;
import java.text.SimpleDateFormat;
import java.util.*;

public class FileManager {

	public static final String DIRNAME_BACKUP = "backups";
	public static final String DIRNAME_LOG = "log";
	public static final String JSON_DIR = "out";
	public static final String DIRNAME_CACHE = "cahce";
	public static final String DIRNAME_SETTINGS = "config";

	public static final String FILENAME_TIMESTAMP_FORMATTER = "yyyy_MM_dd-hh_mm_ss";
	public static final String FILENAME_BACKUP_EXTENSION = ".json";
	private static final String NO_MEDIA = ".nomedia";

	private static final String FILENAME_LOG_BASE_NAME = "log_";
	private static final String FILENAME_BACKUP_BASE_NAME = "backup_";

	public FileManager() {
	}

	public String readFile(File file) throws IOException {
		StringBuilder builder = new StringBuilder();
		BufferedReader br = new BufferedReader(new FileReader(file));
		for (String line; (line = br.readLine()) != null; ) {
			builder.append(line);
		}
		return builder.toString();
	}

	public File getExternalDir() {
		String s = new File("").getAbsolutePath();

		File f = new File(s);
		if (!f.exists())
			createDirectory(f);

		return f;
	}

	public void writeFile(File file, String text) throws IOException {
		File parent = file.getParentFile();
		if (parent != null && !parent.exists()) parent.mkdirs();

		BufferedWriter writer = new BufferedWriter(new FileWriter(file));
		writer.write(text);
		writer.close();
	}

	public void appendFile(File file, String text) throws IOException {
		File parent = file.getParentFile();
		if (!parent.exists()) parent.mkdirs();

		FileWriter fw = new FileWriter(file, true);
		BufferedWriter bw = new BufferedWriter(fw);
		PrintWriter out = new PrintWriter(bw);
		out.println(text);
	}

	public File getGenericExternalDir(String name) {
		File f = new File(getExternalDir(), name);
		createDirectory(f);
		return f;
	}

	public File getCacheDir() {
		return getGenericExternalDir(DIRNAME_CACHE);
	}

	public File getJSONOutDir() {
		return getGenericExternalDir(JSON_DIR);
	}

	public File getBackupDir() {
		return getGenericExternalDir(DIRNAME_BACKUP);
	}

	public File getLogDir() {
		return getGenericExternalDir(DIRNAME_LOG);
	}

	public File getSettingsDir() {
		return getGenericExternalDir(DIRNAME_SETTINGS);
	}

	public String getDynamicNoteBackupFilename() {
		SimpleDateFormat sdf = new SimpleDateFormat(FILENAME_TIMESTAMP_FORMATTER);
		String date = sdf.format(new Date());
		return FILENAME_BACKUP_BASE_NAME + date + FILENAME_BACKUP_EXTENSION;
	}

	public boolean browseFolder(File file) {
		Desktop d = Desktop.getDesktop();
		if (file.isFile()) file = file.getParentFile();
		try {
			d.open(file);
		} catch (IOException e) {
			e.printStackTrace();
			Log.e(e);
			return false;
		}
		return true;
	}

	public void saveListFile(Collection<String> list, File outFile) throws IOException {
		saveListFile(list, outFile, false);
	}

	public void saveListFile(Collection<String> list, File outFile, boolean sort) throws IOException {
		ArrayList<String> outList = new ArrayList<>(list);
		if (sort) Collections.sort(outList);

		StringBuilder builder = new StringBuilder();
		for (String s : outList) {
			builder.append(s);
			builder.append("\n");
		}
		writeFile(outFile, builder.toString().trim());
	}

	public boolean createDirectory(File f) {
		boolean works;
		if (!f.exists()) {
			works = f.mkdirs();
		} else {
			works = true;
		}
		return works;
	}

	@Deprecated
	public boolean createNoMediaFile(File parent) {
		if (!parent.exists() || !parent.isDirectory()) return false;

		File f = new File(parent, NO_MEDIA);
		if (f.exists()) return true;

		boolean created;
		try {
			created = f.createNewFile();
		} catch (IOException e) {
			e.printStackTrace();
			Log.e("Wanted to create 'NomediaFile' in " + parent.getAbsolutePath() + " but it failed!", e);
			return false;
		}
		Log.i("Creating a .nomedia file at: " + f.getAbsolutePath() + " resulted in a success? -> " + created);

		return created;
	}

	public boolean deleteDir(File dir) {
		if (dir != null && dir.isDirectory()) {
			String[] children = dir.list();
			for (String aChildren : children) {
				boolean success = deleteDir(new File(dir, aChildren));
				if (!success) {
					return false;
				}
			}
			return dir.delete();
		} else
			return dir != null && dir.isFile() && dir.delete();
	}

	public boolean isEmptyDirectory(File file) {
		if (!file.isDirectory()) return false;

		File[] files = file.listFiles();
		return files == null || file.length() > 0;
	}

	public String getLogFileName() {
		Date d = new Date();
		Calendar cal = Calendar.getInstance();
		cal.setTime(d);
		String year = String.valueOf(cal.get(Calendar.YEAR));
		String month = String.valueOf(cal.get(Calendar.MONTH) + 1);
		String day = String.valueOf(cal.get(Calendar.DAY_OF_MONTH));

		if (month.length() == 1) {
			month = "0" + month;
		}
		if (day.length() == 1) {
			day = "0" + day;
		}

		return FILENAME_LOG_BASE_NAME + year + "_" + month + "_" + day + ".log";
	}
}