package de.rub.bph.omnineuro.client.core.sheet.reader.versions.meta;

import de.rub.bph.omnineuro.client.core.sheet.reader.MetaDataReaderTask;
import org.apache.poi.ss.usermodel.Workbook;
import org.json.JSONException;
import org.json.JSONObject;

import java.io.File;
import java.io.IOException;

public class MetaDataReaderTaskV1 extends MetaDataReaderTask {
	
	public MetaDataReaderTaskV1(Workbook workbook, String name, File sourceFile) throws IOException {
		super(workbook, name, sourceFile);
	}
	
	@Override
	public JSONObject readMetaDataControls() throws JSONException {
		return readContinuous(54);
	}
	
	@Override
	public JSONObject readMetaDataReagents() throws JSONException {
		return readContinuous(61);
	}
	
	@Override
	public JSONObject readMetaDataOperationProcedures() throws JSONException {
		return readContinuous(82);
	}
	
	@Override
	public String readMetaDataComments() throws SheetReaderException {
		return getValueAt("A100");
	}
	
	@Override
	public JSONObject readMetaDataGeneral() throws JSONException {
		JSONObject general = readRows(1, 27);
		
		JSONObject data = general.getJSONObject("Data");
		if (!data.has("Sex")) {
			data.put("Sex", "undefined");
		}
		
		return general;
	}
	
	@Override
	public JSONObject readPassages() throws JSONException {
		return readRows(12, 13, new JSONObject(), "D", "B");
	}
	
	@Override
	public JSONObject readSolvent() throws JSONException {
		//Extrawurst for NPC1ab. Their raster has shifted because they don't have a control plate ID
		if (hasValueAt("A29")) {
			return readContinuous(29);
		}
		return readContinuous(30);
	}
}
