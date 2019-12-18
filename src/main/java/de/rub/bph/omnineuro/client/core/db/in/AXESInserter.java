package de.rub.bph.omnineuro.client.core.db.in;

import de.rub.bph.omnineuro.client.core.sheet.data.DateInterpreter;
import de.rub.bph.omnineuro.client.imported.log.Log;
import de.rub.bph.omnineuro.client.util.JSONOperator;
import de.rub.bph.omnineuro.client.util.NumberUtils;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.io.File;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;

public class AXESInserter extends DBInserter implements Runnable {
	
	private JSONObject data;
	private String name;
	
	public AXESInserter(JSONObject data, boolean attemptUnblinding) {
		super(attemptUnblinding);
		this.data = data;
		
		name = "<Unknown>";
		try {
			File f = new File(data.getString("SourceFile"));
			name = f.getName();
		} catch (Throwable e) {
			Log.e(e);
		}
	}
	
	private synchronized long getIndividualID(String individual, String sex, String species) throws JSONException, SQLException {
		long individualID;
		
		synchronized (executor) {
			try {
				individualID = executor.getIDViaName("individual", individual);
			} catch (Throwable e) {
				long sexID = executor.getIDViaFeature("sex", "label", sex);
				long speciesID = executor.getIDViaName("species", species);
				
				individualID = executor.getNextSequenceTableVal("individual");
				executor.insertIndividual(individualID, individual, sexID, speciesID);
				Log.i("New individual inserted into the database. Name: '" + individual + "'. ID: " + individualID);
				addError("Warning. Individual '" + individual + "' was not in the database. It has been added. Species: " + species + ". Sex: " + sex);
			}
		}
		
		return individualID;
	}
	
