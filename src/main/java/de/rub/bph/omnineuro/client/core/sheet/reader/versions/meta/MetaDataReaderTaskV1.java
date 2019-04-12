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
		return getValueAt("A91");
	}

	@Override
	public JSONObject readMetaDataGeneral() throws JSONException {
		return readRows(1, 27);
	}
}
