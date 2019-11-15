package de.rub.bph.omnineuro.client.core.sheet.reader.versions;

import de.rub.bph.omnineuro.client.core.sheet.reader.ExperimentDataReaderTask;
import de.rub.bph.omnineuro.client.core.sheet.reader.MetaDataReaderTask;
import de.rub.bph.omnineuro.client.core.sheet.reader.versions.experiment.ExperimentDataReaderTaskV0;
import de.rub.bph.omnineuro.client.core.sheet.reader.versions.experiment.ExperimentDataReaderTaskV1;
import de.rub.bph.omnineuro.client.core.sheet.reader.versions.experiment.ExperimentDataReaderTaskV2;
import de.rub.bph.omnineuro.client.core.sheet.reader.versions.meta.MetaDataReaderTaskV0;
import de.rub.bph.omnineuro.client.core.sheet.reader.versions.meta.MetaDataReaderTaskV1;
import de.rub.bph.omnineuro.client.imported.log.Log;
import org.apache.poi.ss.usermodel.Workbook;

import java.io.File;
import java.io.IOException;

import static de.rub.bph.omnineuro.client.core.sheet.reader.AXESSheetReader.EXCEL_SHEET_SUBNAME_EXPERIMENT_DATA;
import static de.rub.bph.omnineuro.client.core.sheet.reader.AXESSheetReader.EXCEL_SHEET_SUBNAME_METADATA;

public class DataReaderCompat {

	private Workbook workbook;
	private File sourceFile;
	private int version;

	public DataReaderCompat(Workbook workbook, File sourceFile, int version) {
		this.workbook = workbook;
		this.sourceFile = sourceFile;
		this.version = version;

		Log.i("Setting up a sheet reader compat: Version " + version);
	}

	public ExperimentDataReaderTask getExperimentDataTask() throws IOException {
		Log.i("Requesting a compat experiment data task. Version: " + version);
		switch (version) {
			case -1:
				Log.e("Fatal error while reading the sheet version.");
				return null;
			case 0:
				return new ExperimentDataReaderTaskV0(workbook, EXCEL_SHEET_SUBNAME_EXPERIMENT_DATA, sourceFile);
			case 1:
				return new ExperimentDataReaderTaskV1(workbook, EXCEL_SHEET_SUBNAME_EXPERIMENT_DATA, sourceFile);
			case 2:
				return new ExperimentDataReaderTaskV2(workbook, EXCEL_SHEET_SUBNAME_EXPERIMENT_DATA, sourceFile);
			//TODO Use DataReaderTasks, other than forcing Task V2 on all versions
			default:
				Log.e("Sheet version read as " + getVersion() + ", but don't know how to handle it for experiment compat reader.");
				return null;
		}
	}

	public MetaDataReaderTask getMetaDataTask() throws IOException {
		Log.i("Requesting a compat meta data task. Version: " + version);
		switch (version) {
			case -1:
				Log.e("Fatal error while reading the sheet version. ");
				return null;
			case 0:
				return new MetaDataReaderTaskV0(workbook, EXCEL_SHEET_SUBNAME_METADATA, sourceFile);
			case 1:
			case 2:
				return new MetaDataReaderTaskV1(workbook, EXCEL_SHEET_SUBNAME_METADATA, sourceFile);
			default:
				Log.e("Sheet version read as " + getVersion() + ", but don't know how to handle it for meta compat reader.");
				return null;
		}
	}

	public File getSourceFile() {
		return sourceFile;
	}

	public int getVersion() {
		return version;
	}

	public Workbook getWorkbook() {
		return workbook;
	}
}
