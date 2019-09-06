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

public class SheetReader extends JSONOperator implements Runnable {

	public static final int JSON_ROW_SPACES = 4;
	public static final String JSON_ENTRY_METADATA = "MetaData";
	public static final String JSON_ENTRY_SOURCEFILE = "SourceFile";
	public static final String EXCEL_SHEET_SUBNAME_METADATA = "exp. protocol";
	public static final String EXCEL_SHEET_SUBNAME_EXPERIMENT_DATA = "DB import";
	public static final String EXCEL_SHEET_SUBNAME_SHEET_VERSION = "SheetVersion";
	private static final String JSON_ENTRY_EXPERIMENTDATA = "ExperimentData";

	private File sourceFile;
	private File outDir;
	private File experimentJSONFile;
	private JSONObject bufferedExperiment;
	private int sheetVersion;

	public SheetReader(File sourceFile, File outDir) {
		this.sourceFile = sourceFile;
		this.outDir = outDir;
		sheetVersion = -1;
	}

	public File getSourceFile() {
		return sourceFile;
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
			SheetVersionReader reader = new SheetVersionReader(workbook);
			sheetVersion = reader.readVersion();
		} catch (IOException e) {
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
			Log.e("Failed to generate a meta data reader task for this experiment: "+getSourceFile().getName()+". Version: "+sheetVersion,e);
			return;
		}

		// EXPERIMENT DATA

		Log.i("Starting up experiment data instructions!");
		ExperimentDataReaderTask experimentDataReader;
		try {
			experimentDataReader = dataReaderCompat.getExperimentDataTask();
		} catch (Throwable e) {
			Log.e("Failed to generate an experiment data reader task for this experiment: "+getSourceFile().getName()+". Version: "+sheetVersion,e);
			return;
		}

		try {
			experiment.put(JSON_ENTRY_METADATA, metaDataReader.readSheet());
			experiment.put(JSON_ENTRY_EXPERIMENTDATA, experimentDataReader.readSheet());
			experiment.put(JSON_ENTRY_SOURCEFILE, getSourceFile().getAbsolutePath());
			experiment.put(EXCEL_SHEET_SUBNAME_SHEET_VERSION, getSheetVersion());
		} catch (Exception e) {
			e.printStackTrace();
			Log.e("FATAL ERROR! Failed to resolve meta data!", e);
			return;
		}

		experimentJSONFile = new File(outDir, sourceFile.getName().replace(".xlsx", "") + ".json");
		Log.i("Writing file to: " + experimentJSONFile.getAbsolutePath());
		try {
			fileManager.writeFile(experimentJSONFile, experiment.toString(JSON_ROW_SPACES));
		} catch (IOException | JSONException e) {
			e.printStackTrace();
		}
		Log.v("Experiment data read: " + experiment.toString());

		bufferedExperiment = experiment;
	}
	
	public File getExperimentJSONFile() {
		return experimentJSONFile;
	}
	
	public boolean hasExperimentJSONFile(){
		return getExperimentJSONFile() != null;
	}
	
	public int getSheetVersion() {
		return sheetVersion;
	}

	public JSONObject getBufferedExperiment() {
		return bufferedExperiment;
	}

	public boolean hasBufferedExperiment() {
		return getBufferedExperiment() != null;
	}
}
