package de.rub.bph.omnineuro.client.core;

import de.rub.bph.omnineuro.client.core.sheet.reader.AXESSheetReader;
import de.rub.bph.omnineuro.client.imported.filemanager.FileManager;
import de.rub.bph.omnineuro.client.imported.log.Log;
import de.rub.bph.omnineuro.client.util.concurrent.ConcurrentExecutionManager;
import org.json.JSONException;
import org.json.JSONObject;

import javax.swing.filechooser.FileNameExtensionFilter;
import java.io.File;
import java.io.IOException;
import java.util.ArrayList;

import static de.rub.bph.omnineuro.client.core.sheet.reader.AXESSheetReader.JSON_ROW_SPACES;

public class AXESSheetReaderManager extends ConcurrentExecutionManager {
	
	public static final String CSV_FILE_EXTENSION = "csv";
	public static final String EXCEL_FILE_EXTENSION = "xlsx";
	public static final String[] DEFAULT_ALLOWED_EXTENSIONS = new String[]{EXCEL_FILE_EXTENSION};
	public static final String JSON_FILE_OUTDIRNAME = "json";
	private File sourceDir;
	private FileNameExtensionFilter filter;
	
	private ArrayList<File> discoveredAXESSheetsList;
	private ArrayList<File> JSONAXESSheetsList;
	private ArrayList<String> errorList;
	
	public AXESSheetReaderManager(File sourceDir, int threads) {
		this(sourceDir, threads, DEFAULT_ALLOWED_EXTENSIONS);
	}
	
	public AXESSheetReaderManager(File sourceDir, int threads, String[] allowedExtensions) {
		super(threads);
		this.sourceDir = sourceDir;
		setFilter(new FileNameExtensionFilter("Allowed files", allowedExtensions));
		
		discoveredAXESSheetsList = new ArrayList<>();
		JSONAXESSheetsList = new ArrayList<>();
		errorList = new ArrayList<>();
	}
	
	public ArrayList<JSONObject> startReading() {
		Log.i("Starting to discover valid experiment files.");
		ArrayList<File> files = discoverFiles();
		ArrayList<JSONObject> experiments = new ArrayList<>();
		FileManager fileManager = new FileManager();
		
		int count = files.size();
		Log.i("Finished discovering. Files found: " + count);
		
		if (count == 0) {
			Log.w("No files were found! Aborting!");
			return experiments;
		}
		
		ArrayList<AXESSheetReader> readers = new ArrayList<>();
		File outDir = new File(sourceDir, JSON_FILE_OUTDIRNAME);
		outDir.mkdirs();
		
		for (int i = 0; i < files.size(); i++) {
			File f = files.get(i);
			Log.i("[" + (i + 1) + "/" + count + "] Setting up an executor service for " + f.getName());
			AXESSheetReader reader = new AXESSheetReader(f, outDir);
			discoveredAXESSheetsList.add(f);
			
			readers.add(reader);
			submitTask(reader);
		}
		
		waitForTasks();
		
		JSONObject combinedExperiments = new JSONObject();
		File combinedExperimentsFile = new File(outDir, "combinedExperiments.json");
		for (AXESSheetReader reader : readers) {
			if (reader.hasBufferedExperiment()) {
				JSONObject experiment = reader.getBufferedExperiment();
				experiments.add(experiment);
				JSONAXESSheetsList.add(reader.getSourceFile());
				
				try {
					combinedExperiments.put(reader.getExperimentJSONFile().getName(), experiment);
				} catch (JSONException e) {
					Log.e("Failed to add experiment for " + reader.getSourceFile().getName() + " to combined JSON!", e);
					addError(reader.getSourceFile().getName() + " == FATAL ERROR == while preparing sheet for DB: " + e.getClass().getName());
				}
			} else {
				Log.e("Experiment " + reader.getSourceFile() + " failed to extract experiment!!");
				addError(reader.getSourceFile().getName() + " == FATAL ERROR == while reading sheet.");
			}
		}
		
		// Writing combined experiments JSON
		try {
			fileManager.writeFile(combinedExperimentsFile, combinedExperiments.toString(JSON_ROW_SPACES));
		} catch (IOException | JSONException e) {
			Log.e("Failed to write combined experiments file at " + combinedExperimentsFile.getAbsolutePath(), e);
		}
		
		// Writing error file
		File errorOutFile = new File(outDir, "fatal_errors.txt");
		ArrayList<String> tempList = new ArrayList<>();
		tempList.add("AXES Sheets: " + discoveredAXESSheetsList.size() + ". JSON Files: " + JSONAXESSheetsList.size() + "\n");
		tempList.addAll(errorList);
		try {
			fileManager.saveListFile(tempList, errorOutFile);
		} catch (IOException e) {
			Log.e("Failed to write JSON error experiments file at " + errorOutFile.getAbsolutePath(), e);
		}
		
		Log.i("Files read: " + readers.size() + ". Experiments extracted: " + experiments.size());
		return experiments;
	}
	
	public ArrayList<File> discoverFiles() {
		return discoverFiles(sourceDir);
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
	
	@Override
	protected void onWaitUpdate() {
	
	}
	
	private void addError(String error) {
		Log.e(error);
		errorList.add("[ReaderError] " + error);
	}
	
	public ArrayList<File> getDiscoveredAXESSheetsList() {
		return new ArrayList<>(discoveredAXESSheetsList);
	}
	
	public ArrayList<String> getErrors() {
		return new ArrayList<>(errorList);
	}
	
	public FileNameExtensionFilter getFilter() {
		return filter;
	}
	
	public void setFilter(FileNameExtensionFilter filter) {
		this.filter = filter;
	}
	
	public ArrayList<File> getJSONAXESSheetsList() {
		return new ArrayList<>(JSONAXESSheetsList);
	}
	
}
