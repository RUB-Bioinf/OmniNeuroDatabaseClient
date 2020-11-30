package de.rub.bph.omnineuro.client.core.db.in;

import de.rub.bph.omnineuro.client.Client;
import de.rub.bph.omnineuro.client.core.AXESSheetReaderManager;
import de.rub.bph.omnineuro.client.core.ExperimentReaderStatistics;
import de.rub.bph.omnineuro.client.core.db.DBConnection;
import de.rub.bph.omnineuro.client.core.db.OmniNeuroQueryExecutor;
import de.rub.bph.omnineuro.client.core.sheet.reader.versions.meta.ExternalMetadata;
import de.rub.bph.omnineuro.client.imported.filemanager.FileManager;
import de.rub.bph.omnineuro.client.imported.log.Log;
import de.rub.bph.omnineuro.client.util.TimeUtils;
import de.rub.bph.omnineuro.client.util.concurrent.TimedRunnable;
import org.json.JSONObject;

import java.awt.*;
import java.io.File;
import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

import static de.rub.bph.omnineuro.client.core.AXESSheetReaderManager.CSV_FILE_EXTENSION;
import static de.rub.bph.omnineuro.client.core.AXESSheetReaderManager.EXCEL_FILE_EXTENSION;
import static de.rub.bph.omnineuro.client.ui.OmniFrame.OUT_DIR_NAME_INSERTER;
import static de.rub.bph.omnineuro.client.ui.OmniFrame.OUT_DIR_NAME_STATISTICS;

public class InsertManager {
	
	private int threads;
	private ExecutorService service;
	private ArrayList<String> errors, errorsWoNaN;
	private File outDir, inDir;
	private ArrayList<String> triviaList;
	private int methodIndex;
	private Component parent;
	private boolean attemptUnblinding;
	
	public InsertManager(File inDir, int threads, int methodIndex, boolean attemptUnblinding, Component parent) {
		this(inDir, threads, methodIndex, attemptUnblinding, parent, OUT_DIR_NAME_INSERTER);
	}
	
	public InsertManager(File inDir, int threads, int methodIndex, boolean attemptUnblinding, Component parent, String outDirName) {
		this.threads = threads;
		this.parent = parent;
		this.inDir = inDir;
		this.outDir = new File(inDir, outDirName);
		this.methodIndex = methodIndex;
		this.attemptUnblinding = attemptUnblinding;
		
		service = Executors.newFixedThreadPool(threads);
		errors = new ArrayList<>();
		errorsWoNaN = new ArrayList<>(errors);
	}
	
	public ArrayList<DBInserter> fixEPAErrors() {
		String[] csvFileExtension = new String[]{EXCEL_FILE_EXTENSION};
		AXESSheetReaderManager readerManager = new AXESSheetReaderManager(inDir, threads, csvFileExtension);
		ArrayList<File> sheets = readerManager.discoverFiles();
		ArrayList<DBInserter> inserters = new ArrayList<>();
		Log.i("Discovered " + sheets.size() + " EFSA fix sheets.");
		
		for (File f : sheets) {
			inserters.add(new EFSAConcentrationFixer(f));
		}
		return inserters;
	}
	
	public ArrayList<DBInserter> insertOutlierSheets() {
		String[] csvFileExtension = new String[]{CSV_FILE_EXTENSION};
		AXESSheetReaderManager readerManager = new AXESSheetReaderManager(inDir, threads, csvFileExtension);
		ArrayList<File> sheets = readerManager.discoverFiles();
		ArrayList<DBInserter> inserters = new ArrayList<>();
		Log.i("Discovered " + sheets.size() + " outlier sheets.");
		
		Log.i("Preprocessing. Marking all experiments as plausible.");
		DBConnection connection = DBConnection.getDBConnection();
		OmniNeuroQueryExecutor executor = new OmniNeuroQueryExecutor(connection.getConnection());
		try {
			long confirmedPlausibleID = executor.getIDViaName("outlier_type", "Confirmed Plausible");
			long uncheckedOutlier = executor.getIDViaName("outlier_type", "Unchecked");
			
			String query = "UPDATE response set outlier_type_id = " + confirmedPlausibleID + " WHERE response.outlier_type_id = " + uncheckedOutlier + ";";
			executor.execute(query);
		} catch (SQLException e) {
			Log.e(e);
			errors.add("Fatal error: " + e.getMessage());
			return inserters;
		}
		
		for (File f : sheets) {
			inserters.add(new OutlierInserter(f));
		}
		return inserters;
	}
	
