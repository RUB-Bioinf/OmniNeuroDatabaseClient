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
	
	protected long compoundID;
	protected String compoundName, compoundAbbreviation;
	protected OmniNeuroQueryExecutor queryExecutor;
	protected File outFile;
	protected boolean successful;
	
	public CompoundSheetExporter(File targetDir, DBConnection connection, long compoundID, ArrayList<Long> responseIDs, boolean useComma) throws SQLException {
		super(targetDir, connection, responseIDs, useComma);
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
		builder.append("Experiment ID;");
		builder.append(getCompoundName());
		builder.append(";");
		
		ArrayList<String> allConcentrations = ResponseHolder.getUniqueConcentrations(responseHolders);
		ArrayList<String> allEndpoints = ResponseHolder.getUniqueEndpointNames(responseHolders);
		ArrayList<String> allExperimentNames = ResponseHolder.getUniqueExperimentNames(responseHolders);
		ArrayList<Integer> allTimestamps = ResponseHolder.getUniqueTimestamps(responseHolders);
		
		allConcentrations.sort((s, t1) -> {
			try {
				double d1 = Double.parseDouble(s);
				double d2 = Double.parseDouble(t1);
				
				return Double.compare(d1, d2);
			} catch (NumberFormatException e) {
				Log.v("Can't compare concentrations '" + s + "' and '" + t1 + "' as numbers.");
				return s.compareTo(t1);
			}
		});
		Collections.sort(allEndpoints);
		Collections.sort(allTimestamps);
		Collections.sort(allExperimentNames);
		
		for (String e : allEndpoints) {
			for (int t : allTimestamps) {
				builder.append(e).append(" [").append(t).append("h];");
			}
		}
		builder.append("\n");
		
		HashMap<String, HashMap<String, HashMap<String, HashMap<Integer, ArrayList<Double>>>>> holderMap = remapResponseHolders(responseHolders);
		Log.v("Remapped data: " + remapResponseHolders(responseHolders));
		
		int concentrationIndex = 0;
		while (concentrationIndex < allConcentrations.size()) {
			String concentration = allConcentrations.get(concentrationIndex);
			
			String concentrationCorrectSeparator;
			if (isUseComma()) {
				concentrationCorrectSeparator = concentration.replace(".", ",");
			} else {
				concentrationCorrectSeparator = concentration.replace(",", ".");
			}
			
			int experimentNameIndex = 0;
			while (experimentNameIndex < allExperimentNames.size()) {
				boolean nextExperiment = true;
				StringBuilder rowBuilder = new StringBuilder();
				
				String experimentName = allExperimentNames.get(experimentNameIndex);
				HashMap<String, HashMap<String, HashMap<Integer, ArrayList<Double>>>> nameMap = holderMap.get(experimentName);
				
				rowBuilder.append(experimentName).append(";");
				rowBuilder.append(concentrationCorrectSeparator).append(";");
				
				boolean nextReplica = true;
				for (String endpoint : allEndpoints) {
					for (int timestamp : allTimestamps) {
						if (nameMap.containsKey(concentration)) {
							HashMap<String, HashMap<Integer, ArrayList<Double>>> concentrationMap = nameMap.get(concentration);
							if (concentrationMap.containsKey(endpoint)) {
								HashMap<Integer, ArrayList<Double>> endpointMap = concentrationMap.get(endpoint);
								if (endpointMap.containsKey(timestamp)) {
									ArrayList<Double> responses = endpointMap.get(timestamp);
									if (responses.isEmpty()) {
										endpointMap.remove(timestamp);
									} else {
										Double d = responses.get(0);
										responses.remove(d);
										
										String s = String.valueOf(d);
										if (isUseComma()) {
											s = s.replace(".", ",");
										} else {
											s = s.replace(",", ".");
										}
										
										rowBuilder.append(s);
										nextExperiment = false;
									}
								}
							}
						}
						
						rowBuilder.append(";");
					}
				}
				
				rowBuilder.append("\n");
				if (nextExperiment) {
					experimentNameIndex++;
				} else {
					builder.append(rowBuilder.toString());
				}
			}
			
			concentrationIndex++;
			//rowBuilder.append("\n");
			//if (nextReplica) {
			//	concentrationIndex++;
			//} else {
			//	builder.append(rowBuilder.toString());
			//}
		}
		return builder;
	}
	
	/**
	 * Data structure: Experiment Name -> Concentration -> Endpoint name -> Timestamp -> List of Responses
	 */
	public HashMap<String, HashMap<String, HashMap<String, HashMap<Integer, ArrayList<Double>>>>> remapResponseHolders(List<ResponseHolder> holders) {
		HashMap<String, HashMap<String, HashMap<String, HashMap<Integer, ArrayList<Double>>>>> data = new HashMap<>();
		
		for (ResponseHolder holder : holders) {
			String concentration = holder.getConcentrationDescription();
			String name = holder.getExperimentName();
			String endpoint = holder.getEndpointName();
			int timestamp = holder.getTimestamp();
			double response = holder.getResponse();
			
			if (!data.containsKey(name)) data.put(name, new HashMap<>());
			HashMap<String, HashMap<String, HashMap<Integer, ArrayList<Double>>>> nameMap = data.get(name);
			
			if (!nameMap.containsKey(concentration)) nameMap.put(concentration, new HashMap<>());
			HashMap<String, HashMap<Integer, ArrayList<Double>>> concentrationMap = nameMap.get(concentration);
			
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
			errorList.add(e.getMessage());
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
