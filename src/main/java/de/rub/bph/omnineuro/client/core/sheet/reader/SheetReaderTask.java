package de.rub.bph.omnineuro.client.core.sheet.reader;

import org.apache.poi.ss.usermodel.Workbook;
import org.json.JSONException;
import org.json.JSONObject;

import java.io.File;
import java.io.IOException;

public abstract class SheetReaderTask extends SheetReader {
	
	public SheetReaderTask(Workbook workbook, String sheetName, File sourceFile) throws IOException {
		super(sourceFile, workbook, sheetName);
		this.sourceFile = sourceFile;
		
		workbook.close();
	}
	
	public abstract JSONObject readSheet() throws JSONException, SheetReaderException;
	
	public void addRowPair(JSONObject data, int line, boolean forceNumeric) throws SheetReaderException, JSONException {
		addRowPair(data, line, forceNumeric, "A", "B");
	}
	
	public void addRowPair(JSONObject data, int line, boolean forceNumeric, String keyChar, String valueChar) throws SheetReaderException, JSONException {
		data.put(getValueAt(keyChar + line, false), getValueAt(valueChar + line, forceNumeric));
	}
	
}