	public ArrayList<DBInserter> insertKonstanzSheets() {
		AXESSheetReaderManager readerManager = new AXESSheetReaderManager(inDir, threads);
		ArrayList<File> sheets = readerManager.discoverFiles();
		Log.i("Discovered " + sheets.size() + " Konstanz source sheets.");
		
		ArrayList<DBInserter> inserters = new ArrayList<>();
		for (File f : sheets) {
			inserters.add(new KonstanzInserter(f, attemptUnblinding));
		}
		return inserters;
	}
	
	public ArrayList<DBInserter> insertAXESsheets() {
		ExternalMetadata metadata = ExternalMetadata.getInstance();
		
		for (int i = 0; i < 10; i++)
			try {
				metadata.init();
			} catch (Throwable e) {
				Client.showErrorMessage("Failed to read external meta data sheet.!", parent, e);
				return null;
			}
		
		ArrayList<JSONObject> experiments = new ArrayList<>();
		if (inDir.exists() && inDir.isDirectory()) {
			experiments = readAXESSheets(inDir, threads);
		} else {
			Client.showErrorMessage("The specified path does not exist or is invalid!", parent);
			return null;
		}
		
		if (experiments == null || experiments.isEmpty()) {
			Client.showErrorMessage("No experiments located!", parent);
			return null;
		}
		
		ArrayList<DBInserter> inserters = new ArrayList<>();
		for (JSONObject experiment : experiments) {
			AXESInserter inserter = new AXESInserter(experiment, attemptUnblinding);
			inserters.add(inserter);
		}
		return inserters;
	}
	
	public ArrayList<JSONObject> readAXESSheets(File sourceDir, int cores) {
		AXESSheetReaderManager readerManager = new AXESSheetReaderManager(sourceDir, cores);
		ArrayList<JSONObject> readExperiments = readerManager.startReading();
		errors.addAll(readerManager.getErrors());
		
		if (readExperiments == null || readExperiments.size() == 0) {
			Client.showInfoMessage("No Experiments were found!", parent);
			return null;
		}
		
		File statisticsDir = new File(sourceDir, OUT_DIR_NAME_STATISTICS);
		Log.i("Saving statistics to: " + statisticsDir.getAbsolutePath());
		
		ExperimentReaderStatistics statistics = new ExperimentReaderStatistics(readExperiments, statisticsDir);
		try {
			statistics.calculateAll();
		} catch (Exception e) {
			Log.e(e);
			Client.showErrorMessage("Failed to calculate statistics, due to: " + e.getMessage(), parent);
		}
		
		return readExperiments;
	}
	
