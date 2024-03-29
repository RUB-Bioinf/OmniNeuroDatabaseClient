package de.rub.bph.omnineuro.client.core.db.in;

import de.rub.bph.omnineuro.client.core.db.QueryExecutor;
import de.rub.bph.omnineuro.client.core.db.out.holder.CompoundHolder;
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

import static de.rub.bph.omnineuro.client.core.sheet.reader.ExperimentDataReaderTask.ENDPOINT_DOUBLE_INDICATOR;

public class AXESInserter extends DBInserter implements Runnable {
	
	public static final String INVALID_INDIVIDUAL_NAME = "<unknown individual>";
	public static final String INVALID_MUTATION_NAME = "<unknown mutation>";
	public static final String INVALID_SEX_NAME = "undefined";
	public static final String INVALID_SPECIES_NAME = "unknown";
	private static final String INVALID_CELL_LINE_NAME = "<unknown cell line>";
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
	
	@Override
	public void run() {
		try {
			//First: Get all the metadata from the experiment JSON
			Log.i("Running inserter on experiment: " + data.getString("SourceFile"));
			
			JSONObject metaData = data.getJSONObject("MetaData");
			String comment = metaData.getString("Comments");
			
			JSONObject metaDataGeneral = metaData.getJSONObject("General").getJSONObject("Data");
			JSONObject metaDataSolvent = metaData.getJSONObject("Solvents").getJSONObject("Data");
			JSONObject metaDataPassages = metaData.getJSONObject("Passages").getJSONObject("Data");
			
			String projectName = metaDataGeneral.getString("Project");
			String assay = metaDataGeneral.getString("Assay");
			String experimentName = metaDataGeneral.getString("ExperimentID");
			String compound = metaDataGeneral.getString("Compound");
			String casNR = metaDataGeneral.getString("CAS No.");
			String compoundAbbreviation = metaDataGeneral.getString("Compound abbreviation");
			String cellType = metaDataGeneral.getString("Cell type");
			String species = metaDataGeneral.getString("Species");
			String plateFormat = metaDataGeneral.getString("Plateformat");
			String sex = metaDataGeneral.getString("Sex");
			String workgroup = metaDataGeneral.getString("Department"); //Workgroup under department? Yep. This is intentional.
			
			String individual = null;
			String mutation = null;
			String cellLine = null;
			if (metaDataGeneral.has("Individual")) {
				individual = metaDataGeneral.getString("Individual");
			}
			if (metaDataGeneral.has("Mutation")) {
				mutation = metaDataGeneral.getString("Mutation");
			}
			if (metaDataGeneral.has("Cell line")) {
				cellLine = metaDataGeneral.getString("Cell line");
			}
			
			if (compound.equals("0.0")) {
				//If there was no compound meta data sheet provided, the formula evaluator returns '0.0'. That's an error.
				throw new IllegalStateException("Failed to read the meta data sheet containing the compound for " + experimentName + "!");
			}
			
			String controlPlateID = "?";
			if (metaDataGeneral.has("control Plate ID")) {
				controlPlateID = metaDataGeneral.getString("control Plate ID");
			}
			
			String solvent = metaDataSolvent.getString("Solvent");
			solvent = solvent.toUpperCase().trim();
			double solventConcentration = -1.0;
			if (metaDataSolvent.has("Solvent conc.*")) {
				solventConcentration = metaDataSolvent.getDouble("Solvent conc.*");
			}
			if (Double.isNaN(solventConcentration)) {
				addError("Warning: Solvent has illegal values!");
				solventConcentration = -1.0;
			}
			
			long solventID = -1;
			try {
				solventID = executor.getIDViaName("solvent", solvent);
			} catch (Throwable e) {
				addError("The solvent '" + solvent + "', is not in the database!");
			}
			
			casNR = casNR.trim();
			if (casNR.equals("00-00-0") || casNR.equals("??-??-??")) {
				addError("Cas Nr. was " + casNR + ". This got fixed by a workaround. This should be fixed or you create technical debt.", true);
				//FIXME Technical debt detected!
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
			if (!isCompatibleCompoundName(compound)) {
				addError("Warning: The compound '" + compound + "' has potentially troubling characters. Make sure it's alphanumeric! [Special connecting characters are allowed.]");
			}
			
			long individualID;
			long mutationID;
			long cellLineID;
			if (individual == null && mutation == null) {
				addError("Sheet has neither an individual or a mutation!");
			}
			
			if (individual == null) {
				individualID = getInvalidIndividualID();
			} else {
				individualID = getIndividualID(individual, sex, species);
			}
			if (mutation == null) {
				mutationID = getInvalidMutationID();
			} else {
				mutationID = getMutationID(mutation);
			}
			if (cellLine == null) {
				cellLineID = getInvalidCellLineID();
			} else {
				cellLineID = getCellLineID(cellLine);
			}
			
			//But first: Let me take a sel... the necessary IDs of existing meta data from the Database
			long assayID = executor.getIDViaName("assay", assay);
			long cellTypeID = executor.getIDViaName("cell_type", cellType);
			long projectID = executor.getIDViaName("project", projectName);
			long plateFormatID = executor.getIDViaName("plate_format", plateFormat);
			long workgroupID = executor.getIDViaName("workgroup", workgroup);
			
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
					addError("Failed to resolve compound name: '" + compound + "' [" + compoundAbbreviation + "]. That's okay, if a valid Cas Nr. is provided instead: '" + casNR + "'.");
					compoundID = executor.getIDViaFeature("compound", "cas_no", casNR);
					String newCompoundName = executor.getNameViaID("compound", compoundID);
					addError("\t\t\tBut that CAS Nr. existed in the DB and the compound was resolved as '" + newCompoundName + "'.");
				}
			}
			
			if (metaDataGeneral.has("Molecular weight")) {
				NumberUtils numberUtils = new NumberUtils();
				String molecularWeight = metaDataGeneral.getString("Molecular weight");
				if (numberUtils.isNumeric(molecularWeight) && !molecularWeight.toLowerCase().equals("nan")) {
					double weight = Double.parseDouble(molecularWeight);
					executor.updateTable("compound", "molecular_weight", String.valueOf(weight), compoundID);
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
						compoundAbbreviation = compoundHolder.getAbbreviation();
						compoundID = compoundHolder.getCompoundID();
					}
				} else {
					addBlindingRow(compound + " is not a blinded compound.");
				}
			}
			
