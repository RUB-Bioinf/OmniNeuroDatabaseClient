package de.rub.bph.omnineuro.client.core.db.out.efsa;

import de.rub.bph.omnineuro.client.core.db.DBConnection;
import de.rub.bph.omnineuro.client.core.db.OmniNeuroQueryExecutor;
import de.rub.bph.omnineuro.client.core.db.out.ResponseExporter;
import de.rub.bph.omnineuro.client.core.db.out.holder.ConcentrationHolder;
import de.rub.bph.omnineuro.client.core.db.out.holder.ResponseHolder;
import de.rub.bph.omnineuro.client.imported.filemanager.FileManager;
import de.rub.bph.omnineuro.client.imported.log.Log;
import de.rub.bph.omnineuro.client.util.WellBuilder;

import java.io.File;
import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;

public class BlindedCompoundsExporter extends ResponseExporter {
	
	protected OmniNeuroQueryExecutor queryExecutor;
	private ArrayList<ResponseHolder> responseHolders;
	
	public BlindedCompoundsExporter(File targetDir, DBConnection connection, ArrayList<Long> responseIDs, boolean useComma) {
		super(targetDir, connection, responseIDs, useComma);
		queryExecutor = new OmniNeuroQueryExecutor(connection.getConnection());
		queryExecutor.setLogEnabled(true);
	}
	
	@Deprecated
	private String getRow(ResponseHolder holder) {
		String well = holder.getWell();
		WellBuilder wellBuilder = WellBuilder.convertWell(well);
		long experimentID = holder.getExperimentID();
		
		StringBuilder row = new StringBuilder();
		row.append("?"); //TODO compound
		row.append(holder.getExperimentName() + ";");
		
		row.append(wellBuilder.getRow() + ";");
		row.append(wellBuilder.getColExtended() + ";");
		
		row.append("?;");
		row.append("1;");
		
		row.append(holder.getConcentrationDescription() + ";");
		
		row.append(holder.getResponse() + ";;;");
		row.append("BlaBlaBla" + ";;;");
		
		return row.toString();
	}
	