	public void insert() {
		Log.i("Adding insertion tasks!");
		
		ArrayList<DBInserter> inserters = null;
		switch (methodIndex) {
			case 0:
				inserters = insertAXESsheets();
				break;
			case 1:
				inserters = insertKonstanzSheets();
				break;
			case 2:
				inserters = insertOutlierSheets();
				break;
			case 3:
				inserters = fixEPAErrors();
				break;
			default:
				Client.showErrorMessage("Invalid insertion method selected.", parent);
				throw new IllegalStateException("Unknown insert method index: " + methodIndex);
		}
		
		if (inserters != null) {
			for (DBInserter inserter : inserters) {
				service.submit(inserter);
			}
		} else {
			return;
		}
		
		service.shutdown();
		Log.i("Done adding. Starting to wait.");
		
		while (!service.isTerminated()) {
			try {
				Thread.sleep(100);
			} catch (InterruptedException e) {
				e.printStackTrace();
			}
			
			ArrayList<TimedRunnable> timedRunnableList = new ArrayList<>();
			int finishedCount = 0;
			for (DBInserter in : inserters) {
				if (in.isFinished()) finishedCount++;
				TimedRunnable tr = in;
				timedRunnableList.add(tr);
			}
			
			long etaTime = TimedRunnable.calculateETA(timedRunnableList, inserters.size() - finishedCount, getThreads() / -3);
			Date etaDate = new Date(new Date().getTime() + etaTime);
			String etaText = new TimeUtils().formatAbsolute(etaDate, 3, 0);
			
			Log.i("Still waiting for inserter threads to finish: " + finishedCount + " / " + inserters.size() + ". ETA: " + etaText);
		}
		Log.i("Done waiting.");
		
		//Posprocessing statistics and errors
		ArrayList<String> containsErrorList = new ArrayList<>();
		ArrayList<String> containsNaNList = new ArrayList<>();
		ArrayList<String> insertedResponsesList = new ArrayList<>();
		ArrayList<String> insertedBlindedCompounds = new ArrayList<>();
		ArrayList<String> konstanzCasList = new ArrayList<>();
		triviaList = new ArrayList<>();
		
		int errorNaNCount = 0;
		int insertedResponsesCount = 0;
		konstanzCasList.add("Source;Sample ID;Plate ID;Read CAS;Existed in the DB;Database Compound;Database Abbreviation;Same DB Name");
		
		for (DBInserter inserter : inserters) {
			String name = inserter.getName();
			insertedResponsesCount += inserter.getInsertedResponsesCount();
			insertedResponsesList.add(name + ";" + inserter.getInsertedResponsesCount());
			
			if (inserter.hasError()) {
				errors.addAll(inserter.getErrors());
				errorsWoNaN.addAll(inserter.getErrorsWithoutNaN());
				containsErrorList.add(name + ";" + inserter.getErrors().size());
			}
			
			if (inserter.hasNaNs()) {
				containsNaNList.add(name + ";" + inserter.getNaNCount());
				errorNaNCount += inserter.getNaNCount();
			}
			
			insertedBlindedCompounds.addAll(inserter.getBlindingInfo());
			
			if (inserter instanceof KonstanzInserter) {
				KonstanzInserter ki = (KonstanzInserter) inserter;
				
				ArrayList<String> temp = new ArrayList<>(ki.getCASRows());
				Collections.sort(temp);
				konstanzCasList.addAll(temp);
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
		
		FileManager manager = new FileManager();
		Log.i("Saving additional infos to: " + outDir.getAbsolutePath());
		try {
			manager.saveListFile(errors, new File(outDir, "errors.txt"), false);
			manager.saveListFile(errorsWoNaN, new File(outDir, "errors_woNaN.txt"), false);
			manager.saveListFile(containsErrorList, new File(outDir, "contains_errors.csv"), false);
			manager.saveListFile(containsNaNList, new File(outDir, "contains_nan.csv"), false);
			manager.saveListFile(insertedResponsesList, new File(outDir, "inserted_responses.csv"), false);
			manager.saveListFile(triviaList, new File(outDir, "trivia.txt"), false);
			manager.saveListFile(konstanzCasList, new File(outDir, "konstanz_cas.csv"), false);
			
			manager.saveListFile(insertedBlindedCompounds, new File(outDir, "blindedCompounds.txt"), true, false);
		} catch (IOException e) {
			Log.e("Failed to create insertion information file at: " + outDir.getAbsolutePath());
		}
	}
	
	private String getValueRatio(int a, int b) {
		double p = ((double) a / (double) b);
		int ratio = (int) (p * 100);
		return a + " out of " + b + " [" + ratio + "%]";
	}
	
	public ArrayList<String> getErrors() {
		return new ArrayList<>(errors);
	}
	
	public int getThreads() {
		return threads;
	}
	
	public ArrayList<String> getTrivia() {
		return new ArrayList<>(triviaList);
	}
}
