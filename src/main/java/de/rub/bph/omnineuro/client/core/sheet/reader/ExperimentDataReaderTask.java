package de.rub.bph.omnineuro.client.core.sheet.reader;

import de.rub.bph.omnineuro.client.core.sheet.data.EndpointHeader;
import de.rub.bph.omnineuro.client.imported.log.Log;
import org.apache.poi.ss.usermodel.Workbook;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.io.IOException;
import java.util.ArrayList;

public class ExperimentDataReaderTask extends SheetReaderTask {

	private JSONObject concentrations;

	public ExperimentDataReaderTask(Workbook workbook, String sheetName, JSONObject concentrations) throws IOException {
		super(workbook, sheetName);
		this.concentrations = concentrations;
		Log.i("Finished setting up experiment Data reader.");
	}

	@Override
	public JSONObject readSheet() throws JSONException, SheetReaderException {
		JSONObject data = new JSONObject();

		ArrayList<EndpointHeader> endpointHeaders = readEndpoints();
		Log.i("Endpoint count: " + endpointHeaders.size());
		Log.i("Endpoints: " + endpointHeaders);

		JSONObject endpoints = new JSONObject();
		for (EndpointHeader header : endpointHeaders) {
			String name = header.getName();
			JSONObject values = readEndpointValues(header);
			endpoints.put(name, values);
		}

		data.put("Endpoints", endpoints);
		return data;
	}

	public JSONObject readEndpointValues(EndpointHeader header) throws SheetReaderException, JSONException {
		JSONObject data = new JSONObject();

		String column = getExcelColumn(header.getColumnIndex());
		int expectedValues = header.getExpectedValues();
		Log.i("Reading endpoint data for header: '" + header.getName() + "' in col: " + column);

		int replicate = 0;
		String lastConcentration = "";

		for (int i = 3; i < 3 + expectedValues; i++) {
			String value;
			String cell = column + i;

			String currentConcentration;
			try {
				currentConcentration = getValueAt("A" + i, false);
				;
			} catch (SheetReaderException e) {
				//TODO remove try catch and let this operation fail!
				currentConcentration = "#NV";
			}

			if (!currentConcentration.equals(lastConcentration)) {
				lastConcentration = currentConcentration;
				replicate = 0;
			} else {
				replicate++;
			}

			try {
				value = getValueAt(cell);
			} catch (SheetReaderException e) {
				e.printStackTrace();
				//TODO handle exception
				value = "NaN";
			}
			Log.i("Reading cell " + cell + ": " + value + ". Conc: " + currentConcentration + ", Replicate: " + replicate);

			if (!data.has(currentConcentration)) data.put(currentConcentration, new JSONArray());
			JSONArray array = data.getJSONArray(currentConcentration);
			array.put(value);
			data.put(currentConcentration, array);
		}

		return data;
	}

	public ArrayList<EndpointHeader> readEndpoints() throws SheetReaderException, NumberFormatException {
		Log.i("Reading endpoints.");
		ArrayList<EndpointHeader> headers = new ArrayList<>();

		int i = 0;
		while (true) {
			i++;
			String cellName = getExcelColumn(i) + "1";

			String endpointName;
			try {
				endpointName = getValueAt(cellName, false);
			} catch (SheetReaderException e) {
				Log.e("Failed to retrieve value in cell: " + cellName);
				continue;
			}

			if (endpointName.equals("") || endpointName.equals("NaN")) {
				Log.i("Last entry found in: " + cellName + ". Entry read: '" + endpointName + "'.");
				break;
			}

			cellName = getExcelColumn(i) + 2;
			int expectedValues = (int) Double.parseDouble(getValueAt(cellName));

			EndpointHeader header = new EndpointHeader(endpointName, i, expectedValues);
			Log.i("Header added: " + header);
			headers.add(header);
		}

		return headers;
	}

}