	private String getRow(String name, String well) throws SQLException {
		String query = "SELECT response.id, response.value, compound.name, concentration.id, endpoint.id, experiment.name, compound.abbreviation, individual.name, assay.name, response.timestamp FROM assay, individual, compound, response,experiment,well,endpoint, concentration WHERE\n" +
				"assay.id = experiment.assay_id AND individual.id = experiment.individual_id AND response.experiment_id = experiment.id AND response.well_id = well.id AND response.endpoint_id = endpoint.id AND experiment.compound_id = compound.id AND\n" +
				" response.concentration_id = concentration.id\n" +
				" AND (endpoint.id = 17 OR endpoint.id = 20 OR endpoint.id = 23 OR endpoint.id = 49 OR endpoint.id = 19 OR\n" +
				"       endpoint.id = 16 OR endpoint.id = 15 OR endpoint.id = 54 OR endpoint.id = 22 OR endpoint.id = 51 OR\n" +
				"       endpoint.id = 4 OR endpoint.id = 1 OR endpoint.id = 2 OR endpoint.id = 8) " +
				" AND (response.timestamp = 72 OR response.timestamp = 120) AND experiment.name = '" + name + "' AND well.name = '" + well + "' ORDER BY endpoint_id;";
		ResultSet set = queryExecutor.executeQuery(query);
		
		if (!set.next()) {
			Log.v(name + " for " + well + " had no responses. Skipping.");
			return null;
		}
		
		String compoundName, experimentName;
		long concentrationID;
		
		String viabilityResponse72 = ";";
		String proliferationResponse72 = ";";
		String proliferationAreaResponse72 = ";";
		String migration72 = ";";
		String migrationDistance120 = ";";
		String meanMigrationDistanceAllNeurons120 = ";";
		String meanMigrationDistanceAllOligodendrocytes120 = ";";
		String numberNuclei120 = ";";
		String skeletonNeurons120 = ";";
		String totalSubneuritelengthPerNucleusLimited120 = ";";
		String meanNeuriteAreaWoNuclei120 = ";";
		String skeletonOligos120 = ";";
		String cytotoxicityNPC25_72 = ";";
		String cytotoxicityNPC25_120 = ";";
		String viabillity120 = ";";
		
		String individualName;
		String compoundAbbreviation;
		String assayName;
		int timestamp;
		
		do {
			timestamp = set.getInt(10);
			assayName = set.getString(9);
			individualName = set.getString(8);
			compoundAbbreviation = set.getString(7);
			experimentName = set.getString(6);
			long endpointID = set.getLong(5);
			concentrationID = set.getLong(4);
			compoundName = set.getString(3);
			double responseValue = set.getDouble(2);
			long responseID = set.getLong(1);
			
			if (timestamp == 72) {
				if (endpointID == 1) {
					proliferationResponse72 = responseValue + ";";
				} else if (endpointID == 2) {
					proliferationAreaResponse72 = responseValue + ";";
				} else if (endpointID == 4) {
					viabilityResponse72 = responseValue + ";";
				} else if (endpointID == 17) {
					migration72 = responseValue + ";";
				} else if (endpointID == 51) {
					cytotoxicityNPC25_72 = responseValue + ";";
				} else {
					throw new IllegalStateException("Invalid endpoint ID for " + experimentName + " at " + well + " at " + timestamp + "! Endpoint ID " + endpointID + " was unexpected.");
				}
			} else if (timestamp == 120) {
				if (endpointID == 20) {
					migrationDistance120 = responseValue + ";";
				} else if (endpointID == 23) {
					meanMigrationDistanceAllNeurons120 = responseValue + ";";
				} else if (endpointID == 8) {
					meanMigrationDistanceAllOligodendrocytes120 = responseValue + ";";
				} else if (endpointID == 19) {
					numberNuclei120 = responseValue + ";";
				} else if (endpointID == 16) {
					skeletonNeurons120 = responseValue + ";";
				} else if (endpointID == 15) {
					totalSubneuritelengthPerNucleusLimited120 = responseValue + ";";
				} else if (endpointID == 54) {
					meanNeuriteAreaWoNuclei120 = responseValue + ";";
				} else if (endpointID == 22) {
					skeletonOligos120 = responseValue + ";";
				} else if (endpointID == 51) {
					cytotoxicityNPC25_120 = responseValue + ";";
				} else if (endpointID == 4) {
					viabillity120 = responseValue + ";";
				} else {
					throw new IllegalStateException("Invalid endpoint ID for " + experimentName + " at " + well + " at " + timestamp + "! Endpoint ID " + endpointID + " was unexpected.");
				}
			} else {
				throw new IllegalStateException("Received an illegal timestamp for " + experimentName + " at " + well + ": " + timestamp);
			}
		} while (set.next());
		
		ConcentrationHolder concentrationHolder = new ConcentrationHolder(concentrationID, queryExecutor);
		//individualName = individualName.substring(0, individualName.length() - 2);
		if (individualName.length() == 0 || individualName.trim().equals("")) {
			individualName = "<Unknown Individual>";
			addError("Experiment " + experimentName + " has an unknown individual.");
		}
		
		try {
			int individualNumeric = (int) Double.parseDouble(individualName);
			individualName = String.valueOf(individualNumeric);
		} catch (Exception e) {
			Log.w("Non numeric individual name: " + individualName);
			addError("Experiment " + experimentName + " has a non numeric individual. Individual read: '" + individualName + "'");
		}
		
		while (individualName.length() < 3) {
			individualName = "0" + individualName;
		}
		
		StringBuilder row = new StringBuilder();
		WellBuilder wellBuilder = null;
		try {
			wellBuilder = WellBuilder.convertWell(well);
		} catch (IllegalArgumentException e) {
			addError("Experiment " + experimentName + " has an invalid well name: '" + well + "'");
		}
		
		row.append(compoundName + ";"); //TODO compound
		row.append(experimentName + ";");
		
		if (wellBuilder == null) {
			row.append("<unknown>;<unknown>;");
		} else {
			row.append(wellBuilder.getRow() + ";");
			row.append(wellBuilder.getColExtended() + ";");
		}
		
		String wellType = "t";
		if (concentrationHolder.isControl()) {
			String acronym = concentrationHolder.getControlAcronym();
			if (acronym == null) {
				throw new IllegalStateException("Concentration of control with id " + concentrationID + " has no Acronym!");
			}
			switch (acronym) {
				case "SC":
					wellType = "n";
					break;
				case "PC":
					wellType = "p1";
					break;
				case "BGBrdU":
					wellType = "b1";
					break;
				case "BG":
					wellType = "b2";
					break;
				case "LC":
					wellType = "p2";
					break;
				default:
					wellType = "?";
					Log.w("Warning! Unexpected Well type for " + experimentName + " at " + well + ": " + concentrationHolder.getControlName());
					break;
			}
		}
		row.append(wellType + ";");
		row.append("1;");
		row.append(concentrationHolder.getDescription() + ";");
		
		row.append(migration72);
		row.append(migrationDistance120);
		row.append(meanMigrationDistanceAllNeurons120);
		row.append(meanMigrationDistanceAllOligodendrocytes120);
		row.append(numberNuclei120);
		row.append(skeletonNeurons120);
		row.append(totalSubneuritelengthPerNucleusLimited120);
		row.append(meanNeuriteAreaWoNuclei120);
		row.append(skeletonOligos120);
		row.append(cytotoxicityNPC25_72);
		row.append(cytotoxicityNPC25_120);
		row.append(viabillity120);
		
		row.append(viabilityResponse72);
		row.append(proliferationResponse72);
		row.append(proliferationAreaResponse72);
		
		row.append(experimentName + "_??_" + assayName + "_" + individualName);
		
		return row.toString();
	}
	
