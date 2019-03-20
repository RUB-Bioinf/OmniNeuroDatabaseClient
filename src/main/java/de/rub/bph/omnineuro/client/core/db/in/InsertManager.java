package de.rub.bph.omnineuro.client.core.db.in;

import de.rub.bph.omnineuro.client.imported.filemanager.FileManager;
import de.rub.bph.omnineuro.client.imported.log.Log;
import org.json.JSONObject;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

public class InsertManager {

	private int threads;
	private ExecutorService service;
	private ArrayList<JSONObject> experiments;
	private ArrayList<String> errors;
	private File outDir;

	public InsertManager(File outDir, int threads, ArrayList<JSONObject> experiments) {
		this.threads = threads;
		this.experiments = experiments;
		this.outDir = outDir;

		service = Executors.newFixedThreadPool(threads);
		errors = new ArrayList<>();
	}

	public void insert() {
		Log.i("Adding insertion tasks!");

		ArrayList<JSONInserter> inserters = new ArrayList<>();
		FileManager manager = new FileManager();

		for (JSONObject experiment : experiments) {
			JSONInserter inserter = new JSONInserter(experiment);
			inserters.add(inserter);
			service.submit(inserter);
		}
		service.shutdown();
		Log.i("Done adding. Starting to wait.");

		while (!service.isTerminated()) {
			try {
				Thread.sleep(100);
			} catch (InterruptedException e) {
				e.printStackTrace();
			}
			Log.i("Still waiting for threads to finish...");
		}
		Log.i("Done waiting.");

		for (JSONInserter inserter : inserters) {
			errors.addAll(inserter.getErrors());
		}
		Log.i("Overall, there were " + errors.size() + " error(s) while inserting!");

		File errorFile = new File(outDir, "errors.txt");
		Log.i("Saving errors to: "+errorFile.getAbsolutePath());
		try {
			manager.saveListFile(errors, errorFile, true);
		} catch (IOException e) {
			Log.e("Failed to create insertion error list at: " + errorFile.getAbsolutePath());
		}
	}

	public ArrayList<String> getErrors() {
		return new ArrayList<>(errors);
	}

	public int getThreads() {
		return threads;
	}
}
