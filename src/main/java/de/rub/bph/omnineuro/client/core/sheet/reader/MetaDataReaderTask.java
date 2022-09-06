package de.rub.bph.omnineuro.client.core.sheet.reader;

import de.rub.bph.omnineuro.client.imported.log.Log;
import org.apache.poi.ss.usermodel.Workbook;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.io.File;
import java.io.IOException;

public abstract class MetaDataReaderTask extends SheetReaderTask {
	
	public static final String JSON_EXTRACTION_ENTRY_DATA = "Data";
	public static final String JSON_EXTRACTION_ENTRY_DATA_COUNT = JSON_EXTRACTION_ENTRY_DATA + "Count";
	public static final String JSON_EXTRACTION_ENTRY_ERRORS = "Errors";
	public static final String JSON_EXTRACTION_ENTRY_ERRORS_COUNT = JSON_EXTRACTION_ENTRY_ERRORS + "Count";
	public static final String JSON_METADATA_TYPE_COMMENTS = "Comments";
	public static final String JSON_METADATA_TYPE_CONTROLS = "Controls";
	public static final String JSON_METADATA_TYPE_OPERATION_PROCEDURES = "OperationProcedures";
	public static final String JSON_METADATA_TYPE_PASSAGES = "Passages";
	public static final String JSON_METADATA_TYPE_PASSAGES_DATES = "Passages-Dates";
	public static final String JSON_METADATA_TYPE_PASSAGES_P = "Passages-P";
	public static final String JSON_METADATA_TYPE_REAGENTS = "Reagents";
	public static final String JSON_METADATA_TYPE_SOLVENTS = "Solvents";
	
	public MetaDataReaderTask(Workbook workbook, String name, File sourceFile) throws IOException {
		super(workbook, name, sourceFile);
		Log.i("Prepared Metadata sheet.");
	}
	
	public JSONObject readContinuous(int start) throws JSONException {
		return readContinuous(start, null);
	}
	
	public JSONObject readContinuous(int start, JSONObject data) throws JSONException {
		return readContinuous(start, new JSONObject(), "A");
	}
	
	public JSONObject readContinuous(int start, JSONObject data, String startKey) throws JSONException {
		return readRows(start, start + getContinuousRowEntries(startKey, start), data);
	}
	
	public JSONObject readRows(int start, int end) throws JSONException {
		return readRows(start, end, new JSONObject());
	}
	
	public JSONObject readRows(int start, int end, JSONObject input) throws JSONException {
		return readRows(start, end, input, "A", "B");
	}
	
	public JSONObject readRows(int start, int end, JSONObject input, String keyChar, String valueChar) throws JSONException {
		if (input == null) {
			return readRows(start, end, new JSONObject(), keyChar, valueChar);
		}
		
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
		
		for (int i = 0; i < end - start + 1; i++) {
			try {
				addRowPair(data, i + start, false, keyChar, valueChar);
			} catch (Exception e) {
				Log.e(e);
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
	
	public abstract JSONObject readMetaDataControls() throws JSONException;
	
	public abstract JSONObject readMetaDataReagents() throws JSONException;
	
	public abstract JSONObject readMetaDataOperationProcedures() throws JSONException;
	
	public abstract String readMetaDataComments() throws SheetReaderException;
	
	public abstract JSONObject readMetaDataGeneral() throws JSONException;
	
	public abstract JSONObject readPassages() throws JSONException;
	
	public abstract JSONObject readSolvent() throws JSONException;
	
	@Override
	public JSONObject readSheet() throws JSONException {
		JSONObject data = new JSONObject();
		
		try {
			data.put(JSON_METADATA_TYPE_CONTROLS, readMetaDataControls());
			data.put(JSON_METADATA_TYPE_REAGENTS, readMetaDataReagents());
			data.put(JSON_METADATA_TYPE_OPERATION_PROCEDURES, readMetaDataOperationProcedures());
			data.put(JSON_METADATA_TYPE_COMMENTS, readMetaDataComments());
			data.put(JSON_METADATA_TYPE_PASSAGES, readPassages());
			data.put(JSON_METADATA_TYPE_SOLVENTS, readSolvent());
		} catch (Exception e) {
			Log.e("Failed to generate secondary metadata JSON!", e);
		}
		data.put("General", readMetaDataGeneral());
		
		return data;
	}
	
}
