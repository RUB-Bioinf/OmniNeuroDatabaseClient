package de.rub.bph.omnineuro.client.core.db.out;

import de.rub.bph.omnineuro.client.Client;
import de.rub.bph.omnineuro.client.core.db.DBConnection;
import de.rub.bph.omnineuro.client.core.db.OmniNeuroQueryExecutor;
import de.rub.bph.omnineuro.client.core.db.out.efsa.BlindedCompoundsExporter;
import de.rub.bph.omnineuro.client.core.db.out.r.CompoundSheetExporter;
import de.rub.bph.omnineuro.client.imported.log.Log;
import org.apache.commons.collections4.ListUtils;
import org.json.JSONObject;

import java.io.File;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;

public class ResponseSheetExporterCompatManager extends SheetExporterCompatManager {
	
	public static final String EXPORT_DIRNAME_COMPOUNDS = "compounds";
	public static final String EXPORT_DIRNAME_EFSA = "efsa";
	
	private OmniNeuroQueryExecutor queryExecutor;
	private DBConnection connection;
	private ArrayList<Long> responseIDs;
	private JSONObject config;
	private boolean useComma;
	private ArrayList<CompoundSheetExporter> exporters;
	private boolean includeBlinded;
	
	public ResponseSheetExporterCompatManager(int threads, File sourceDir, ArrayList<Long> responseIDs, boolean includeBlinded, boolean useComma) {
		super(threads, sourceDir);
		this.includeBlinded = includeBlinded;
		this.useComma = useComma;
		this.responseIDs = responseIDs;
		
		modifySourceDirBasedOnConfig(config);
		
		connection = DBConnection.getDBConnection();
		queryExecutor = new OmniNeuroQueryExecutor(connection.getConnection());
	}
	
	public void exportEFSASheet() throws SQLException {
		String query = "SELECT DISTINCT response.id FROM response, experiment, compound WHERE compound.blinded = TRUE AND compound.id = experiment.compound_id AND\n" +
				"experiment.id = response.experiment_id AND (response.endpoint_id = 1 OR response.endpoint_id = 2 OR response.endpoint_id = 4);";
		ResultSet set = queryExecutor.executeQuery(query);
		ArrayList<Long> foundResponseIDs = queryExecutor.extractIDs(set);
		ArrayList<Long> retained = foundResponseIDs;
		//ArrayList<Long> retained = new ArrayList<>(ListUtils.retainAll(foundResponseIDs, responseIDs));
		
		//TODO: This will lead to technical debt!
		//  The idea here is that only blinded compounds are affected by this export. But since specific ones were requested
		//  at one point in time, this mess was implemented. This hould be fixed in the future
		retained = responseIDs;
		
		File targetDir = new File(sourceDir, EXPORT_DIRNAME_EFSA);
		targetDir.mkdirs();
		
		BlindedCompoundsExporter exporter = new BlindedCompoundsExporter(targetDir, connection, retained, useComma);
		exporter.run();
	}
	
	public ArrayList<CompoundSheetExporter> exportCompoundSheet() throws SQLException { //TODO restrictive Params here?
		ArrayList<Long> compoundIDs = queryExecutor.getIDs("compound");
		ArrayList<Long> retainedCompoundIDs = new ArrayList<>();
		HashMap<Long, ArrayList<Long>> compoundResponseMap = new HashMap<>();
		
		for (long compoundID : compoundIDs) {
			String query = "SELECT DISTINCT response.id FROM response,compound,experiment WHERE response.experiment_id=experiment.id " +
					"AND experiment.compound_id=compound.id AND compound.id = " + compoundID + ";";
			ResultSet set = queryExecutor.executeQuery(query);
			ArrayList<Long> foundResponseIDs = queryExecutor.extractIDs(set);
			
			ArrayList<Long> retained = new ArrayList<>(ListUtils.retainAll(foundResponseIDs, responseIDs));
			Log.i("Found " + retained.size() + " mutual elements from all responses [" + foundResponseIDs.size() + "] and limited [" + responseIDs.size() + "] for compound ID " + compoundID);
			
			if (!retained.isEmpty()) {
				compoundResponseMap.put(compoundID, retained);
				retainedCompoundIDs.add(compoundID);
			}
		}
		
		if (retainedCompoundIDs.isEmpty()) {
			throw new IllegalStateException("No compounds were found in the database that match the limiter. This happened so late in the algorithm that" +
					" this error should not be reached. If so, this is a really severe error where data has been lost!");
		}
		
		File targetDir = new File(sourceDir, EXPORT_DIRNAME_COMPOUNDS);
		targetDir.mkdirs();
		
		ArrayList<CompoundSheetExporter> exporterList = new ArrayList<>();
		for (Long id : retainedCompoundIDs) {
			Log.i("I am working with this compound id " + id + ". Name: " + queryExecutor.getNameViaID("compound", id));
			
			CompoundSheetExporter exporter = new CompoundSheetExporter(targetDir, connection, id, compoundResponseMap.get(id), useComma);
			exporterList.add(exporter);
			submitTask(exporter);
		}
		
		return exporterList;
	}
	
	@Override
	public void export() {
		//TODO distinguish parameters here and add via sub functions?
		
		if (includeBlinded) {
			try {
				exportEFSASheet();
			} catch (SQLException e) {
				Log.e(e);
				Client.showErrorMessage("Failed to export experiment data!\nA more detailed message will be displayed in the future.", null, e);
			}
		}
		
		try {
			exporters = exportCompoundSheet();
		} catch (Throwable e) {
			Log.e(e);
			Client.showErrorMessage("Failed to export experiment data!\nA more detailed message will be displayed in the future.", null, e);
		}
		
		waitForTasks();
	}
	
	@Override
	public ArrayList<String> getErrors() {
		ArrayList<String> tempList = new ArrayList<>();
		for (CompoundSheetExporter exporter : exporters) {
			tempList.addAll(exporter.getErrors());
		}
		return tempList;
	}
	
	@Override
	public int getTaskCount() {
		return exporters.size();
	}
	
	public ArrayList<Long> getResponseIDs() {
		return responseIDs;
	}
	
	public boolean isUseComma() {
		return useComma;
	}
}
