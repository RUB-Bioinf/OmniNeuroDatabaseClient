package de.rub.bph.omnineuro.client.core.db.out.assay_distribution;

import de.rub.bph.omnineuro.client.core.db.DBConnection;
import de.rub.bph.omnineuro.client.core.db.OmniNeuroQueryExecutor;
import de.rub.bph.omnineuro.client.core.db.out.SheetExporterCompatManager;
import de.rub.bph.omnineuro.client.imported.filemanager.FileManager;
import de.rub.bph.omnineuro.client.imported.log.Log;

import java.io.File;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.concurrent.ExecutorService;

public class AssayDistributionSheetExporter extends SheetExporterCompatManager {
	
	private ArrayList<String> errorList;
	private OmniNeuroQueryExecutor queryExecutor;
	private File outFile;
	private ExecutorService service;
	private ArrayList<Long> compoundIDs;
	private ArrayList<String> assayNames;
	
	public AssayDistributionSheetExporter(int threads, File sourceDir) throws SQLException {
		super(threads, sourceDir);
		
		errorList = new ArrayList<>();
		DBConnection connection = DBConnection.getDBConnection();
		queryExecutor = new OmniNeuroQueryExecutor(connection.getConnection());
		queryExecutor.setLogEnabled(false);
		
		String compoundQuery = "SELECT id from compound ORDER BY name";
		compoundIDs = queryExecutor.extractLongFeature(queryExecutor.executeQuery(compoundQuery), "id");
		assayNames = queryExecutor.getColumn("assay", "name", true);
		
		outFile = new File(sourceDir, "assay_distribution.csv");
	}
	
	private String getRowText(long compoundID, int index) throws SQLException {
		StringBuilder row = new StringBuilder();
		row.append(index + 1 + ";");
		
		String cas = queryExecutor.getFeatureViaID("compound", "cas_no", compoundID);
		String compoundName = queryExecutor.getNameViaID("compound", compoundID);
		
		row.append(compoundName + ";");
		row.append(cas + ";");
		
		int sum = 0;
		for (String assay : assayNames) {
			String query = "SELECT count(experiment.id)\n" +
					"FROM compound,\n" +
					"     experiment,\n" +
					"     assay\n" +
					"WHERE compound.id = " + compoundID + "\n" +
					"  AND experiment.compound_id = compound.id\n" +
					"  AND experiment.assay_id = assay.id\n" +
					"  AND assay.name = '" + assay + "';";
			ResultSet set = queryExecutor.executeQuery(query);
			set.next();
			int count = set.getInt("count");
			sum += count;
			row.append(count + ";");
		}
		row.append(sum);
		
		return row.toString();
	}
	
	@Override
	public void export() {
		try {
			StringBuilder headerLine = new StringBuilder();
			headerLine.append("Index;Compound;CAS;");
			for (String assay : assayNames) {
				headerLine.append("n (" + assay + ");");
			}
			headerLine.append("Sum");
			
			ArrayList<String> outLines = new ArrayList<>();
			outLines.add(headerLine.toString());
			
			for (int i = 0; i < compoundIDs.size(); i++) {
				long currentID = compoundIDs.get(i);
				String row = getRowText(currentID, i);
				outLines.add(row);
				Log.i("Assay Distribution sheet Progress: " + i + "/" + compoundIDs.size());
			}
			
			FileManager manager = new FileManager();
			manager.saveListFile(outLines, outFile);
		} catch (Exception e) {
			Log.e(e);
			errorList.add("Fatal error!! " + e.getMessage());
		}
	}
	
	@Override
	public ArrayList<String> getErrors() {
		return new ArrayList<>(errorList);
	}
	
	@Override
	public int getTaskCount() {
		return compoundIDs.size();
	}
}
