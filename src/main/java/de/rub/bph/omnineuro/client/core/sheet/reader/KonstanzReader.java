package de.rub.bph.omnineuro.client.core.sheet.reader;

import org.apache.poi.ss.usermodel.Workbook;
import org.json.JSONException;
import org.json.JSONObject;

import java.io.File;
import java.io.IOException;

@Deprecated
public class KonstanzReader extends SheetReaderTask {
	
	public KonstanzReader(Workbook workbook, String sheetName, File sourceFile) throws IOException {
		super(workbook, sheetName, sourceFile);
	}
	
	@Override
	public JSONObject readSheet() throws JSONException, SheetReaderException {
		return null;
	}
}
