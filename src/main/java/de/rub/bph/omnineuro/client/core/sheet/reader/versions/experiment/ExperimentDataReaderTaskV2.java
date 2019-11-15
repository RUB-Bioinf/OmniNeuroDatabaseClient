package de.rub.bph.omnineuro.client.core.sheet.reader.versions.experiment;

import de.rub.bph.omnineuro.client.core.sheet.data.EndpointHeader;
import de.rub.bph.omnineuro.client.core.sheet.reader.ExperimentDataReaderTask;
import org.apache.poi.ss.usermodel.Workbook;
import org.json.JSONException;
import org.json.JSONObject;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;

public class ExperimentDataReaderTaskV2 extends ExperimentDataReaderTask {
	
	public ExperimentDataReaderTaskV2(Workbook workbook, String sheetName, File sourceFile) throws IOException {
		super(workbook, sheetName, sourceFile, 2);
	}
	
	@Override
	public JSONObject readEndpointValues(EndpointHeader header) throws JSONException {
		return readEndpointValuesContinuous(header, 1);
	}
	
	@Override
	public ArrayList<EndpointHeader> readEndpointsHeaders() throws SheetReaderException, NumberFormatException {
		ExperimentDataReaderTaskV1 helperTask = null;
		try {
			helperTask = new ExperimentDataReaderTaskV1(workbook, getSheetName(), getSourceFile());
		} catch (IOException e) {
			e.printStackTrace();
			return new ArrayList<>();
		}
		return helperTask.readEndpointsHeaders(2, true);
	}
}
