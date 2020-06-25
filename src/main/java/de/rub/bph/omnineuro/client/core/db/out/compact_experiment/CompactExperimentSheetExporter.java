package de.rub.bph.omnineuro.client.core.db.out.compact_experiment;

import de.rub.bph.omnineuro.client.Client;
import de.rub.bph.omnineuro.client.config.ExportConfigManager;
import de.rub.bph.omnineuro.client.core.db.DBConnection;
import de.rub.bph.omnineuro.client.core.db.OmniNeuroQueryExecutor;
import de.rub.bph.omnineuro.client.core.db.out.SheetExporterCompatManager;
import de.rub.bph.omnineuro.client.core.db.out.holder.ConcentrationHolder;
import de.rub.bph.omnineuro.client.core.sheet.data.DateInterpreter;
import de.rub.bph.omnineuro.client.imported.filemanager.FileManager;
import de.rub.bph.omnineuro.client.imported.log.Log;
import de.rub.bph.omnineuro.client.util.WellBuilder;
import org.json.JSONArray;
import org.json.JSONObject;

import java.io.File;
import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

public class CompactExperimentSheetExporter extends SheetExporterCompatManager {
	
	private ArrayList<String> errorList;
	private OmniNeuroQueryExecutor queryExecutor;
	private File outFile;
	private ExecutorService service;
	private ArrayList<CompactExperimentSheetRunner> runnerList;
	
	public CompactExperimentSheetExporter(int threads, File sourceDir) throws SQLException {
		super(threads, sourceDir);
		errorList = new ArrayList<>();
		DBConnection connection = DBConnection.getDBConnection();
		queryExecutor = new OmniNeuroQueryExecutor(connection.getConnection());
		queryExecutor.setLogEnabled(false);
		
		outFile = new File(sourceDir, "fullExport.csv");
		runnerList = new ArrayList<>();
	}
	
	protected void addError(String error) {
		errorList.add(error);
		Log.e(error);
	}
	
