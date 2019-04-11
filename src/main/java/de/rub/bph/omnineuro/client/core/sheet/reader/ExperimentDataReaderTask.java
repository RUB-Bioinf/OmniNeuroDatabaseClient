package de.rub.bph.omnineuro.client.core.sheet.reader;

import de.rub.bph.omnineuro.client.core.sheet.data.EndpointHeader;
import de.rub.bph.omnineuro.client.imported.log.Log;
import org.apache.poi.ss.usermodel.Workbook;
import org.json.JSONException;
import org.json.JSONObject;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;

public abstract class ExperimentDataReaderTask extends SheetReaderTask {

	public static final String CELL_VALUE_ZERO = "0.0";
	private int sheetVersion;

	public ExperimentDataReaderTask(Workbook workbook, String sheetName, File sourceFile, int sheetVersion) throws IOException {
		super(workbook, sheetName, sourceFile);
		this.sheetVersion = sheetVersion;
		Log.i("Finished setting up experiment Data reader. Version: " + getSheetVersion());
	}

	@Override
	public JSONObject readSheet() throws JSONException, SheetReaderException {
		JSONObject data = new JSONObject();

		ArrayList<EndpointHeader> endpointHeaders = readEndpointsHeaders();
		Log.i("Endpoint count: " + endpointHeaders.size());
		Log.i("Endpoints: " + endpointHeaders);

		JSONObject endpoints = new JSONObject();
		for (EndpointHeader header : endpointHeaders) {
			String name = header.getName();

			JSONObject endpoint = new JSONObject();
			endpoint.put("timestamp", header.getTimestamp());
			endpoint.put("responses", readEndpointValues(header));

			endpoints.put(name, endpoint);
		}

		data.put("Endpoints", endpoints);
		return data;
	}

	public abstract JSONObject readEndpointValues(EndpointHeader header) throws JSONException;

	public abstract ArrayList<EndpointHeader> readEndpointsHeaders() throws SheetReaderException, NumberFormatException;

	public int getSheetVersion() {
		return sheetVersion;
	}
}
