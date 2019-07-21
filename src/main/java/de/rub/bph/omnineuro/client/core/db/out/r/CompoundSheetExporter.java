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
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class CompoundSheetExporter extends SheetExporter {
	
	public static final String WELL_REGEX = "([A-Z]+)(\\d+)";
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
		builder.append(";Well;");
		
		ArrayList<String> allConcentrations = ResponseHolder.getUniqueConcentrations(responseHolders);
		ArrayList<String> allEndpoints = ResponseHolder.getUniqueEndpointNames(responseHolders);
		ArrayList<String> allExperimentNames = ResponseHolder.getUniqueExperimentNames(responseHolders);
		ArrayList<Integer> allTimestamps = ResponseHolder.getUniqueTimestamps(responseHolders);
		ArrayList<String> allWells = ResponseHolder.getUniqueWells(responseHolders);
		
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
		allWells.sort((well1, well2) -> {
			Pattern p = Pattern.compile(WELL_REGEX);
			Matcher m1 = p.matcher(well1);
			Matcher m2 = p.matcher(well2);
			
			if (m1.matches() && m2.matches()) {
				String part1 = m1.group(1);
				String part2 = m2.group(1);
				
				int value1 = Integer.parseInt(m1.group(2));
				int value2 = Integer.parseInt(m2.group(2));
				
				if (part1.equals(part2)) {
					return Integer.compare(value1, value2);
				}
				return part1.compareTo(part2);
			} else {
				Log.w("Failed to apply well regex ['" + WELL_REGEX + "'] to '" + well1 + "' and '" + well2 + "'!");
				return well1.compareTo(well2);
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
		
		HashMap<String, HashMap<String, HashMap<String, HashMap<String, HashMap<Integer, ArrayList<Double>>>>>> holderMap = remapResponseHolders(responseHolders);
		Log.v("Remapped data: " + holderMap);
		
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
						rowBuilder.append("\n");
						builder.append(rowBuilder.toString());
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
	public HashMap<String, HashMap<String, HashMap<String, HashMap<String, HashMap<Integer, ArrayList<Double>>>>>> remapResponseHolders(List<ResponseHolder> holders) {
		HashMap<String, HashMap<String, HashMap<String, HashMap<String, HashMap<Integer, ArrayList<Double>>>>>> data = new HashMap<>();
		
		for (ResponseHolder holder : holders) {
			String concentration = holder.getConcentrationDescription();
			String name = holder.getExperimentName();
			String endpoint = holder.getEndpointName();
			String well = holder.getWell();
			int timestamp = holder.getTimestamp();
			double response = holder.getResponse();
			
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
