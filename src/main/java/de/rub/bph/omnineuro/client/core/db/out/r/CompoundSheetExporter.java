package de.rub.bph.omnineuro.client.core.db.out.r;

import de.rub.bph.omnineuro.client.core.db.DBConnection;
import de.rub.bph.omnineuro.client.core.db.OmniNeuroQueryExecutor;
import de.rub.bph.omnineuro.client.core.db.out.ResponseHolder;
import de.rub.bph.omnineuro.client.core.db.out.SheetExporter;
import de.rub.bph.omnineuro.client.imported.filemanager.FileManager;
import de.rub.bph.omnineuro.client.imported.log.Log;
import de.rub.bph.omnineuro.client.util.WellBuilder;

import java.io.File;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;

import static de.rub.bph.omnineuro.client.util.WellBuilder.WELL_REGEX;

public class CompoundSheetExporter extends SheetExporter {
	
	protected long compoundID;
	protected String compoundName, compoundAbbreviation;
	protected OmniNeuroQueryExecutor queryExecutor;
	protected File outFile;
	protected boolean successful;
	
	private ArrayList<ResponseHolder> responseHolders;
	
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
	
	public StringBuilder buildCSV(boolean separatePerAssay) {
		StringBuilder builder = new StringBuilder();
		builder.append("Experiment ID;");
		builder.append(getCompoundName());
		builder.append(";Well;");
		
		ArrayList<String> allConcentrations = ResponseHolder.getUniqueConcentrations(responseHolders);
		ArrayList<String> allEndpoints = ResponseHolder.getUniqueEndpointNames(responseHolders);
		ArrayList<String> allExperimentNames = ResponseHolder.getUniqueExperimentNames(responseHolders);
		ArrayList<Integer> allTimestamps = ResponseHolder.getUniqueTimestamps(responseHolders);
		ArrayList<String> allWells = ResponseHolder.getUniqueWells(responseHolders);
		ArrayList<String> allAssays = ResponseHolder.getUniqueAssays(responseHolders);
		
		if (separatePerAssay) {
			Collections.sort(allAssays);
			ArrayList<String> tempList = new ArrayList<>(allEndpoints);
			allEndpoints = new ArrayList<>();
			for (String s : tempList) {
				for (String assay : allAssays) {
					allEndpoints.add(s + " (" + assay + ")");
				}
			}
		}
		
		allConcentrations.sort((s, t1) -> {
			if (s == null) s = "<Null>";
			if (t1 == null) t1 = "<Null>";
			
			try {
				double d1 = Double.parseDouble(s);
				double d2 = Double.parseDouble(t1);
				
				return Double.compare(d1, d2);
			} catch (NumberFormatException e) {
				Log.v("Can't compare concentrations '" + s + "' and '" + t1 + "' as numbers.");
				return s.compareTo(t1);
			}
		});
		
		allWells.sort((well1, well2) -> {
			WellBuilder builder1;
			WellBuilder builder2;
			try {
				builder1 = WellBuilder.convertWell(well1);
				builder2 = WellBuilder.convertWell(well2);
			} catch (Exception e) {
				Log.w("Failed to apply well regex ['" + WELL_REGEX + "'] to '" + well1 + "' and '" + well2 + "'!");
				return well1.compareTo(well2);
			}
			
			return builder1.compareTo(builder2);
		});
		Collections.sort(allEndpoints);
		Collections.sort(allTimestamps);
		Collections.sort(allExperimentNames);
		
		for (String e : allEndpoints) {
			e = e.replace("Viabillity", "Viability");
			
			for (int t : allTimestamps) {
				builder.append(e).append(" [").append(t).append("h];");
			}
		}
		
		String firstRow = builder.toString();
		firstRow = firstRow.substring(0, firstRow.length() - 1);
		
		//If an endpoint has only 1 assay, then the assay notion is removed
		if (separatePerAssay) {
			ArrayList<String> singleEndpoints = new ArrayList<>();
			ArrayList<String> multipleEndpoints = new ArrayList<>();
			
			String[] endpointParts = firstRow.split(";");
			for (String s : endpointParts) {
				if (singleEndpoints.contains(s)) {
					multipleEndpoints.add(s);
				} else {
					singleEndpoints.add(s);
				}
			}
			
			for (String endpoint : multipleEndpoints) {
				String s = endpoint;
				for (String assay : allAssays) {
					s = s.replace(assay, "");
				}
				s = s.replace("()", "");
				while (s.contains("  ")) {
					s = s.replace("  ", " ");
				}
				
				firstRow = firstRow.replace(endpoint, s);
			}
		}
		
		builder = new StringBuilder(firstRow);
		builder.append("\n");
		
		HashMap<String, HashMap<String, HashMap<String, HashMap<String, HashMap<Integer, ArrayList<Double>>>>>> holderMap = remapResponseHolders(responseHolders, separatePerAssay);
		Log.v("Remapped data: " + holderMap);
		
		int concentrationIndex = 0;
		while (concentrationIndex < allConcentrations.size()) {
			String concentration = allConcentrations.get(concentrationIndex);
			if (concentration == null) {
				addError("A Concentration is null for " + getCompoundName() + "! Index: " + concentrationIndex + ". All concentrations: " + allConcentrations);
				concentrationIndex++;
				continue;
			}
			
			String concentrationCorrectSeparator;
			if (isUseComma()) {
				concentrationCorrectSeparator = concentration.replace(".", ",");
			} else {
				concentrationCorrectSeparator = concentration.replace(",", ".");
			}
			
			int experimentNameIndex = 0;
			while (experimentNameIndex < allExperimentNames.size()) {
				boolean nextExperiment = true;
				
				String experimentName = allExperimentNames.get(experimentNameIndex);
				for (String well : allWells) {
					HashMap<String, HashMap<String, HashMap<String, HashMap<Integer, ArrayList<Double>>>>> nameMap = holderMap.get(experimentName);
					
					StringBuilder rowBuilder = new StringBuilder();
					rowBuilder.append(experimentName).append(";");
					rowBuilder.append(concentrationCorrectSeparator).append(";");
					rowBuilder.append(well).append(";");
					boolean valuesAdded = false;
					
					for (String endpoint : allEndpoints) {
						for (int timestamp : allTimestamps) {
							if (nameMap.containsKey(concentration)) {
								HashMap<String, HashMap<String, HashMap<Integer, ArrayList<Double>>>> concentrationMap = nameMap.get(concentration);
								if (concentrationMap.containsKey(well)) {
									
									HashMap<String, HashMap<Integer, ArrayList<Double>>> wellMap = concentrationMap.get(well);
									if (wellMap.containsKey(endpoint)) {
										
										HashMap<Integer, ArrayList<Double>> endpointMap = wellMap.get(endpoint);
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
												valuesAdded = true;
											}
										}
									}
								}
							}
							
							rowBuilder.append(";");
						}
					}
					
					if (valuesAdded) {
						String row = rowBuilder.toString();
						if (row.endsWith(";")) {
							row = row.substring(0, row.length() - 1);
						}
						row = row + "\n";
						builder.append(row);
					}
				}
				
				if (nextExperiment) {
					experimentNameIndex++;
				}
			}
			concentrationIndex++;
		}
		return builder;
	}
	
	/**
	 * Data structure: Experiment Name -> Concentration -> Well -> Endpoint name -> Timestamp -> List of Responses
	 */
	public HashMap<String, HashMap<String, HashMap<String, HashMap<String, HashMap<Integer, ArrayList<Double>>>>>> remapResponseHolders(List<ResponseHolder> holders, boolean separatePerAssay) {
		HashMap<String, HashMap<String, HashMap<String, HashMap<String, HashMap<Integer, ArrayList<Double>>>>>> data = new HashMap<>();
		
		for (ResponseHolder holder : holders) {
			String concentration = holder.getConcentrationDescription();
			String name = holder.getExperimentName();
			String endpoint = holder.getEndpointName();
			String well = holder.getWell();
			String assay = holder.getAssayName();
			int timestamp = holder.getTimestamp();
			double response = holder.getResponse();
			
			if (separatePerAssay) {
				endpoint = endpoint + " (" + assay + ")";
			}
			
			if (!data.containsKey(name)) data.put(name, new HashMap<>());
			HashMap<String, HashMap<String, HashMap<String, HashMap<Integer, ArrayList<Double>>>>> nameMap = data.get(name);
			
			if (!nameMap.containsKey(concentration)) nameMap.put(concentration, new HashMap<>());
			HashMap<String, HashMap<String, HashMap<Integer, ArrayList<Double>>>> concentrationMap = nameMap.get(concentration);
			
			if (!concentrationMap.containsKey(well)) concentrationMap.put(well, new HashMap<>());
			HashMap<String, HashMap<Integer, ArrayList<Double>>> wellMap = concentrationMap.get(well);
			
			if (!wellMap.containsKey(endpoint)) wellMap.put(endpoint, new HashMap<>());
			HashMap<Integer, ArrayList<Double>> timestampMap = wellMap.get(endpoint);
			
			if (!timestampMap.containsKey(timestamp)) timestampMap.put(timestamp, new ArrayList<>());
			ArrayList<Double> responses = timestampMap.get(timestamp);
			responses.add(response);
		}
		
		return data;
	}
	
	private ArrayList<ResponseHolder> removeDuplicateResponseHolders() {
		Log.i("Checking " + responseHolders.size() + " for uniqueness.");
		ArrayList<ResponseHolder> uniqueHolders = new ArrayList<>();
		ArrayList<ResponseHolder> duplicateHolders = new ArrayList<>();
		
		for (ResponseHolder holder : responseHolders) {
			if (holder.isUniquelyCreated()) {
				uniqueHolders.add(holder);
			} else {
				duplicateHolders.add(holder);
			}
		}
		Log.i("In the first round, " + duplicateHolders.size() + " holders were uniquely fetched, but " + duplicateHolders.size() + " were duplicates!");
		
		ArrayList<Integer> knownHashesList = new ArrayList<>();
		for (ResponseHolder holder : duplicateHolders) {
			int hash = holder.hashCode();
			if (!knownHashesList.contains(hash)) {
				knownHashesList.add(hash);
				uniqueHolders.add(holder);
				addError("Response duplicate detected: " + holder.getWell() + " at " + holder.getTimestamp() + "h at endpoint '" + holder.getEndpointName() + "' has value " + holder.getResponse() + " " + holder.getCreationCount() + " times for concentration '" + holder.getConcentrationDescription() + "'. Reduced to 1.");
			} else {
				Log.i("Sanity check. Are these lines the same: [" + hash + "] -> " + holder.toString());
			}
		}
		
		return uniqueHolders;
	}
	
	@Override
	public void run() {
		try {
			//ArrayList<Long> responseIDs = new ArrayList<>();
			//for (long id : getExperimentIDs()) {
			//	responseIDs.addAll(queryExecutor.getIDsViaFeature("response", "experiment_id", String.valueOf(id)));
			//}
			//Log.i("Compound " + getCompoundAbbreviation() + " has " + responseIDs.size() + " responses in the database.");
			
			responseHolders = new ArrayList<>();
			for (long id : responseIDs) {
				ResponseHolder holder = new ResponseHolder(id, queryExecutor);
				Log.v("I have a holder: " + holder);
				responseHolders.add(holder);
			}
			Log.i("Holders created for " + getCompoundAbbreviation() + ": " + responseHolders.size());
			responseHolders = removeDuplicateResponseHolders();
			
			ArrayList<String> uniqueConcentrations = ResponseHolder.getUniqueConcentrations(responseHolders);
			Log.i("Unique concentrations: " + uniqueConcentrations);
			
			boolean separatePerAssay = false;
			//TODO make this a parameter
			
			StringBuilder fileContents = buildCSV(separatePerAssay);
			FileManager fileManager = new FileManager();
			fileManager.writeFile(outFile, fileContents.toString());
			
			successful = true;
		} catch (Throwable e) {
			addError("Failed to create " + getCompoundAbbreviation() + " ['" + getCompoundName() + "'] export file because of an " + e.getClass().getSimpleName() + "-Error!");
			Log.e(e);
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
	
	public ArrayList<ResponseHolder> getResponseHolders() {
		return responseHolders;
	}
	
	public boolean isSuccessful() {
		return successful;
	}
	
}
