package de.rub.bph.omnineuro.client.core.sheet.reader;

import de.rub.bph.omnineuro.client.core.sheet.reader.versions.MetaDataReaderCompat;
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
		Workbook workbook = null;
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
		Log.i("Interpretation complete.");

		// SHEET VERSION

		try {
			sheetVersion = new SheetVersionReader(workbook).readVersion();
		} catch (IOException e) {
			Log.e("IO Exception during check for sheet version!", e);
			return;
		}

		// META DATA

		Log.i("Starting up meta data instructions!");
		FileManager fileManager = new FileManager();
		MetaDataReaderTask metaDataReader;
		MetaDataReaderCompat metaDataReaderCompat = new MetaDataReaderCompat(workbook, sourceFile, getSheetVersion());
		try {
			metaDataReader = metaDataReaderCompat.getTask();
		} catch (IOException e) {
			Log.e(e);
			return;
		}

		// EXPERIMENT DATA

		Log.i("Starting up experiment data instructions!");
		ExperimentDataReaderTask experimentDataReader;
		try {
			experimentDataReader = new ExperimentDataReaderTask(workbook, EXCEL_SHEET_SUBNAME_EXPERIMENT_DATA, sourceFile, getSheetVersion());
		} catch (IOException e) {
			Log.e(e);
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

		File outFile = new File(outDir, sourceFile.getName().replace(".xlsx", "") + ".json");
		Log.i("Writing file to: " + outFile.getAbsolutePath());
		try {
			fileManager.writeFile(outFile, experiment.toString(JSON_ROW_SPACES));
		} catch (IOException | JSONException e) {
			e.printStackTrace();
		}
		Log.v("Experiment data read: " + experiment.toString());

		bufferedExperiment = experiment;
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
