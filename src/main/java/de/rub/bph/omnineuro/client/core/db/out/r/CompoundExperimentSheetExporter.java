package de.rub.bph.omnineuro.client.core.db.out.r;

import de.rub.bph.omnineuro.client.core.db.DBConnection;
import de.rub.bph.omnineuro.client.core.db.OmniNeuroQueryExecutor;
import de.rub.bph.omnineuro.client.core.db.out.SheetExporterCompatManager;
import de.rub.bph.omnineuro.client.core.db.out.holder.CompoundHolder;
import de.rub.bph.omnineuro.client.imported.filemanager.FileManager;
import de.rub.bph.omnineuro.client.imported.log.Log;

import java.io.File;
import java.sql.SQLException;
import java.util.ArrayList;

public class CompoundExperimentSheetExporter extends SheetExporterCompatManager {
	
	private ArrayList<Long> compoundIDs;
	private OmniNeuroQueryExecutor queryExecutor;
	
	public CompoundExperimentSheetExporter(int threads, File sourceDir, ArrayList<Long> responseIDs) throws SQLException {
		super(threads, sourceDir);
		DBConnection connection = DBConnection.getDBConnection();
		queryExecutor = new OmniNeuroQueryExecutor(connection.getConnection());
		queryExecutor.setLogEnabled(false);
		
		compoundIDs = extractCompoundIDs(responseIDs);
	}
	
	private ArrayList<Long> extractCompoundIDs(ArrayList<Long> responseIDs) throws SQLException {
		ArrayList<Long> foundIDs = new ArrayList<>();
		StringBuilder queryBuilder = new StringBuilder();
		
		queryBuilder.append("SELECT distinct compound.id,compound.name FROM compound,experiment,response where compound.id = experiment.compound_id AND response.experiment_id = experiment.id AND response.id = ANY ('{");
		// Original query idea: SELECT distinct compound.id,compound.name FROM compound,experiment,response where compound.id = experiment.compound_id AND response.experiment_id = experiment.id AND response.id = ANY ('{1,2,3,4,5}'::int[]) ORDER BY id;
		for (int i = 0; i < responseIDs.size(); i++) {
			Long id = responseIDs.get(i);
			//Long experiment = Long.valueOf(queryExecutor.getFeatureViaID("response", "experiment_id", id));
			queryBuilder.append(id);
			if (i != responseIDs.size() - 1) {
				queryBuilder.append(",");
			}
			
			if (i % 500 == 0) {
				Log.i("Progress: " + i + "/" + responseIDs.size());
			}
		}
		queryBuilder.append("}'::int[]) ORDER BY compound.name;");
		String query = queryBuilder.toString();
		
		Log.i("Executing query: " + query);
		foundIDs = queryExecutor.extractIDs(queryExecutor.executeQuery(query));
		Log.i("Done.");
		Log.i("Found " + foundIDs.size() + " compounds in " + responseIDs.size() + " responses.");
		return foundIDs;
	}
	
	public String getHeaderText(int experimentIDs) {
		StringBuilder builder = new StringBuilder("Compound;CAS;Number Experiments");
		for (int i = 0; i < experimentIDs; i++) {
			builder.append(";ExperimentID");
		}
		return builder.toString();
	}
	
	@Override
	public void export() {
		Log.i("Exporting Experiment overviews to: " + sourceDir.getAbsolutePath());
		StringBuilder builder = new StringBuilder();
		
		File outfile = new File(sourceDir, "experimentsPerCompounds.csv");
		FileManager fileManager = new FileManager();
		
		int experimentCountHeaderNumber = 0;
		try {
			for (int i = 0; i < compoundIDs.size(); i++) {
				long id = compoundIDs.get(i);
				CompoundHolder holder = CompoundHolder.getCompoundHolderViaID(id, queryExecutor);
				String compoundName = holder.getName();
				
				builder.append(compoundName).append(";").append(holder.getCas()).append(";");
				String query = "SELECT DISTINCT experiment.name FROM experiment,compound where compound.id = experiment.compound_id AND compound.id = " + id + " ORDER BY experiment.name;";
				ArrayList<String> experimentNames = queryExecutor.extractStringFeature(queryExecutor.executeQuery(query), "name");
				
				experimentCountHeaderNumber = Math.max(experimentCountHeaderNumber, experimentNames.size());
				builder.append(experimentNames.size() + ";");
				for (String name : experimentNames) {
					builder.append(name);
					builder.append(";");
				}
				
				builder.append("\n");
				Log.i("Finished " + i + " / " + compoundIDs.size() + " Compounds. Current: " + compoundName);
			}
			
			builder.insert(0, getHeaderText(experimentCountHeaderNumber) + "\n");
			fileManager.writeFile(outfile, builder.toString());
		} catch (Exception e) {
			Log.e(e);
			//TODO error
		}
	}
	
	@Override
	public ArrayList<String> getErrors() {
		//TODO add error system
		return new ArrayList<>();
	}
	
	@Override
	public int getTaskCount() {
		return 0;
	}
}
