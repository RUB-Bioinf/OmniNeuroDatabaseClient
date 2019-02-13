package de.rub.bph.omnineuro.client.core.sheet;

import de.rub.bph.omnineuro.client.core.sheet.reader.SheetReader;
import de.rub.bph.omnineuro.client.imported.log.Log;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;

public class ReaderManager extends SheetReader {

	public ReaderManager(File source, String name) throws IOException {
		super(source);
		Log.i("Preparing workbook: " + source.getAbsolutePath() + ", page: '" + name + "'.");

		FileInputStream excelFile = new FileInputStream(source);
		Workbook workbook = new XSSFWorkbook(excelFile);
		sheet = workbook.getSheet(name);
		workbook.close();

		setSheet(sheet);
		Log.i("Workbook prepared without problems.");
	}

	public JSONObject readSheet() throws JSONException, SheetReaderException {
		JSONObject data = new JSONObject();

		data.put("CompoundCount", getValueAt("B32"));

		try {
			data.put("Controls", readRows(51, 53));
			data.put("Reagents", readRows(56, 77));
			data.put("OperationProcedures", readRows(81, 88));
			data.put("Comments", getValueAt("A90"));
		} catch (Exception e) {
			Log.e("Failed to generate Control JSON!", e);
		}

		JSONObject metaData = readRows(1, 24);
		metaData = readRows(26, 30, metaData);
		data.put("Values", metaData);

		return data;
	}


	public JSONObject readRows(int start, int end) throws JSONException {
		return readRows(start, end, new JSONObject());
	}

	public JSONObject readRows(int start, int end, JSONObject input) throws JSONException {
		JSONArray errors;
		JSONObject data;

		if (input.has("Errors")) {
			errors = input.getJSONArray("Errors");
		} else {
			errors = new JSONArray();
		}
		if (input.has("Data")) {
			data = input.getJSONObject("Data");
		} else {
			data = new JSONObject();
		}

		for (int i = start; i < end + 1; i++) {
			try {
				addRowPair(data, i);
			} catch (Exception e) {
				errors.put(e.getMessage());
			}
		}

		input.put("Data", data);
		input.put("ErrorCount", errors.length());
		input.put("DataCount", data.length());
		input.put("Errors", errors);
		return input;
	}


}
