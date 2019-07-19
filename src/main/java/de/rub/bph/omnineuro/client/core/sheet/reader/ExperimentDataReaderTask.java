package de.rub.bph.omnineuro.client.core.sheet.reader;

import de.rub.bph.omnineuro.client.core.sheet.data.EndpointHeader;
import de.rub.bph.omnineuro.client.imported.log.Log;
import org.apache.poi.ss.usermodel.Workbook;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;

public abstract class ExperimentDataReaderTask extends SheetReaderTask {
	
	public static final String CELL_VALUE_ZERO = "0.0";
	public static final int WELL_INDEX_NOT_AVAILABLE = -1;
	private int sheetVersion;
	private String sheetName;
	
	public ExperimentDataReaderTask(Workbook workbook, String sheetName, File sourceFile, int sheetVersion) throws IOException {
		super(workbook, sheetName, sourceFile);
		this.sheetVersion = sheetVersion;
		this.sheetName = sheetName;
		Log.i("Finished setting up experiment Data reader. Version: " + getSheetVersion());
	}
	
	public JSONObject readEndpointValuesContinuous(EndpointHeader header, int wellColumnIndex) throws JSONException {
		JSONObject data = new JSONObject();
		
		String column = getExcelColumn(header.getColumnIndex());
		int expectedValues = header.getExpectedValues();
		int rowIndex = header.getRowIndex();
		Log.i("Reading endpoint data for header: '" + header.getName() + "' [" + header.getTimestamp() + "] in cell: " + column + rowIndex + " onwards. Sheet version: " + getSheetVersion());
		
		int replicate = 0;
		String lastConcentration = "";
		
		for (int i = rowIndex; i < rowIndex + expectedValues; i++) {
			String value;
			String cell = column + i;
			
			String currentConcentration;
			String currentConcentrationLocation = "A" + i;
			try {
				currentConcentration = getValueAt(currentConcentrationLocation, false);
			} catch (SheetReaderException ignored) {
				try {
					currentConcentration = getValueAt(currentConcentrationLocation, true);
				} catch (SheetReaderException e) {
					//TODO remove try catch and let this operation fail?
					currentConcentration = "#NV";
					Log.i("Failed to resolve a concentration at " + currentConcentrationLocation + ". Trailing error msg: " + ignored.getMessage(), e);
				}
			}
			
			if (!currentConcentration.equals(lastConcentration)) {
				lastConcentration = currentConcentration;
				replicate = 0;
			} else {
				replicate++;
			}
			
			try {
				value = getValueAt(cell, true);
			} catch (SheetReaderException e) {
				Log.e("Failed to read response in " + cell + " for experiment " + getFileName(), e);
				value = "NaN";
			}
			
			if (value.equals(CELL_VALUE_ZERO)) {
				Log.i("Warning. Cell " + cell + " is zero! Type: " + getCellType(cell));
				
				try {
					String stringValue = getValueAt(cell, false);
					Log.i("Testing for String value. If that's a blank string then it's confirmed that here's a missing value! Criteria: " + stringValue);
					if (stringValue.equals("")) {
						value = "NaN";
					}
				} catch (SheetReaderException e) {
					Log.i("Testing resulted in an error. I guess it's confirmed then.", e);
				}
			}
			
			JSONObject response = new JSONObject();
			response.put("value", value);
			
			String sourceWell = "<undefined>";
			if (wellColumnIndex != WELL_INDEX_NOT_AVAILABLE) {
				String wellColumn = getExcelColumn(wellColumnIndex);
				String wellCell = wellColumn + i;
				Log.i("Reading sourceWell here: " + wellCell);
				try {
					sourceWell = getValueAt(wellCell);
					response.put("well", sourceWell);
				} catch (SheetReaderException e) {
					e.printStackTrace();
				}
			}
			
			Log.i("Reading cell " + cell + ": " + value + " [ExcelType: " + getCellType(cell) + "]. Conc: " + currentConcentration + ", Replicate: " + replicate + ", Well: " + sourceWell);
			
			if (!data.has(currentConcentration)) data.put(currentConcentration, new JSONArray());
			JSONArray array = data.getJSONArray(currentConcentration);
			array.put(response);
			data.put(currentConcentration, array);
		}
		
		return data;
	}
	
	public abstract JSONObject readEndpointValues(EndpointHeader header) throws JSONException;
	
	public abstract ArrayList<EndpointHeader> readEndpointsHeaders() throws SheetReaderException, NumberFormatException;
	
	@Override
	public JSONObject readSheet() throws JSONException, SheetReaderException {
		JSONObject data = new JSONObject();
		
		ArrayList<EndpointHeader> endpointHeaders = readEndpointsHeaders();
		Log.i("Endpoint count: " + endpointHeaders.size());
		Log.i("Endpoints: " + endpointHeaders);
		
		JSONObject endpoints = new JSONObject();
		for (EndpointHeader header : endpointHeaders) {
			String name = header.getName();
			
			String detectionMethod = header.getDetectionMethod();
			if (detectionMethod == null) {
				detectionMethod = "Unknown";
			}
			
			JSONObject endpoint = new JSONObject();
			endpoint.put("timestamp", header.getTimestamp());
			endpoint.put("detectionMethod", detectionMethod);
			endpoint.put("responses", readEndpointValues(header));
			
			endpoints.put(name, endpoint);
		}
		
		data.put("Endpoints", endpoints);
		return data;
	}
	
	public String getSheetName() {
		return sheetName;
	}
	
	public int getSheetVersion() {
		return sheetVersion;
	}
}
