package de.rub.bph.omnineuro.client.core.sheet.reader.versions;

import de.rub.bph.omnineuro.client.core.sheet.reader.MetaDataReaderTask;
import de.rub.bph.omnineuro.client.core.sheet.reader.versions.meta.MetaDataReaderTaskV0;
import de.rub.bph.omnineuro.client.imported.log.Log;
import org.apache.poi.ss.usermodel.Workbook;

import java.io.File;
import java.io.IOException;

import static de.rub.bph.omnineuro.client.core.sheet.reader.SheetReader.EXCEL_SHEET_SUBNAME_METADATA;

public class MetaDataReaderCompat {

	private Workbook workbook;
	private File sourceFile;
	private int version;

	public MetaDataReaderCompat(Workbook workbook, File sourceFile, int version) {
		this.workbook = workbook;
		this.sourceFile = sourceFile;
		this.version = version;
	}

	public MetaDataReaderTask getTask() throws IOException {
		switch (version) {
			case -1:
				Log.e("Fatal error while reading the sheet version. ");
				return null;
			case 0:
				return new MetaDataReaderTaskV0(workbook, EXCEL_SHEET_SUBNAME_METADATA, sourceFile);
			default:
				Log.w("Sheet version read as " + getVersion() + ", but don't know how to handle it.");
				return null;
		}
	}

	public Workbook getWorkbook() {
		return workbook;
	}

	public File getSourceFile() {
		return sourceFile;
	}

	public int getVersion() {
		return version;
	}
}
