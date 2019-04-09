package de.rub.bph.omnineuro.client.core.sheet.reader.versions;

import de.rub.bph.omnineuro.client.core.sheet.reader.MetaDataReaderTask;
import org.apache.poi.ss.usermodel.Workbook;

import java.io.File;
import java.io.IOException;

public class MetaDataReaderTaskV0 extends MetaDataReaderTask {

	public MetaDataReaderTaskV0(Workbook workbook, String name, File sourceFile) throws IOException {
		super(workbook, name, sourceFile);
	}




}
