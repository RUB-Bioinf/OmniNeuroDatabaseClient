package de.rub.bph.omnineuro.client.core.sheet.reader.versions;

import de.rub.bph.omnineuro.client.core.sheet.reader.ExperimentDataReaderTask;
import de.rub.bph.omnineuro.client.core.sheet.reader.MetaDataReaderTask;
import de.rub.bph.omnineuro.client.core.sheet.reader.versions.experiment.ExperimentDataReaderTaskV0;
import de.rub.bph.omnineuro.client.core.sheet.reader.versions.experiment.ExperimentDataReaderTaskV2;
import de.rub.bph.omnineuro.client.core.sheet.reader.versions.meta.MetaDataReaderTaskNPC2VIPPlus;
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
	private String version;
	
	public DataReaderCompat(Workbook workbook, File sourceFile, String version) {
		this.workbook = workbook;
		this.sourceFile = sourceFile;
		
		if (version == null) version = "";
		this.version = version.trim();
		
		Log.i("Setting up a sheet reader compat: Version " + version);
	}
	
	public ExperimentDataReaderTask getExperimentDataTask() throws IOException {
		Log.i("Requesting a compat experiment data task. Version: " + version);
		
		switch (version) {
			case "":
				Log.e("Fatal error while reading the sheet version.");
				return null;
			case "0":
				return new ExperimentDataReaderTaskV0(workbook, EXCEL_SHEET_SUBNAME_EXPERIMENT_DATA, sourceFile);
			case "1":
			case "iNPC1ab_VIP+_V1":
			case "iNPC2_VIP+_V1":
			case "2":
				return new ExperimentDataReaderTaskV2(workbook, EXCEL_SHEET_SUBNAME_EXPERIMENT_DATA, sourceFile);
			//TODO Use DataReaderTasks, other than forcing Task V2 on all versions
			default:
				Log.e("Sheet version read as " + getVersion() + ", but don't know how to handle it for experiment compat reader.");
				return null;
		}
	}
	
	public String getVersion() {
		return version;
	}
	
	public File getSourceFile() {
		return sourceFile;
	}
	
	public MetaDataReaderTask getMetaDataTask() throws IOException {
		Log.i("Requesting a compat meta data task. Version: " + version);
		switch (version) {
			case "":
				Log.e("Fatal error while reading the sheet version. ");
				return null;
			case "0":
				return new MetaDataReaderTaskV0(workbook, EXCEL_SHEET_SUBNAME_METADATA, sourceFile);
			case "1":
			case "2":
			case "iNPC1ab_VIP+_V1":
				return new MetaDataReaderTaskV1(workbook, EXCEL_SHEET_SUBNAME_METADATA, sourceFile);
			case "iNPC2_VIP+_V1":
				return new MetaDataReaderTaskNPC2VIPPlus(workbook, EXCEL_SHEET_SUBNAME_METADATA, sourceFile);
			default:
				Log.e("Sheet version read as " + getVersion() + ", but don't know how to handle it for meta compat reader.");
				return null;
		}
	}

	public Workbook getWorkbook() {
		return workbook;
	}
}
