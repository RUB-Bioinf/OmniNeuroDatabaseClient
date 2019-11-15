package de.rub.bph.omnineuro.client.core.sheet.reader;

import org.apache.poi.ss.usermodel.Workbook;
import org.json.JSONException;
import org.json.JSONObject;

import java.io.File;
import java.io.IOException;

public abstract class SheetReaderTask extends SheetReader {
	
	protected File sourceFile;
	
	public SheetReaderTask(Workbook workbook, String sheetName, File sourceFile) throws IOException {
		super(workbook, sheetName);
		this.sourceFile = sourceFile;
		
		workbook.close();
	}
	
	public abstract JSONObject readSheet() throws JSONException, SheetReaderException;
	
	public void addRowPair(JSONObject data, int line, boolean forceNumeric) throws SheetReaderException, JSONException {
		data.put(getValueAt("A" + line, false), getValueAt("B" + line, forceNumeric));
	}
	
	public String getFileName() {
		return getSourceFile().getName();
	}
	
	public File getSourceFile() {
		return sourceFile;
	}
	
}
