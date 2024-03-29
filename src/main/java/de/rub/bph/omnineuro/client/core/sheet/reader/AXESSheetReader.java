package de.rub.bph.omnineuro.client.core.sheet.reader;

import de.rub.bph.omnineuro.client.core.sheet.reader.versions.DataReaderCompat;
import de.rub.bph.omnineuro.client.imported.filemanager.FileManager;
import de.rub.bph.omnineuro.client.imported.log.Log;
import de.rub.bph.omnineuro.client.util.JSONOperator;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.json.JSONException;
import org.json.JSONObject;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;

public class AXESSheetReader extends JSONOperator implements Runnable {
	
	public static final String EXCEL_SHEET_SUBNAME_EXPERIMENT_DATA = "DB import";
	public static final String EXCEL_SHEET_SUBNAME_METADATA = "exp. protocol";
	public static final String EXCEL_SHEET_SUBNAME_SHEET_VERSION = "SheetVersion";
	public static final String JSON_ENTRY_METADATA = "MetaData";
	public static final String JSON_ENTRY_SOURCEFILE = "SourceFile";
	public static final int JSON_ROW_SPACES = 4;
	private static final String JSON_ENTRY_EXPERIMENTDATA = "ExperimentData";
	
	private File sourceFile;
	private File outDir;
	private File experimentJSONFile;
	private JSONObject bufferedExperiment;
	private String sheetVersion;
	
	public AXESSheetReader(File sourceFile, File outDir) {
		this.sourceFile = sourceFile;
		this.outDir = outDir;
		sheetVersion = null;
	}
	
	@Override
	public void run() {
		Workbook workbook;
		FileManager fileManager = new FileManager();
		JSONObject experiment = new JSONObject();
		
		Log.i("Reading Excel file: " + sourceFile.getAbsolutePath());
		try {
			FileInputStream excelFile = new FileInputStream(sourceFile);
			Log.i("File read. Interpreting it now.");
			workbook = new XSSFWorkbook(excelFile);
		} catch (IOException e) {
			Log.e(e);
			return;
		}
		Log.i("Interpretation complete. Sheet name: '" + workbook.getSheetName(workbook.getActiveSheetIndex()) + "'");
		
		// SHEET VERSION & COMPAT
		
		try {
			SheetVersionReader reader = new SheetVersionReader(workbook, sourceFile);
			sheetVersion = reader.readVersion();
		} catch (Exception e) {
			Log.e("IO Exception during check for sheet version!", e);
			return;
		}
		DataReaderCompat dataReaderCompat = new DataReaderCompat(workbook, sourceFile, getSheetVersion());
		
		// META DATA
		
		Log.i("Starting up meta data instructions!");
		MetaDataReaderTask metaDataReader;
		try {
			metaDataReader = dataReaderCompat.getMetaDataTask();
		} catch (Throwable e) {
			Log.e("Failed to generate a meta data reader task for this experiment: " + getSourceFile().getName() + ". Version: " + sheetVersion, e);
			return;
		}
		
		// EXPERIMENT DATA
		
		Log.i("Starting up experiment data instructions!");
		ExperimentDataReaderTask experimentDataReader;
		try {
			experimentDataReader = dataReaderCompat.getExperimentDataTask();
		} catch (Throwable e) {
			Log.e("Failed to generate an experiment data reader task for this experiment: " + getSourceFile().getName() + ". Version: " + sheetVersion, e);
			return;
		}
		
		String progressLabel = null;
		try {
			progressLabel = "meta data";
			experiment.put(JSON_ENTRY_METADATA, metaDataReader.readSheet());
			
			progressLabel = "experiment data";
			experiment.put(JSON_ENTRY_EXPERIMENTDATA, experimentDataReader.readSheet());
			
			progressLabel = "local path";
			experiment.put(JSON_ENTRY_SOURCEFILE, getSourceFile().getAbsolutePath());
			
			progressLabel = "sheet version";
			experiment.put(EXCEL_SHEET_SUBNAME_SHEET_VERSION, getSheetVersion());
		} catch (Throwable e) {
			e.printStackTrace();
			Log.e("FATAL ERROR! Failed to resolve '" + progressLabel + "' for " + getSourceFile() + "!", e);
			return;
		}
		
		experimentJSONFile = new File(outDir, sourceFile.getName().replace(".xlsx", "") + ".json");
		Log.i("Writing file to: " + experimentJSONFile.getAbsolutePath());
		try {
			fileManager.writeFile(experimentJSONFile, experiment.toString(JSON_ROW_SPACES));
		} catch (IOException | JSONException e) {
			e.printStackTrace();
			Log.e("Failed to output a JSON File for: " + sourceFile.getAbsolutePath(), e);
		}
		Log.v("Experiment data read: " + experiment.toString());
		
		bufferedExperiment = experiment;
	}
	
	public boolean hasBufferedExperiment() {
		return getBufferedExperiment() != null;
	}
	
	public JSONObject getBufferedExperiment() {
		return bufferedExperiment;
	}
	
	public File getExperimentJSONFile() {
		return experimentJSONFile;
	}
	
	public String getSheetVersion() {
		return sheetVersion;
	}
	
	public File getSourceFile() {
		return sourceFile;
	}
}