	@Override
	public void export() {
		ArrayList<String> outTextLines = new ArrayList<>();
		FileManager fileManager = new FileManager();
		service = Executors.newFixedThreadPool(threads);
		
		ExportConfigManager configManager = ExportConfigManager.getInstance();
		JSONObject config = configManager.getCurrentConfig();
		
		ArrayList<String> allowedCompounds = new ArrayList<>();
		ArrayList<String> includedCompounds = new ArrayList<>();
		try {
			allowedCompounds = queryExecutor.getColumn("compound", "name");
		} catch (SQLException ex) {
			ex.printStackTrace();
			Client.showSQLErrorMessage(ex, null);
			return;
		}
		if (config.has("limiters")) {
			try {
				JSONArray compoundLimiters = config.getJSONObject("limiters").getJSONObject("compound").getJSONArray("data");
				allowedCompounds.clear();
				for (int i = 0; i < compoundLimiters.length(); i++) {
					allowedCompounds.add(compoundLimiters.getString(i));
				}
			} catch (Throwable e) {
				e.printStackTrace();
			}
		}
		Collections.sort(allowedCompounds);
		Log.i("List of allowed compounds in this export (Count: " + allowedCompounds.size() + "): " + allowedCompounds);
		
		ArrayList<Long> allowedOutlierStatus = new ArrayList<>();
		try {
			allowedOutlierStatus = queryExecutor.getIDs("outlier_type");
		} catch (SQLException ex) {
			ex.printStackTrace();
			Client.showSQLErrorMessage(ex, null);
			return;
		}
		if (config.has("limiters")) {
			try {
				JSONArray compoundLimiters = config.getJSONObject("limiters").getJSONObject("outlier_type").getJSONArray("data");
				allowedOutlierStatus.clear();
				for (int i = 0; i < compoundLimiters.length(); i++) {
					allowedOutlierStatus.add(queryExecutor.getIDViaName("outlier_type", compoundLimiters.getString(i)));
				}
			} catch (Throwable e) {
				e.printStackTrace();
			}
		}
		Collections.sort(allowedOutlierStatus);
		Log.i("List of allowed outlier states in this export (Count: " + allowedOutlierStatus.size() + "): " + allowedOutlierStatus);
		
		try {
			ArrayList<String> experimentNames = queryExecutor.getColumn("experiment", "name");
			ArrayList<String> endpointNames = queryExecutor.getColumn("endpoint", "name");
			ArrayList<String> timestamps = queryExecutor.getColumn("response", "timestamp", true);
			
			Collections.sort(experimentNames);
			Collections.sort(endpointNames);
			Collections.sort(timestamps);
			Log.i("Experiments found in the DB: " + Arrays.toString(experimentNames.toArray()));
			
			/*
			endpointNames.remove("Viability UKN2");
			endpointNames.remove("Migration UKN2");
			endpointNames.remove("Neurite Area UKN5");
			endpointNames.remove("Valid Objects UKN4");
			endpointNames.remove("Selected Objects UKN5");
			endpointNames.remove("Selected Objects UKN4");
			endpointNames.remove("Valid Objects UKN5");
			endpointNames.remove("Neurite Area UKN4");
			endpointNames.remove("Neuronal Density Ring 1");
			endpointNames.remove("Neuronal Density Ring 2");
			endpointNames.remove("Neuronal Density Ring 3");
			endpointNames.remove("Neuronal Density Ring 4");
			endpointNames.remove("Neuronal Density Ring 5");
			endpointNames.remove("Neuronal Density Ring 6");
			endpointNames.remove("Neuronal Density Ring 7");
			endpointNames.remove("Neuronal Density Ring 8");
			endpointNames.remove("Neuronal Density Ring 9");
			endpointNames.remove("Neuronal Density Ring 10");
			endpointNames.remove("Mean Subneurite Count limited");
			endpointNames.remove("Skeleton Oligos");
			endpointNames.remove("Mean Migration Distance all neurons");
			endpointNames.remove("Average Subneuritelength per Nucleus limited");
			 */
			
			endpointNames = new ArrayList<>();
			
			//IUF Endpoints
			//endpointNames.add("Proliferation (BrdU)");
			//endpointNames.add("Proliferation Area");
			//endpointNames.add("Viabillity");
			//endpointNames.add("Viabillity of Proliferation");
			//endpointNames.add("Mean Migration Distance all Oligodendrocytes");
			//endpointNames.add("Skeleton Neurons");
			//endpointNames.add("Migration");
			//endpointNames.add("Number Nuclei");
			//endpointNames.add("Migration Distance");
			//endpointNames.add("Skeleton Oligos");
			//endpointNames.add("Mean Migration Distance all neurons");
			//endpointNames.add("Cytotoxicity (NPC1ab)");
			//endpointNames.add("Cytotoxicity (NPC2-5)");
			
			//Konstanz Endpoints
			endpointNames.add("Viability UKN2");
			endpointNames.add("Migration UKN2");
			endpointNames.add("Neurite Area UKN5");
			endpointNames.add("Valid Objects UKN4");
			endpointNames.add("Selected Objects UKN5");
			endpointNames.add("Selected Objects UKN4");
			endpointNames.add("Neurite Area");
			endpointNames.add("Selected Objects");
			endpointNames.add("Valid Objects");
			endpointNames.add("Valid Objects UKN5");
			endpointNames.add("Neurite Area UKN4");
			endpointNames.add("Viabilty UKN2");
			
			StringBuilder headerBuilder = new StringBuilder();
			headerBuilder.append("ExperimentID;Plating date (ddMONjj);Assay;Species;Cell type;Individual;Date (ddMONjj)/passage 0;P;Date (ddMONjj)/passage 1;P;control Plate ID;" +
					"Compound;Compound abbreviation;CAS No.;Molecular weight;Stock conc.;Dilutionfactor total;" +
					"Pre-dilution;Dilution factor pre-dilution;Dilution factor pre-dilution/1st conc.;" +
					"Dilution factor serialdilution;Solvent conc.*;Solvent;Condiction;Well;");
			for (String endpoint : endpointNames) {
				for (String timestamp : timestamps) {
					headerBuilder.append(endpoint).append(" [").append(timestamp).append("];");
				}
			}
			outTextLines.add(headerBuilder.toString());
			
			for (int i = 0; i < experimentNames.size(); i++) {
				String experimentName = experimentNames.get(i);
				StringBuilder metaDataBuilder = new StringBuilder();
				Log.i("Adding experiment to concurrent queue: " + (i + 1) + "/" + experimentNames.size() + ": " + experimentName);
				
				//if (i == 7) break;
				
				String query = "SELECT DISTINCT experiment.name,\n" +
						"                experiment.timestamp,\n" +
						"                assay.name,\n" +
						"                species.name,\n" +
						"                cell_type.name,\n" +
						"                individual.name,\n" +
						"                experiment.control_plate_id,\n" +
						"                compound.name,\n" +
						"                compound.abbreviation,\n" +
						"                compound.cas_no,\n" +
						"                compound.molecular_weight,\n" +
						"                experiment.solvent_concentration,\n" +
						"                solvent.name\n" +
						"FROM experiment,\n" +
						"     individual,\n" +
						"     cell_type,\n" +
						"     species,\n" +
						"     assay,\n" +
						"     compound,\n" +
						"     solvent,\n" +
						"     sex\n" +
						"WHERE experiment.name = '" + experimentName + "'\n" +
						"  AND individual.id = experiment.individual_id\n" +
						"  AND species.id = individual.species_id\n" +
						"  AND assay.id = experiment.assay_id\n" +
						"  AND compound.id = experiment.compound_id\n" +
						"  AND experiment.solvent_id = solvent.id\n" +
						"  AND cell_type.id = experiment.cell_type_id";
				ResultSet set = queryExecutor.executeQuery(query);
				if (!set.next()) {
					addError("No entries for experiment " + experimentName + " in the DB found.");
					continue;
				}
				
				long platingDate = Long.parseLong(set.getString(2));
				String compoundName = set.getString(8);
				if (!allowedCompounds.contains(compoundName)) {
					Log.i("Experiment " + experimentName + " has compound " + compoundName + ". That's not in the configuration. Skipping.");
					continue;
				}
				
				metaDataBuilder.append(set.getString(1) + ";");
				metaDataBuilder.append(DateInterpreter.parseDate(platingDate).getBaseDate() + ";");
				metaDataBuilder.append(set.getString(3) + ";");
				metaDataBuilder.append(set.getString(4) + ";");
				metaDataBuilder.append(set.getString(5) + ";");
				metaDataBuilder.append(set.getString(6) + ";");
				
				query = "SELECT passage.timestamp, passage.p\n" +
						"FROM passage,\n" +
						"     experiment\n" +
						"WHERE passage.experiment_id = experiment.id\n" +
						"  AND experiment.name = '" + experimentName + "'\n" +
						"ORDER BY passage.p\n" +
						"LIMIT 2";
				ResultSet passageSet = queryExecutor.executeQuery(query);
				for (int j = 0; j < 2; j++) {
					String passageTimestamp = "?";
					String passageP = "?";
					if (passageSet.next()) {
						long resultTimestamp = passageSet.getLong(1);
						
						passageTimestamp = DateInterpreter.parseDate(resultTimestamp).getBaseDate();
						passageP = String.valueOf(passageSet.getDouble(2));
					}
					
					metaDataBuilder.append(passageTimestamp + ";" + passageP + ";");
				}
				
				metaDataBuilder.append(set.getString(7) + ";");
				metaDataBuilder.append(set.getString(8) + ";");
				metaDataBuilder.append(set.getString(9) + ";");
				metaDataBuilder.append(set.getString(10) + ";");
				metaDataBuilder.append(set.getString(11) + ";");
				metaDataBuilder.append("?;?;?;?;?;?;");
				metaDataBuilder.append(set.getString(12) + ";");
				metaDataBuilder.append(set.getString(13) + ";");
				
				//Log.i(metaDataBuilder.toString());
				//outTextLines.add(metaDataBuilder.toString());
				
				query = "SELECT DISTINCT well.name\n" +
						"FROM experiment,\n" +
						"     well,\n" +
						"     response\n" +
						"WHERE experiment.id = experiment_id\n" +
						"  AND well.id = well_id\n" +
						"  and experiment.name = '" + experimentName + "'";
				ArrayList<String> wellList = queryExecutor.extractStringFeature(queryExecutor.executeQuery(query), "name");
				wellList = WellBuilder.sortWellList(wellList);
				
				if (!includedCompounds.contains(compoundName)) {
					includedCompounds.add(compoundName);
				}
				
				CompactExperimentSheetRunner sheetRunner = new CompactExperimentSheetRunner(metaDataBuilder.toString(), experimentName, endpointNames, timestamps, queryExecutor, wellList, allowedOutlierStatus);
				runnerList.add(sheetRunner);
				service.submit(sheetRunner);
			}
		} catch (Throwable e) {
			e.printStackTrace();
			addError("Failed to set up export sheet: " + e.getMessage());
		}
		
		Collections.sort(runnerList);
		Collections.sort(includedCompounds);
		Log.i("These " + includedCompounds.size() + " will be used in the export: " + includedCompounds);
		
		service.shutdown();
		while (!service.isTerminated()) {
			int terminatedCount = 0;
			ArrayList<String> tempLinesList = new ArrayList<>();
			
			for (CompactExperimentSheetRunner runner : runnerList) {
				tempLinesList.addAll(runner.getResultRows());
				if (runner.isTerminated()) terminatedCount++;
			}
			try {
				fileManager.saveListFile(tempLinesList, outFile, false);
			} catch (IOException e) {
				e.printStackTrace();
			}
			
			double p = (double) terminatedCount / (double) runnerList.size();
			Log.i("Waiting for threads... Finished: " + terminatedCount + "/" + runnerList.size() + " [" + (int) (p * 100) + "%]");
			try {
				Thread.sleep(20000);
			} catch (InterruptedException e) {
				e.printStackTrace();
			}
		}
		
		Log.i("Waiting finished. Merging CSV lines.");
		for (CompactExperimentSheetRunner runner : runnerList) {
			outTextLines.addAll(runner.getResultRows());
		}
		
		Log.i("All done. Writing to file system: " + outFile.getAbsolutePath());
		try {
			fileManager.saveListFile(outTextLines, outFile, false);
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		Log.i("Finished.");
	}
	
	@Override
	public ArrayList<String> getErrors() {
		return new ArrayList<>(errorList);
	}
	
	@Override
	public int getTaskCount() {
		return runnerList.size();
	}
	
	protected static class CompactExperimentSheetRunner implements Runnable, Comparable<CompactExperimentSheetRunner> {
		
		private String experimentName;
		private ArrayList<String> endpointNames;
		private ArrayList<String> timestamps;
		private ArrayList<Long> allowedOutlierStates;
		private OmniNeuroQueryExecutor queryExecutor;
		private ArrayList<String> wellList;
		private String metadataText;
		private boolean terminated;
		
		private ArrayList<String> resultRows;
		
		public CompactExperimentSheetRunner(String metadataText, String experimentName, ArrayList<String> endpointNames, ArrayList<String> timestamps, OmniNeuroQueryExecutor queryExecutor, ArrayList<String> wellList, ArrayList<Long> allowedOutlierStates) {
			this.experimentName = experimentName;
			this.metadataText = metadataText;
			this.endpointNames = endpointNames;
			this.timestamps = timestamps;
			this.queryExecutor = queryExecutor;
			this.wellList = wellList;
			this.allowedOutlierStates = allowedOutlierStates;
			terminated = false;
			resultRows = new ArrayList<>();
			Thread.currentThread().setName("CompactExperimentSheetRunner [" + experimentName + "]");
			
			if (allowedOutlierStates.isEmpty()) {
				throw new IllegalArgumentException("Cannot run the export. No allowed outlier states are defined.");
			}
		}
		
		@Override
		public int compareTo(CompactExperimentSheetRunner compactExperimentSheetRunner) {
			return getExperimentName().compareTo(compactExperimentSheetRunner.getExperimentName());
		}
		
		@Override
		public void run() {
			Log.i("Beginning export for: " + experimentName);
			try {
				int queryCountMax = wellList.size() * endpointNames.size() * timestamps.size();
				int queryCount = 0;
				for (String currentWell : wellList) {
					StringBuilder rowBuilder = new StringBuilder();
					rowBuilder.append(metadataText);
					boolean wellPending = true;
					
					StringBuilder queryBuilder = new StringBuilder();
					
					for (String endpoint : endpointNames) {
						for (String timestampStr : timestamps) {
							int timestamp = Integer.parseInt(timestampStr);
							queryCount++;
							
							double p = (double) queryCount / (double) queryCountMax;
							String logText = experimentName + ": " + queryCount + "/" + queryCountMax + " [" + (int) (p * 100) + "%]";
							if (queryCount % 200 == 0) {
								Log.i(logText);
							} else {
								Log.v(logText);
							}
							Thread.currentThread().setName("CompactExperimentSheetRunner - " + logText);
							
							StringBuilder outlierConditionalBuilder = new StringBuilder();
							for (int i = 0; i < allowedOutlierStates.size(); i++) {
								if (i != 0) {
									outlierConditionalBuilder.append(" OR ");
								}
								outlierConditionalBuilder.append("response.outlier_type_id = ");
								outlierConditionalBuilder.append(allowedOutlierStates.get(i));
							}
							
							String query = "SELECT response.value,concentration.id\n" +
									"from response,\n" +
									"     well,\n" +
									"     endpoint,\n" +
									"     concentration,\n" +
									"     experiment\n" +
									"where well.id = response.well_id\n" +
									"  AND (" + outlierConditionalBuilder.toString() + ")\n" +
									"  AND endpoint.id = response.endpoint_id\n" +
									"  AND experiment.id = response.experiment_id\n" +
									"  AND concentration.id = response.concentration_id\n" +
									"  AND concentration.id = response.concentration_id\n" +
									"  AND response.timestamp = " + timestampStr + "\n" +
									"  AND well.name = '" + currentWell + "'\n" +
									"  AND experiment.name = '" + experimentName + "'\n" +
									"  AND endpoint.name = '" + endpoint + "'";
							ResultSet set = queryExecutor.executeQuery(query);
							if (set.next()) {
								if (wellPending) {
									long concentrationID = set.getLong(2);
									ConcentrationHolder holder = new ConcentrationHolder(concentrationID, queryExecutor);
									rowBuilder.insert(metadataText.length(), holder.getDescription() + ";" + currentWell + ";");
									wellPending = false;
								}
								
								rowBuilder.append(set.getString(1));
							}
							rowBuilder.append(";");
						}
					}
					resultRows.add(rowBuilder.toString());
				}
			} catch (Throwable e) {
				Log.e(e);
			}
			
			Log.i("Finished export: " + experimentName);
			setTerminated(true);
		}
		
		public String getExperimentName() {
			return experimentName;
		}
		
		public ArrayList<String> getResultRows() {
			return new ArrayList<>(resultRows);
		}
		
		public boolean isTerminated() {
			return terminated;
		}
		
		public void setTerminated(boolean terminated) {
			this.terminated = terminated;
		}
	}
}
