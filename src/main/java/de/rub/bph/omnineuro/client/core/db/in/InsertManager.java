package de.rub.bph.omnineuro.client.core.db.in;

import de.rub.bph.omnineuro.client.core.db.DBConnection;
import de.rub.bph.omnineuro.client.core.db.OmniNeuroQueryExecutor;
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
	private ArrayList<String> errors, errorsWoNaN;
	private File outDir;
	private ArrayList<String> triviaList;

	public InsertManager(File outDir, int threads, ArrayList<JSONObject> experiments) {
		this.threads = threads;
		this.experiments = experiments;
		this.outDir = outDir;

		service = Executors.newFixedThreadPool(threads);
		errors = new ArrayList<>();
		errorsWoNaN = new ArrayList<>(errors);
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
		triviaList = new ArrayList<>();

		int errorNaNCount = 0;
		int insertedResponsesCount = 0;

		for (JSONInserter inserter : inserters) {
			String name = inserter.getName();
			insertedResponsesCount += inserter.getInsertedResponses();
			insertedResponsesList.add(name + ";" + inserter.getInsertedResponses());

			if (inserter.hasError()) {
				errors.addAll(inserter.getErrors());
				errorsWoNaN.addAll(inserter.getErrorsWithoutNaN());
				containsErrorList.add(name + ";" + inserter.getErrors().size());
			}

			if (inserter.hasNaNs()) {
				containsNaNList.add(name + ";" + inserter.getNaNCount());
				errorNaNCount += inserter.getNaNCount();
			}
		}

		triviaList.add("Total errors discovered: " + errors.size());
		triviaList.add("Experiment files read: " + inserters.size());
		triviaList.add("Errors in experiments: " + getValueRatio(containsErrorList.size(), inserters.size()));
		triviaList.add("Errors in experiments (without NaNs): " + getValueRatio(errorsWoNaN.size(), inserters.size()));
		triviaList.add("Total NaNs discovered: " + errorNaNCount);
		triviaList.add("NaNs in experiments: " + getValueRatio(containsNaNList.size(), inserters.size()));
		triviaList.add("Total responses inserted: " + insertedResponsesCount);

		DBConnection connection = DBConnection.getDBConnection();
		OmniNeuroQueryExecutor executor = new OmniNeuroQueryExecutor(connection.getConnection());
		triviaList.add("Inserted into database: '" + connection.getIp() + "' on '" + connection.getDbName() + "' as '" + connection.getUserName() + "'.");
		try {
			triviaList.add("Total experiments count in the database: " + executor.selectRowCount("experiment", "id", false));
			triviaList.add("All response values in the database: " + executor.selectRowCount("response", "value", false));
			triviaList.add("Unique response values in the database: " + executor.selectRowCount("response", "value", true));
			triviaList.add("Unique concentration values in the database: " + executor.selectRowCount("concentration", "value", true));
		} catch (Throwable e) {
			Log.e(e);
			triviaList.add("Failed to collect import database dependant trivia. Error Code: " + e.getMessage());
		}

		for (String trivia : triviaList) {
			Log.i("Insertion trivia: " + trivia);
		}

		Log.i("Saving additional infos to: " + outDir.getAbsolutePath());
		try {
			manager.saveListFile(errors, new File(outDir, "errors.txt"), false);
			manager.saveListFile(errorsWoNaN, new File(outDir, "errors_woNaN.txt"), false);
			manager.saveListFile(containsErrorList, new File(outDir, "contains_errors.csv"), false);
			manager.saveListFile(containsNaNList, new File(outDir, "contains_nan.csv"), false);
			manager.saveListFile(insertedResponsesList, new File(outDir, "inserted_responses.csv"), false);
			manager.saveListFile(triviaList, new File(outDir, "trivia.txt"), false);
		} catch (IOException e) {
			Log.e("Failed to create insertion information file at: " + outDir.getAbsolutePath());
		}
	}

	private String getValueRatio(int a, int b) {
		double p = ((double) a / (double) b);
		int ratio = (int) (p * 100);
		return a + " out of " + b + " [" + ratio + "%]";
	}

	public ArrayList<String> getTrivia() {
		return new ArrayList<>(triviaList);
	}

	public ArrayList<String> getErrors() {
		return new ArrayList<>(errors);
	}

	public int getThreads() {
		return threads;
	}
}
