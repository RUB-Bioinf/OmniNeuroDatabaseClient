package de.rub.bph.omnineuro.client.core.sheet.reader.versions.experiment;

import de.rub.bph.omnineuro.client.core.sheet.data.EndpointHeader;
import de.rub.bph.omnineuro.client.core.sheet.reader.ExperimentDataReaderTask;
import de.rub.bph.omnineuro.client.imported.log.Log;
import org.apache.poi.ss.usermodel.Workbook;
import org.json.JSONException;
import org.json.JSONObject;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;

public class ExperimentDataReaderTaskV1 extends ExperimentDataReaderTask {

	public ExperimentDataReaderTaskV1(Workbook workbook, String sheetName, File sourceFile) throws IOException {
		super(workbook, sheetName, sourceFile, 1);
	}

	@Override
	public JSONObject readEndpointValues(EndpointHeader header) throws JSONException {
		return readEndpointValuesContinuous(header);
	}

	@Override
	public ArrayList<EndpointHeader> readEndpointsHeaders() throws SheetReaderException, NumberFormatException {
		Log.i("Reading endpoint headers.");
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

			cellName = getExcelColumn(i) + 3;
			int expectedValues = (int) Double.parseDouble(getValueAt(cellName));

			cellName = getExcelColumn(i) + 2;
			int timestamp = (int) Double.parseDouble(getValueAt(cellName));

			EndpointHeader header = new EndpointHeader(endpointName, i, expectedValues, timestamp, 4);
			Log.i("Header added: " + header);
			headers.add(header);
		}

		return headers;
	}
}
