package de.rub.bph.omnineuro.client.core.sheet.reader.versions.meta;

import org.apache.poi.ss.usermodel.Workbook;
import org.json.JSONException;
import org.json.JSONObject;

import java.io.File;
import java.io.IOException;

public class MetaDataReaderTaskNPC2VIPPlus extends MetaDataReaderTaskV1 {
	
	public MetaDataReaderTaskNPC2VIPPlus(Workbook workbook, String name, File sourceFile) throws IOException {
		super(workbook, name, sourceFile);
	}
	
	@Override
	public JSONObject readMetaDataControls() throws JSONException {
		return readContinuous(55);
	}
	
	@Override
	public JSONObject readMetaDataReagents() throws JSONException {
		return readContinuous(60);
	}
	
	@Override
	public JSONObject readMetaDataOperationProcedures() throws JSONException {
		return readContinuous(83);
	}
	
	@Override
	public String readMetaDataComments() throws SheetReaderException {
		return getValueAt("A94");
	}
	
	@Override
	public JSONObject readMetaDataGeneral() throws JSONException {
		JSONObject general = readRows(1, 28);
		
		JSONObject data = general.getJSONObject("Data");
		if (!data.has("Sex")) {
			data.put("Sex", "undefined");
		}
		
		return general;
	}
	
	@Override
	public JSONObject readPassages() throws JSONException {
		return readRows(13, 14, new JSONObject(), "D", "B");
	}
	
	@Override
	public JSONObject readSolvent() throws JSONException {
		//Extrawurst for NPC1ab. Their raster has shifted because they don't have a control plate ID
		return readContinuous(30);
	}
	
}
