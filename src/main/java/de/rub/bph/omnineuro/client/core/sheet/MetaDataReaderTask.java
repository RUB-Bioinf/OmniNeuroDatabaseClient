package de.rub.bph.omnineuro.client.core.sheet;

import de.rub.bph.omnineuro.client.core.sheet.reader.SheetReaderTask;
import de.rub.bph.omnineuro.client.imported.filemanager.FileManager;
import de.rub.bph.omnineuro.client.imported.log.Log;
import org.apache.poi.ss.usermodel.Workbook;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.io.File;
import java.io.IOException;

public class MetaDataReaderTask extends SheetReaderTask {

	public static final String JSON_METADATA_TYPE_CONTROLS = "Controls";
	public static final String JSON_METADATA_TYPE_COMMENTS = "Comments";
	public static final String JSON_METADATA_TYPE_OPERATION_PROCEDURES = "OperationProcedures";
	public static final String JSON_METADATA_TYPE_REAGENTS = "Reagents";

	public static final String JSON_EXTRACTION_ENTRY_ERRORS = "Errors";
	public static final String JSON_EXTRACTION_ENTRY_ERRORS_COUNT = JSON_EXTRACTION_ENTRY_ERRORS + "Count";
	public static final String JSON_EXTRACTION_ENTRY_DATA = "Data";
	public static final String JSON_EXTRACTION_ENTRY_DATA_COUNT = JSON_EXTRACTION_ENTRY_DATA + "Count";

	public MetaDataReaderTask(Workbook workbook, String name, File sourceFile) throws IOException {
		super(workbook, name, sourceFile);
		Log.i("Prepared Metadata sheet.");
	}

	@Override
	public JSONObject readSheet() throws JSONException, SheetReaderException {
		FileManager fileManager = new FileManager();
		JSONObject data = new JSONObject();

		data.put("CompoundCount", getValueAt("B32"));

		try {
			data.put(JSON_METADATA_TYPE_CONTROLS, readRows(51, 53));
			data.put(JSON_METADATA_TYPE_REAGENTS, readRows(56, 77));
			data.put(JSON_METADATA_TYPE_OPERATION_PROCEDURES, readRows(78, 80));
			data.put(JSON_METADATA_TYPE_COMMENTS, getValueAt("A90"));
		} catch (Exception e) {
			Log.e("Failed to generate Control JSON!", e);
		}

		JSONObject metaData = readRows(1, 24);
		metaData = readRows(26, 30, metaData);
		data.put("General", metaData);

		return data;
	}

	public JSONObject readRows(int start, int end) throws JSONException {
		return readRows(start, end, new JSONObject());
	}

	public JSONObject readRows(int start, int end, JSONObject input) throws JSONException {
		JSONArray errors;
		JSONObject data;

		if (input.has(JSON_EXTRACTION_ENTRY_ERRORS)) {
			errors = input.getJSONArray(JSON_EXTRACTION_ENTRY_ERRORS);
		} else {
			errors = new JSONArray();
		}
		if (input.has(JSON_EXTRACTION_ENTRY_DATA)) {
			data = input.getJSONObject(JSON_EXTRACTION_ENTRY_DATA);
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

		data.remove("");

		input.put(JSON_EXTRACTION_ENTRY_DATA, data);
		input.put(JSON_EXTRACTION_ENTRY_ERRORS_COUNT, errors.length());
		input.put(JSON_EXTRACTION_ENTRY_DATA_COUNT, data.length());
		input.put(JSON_EXTRACTION_ENTRY_ERRORS, errors);
		return input;
	}

}
