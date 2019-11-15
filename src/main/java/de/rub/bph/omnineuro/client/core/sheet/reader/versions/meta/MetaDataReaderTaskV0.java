package de.rub.bph.omnineuro.client.core.sheet.reader.versions.meta;

import de.rub.bph.omnineuro.client.core.sheet.reader.MetaDataReaderTask;
import org.apache.poi.ss.usermodel.Workbook;
import org.json.JSONException;
import org.json.JSONObject;

import java.io.File;
import java.io.IOException;

public class MetaDataReaderTaskV0 extends MetaDataReaderTask {

	public MetaDataReaderTaskV0(Workbook workbook, String name, File sourceFile) throws IOException {
		super(workbook, name, sourceFile);
	}

	@Override
	public JSONObject readMetaDataControls() throws JSONException {
		return readRows(41, 44);
	}

	@Override
	public JSONObject readMetaDataReagents() throws JSONException {
		return readContinuous(47);
	}

	@Override
	public JSONObject readMetaDataOperationProcedures() throws JSONException {
		return readContinuous(68);
	}

	@Override
	public String readMetaDataComments() throws SheetReaderException {
		return getValueAt("A77");
	}

	@Override
	public JSONObject readMetaDataGeneral() throws JSONException {
		JSONObject general = readRows(27, 31, readRows(1, 25));

		JSONObject data = general.getJSONObject("Data");
		data.put("Institution", "IUF – Leibniz Research Institute for Environmental Medicine");
		data.put("Department", "Modern risk assessment and sphere biology");
		data.put("Workgroup", "Modern risk assessment and sphere biology");
		data.put("Group leader", "Ellen Fritsche");
		data.put("Project", "EFSA DNT2");
		data.put("Sex", "undefined");

		return general;
	}


}
