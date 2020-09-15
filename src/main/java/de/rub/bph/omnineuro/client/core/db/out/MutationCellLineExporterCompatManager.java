package de.rub.bph.omnineuro.client.core.db.out;

import de.rub.bph.omnineuro.client.Client;
import de.rub.bph.omnineuro.client.core.db.DBConnection;
import de.rub.bph.omnineuro.client.core.db.OmniNeuroQueryExecutor;
import de.rub.bph.omnineuro.client.core.db.out.holder.MutationPooler;
import de.rub.bph.omnineuro.client.core.db.out.holder.ResponseHolder;
import de.rub.bph.omnineuro.client.core.db.out.r.CompoundSheetExporter;
import de.rub.bph.omnineuro.client.imported.filemanager.FileManager;
import de.rub.bph.omnineuro.client.imported.log.Log;
import org.json.JSONException;
import org.json.JSONObject;

import java.io.File;
import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.Set;

public class MutationCellLineExporterCompatManager extends SheetExporterCompatManager {
	
	private OmniNeuroQueryExecutor queryExecutor;
	private DBConnection connection;
	private ArrayList<Long> responseIDs;
	private boolean useComma;
	private JSONObject config;
	
	private ArrayList<MutationPooler> poolers;
	private ArrayList<CompoundSheetExporter> exporters;
	
	public MutationCellLineExporterCompatManager(int threads, File sourceDir, ArrayList<Long> responseIDs, boolean useComma) throws SQLException {
		super(threads, sourceDir);
		
		this.useComma = useComma;
		this.responseIDs = responseIDs;
		connection = DBConnection.getDBConnection();
		queryExecutor = new OmniNeuroQueryExecutor(connection.getConnection());
		modifySourceDirBasedOnConfig(config);
		
		poolers = MutationPooler.getAllPossiblePoolers(queryExecutor);
	}
	
	@Override
	public void export() {
		try {
			exporters = getExporterList();
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
	
	private ArrayList<CompoundSheetExporter> getExporterList() throws SQLException, IOException {
		System.out.println("Boii");
		ArrayList<ResponseHolder> holders = new ArrayList<>();
		ArrayList<MutationPooler> allPoolers = new ArrayList<>();
		ArrayList<MutationPooler> allPossiblePoolers = MutationPooler.getAllPossiblePoolers(queryExecutor);
		ArrayList<CompoundSheetExporter> exporterList = new ArrayList<>();
		FileManager fileManager = new FileManager();
		
		// HashMap taking the hash of a pooler and returning a map of compounds. This map contains the responseIDs that match the pooler & compound
		HashMap<Integer, HashMap<Long, ArrayList<Long>>> mutationCompoundResponseMap = new HashMap<>();
		
		// Hashmap taking the hash of a pooler and returning a list of experiment names, using that pooler
		HashMap<Integer, ArrayList<String>> mutationExperimentMap = new HashMap<>();
		
		// Hashmap taking a pooler and returning the corresponding export target dir
		HashMap<MutationPooler, File> mutationOutDirMap = new HashMap<>();
		for (MutationPooler pooler : poolers) {
			File dir = new File(sourceDir, "mutation-" + pooler.toSingleLine());
			dir.mkdirs();
			mutationOutDirMap.put(pooler, dir);
			
			File descriptionFile = new File(dir, "mutation-meta.json");
			try {
				String description = pooler.toJSON().toString(4);
				fileManager.writeFile(descriptionFile, description);
			} catch (JSONException | IOException e) {
				Log.e(e);
			}
			
			mutationCompoundResponseMap.put(pooler.hashCode(), new HashMap<>());
			mutationExperimentMap.put(pooler.hashCode(), new ArrayList<>());
		}
		
		// Loading and preprocessing holders / mutation poolers
		for (int i = 0; i < responseIDs.size(); i++) {
			long id = responseIDs.get(i);
			ResponseHolder holder = new ResponseHolder(id, queryExecutor);
			MutationPooler pooler = MutationPooler.createFromResponse(id, queryExecutor);
			long compoundID = holder.getCompoundID();
			
			int poolerHash = pooler.hashCode();
			HashMap<Long, ArrayList<Long>> compoundResponseMap = mutationCompoundResponseMap.get(poolerHash);
			if (!compoundResponseMap.containsKey(compoundID)) {
				compoundResponseMap.put(compoundID, new ArrayList<Long>());
			}
			compoundResponseMap.get(compoundID).add(id);
			
			ArrayList<String> experimentList = mutationExperimentMap.get(poolerHash);
			if (!experimentList.contains(holder.getExperimentName())) {
				experimentList.add(holder.getExperimentName());
			}
			
			allPoolers.add(pooler);
			holders.add(holder);
			if (i % 500 == 0) {
				double p = ((double) i / (double) responseIDs.size());
				int pp = (int) (p * 100);
				Log.i("Holders created: " + i + " / " + responseIDs.size() + ". " + pp + "%.");
			}
		}
		Log.i("Converted Holders: " + responseIDs.size());
		
		// Saving statistics overviews
		StringBuilder experimentNameOverviewBuilder = new StringBuilder();
		StringBuilder experimentCountBuilder = new StringBuilder();
		experimentCountBuilder.append("Index;Mutation;Cell Line;Cell Type;Experiment Count\n");
		
		for (int j = 0; j < allPossiblePoolers.size(); j++) {
			MutationPooler pooler = allPossiblePoolers.get(j);
			ArrayList<String> experiments = new ArrayList<>();
			if (mutationExperimentMap.containsKey(pooler.hashCode()))
				experiments = mutationExperimentMap.get(pooler.hashCode());
			Collections.sort(experiments);
			
			experimentNameOverviewBuilder.append("Mutation;" + pooler.getMutation() + "\n");
			experimentNameOverviewBuilder.append("Cell Line;" + pooler.getCellLine() + "\n");
			experimentNameOverviewBuilder.append("Cell Type;" + pooler.getCellType() + "\n");
			experimentNameOverviewBuilder.append("Short;" + pooler.toSingleLine() + "\n");
			experimentNameOverviewBuilder.append("Index;Experiment Name\n");
			
			experimentCountBuilder.append((j + 1) + ";" + pooler.getMutation() + ";" + pooler.getCellLine() + ";" + pooler.getCellType() + ";" + experiments.size() + "\n");
			for (int i = 0; i < experiments.size(); i++) {
				String ex = experiments.get(i);
				experimentNameOverviewBuilder.append((i + 1) + ";" + ex + "\n");
			}
			experimentNameOverviewBuilder.append("\n");
		}
		fileManager.writeFile(new File(sourceDir, "mutation-experiments-overview.csv"), experimentNameOverviewBuilder.toString());
		fileManager.writeFile(new File(sourceDir, "mutation-experiments-count.csv"), experimentCountBuilder.toString());
		
		// Setting up concurrent tasks
		for (MutationPooler pooler : poolers) {
			int poolerHash = pooler.hashCode();
			HashMap<Long, ArrayList<Long>> compoundResponseMap = mutationCompoundResponseMap.get(poolerHash);
			
			Set<Long> allCompounds = compoundResponseMap.keySet();
			Log.i("Pooler " + pooler + " has " + allCompounds.size() + " compounds.");
			
			for (long compoundID : allCompounds) {
				ArrayList<Long> responseIDs = compoundResponseMap.get(compoundID);
				File outPath = mutationOutDirMap.get(pooler);
				
				CompoundSheetExporter exporter = new CompoundSheetExporter(outPath, connection, compoundID, responseIDs, useComma, false);
				exporterList.add(exporter);
				submitTask(exporter);
			}
		}
		
		return exporterList;
	}
}
