package de.rub.bph.omnineuro.client.core.sheet.reader.versions.experiment;


import de.rub.bph.omnineuro.client.core.sheet.data.EndpointHeader;
import de.rub.bph.omnineuro.client.core.sheet.reader.ExperimentDataReaderTask;
import de.rub.bph.omnineuro.client.core.sheet.reader.versions.DataReaderCompat;
import de.rub.bph.omnineuro.client.imported.log.Log;
import de.rub.bph.omnineuro.client.util.TimestampLookupManager;
import org.apache.poi.ss.usermodel.Workbook;
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
		return readEndpointValuesContinuous(header);
	}

	@Override
	public ArrayList<EndpointHeader> readEndpointsHeaders() throws SheetReaderException, NumberFormatException {
		boolean amalgam;
		//Hint: Sometimes version 0 sheets may have the structure from version 1.
		//Indicator for this: These sheets have a timestamp entry in A2

		try {
			String v1Indicator = getValueAt("A2", false);
			amalgam = v1Indicator.equals("Timepoint");
		} catch (Throwable e) {
			amalgam = false;
		}

		if (amalgam) {
			Log.i(getFileName() + " is a version 0 and version 1 amalgam! Calculating amalgam headers.");
			try {
				return new DataReaderCompat(workbook, sourceFile, 1).getExperimentDataTask().readEndpointsHeaders();
			} catch (IOException e) {
				Log.e("Failed to generate header amalgam info for experiment: " + getFileName(), e);
			}
		}


		Log.i("Reading endpoints.");
		ArrayList<EndpointHeader> headers = new ArrayList<>();
		TimestampLookupManager timestampLookupManager = TimestampLookupManager.getInstance();

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

			if (!timestampLookupManager.hasEndpoint(endpointName)) {
				throw new SheetReaderException("Endpoint lookup error! The lookup table [Expected location: " + timestampLookupManager.getDataFile().getAbsolutePath() + "] does not contain information for endpoint '" + endpointName + "' in sheet " + getFileName() + "!");
			}

			EndpointHeader header = new EndpointHeader(timestampLookupManager.getName(endpointName), i, expectedValues, timestampLookupManager.getTimestamp(endpointName), 3);
			Log.i("Header added: " + header);
			headers.add(header);
		}

		return headers;
	}
}
