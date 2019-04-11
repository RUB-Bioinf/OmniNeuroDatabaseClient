package de.rub.bph.omnineuro.client.core.sheet.reader.versions.experiment;


import de.rub.bph.omnineuro.client.core.sheet.data.EndpointHeader;
import de.rub.bph.omnineuro.client.core.sheet.reader.ExperimentDataReaderTask;
import de.rub.bph.omnineuro.client.imported.log.Log;
import org.apache.poi.ss.usermodel.Workbook;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;

public class ExperimentDataReaderTaskV0 extends ExperimentDataReaderTask {

	public ExperimentDataReaderTaskV0(Workbook workbook, String sheetName, File sourceFile) throws IOException {
		super(workbook, sheetName, sourceFile, 0);
	}

	@Override
	public JSONObject readEndpointValues(EndpointHeader header) throws JSONException {
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
				Log.e(e);
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

			Log.i("Reading cell " + cell + ": " + value + " [ExcelType: " + getCellType(cell) + "]. Conc: " + currentConcentration + ", Replicate: " + replicate);

			if (!data.has(currentConcentration)) data.put(currentConcentration, new JSONArray());
			JSONArray array = data.getJSONArray(currentConcentration);
			array.put(value);
			data.put(currentConcentration, array);
		}

		return data;
	}

	@Override
	public ArrayList<EndpointHeader> readEndpointsHeaders() throws SheetReaderException, NumberFormatException {
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

			EndpointHeader header = new EndpointHeader(endpointName, i, expectedValues, 24);
			Log.i("Header added: " + header);
			headers.add(header);
		}

		return headers;
	}
}
