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

		//Posprocessing statistics and errors
		ArrayList<String> containsErrorList = new ArrayList<>();
		ArrayList<String> containsNaNList = new ArrayList<>();
		ArrayList<String> insertedResponsesList = new ArrayList<>();
		ArrayList<String> triviaList = new ArrayList<>();

		int errorNaNCount = 0;
		int insertedResponsesCount = 0;

		for (JSONInserter inserter : inserters) {
			String name = inserter.getName();
			insertedResponsesCount += inserter.getInsertedResponses();
			insertedResponsesList.add(name + ";" + inserter.getInsertedResponses());

			if (inserter.hasError()) {
				errors.addAll(inserter.getErrors());
				containsErrorList.add(name + ";" + inserter.getErrors().size());
			}

			if (inserter.hasNaNs()) {
				containsNaNList.add(name + ";" + inserter.getNaNCount());
				errorNaNCount += inserter.getNaNCount();
			}
		}

		triviaList.add("Total errors discovered: " + errors.size());
		triviaList.add("Errors in experiments: " + containsErrorList.size() + " out of " + inserters.size());
		triviaList.add("Total NaNs discovered: " + errorNaNCount);
		triviaList.add("NaNs in experiments: " + containsNaNList.size() + " out of " + inserters.size());
		triviaList.add("Errors discovered: " + errors.size());
		triviaList.add("Total responses inserted: " + insertedResponsesCount);

		for (String trivia : triviaList) {
			Log.i("Insertion trivia: " + trivia);
		}

		Log.i("Saving additional infos to: " + outDir.getAbsolutePath());
		try {
			manager.saveListFile(errors, new File(outDir, "errors.txt"), false);
			manager.saveListFile(containsErrorList, new File(outDir, "contains_errors.csv"), false);
			manager.saveListFile(containsNaNList, new File(outDir, "contains_nan.csv"), false);
			manager.saveListFile(insertedResponsesList, new File(outDir, "inserted_responses.csv"), false);
			manager.saveListFile(triviaList, new File(outDir, "trivia.txt"), false);
		} catch (IOException e) {
			Log.e("Failed to create insertion information file at: " + outDir.getAbsolutePath());
		}
	}

	public ArrayList<String> getErrors() {
		return new ArrayList<>(errors);
	}

	public int getThreads() {
		return threads;
	}
}
