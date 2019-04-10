package de.rub.bph.omnineuro.client.core.sheet.reader;

import de.rub.bph.omnineuro.client.imported.log.Log;
import de.rub.bph.omnineuro.client.util.NumberUtils;
import org.apache.poi.ss.usermodel.Workbook;
import org.json.JSONException;
import org.json.JSONObject;

import java.io.IOException;

import static de.rub.bph.omnineuro.client.core.sheet.reader.SheetReader.EXCEL_SHEET_SUBNAME_METADATA;

public class SheetVersionReader extends MetaDataReaderTask {

	public SheetVersionReader(Workbook workbook) throws IOException {
		super(workbook, EXCEL_SHEET_SUBNAME_METADATA, null);
	}

	public int readVersion() {
		NumberUtils numberUtils = new NumberUtils();
		try {
			String versionKey = getValueAt("A1");
			if (versionKey == null || !versionKey.equals("Version")) {
				return 0;
			}

			String s = getValueAt("B1", true);
			if (numberUtils.isNumeric(s)) {
				return Integer.parseInt(s);
			}

			return 0;
		} catch (SheetReaderTask.SheetReaderException e) {
			Log.e(e);
			return -1;
		}
	}

	@Override
	public JSONObject readMetaDataControls() throws JSONException {
		return null;
	}

	@Override
	public JSONObject readMetaDataReagents() throws JSONException {
		return null;
	}

	@Override
	public JSONObject readMetaDataOperationProcedures() throws JSONException {
		return null;
	}

	@Override
	public String readMetaDataComments() throws SheetReaderException {
		return null;
	}

	@Override
	public JSONObject readMetaDataGeneral() throws JSONException {
		return null;
	}
}