	@Override
	public void run() {
		responseHolders = new ArrayList<>();
		queryExecutor.setLogEnabled(false);
		
		try {
			int fivePercent = (int) (responseIDs.size() * .05);
			for (int i = 0; i < responseIDs.size(); i++) {
				long id = responseIDs.get(i);
				ResponseHolder holder = new ResponseHolder(id, queryExecutor);
				responseHolders.add(holder);
				
				if (i % fivePercent == 0) {
					Log.i("Holder created: " + i + "/" + responseIDs.size() + " -> " + (int) (((double) i / (double) responseIDs.size()) * 100) + "%");
				}
			}
		} catch (SQLException e) {
			Log.e(e);
			e.printStackTrace();
		}
		
		StringBuilder builder = new StringBuilder();
		builder.append(getFileHeader());
		
		ArrayList<String> uniqueNames = ResponseHolder.getUniqueExperimentNames(responseHolders);
		ArrayList<String> uniqueWells = ResponseHolder.getUniqueWells(responseHolders);
		Collections.sort(uniqueNames);
		Collections.sort(uniqueWells, new Comparator<String>() {
			@Override
			public int compare(String o1, String o2) {
				try {
					return WellBuilder.convertWell(o1).compareTo(WellBuilder.convertWell(o2));
				} catch (Exception e) {
					return o1.compareTo(o2);
				}
			}
		});
		
		File outFile = new File(targetDir, "blindCompounds.csv");
		File outErrors = new File(targetDir, "errors.txt");
		FileManager fileManager = new FileManager();
		
		int count = 0;
		int combinedVals = uniqueNames.size() * uniqueWells.size();
		int fivePercent = (int) (combinedVals * .05);
		for (String name : uniqueNames) {
			for (String well : uniqueWells) {
				count++;
				String row = null;
				try {
					row = getRow(name, well);
				} catch (SQLException e) {
					e.printStackTrace();
				}
				
				if (row != null) {
					builder.append(row);
					builder.append("\n");
				}
				
				if (count % fivePercent == 0) {
					Log.i("Row: " + count + " / " + combinedVals + " -> " + (int) (((double) count / (double) combinedVals) * 100) + "%");
				}
				
				try {
					fileManager.writeFile(outFile, builder.toString());
				} catch (IOException e) {
					Log.e(e);
				}
			}
		}
		
		try {
			fileManager.writeFile(outFile, builder.toString());
			fileManager.saveListFile(errorList, outErrors);
		} catch (IOException e) {
			Log.e(e);
		}
	}
	
	public static String getFileHeader() {
		return "spid;apid;rowi;coli;wllt;wllq;conc;rval;rval;rval;rval;rval;rval;rval;rval;rval;rval;rval;rval;rval;rval;rval;srcf\n" +
				"sample ID from source plate;Unique plate ID (no repeated plates across assay endpoint);row index;column index;well type;well quality;concentration (µM);raw value of response;raw value of response;raw value of response;source file name\n" +
				";;;;;;;" +
				"Migration [72h];" +
				"Migration Distance [120h];" +
				"Mean Migration Distance all neurons [120h];" +
				"Mean Migration Distance all Oligodendrocytes [120h];" +
				"Number Nuclei [120h];" +
				"Skeleton Neurons [120h];" +
				"Total Subneuritelength per Nucleus limited [120h];" +
				"Mean Neurite Area wo Nuclei [120h];" +
				"Skeleton Oligos [120h];" +
				"Cytotoxicity (NPC2-5) [72h];" +
				"Cytotoxicity (NPC2-5) [120h];" +
				"Viabillity [120h];" +
				"Viability [72h];" +
				"Proliferation (BrdU) [72h];" +
				"Proliferation Area [72h];\n";
	}
}
