package de.rub.bph.omnineuro.client.core;

import de.rub.bph.omnineuro.client.core.sheet.reader.SheetReader;
import de.rub.bph.omnineuro.client.imported.log.Log;
import org.json.JSONObject;

import javax.swing.filechooser.FileNameExtensionFilter;
import java.io.File;
import java.util.ArrayList;
import java.util.Date;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

public class SheetReaderManager {

	public static final String EXCEL_FILE_EXTENSION = "xlsx";
	public static final String[] DEFAULT_ALLOWED_EXTENSIONS = new String[]{EXCEL_FILE_EXTENSION};

	private File sourceDir;
	private ExecutorService service;
	private FileNameExtensionFilter filter;

	public SheetReaderManager(File sourceDir, int threads) {
		this.sourceDir = sourceDir;
		service = Executors.newFixedThreadPool(threads);
		setFilter(new FileNameExtensionFilter("Excel Sheets", DEFAULT_ALLOWED_EXTENSIONS));
	}

	public FileNameExtensionFilter getFilter() {
		return filter;
	}

	public void setFilter(FileNameExtensionFilter filter) {
		this.filter = filter;
	}

	public void startReading() {
		Log.i("Starting to discover valid experiment files.");
		ArrayList<File> files = discoverFiles(sourceDir);
		int count = files.size();
		Log.i("Finished discovering. Files found: " + count);

		if (count == 0) {
			Log.w("No files were found! Aborting!");
			return;
		}

		ArrayList<SheetReader> readers = new ArrayList<>();
		for (int i = 0; i < files.size(); i++) {
			File f = files.get(i);
			Log.i("[" + (i + 1) + "/" + count + "] Setting up an executor service for " + f.getName());
			SheetReader reader = new SheetReader(f);

			readers.add(reader);
			service.submit(reader);
		}

		waitForTasks();
		ArrayList<JSONObject> experiments = new ArrayList<>();
		for (SheetReader reader:readers){
			if (reader.hasBufferedExperiment()){
				experiments.add(reader.getBufferedExperiment());
			}
		}
		Log.i("Files read: "+readers.size()+". Experiments extracted: "+experiments.size());
	}

	private void waitForTasks() {
		Log.i("Waiting for tasks to finish!");
		long start = new Date().getTime();
		service.shutdown();
		while (!service.isTerminated()) {
			try {
				Thread.sleep(1000);
			} catch (InterruptedException e) {
				Log.e(e);
			}
			Log.i("Still waiting...");
		}
		long diff = new Date().getTime() - start;
		Log.i("Finished waiting! Execution time: " + diff + "ms [" + (int) (diff * .001) + "s].");
	}

	public ArrayList<File> discoverFiles(File currentDir) {
		Log.i("Discovering files in dir: " + currentDir.getAbsolutePath());
		ArrayList<File> list = new ArrayList<>();
		File[] files = currentDir.listFiles();

		if (files == null) {
			Log.w("Failed to retrieve child files in the directory!");
			return list;
		}

		Log.i("Discovered " + files.length + " potential file(s).");
		for (File f : files) {
			if (f.isDirectory()) {
				Log.i(f.getAbsolutePath() + " is a directory. Let's see what is in there!.");
				ArrayList<File> subFiles = discoverFiles(f);
				Log.i("Jumping up an interation. Adding the " + subFiles.size() + " sub file(s) to the current stack of " + list.size());
				list.addAll(subFiles);
				continue;
			}

			if (getFilter().accept(f)) {
				list.add(f);
				Log.i("[" + list.size() + "] Found an experiment file: " + f.getAbsolutePath());
			} else {
				Log.i("Filter rejected this file: " + f.getAbsolutePath());
			}
		}
		return list;
	}

}