			long experimentID;
			synchronized (executor) {
				experimentID = executor.getNextSequenceTableVal("experiment");
				executor.insertExperiment(experimentID, date.getTime(), experimentName, projectID, workgroupID, individualID, mutationID, compoundID, cellTypeID, assayID, plateFormatID, solventID, solventConcentration, controlPlateID, cellLineID);
			}
			
			for (String passageP : JSONOperator.getKeys(metaDataPassages)) {
				try {
					int p = (int) Double.parseDouble(passageP);
					String passageDate = metaDataPassages.getString(passageP);
					DateInterpreter interpreter = new DateInterpreter(passageDate);
					
					long passageDateValue = interpreter.interpretDate().getTime();
					executor.insertPassage(experimentID, passageDateValue, p);
				} catch (Throwable e) {
					Log.e(e);
					addError("Failed to insert passage '" + passageP + "' for " + experimentName + ". Reason: " + e.getMessage());
				}
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
				
				String endpointDoubleIndicator = String.valueOf(ENDPOINT_DOUBLE_INDICATOR);
				endpoint = endpoint.replace(endpointDoubleIndicator, "");
				
				if (endpoint.equals("Cytotoxicity")) {
					endpoint = endpoint + " (" + assay + ")";
					addError("The cytotox endpoint has been adjusted by a workaround in the code! This leads to technical debt if not fixed!", true);
					//FIXME Technical debt detected!
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
						long wellID = wellNotAvailableID;
						String currentWell = "<well unknown>";
						
						if (response.has("well")) {
							synchronized (executor) {
								String well = response.getString("well");
								currentWell = well;
								try {
									wellID = executor.getIDViaName("well", well);
								} catch (Throwable e2) {
									Log.i("Failed to fetch well '" + well + "' from the DB. Inserting it instead!");
									executor.insertWell(well);
									wellID = executor.getIDViaName("well", well);
								}
							}
						}
						
						double result;
						try {
							result = response.getDouble("value");
						} catch (JSONException e) {
							String s = response.getString("value");
							if (s == null) {
								s = "";
							}
							addError("The  " + endpoint + " at " + timestamp + " in " + experimentName + " at concentration " + concentration + " in " + currentWell + " is an invalid value: '" + s + "'. Skipping this response.", s.length() == 0);
							continue;
						}
						
						boolean nan = Double.isNaN(result);
						if (nan) {
							incrementNaNCount();
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
			String fatalErrorText = " == FATAL ERROR! == Failed to insert Experiment " + getName() + " into the database! Error Type: " + e.getClass().getSimpleName() + ". Reason: '" + e.getMessage() + "'";
			if (e instanceof SQLException) {
				fatalErrorText = fatalErrorText + ". Last SQL query: " + QueryExecutor.getLastCachedQuery();
			}
			
			Log.e("Failed to insert Experiment: " + getName(), e);
			addError(fatalErrorText);
		}
		Log.i("Finished inserting responses for " + getName() + ". Count: " + getInsertedResponsesCount());
		setFinished();
	}
	
	public static synchronized long getInvalidIndividualID() throws JSONException, SQLException {
		long individualID;
		
		synchronized (executor) {
			try {
				individualID = executor.getIDViaName("individual", INVALID_INDIVIDUAL_NAME);
			} catch (Throwable e) {
				long sexID = executor.getIDViaFeature("sex", "label", INVALID_SEX_NAME);
				long speciesID = executor.getIDViaName("species", INVALID_SPECIES_NAME);
				
				individualID = executor.getNextSequenceTableVal("individual");
				executor.insertIndividual(individualID, INVALID_INDIVIDUAL_NAME, sexID, speciesID);
			}
		}
		
		return individualID;
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
	
	public static synchronized long getInvalidMutationID() throws SQLException {
		long mutationID;
		
		synchronized (executor) {
			try {
				mutationID = executor.getIDViaName("mutation", INVALID_MUTATION_NAME);
			} catch (Throwable e) {
				mutationID = executor.getNextSequenceTableVal("mutation");
				executor.insertMutation(mutationID, INVALID_MUTATION_NAME);
			}
		}
		
		return mutationID;
	}
	
	private synchronized long getMutationID(String mutation) throws SQLException {
		long mutationID;
		
		synchronized (executor) {
			try {
				mutationID = executor.getIDViaName("mutation", mutation);
			} catch (Throwable e) {
				mutationID = executor.getNextSequenceTableVal("mutation");
				executor.insertMutation(mutationID, mutation);
			}
		}
		
		return mutationID;
	}
	
	public static synchronized long getInvalidCellLineID() throws SQLException {
		long cellLineID;
		
		synchronized (executor) {
			try {
				cellLineID = executor.getIDViaName("cell_line", INVALID_CELL_LINE_NAME);
			} catch (Throwable e) {
				cellLineID = executor.getNextSequenceTableVal("cell_line");
				executor.insertCellLine(cellLineID, INVALID_CELL_LINE_NAME);
			}
		}
		
		return cellLineID;
	}
	
	private synchronized long getCellLineID(String cellLine) throws SQLException {
		long cellLineID;
		
		synchronized (executor) {
			try {
				cellLineID = executor.getIDViaName("cell_line", cellLine);
			} catch (Throwable e) {
				cellLineID = executor.getNextSequenceTableVal("cell_line");
				executor.insertCellLine(cellLineID, cellLine);
			}
		}
		
		return cellLineID;
	}
	
	@Override
	public String getName() {
		return name;
	}
	
}
