package de.rub.bph.omnineuro.client.core.sheet.reader;

import de.rub.bph.omnineuro.client.imported.log.Log;
import org.apache.poi.ss.usermodel.Workbook;
import org.json.JSONException;
import org.json.JSONObject;

import java.io.IOException;

public class ExperimentDataReader extends SheetReader {

	private JSONObject concentrations;

	public ExperimentDataReader(Workbook workbook, String sheetName, JSONObject concentrations) throws IOException {
		super(workbook, sheetName);
		this.concentrations = concentrations;
		Log.i("Finished setting up experiment Data reader.");
	}

	@Override
	public JSONObject readSheet() throws JSONException, SheetReaderException {
		return null;
	}
}
