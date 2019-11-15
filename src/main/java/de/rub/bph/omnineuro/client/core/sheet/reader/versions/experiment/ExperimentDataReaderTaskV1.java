package de.rub.bph.omnineuro.client.core.sheet.reader.versions.experiment;

import de.rub.bph.omnineuro.client.core.sheet.data.EndpointHeader;
import de.rub.bph.omnineuro.client.core.sheet.reader.ExperimentDataReaderTask;
import de.rub.bph.omnineuro.client.imported.log.Log;
import de.rub.bph.omnineuro.client.util.TimestampLookupManager;
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
	
	public ArrayList<EndpointHeader> readEndpointsHeaders(int startIndex, boolean hasDetectionMethod) throws SheetReaderException, NumberFormatException {
		Log.i("Reading endpoint headers.");
		ArrayList<EndpointHeader> headers = new ArrayList<>();
		TimestampLookupManager lookupManager = TimestampLookupManager.getInstance();
		
		int i = startIndex;
		while (true) {
			String cellName = getExcelColumn(i) + "1";
			String endpointName;
			
			try {
				endpointName = getValueAt(cellName, false);
			} catch (SheetReaderException e) {
				Log.e("Failed to retrieve value in cell: " + cellName);
				continue;
			}
			
			if (lookupManager.hasEndpoint(endpointName)) {
				String lookupHeaderName = lookupManager.getName(endpointName);
				Log.w("Amalgam sheet endpoint name detected. Interpreting '" + endpointName + "' as: " + lookupHeaderName + ". Timestamp: " + lookupManager.getTimestamp(endpointName));
				endpointName = lookupHeaderName;
			}
			
			if (endpointName.equals("") || endpointName.equals("NaN")) {
				Log.i("Last entry found in: " + cellName + ". Entry read: '" + endpointName + "'.");
				break;
			}
			
			int detectionMethodModifier = 0;
			String detectionMethod = null;
			if (hasDetectionMethod) {
				detectionMethodModifier = 1;
				cellName = getExcelColumn(i) + 2;
				detectionMethod = getValueAt(cellName);
			}
			
			cellName = getExcelColumn(i) + (3 + detectionMethodModifier);
			int expectedValues = (int) Double.parseDouble(getValueAt(cellName));
			
			cellName = getExcelColumn(i) + (2 + detectionMethodModifier);
			int timestamp = (int) Double.parseDouble(getValueAt(cellName));
			
			EndpointHeader header = new EndpointHeader(endpointName, i, expectedValues, timestamp, 4 + detectionMethodModifier, detectionMethod);
			Log.i("Header added: " + header);
			headers.add(header);
			
			i++;
		}
		
		return headers;
	}
	
	@Override
	public JSONObject readEndpointValues(EndpointHeader header) throws JSONException {
		return readEndpointValuesContinuous(header, WELL_INDEX_NOT_AVAILABLE);
	}
	
	@Override
	public ArrayList<EndpointHeader> readEndpointsHeaders() throws SheetReaderException, NumberFormatException {
		return readEndpointsHeaders(1, false);
	}
}
