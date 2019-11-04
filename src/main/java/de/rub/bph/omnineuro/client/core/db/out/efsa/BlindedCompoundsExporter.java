package de.rub.bph.omnineuro.client.core.db.out.efsa;

import de.rub.bph.omnineuro.client.core.db.DBConnection;
import de.rub.bph.omnineuro.client.core.db.OmniNeuroQueryExecutor;
import de.rub.bph.omnineuro.client.core.db.out.ConcentrationHolder;
import de.rub.bph.omnineuro.client.core.db.out.ResponseHolder;
import de.rub.bph.omnineuro.client.core.db.out.SheetExporter;
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

public class BlindedCompoundsExporter extends SheetExporter {
	
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
		String query = "SELECT response.id, response.value, compound.name, concentration.id, endpoint.id, experiment.name, compound.abbreviation, individual.name, assay.name FROM assay, individual, compound, response,experiment,well,endpoint, concentration WHERE\n" +
				"assay.id = experiment.assay_id AND individual.id = experiment.individual_id AND response.experiment_id = experiment.id AND response.well_id = well.id AND response.endpoint_id = endpoint.id AND experiment.compound_id = compound.id AND\n" +
				" response.concentration_id = concentration.id\n" +
				" AND (endpoint.id = 4 OR endpoint.id = 1 OR endpoint.id = 2) AND response.timestamp = 72 AND experiment.name = '" + name + "' AND well.name = '" + well + "' ORDER BY endpoint_id;";
		ResultSet set = queryExecutor.executeQuery(query);
		
		if (!set.next()) {
			Log.i(name + " for " + well + " had no responses. Skipping.");
			return null;
		}
		
		String compoundName, experimentName;
		long concentrationID;
		String viabilityResponse = ";";
		String proliferationResponse = ";";
		String proliferationAreaResponse = ";";
		String individualName;
		String compoundAbbreviation;
		String assayName;
		
		do {
			assayName = set.getString(9);
			individualName = set.getString(8);
			compoundAbbreviation = set.getString(7);
			experimentName = set.getString(6);
			long endpointID = set.getLong(5);
			concentrationID = set.getLong(4);
			compoundName = set.getString(3);
			double responseValue = set.getDouble(2);
			long responseID = set.getLong(1);
			
			if (endpointID == 1) {
				proliferationResponse = responseValue + ";";
			} else if (endpointID == 2) {
				proliferationAreaResponse = responseValue + ";";
			} else if (endpointID == 4) {
				viabilityResponse = responseValue + ";";
			} else {
				throw new IllegalStateException("Wow, you ripped a hole in the fabric of the universe! Response ID " + endpointID + " was returned, but how is that possible??");
			}
		} while (set.next());
		
		ConcentrationHolder concentrationHolder = new ConcentrationHolder(concentrationID, queryExecutor);
		//individualName = individualName.substring(0, individualName.length() - 2);
		if (individualName.length() == 0 || individualName.trim().equals("")) {
			individualName = "<Unknown Individual>";
		}
		
		try {
			int individualNumeric = (int) Double.parseDouble(individualName);
			individualName = String.valueOf(individualNumeric);
		} catch (Exception e) {
			Log.w("Non numeric individual name: " + individualName);
		}
		
		while (individualName.length() < 3) {
			individualName = "0" + individualName;
		}
		
		StringBuilder row = new StringBuilder();
		WellBuilder wellBuilder = WellBuilder.convertWell(well);
		row.append(compoundName + ";"); //TODO compound
		row.append(experimentName + ";");
		
		row.append(wellBuilder.getRow() + ";");
		row.append(wellBuilder.getColExtended() + ";");
		
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
		
		row.append(viabilityResponse);
		row.append(proliferationResponse);
		row.append(proliferationAreaResponse);
		
		row.append(experimentName + "_??_" + assayName + "_" + individualName);
		
		return row.toString();
	}
	
	@Override
	public void run() {
		responseHolders = new ArrayList<>();
		try {
			for (long id : responseIDs) {
				ResponseHolder holder = new ResponseHolder(id, queryExecutor);
				responseHolders.add(holder);
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
				return WellBuilder.convertWell(o1).compareTo(WellBuilder.convertWell(o2));
			}
		});
		
		for (String name : uniqueNames) {
			for (String well : uniqueWells) {
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
			}
		}
		
		File outFile = new File(targetDir, "blindCompounds.csv");
		FileManager fileManager = new FileManager();
		try {
			fileManager.writeFile(outFile, builder.toString());
		} catch (IOException e) {
			Log.e(e);
		}
	}
	
	public static String getFileHeader() {
		return "spid;apid;rowi;coli;wllt;wllq;conc;rval;rval;rval;srcf\n" +
				"sample ID from source plate;Unique plate ID (no repeated plates across assay endpoint);row index;column index;well type;well quality;concentration (µM);raw value of response;raw value of response;raw value of response;source file name\n" +
				";;;;;;;Viability 72h;Proliferation (BrdU);Proliferation Area;\n";
	}
}