	@Override
	public void run() {
		try {
			//First: Get all the metadata from the experiment JSON
			Log.i("Running inserter on experiment: " + data.getString("SourceFile"));
			
			JSONObject metaData = data.getJSONObject("MetaData");
			String comment = metaData.getString("Comments");
			
			JSONObject metaDataGeneral = metaData.getJSONObject("General").getJSONObject("Data");
			String projectName = metaDataGeneral.getString("Project");
			String assay = metaDataGeneral.getString("Assay");
			String experimentName = metaDataGeneral.getString("ExperimentID");
			String individual = metaDataGeneral.getString("Individual");
			String compound = metaDataGeneral.getString("Compound");
			String casNR = metaDataGeneral.getString("CAS No.");
			String compuntAbbreviation = metaDataGeneral.getString("Compound abbreviation");
			String cellType = metaDataGeneral.getString("Cell type");
			String species = metaDataGeneral.getString("Species");
			String plateFormat = metaDataGeneral.getString("Plateformat");
			String sex = metaDataGeneral.getString("Sex");
			String workgroup = metaDataGeneral.getString("Department"); //Workgroup under department? Yep. This is intentional.
			
			if (casNR.equals("00-00-0") || casNR.equals("??-??-??")) {
				addError("Cas Nr. was " + casNR + ". This got fixed by a workaround. This should be fixed or you create technical debt.");
				casNR = "??-??-?";
			}
			
			Date date = new Date(0);
			String platingDate = metaDataGeneral.getString("Plating date (ddMONjj)");
			try {
				date = new DateInterpreter(platingDate).interpretDate();
				Log.i("Self check on date: " + platingDate + " -> " + new SimpleDateFormat("dd.MM.yyyy").format(date));
			} catch (Throwable e) {
				Log.e("Failed to interpret plating date!", e);
				addError("Unable to interpret plating date: '" + platingDate + "'! Are you sure this is the right format?");
			}
			
			if (compound.equals("NaN")) {
				addError("Compound is unknown!", true);
			}
			
			//Next: Insert it into the database
			Log.i("TODO: Actually insert it now...");
			
			//But first: Let me take a sel... the necessary IDs of existing meta data from the Database
			long assayID = executor.getIDViaName("assay", assay);
			long cellTypeID = executor.getIDViaName("cell_type", cellType);
			long projectID = executor.getIDViaName("project", projectName);
			long plateformatID = executor.getIDViaName("plate_format", plateFormat);
			long workgroupID = executor.getIDViaName("workgroup", workgroup);
			
			long individualID = getIndividualID(individual, sex, species);
			long wellNotAvailableID = executor.getIDViaName("well", "Unknown");
			long detectionMethodNotAvailableID = executor.getIDViaName("detection_method", "Unknown");
			
			long compoundID;
			try {
				compoundID = executor.getIDViaName("compound", compound);
			} catch (Throwable e) {
				if (compound.equals("?") || compound.equals(casNR)) {
					Log.i("It is assumed that '" + casNR + "' is a blinded compound. It's not yet present in the database. Fetching it!");
					
					synchronized (executor) {
						try {
							compoundID = executor.getIDViaFeature("compound", "cas_no", casNR);
							Log.i("The blinded compound '" + casNR + "' was already in the DB. All good.");
						} catch (Throwable e2) {
							Log.i("Failed to fetch blinded compound '" + casNR + "' from the DB. Inserting it instead!");
							executor.insertCompound(casNR, casNR, casNR, true);
							compoundID = executor.getIDViaName("compound", casNR);
						}
					}
				} else {
					addError("Failed to resolve compound name: '" + compound + "' [" + compuntAbbreviation + "]. That's okay, if a valid Cas Nr. is provided instead: '" + casNR + "'.");
					compoundID = executor.getIDViaFeature("compound", "cas_no", casNR);
					String newCompoundName = executor.getNameViaID("compound", compoundID);
					addError("\t\t\tBut that CAS Nr. existed in the DB and the compound was resolved as '" + newCompoundName + "'.");
				}
			}
			
			String blindedQueryResult = executor.getFeatureViaID("compound", "blinded", compoundID).toLowerCase();
			boolean blindedCompound = (blindedQueryResult.equals("t") || blindedQueryResult.equals("true") || blindedQueryResult.equals("1"));
			
			if (attemptUnblinding) {
				if (blindedCompound) {
					CompoundHolder compoundHolder = attemptUnblinding(casNR);
					if (compoundHolder != null) {
						compound = compoundHolder.getName();
						casNR = compoundHolder.getCas();
						compuntAbbreviation = compoundHolder.getAbbreviation();
						compoundID = compoundHolder.getCompoundID();
					}
				} else {
					addBlindingRow(compound + " is not a blinded compound.");
				}
			}
			
			long experimentID;
			synchronized (executor) {
				experimentID = executor.getNextSequenceTableVal("experiment");
				executor.insertExperiment(experimentID, date.getTime(), experimentName, projectID, workgroupID, individualID, compoundID, cellTypeID, assayID, plateformatID);
			}
			
			executor.insertComment(comment, experimentID);
			
			//Now comes actual experiment data
			NumberUtils numberUtils = new NumberUtils();
			JSONObject experimentData = data.getJSONObject("ExperimentData").getJSONObject("Endpoints");
			
			long outlierID = executor.getIDViaName("outlier_type", "Unchecked");
			for (String endpoint : JSONOperator.getKeys(experimentData)) {
				JSONObject endpointData = experimentData.getJSONObject(endpoint);
				int timestamp = endpointData.getInt("timestamp");
				String detectionMethod = endpointData.getString("detectionMethod");
				JSONObject responses = endpointData.getJSONObject("responses");
				
				if (endpoint.equals("Cytotoxicity")) {
					endpoint = endpoint + " (" + assay + ")";
					addError("The cytotox endpoint has been by a workaround. This leads to technical debt if not fixed!");
				}
				
				long endpointID;
				try {
					endpointID = executor.getIDViaName("endpoint", endpoint);
				} catch (Throwable t) {
					Log.e(t);
					addError("Unable to find an endpoint in the database named '" + endpoint + "'.");
					continue;
				}
				
				long detectionMethodID;
				try {
					detectionMethodID = executor.getIDViaName("detection_method", detectionMethod);
				} catch (Throwable e2) {
					addError("The detection method '" + detectionMethod + "', stated by this experiment for endpoint " + endpoint + " is not in the database!");
					continue;
				}
				
				for (String concentration : JSONOperator.getKeys(responses)) {
					boolean control = !numberUtils.isNumeric(concentration);
					
					long controlID;
					long concentrationID;
					if (control) {
						try {
							controlID = executor.getIDViaName("control", concentration);
						} catch (Throwable e) {
							Log.e(e);
							addError("Unknown concentration entry found. I think this concentration is actually a control. But I can't find a control in the database with this name: '" + concentration + "'.");
							continue;
						}
						concentrationID = executor.insertConcentration(0, controlID);
					} else {
						controlID = executor.getIDViaName("control", "No control");
						double d = Double.parseDouble(concentration);
						
						if (d == 0) {
							addError("A concentration for endpoint " + endpoint + " at " + timestamp + "h is zero, but this is not a control.");
						}
						if (d < 0) {
							addError("The concentration for endpoint " + endpoint + " at " + timestamp + "h is negative!");
						}
						
						concentrationID = executor.insertConcentration(d);
					}
					
					JSONArray results = responses.getJSONArray(concentration);
					Log.i(endpoint + " -> " + concentration + " [ID: " + concentrationID + "] (Control: " + control + " [ID: " + controlID + "]) -> Responses: " + results);
					
					for (int i = 0; i < results.length(); i++) {
						JSONObject response = results.getJSONObject(i);
						double result = response.getDouble("value");
						
						boolean nan = Double.isNaN(result);
						if (nan) {
							incrementNaNCount();
						}
						
						long wellID = wellNotAvailableID;
						if (response.has("well")) {
							synchronized (executor) {
								String well = response.getString("well");
								try {
									wellID = executor.getIDViaName("well", well);
								} catch (Throwable e2) {
									Log.i("Failed to fetch well '" + well + "' from the DB. Inserting it instead!");
									executor.insertWell(well);
									wellID = executor.getIDViaName("well", well);
								}
							}
						}
						
						try {
							executor.insertResponse(result, timestamp, endpointID, concentrationID, experimentID, wellID, outlierID, detectionMethodID);
						} catch (Throwable e) {
							addError("Failed to insert response '" + result + "' for endpoint " + endpoint + " at " + timestamp + "h for concentration " + concentration + " into the database. Reason: " + e.getMessage().replace("\n", " "), nan);
							continue;
						}
						
						incrementInsertedResponsesCount();
					}
				}
			}
		} catch (Throwable e) {
			Log.e("Failed to insert Experiment: " + getName(), e);
			addError("Failed to insert Experiment " + getName() + " into the database! Error Type: " + e.getClass().getSimpleName() + ". Reason: '" + e.getMessage() + "'");
		}
		Log.i("Finished inserting responses for " + getName() + ". Count: " + getInsertedResponsesCount());
	}
	
	@Override
	public String getName() {
		return name;
	}
	
}
