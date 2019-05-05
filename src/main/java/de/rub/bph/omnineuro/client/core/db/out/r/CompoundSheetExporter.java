package de.rub.bph.omnineuro.client.core.db.out.r;

import de.rub.bph.omnineuro.client.core.db.DBConnection;
import de.rub.bph.omnineuro.client.core.db.OmniNeuroQueryExecutor;
import de.rub.bph.omnineuro.client.core.db.out.ResponseHolder;
import de.rub.bph.omnineuro.client.core.db.out.SheetExporter;
import de.rub.bph.omnineuro.client.imported.filemanager.FileManager;
import de.rub.bph.omnineuro.client.imported.log.Log;

import java.io.File;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;

public class CompoundSheetExporter extends SheetExporter {
	
	private long compoundID;
	private String compoundName, compoundAbbreviation;
	private OmniNeuroQueryExecutor queryExecutor;
	private File outFile;
	private boolean successful;
	
	public CompoundSheetExporter(File targetDir, DBConnection connection, long compoundID, ArrayList<Long> responseIDs) throws SQLException {
		super(targetDir, connection, responseIDs);
		this.compoundID = compoundID;
		successful = false;
		
		queryExecutor = new OmniNeuroQueryExecutor(connection.getConnection());
		queryExecutor.setLogEnabled(false);
		compoundName = queryExecutor.getNameViaID("compound", compoundID);
		compoundAbbreviation = queryExecutor.getFeatureViaID("compound", "abbreviation", compoundID);
		
		outFile = new File(targetDir, compoundAbbreviation + ".csv");
		Log.i("Writing " + compoundName + " results to: " + outFile.getAbsolutePath());
		Log.i("Compound " + getCompoundAbbreviation() + " has " + responseIDs.size() + " responses in the DB.");
	}
	
	public StringBuilder buildCSV(ArrayList<ResponseHolder> responseHolders) {
		StringBuilder builder = new StringBuilder();
		builder.append(getCompoundName()).append(";");
		
		ArrayList<String> allConcentrations = ResponseHolder.getUniqueConcentrations(responseHolders);
		ArrayList<String> allEndpoints = ResponseHolder.getUniqueEndpointNamess(responseHolders);
		ArrayList<Integer> allTimestamps = ResponseHolder.getUniqueTimestamps(responseHolders);
		Collections.sort(allConcentrations);
		Collections.sort(allEndpoints);
		Collections.sort(allTimestamps);
		
		for (String e : allEndpoints) {
			for (int t : allTimestamps) {
				builder.append(e).append(" [").append(t).append("h];");
			}
		}
		builder.append("\n");
		
		HashMap<String, HashMap<String, HashMap<Integer, ArrayList<Double>>>> holderMap = remapResponseHolders(responseHolders);
		Log.v("Remapped data: " + remapResponseHolders(responseHolders));
		
		int concentrationIndex = 0;
		while (concentrationIndex < allConcentrations.size()) {
			String concentration = allConcentrations.get(concentrationIndex);
			StringBuilder rowBuilder = new StringBuilder();
			rowBuilder.append(concentration).append(";");
			
			boolean nextReplicant = true;
			for (String endpoint : allEndpoints) {
				for (int timestamp : allTimestamps) {
					if (holderMap.containsKey(concentration)) {
						HashMap<String, HashMap<Integer, ArrayList<Double>>> concentrationMap = holderMap.get(concentration);
						if (concentrationMap.containsKey(endpoint)) {
							HashMap<Integer, ArrayList<Double>> endpointMap = concentrationMap.get(endpoint);
							if (endpointMap.containsKey(timestamp)) {
								ArrayList<Double> responses = endpointMap.get(timestamp);
								if (responses.isEmpty()) {
									endpointMap.remove(timestamp);
								} else {
									Double d = responses.get(0);
									responses.remove(d);
									rowBuilder.append(d);
									nextReplicant = false;
								}
							}
						}
					}
					
					rowBuilder.append(";");
					//ArrayList<Double> d = holderMap.get(concentration).get(endpoint).get(timestamp);
					//
					////TODO Hashmaps aufdröseln und nullchecks und dann alles in den stringwriter packen
					//
					//Log.i(d + "");
					//builder.append(d.get(0));
				}
			}
			
			rowBuilder.append("\n");
			if (nextReplicant) {
				concentrationIndex++;
			} else {
				builder.append(rowBuilder.toString());
			}
		}
		
		return builder;
	}
	
	/**
	 * Data structure: Concentration -> Endpoint name -> Timestamp -> List of Responses
	 */
	public HashMap<String, HashMap<String, HashMap<Integer, ArrayList<Double>>>> remapResponseHolders(List<ResponseHolder> holders) {
		HashMap<String, HashMap<String, HashMap<Integer, ArrayList<Double>>>> data = new HashMap<>();
		
		for (ResponseHolder holder : holders) {
			String concentration = holder.getConcentrationDescription();
			String endpoint = holder.getEndpointName();
			int timestamp = holder.getTimestamp();
			double response = holder.getResponse();
			
			if (!data.containsKey(concentration)) data.put(concentration, new HashMap<>());
			HashMap<String, HashMap<Integer, ArrayList<Double>>> concentrationMap = data.get(concentration);
			
			if (!concentrationMap.containsKey(endpoint)) concentrationMap.put(endpoint, new HashMap<>());
			HashMap<Integer, ArrayList<Double>> timestampMap = concentrationMap.get(endpoint);
			
			if (!timestampMap.containsKey(timestamp)) timestampMap.put(timestamp, new ArrayList<>());
			ArrayList<Double> responses = timestampMap.get(timestamp);
			responses.add(response);
		}
		return data;
	}
	
	@Override
	public void run() {
		try {
			//ArrayList<Long> responseIDs = new ArrayList<>();
			//for (long id : getExperimentIDs()) {
			//	responseIDs.addAll(queryExecutor.getIDsViaFeature("response", "experiment_id", String.valueOf(id)));
			//}
			//Log.i("Compound " + getCompoundAbbreviation() + " has " + responseIDs.size() + " responses in the database.");
			
			ArrayList<ResponseHolder> responseHolders = new ArrayList<>();
			for (long id : responseIDs) {
				ResponseHolder holder = new ResponseHolder(id, queryExecutor);
				Log.v("I have a holder: " + holder);
				responseHolders.add(holder);
			}
			Log.i("Holders created for " + getCompoundAbbreviation() + ": " + responseHolders.size());
			
			ArrayList<String> uniqueConcentrations = ResponseHolder.getUniqueConcentrations(responseHolders);
			Log.i("Unique concentrations: " + uniqueConcentrations);
			
			StringBuilder fileContents = buildCSV(responseHolders);
			FileManager fileManager = new FileManager();
			fileManager.writeFile(outFile, fileContents.toString());
			
			successful = true;
		} catch (Throwable e) {
			Log.e("Failed to create " + getCompoundAbbreviation() + " ['" + getCompoundName() + "'] export file because of an " + e.getClass().getSimpleName() + "-Error!", e);
		}
	}
	
	public String getCompoundAbbreviation() {
		return compoundAbbreviation;
	}
	
	public long getCompoundID() {
		return compoundID;
	}
	
	public String getCompoundName() {
		return compoundName;
	}
	
	public File getOutFile() {
		return outFile;
	}
	
	public boolean isSuccessful() {
		return successful;
	}
	
}
