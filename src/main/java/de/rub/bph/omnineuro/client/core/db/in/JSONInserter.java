package de.rub.bph.omnineuro.client.core.db.in;

import de.rub.bph.omnineuro.client.core.db.DBConnection;
import de.rub.bph.omnineuro.client.core.db.OmniNeuroQueryExecutor;
import de.rub.bph.omnineuro.client.core.sheet.data.DateInterpreter;
import de.rub.bph.omnineuro.client.imported.log.Log;
import de.rub.bph.omnineuro.client.util.JSONOperator;
import de.rub.bph.omnineuro.client.util.NumberUtils;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.io.File;
import java.sql.Connection;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

public class JSONInserter extends JSONOperator implements Runnable {

	private static OmniNeuroQueryExecutor executor;

	private ArrayList<String> errors;
	private JSONObject data;
	private String name;
	private int insertedResponses;
	private int NaNCounts;

	public JSONInserter(JSONObject data) {
		this.data = data;
		Connection connection = DBConnection.getDBConnection().getConnection();
		errors = new ArrayList<>();
		insertedResponses = 0;
		NaNCounts = 0;

		if (executor == null) {
			executor = new OmniNeuroQueryExecutor(connection);
		}

		name = "<Unknown>";
		try {
			File f = new File(data.getString("SourceFile"));
			name = f.getName();
		} catch (Throwable e) {
			Log.e(e);
		}
	}

	public String getName() {
		return name;
	}

	public void insert() {
		run();
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
			String cellType = metaDataGeneral.getString("Cell type");
			String species = metaDataGeneral.getString("Species");
			String plateFormat = metaDataGeneral.getString("Plateformat");

			Date date = new Date(0);
			String platingDate = metaDataGeneral.getString("Plating date (ddMONjj)");
			try {
				date = new DateInterpreter(platingDate).interpretDate();
				Log.i("Self check on date: " + platingDate + " -> " + new SimpleDateFormat("dd.MM.yyyy").format(date));
			} catch (Throwable e) {
				Log.e("Failed to interpret plating date!", e);
				addError("Unable to interpret plating date: '" + platingDate + "'! Are you sure this is the right format?");
			}

			String department = "IUF";
			//TODO add department to sheet
			addError("Department for " + getName() + " has been defaulted to '" + department + "'");

			String workgroup = "AG Fritsche";
			//TODO add workgroup to sheet
			addError("Workgroup for " + getName() + " has been defaulted to '" + workgroup + "'");

			String sex = "undefined";
			//TODO Add SEX to sheet
			addError("Sex for " + getName() + " has been defaulted to '" + sex + "'");

			if (compound.equals("NaN")) {
				addError("Compound is unknown!");
			}

			//Next: Insert it into the database
			Log.i("TODO: Actually insert it now...");

			//But first: Let me take a sel... the necessary IDs of existing meta data from the Database
			long assayID = executor.getIDViaName("assay", assay);
			long cellTypeID = executor.getIDViaName("cell_type", cellType);
			long projectID = executor.getIDViaName("project", projectName);
			long plateformatID = executor.getIDViaName("plate_format", plateFormat);
			long departmentID = executor.getIDViaName("department", department);
			long workgroupID = executor.getIDViaName("workgroup", workgroup);

			long individualID = getIndividualID(individual, sex, species);

			long compoundID;
			try {
				compoundID = executor.getIDViaName("compound", compound);
			} catch (Throwable e) {
				addError("Failed to resolve compound name: '" + compound + "'. That's okay, if a valid Cas Nr. is provided instead: '" + casNR + "'.");

				compoundID = executor.getIDViaFeature("compound", "cas_no", casNR);
				addError("\t\t\tBut that CAS Nr. existed in the DB and the compound was resolved.");
			}

			long experimentID;
			synchronized (executor) {
				experimentID = executor.getNextSequenceTableVal("experiment");
				executor.insertExperiment(experimentID, date.getTime(), name, projectID, workgroupID, individualID, compoundID, cellTypeID, assayID, plateformatID);
			}

			executor.insertComment(comment, experimentID);

			//Now comes actual experiment data
			NumberUtils numberUtils = new NumberUtils();
			JSONObject experimentData = data.getJSONObject("ExperimentData").getJSONObject("Endpoints");

			long outlierID = executor.getIDViaName("outlier_type", "Unchecked");
			for (String endpoint : getKeys(experimentData)) {
				JSONObject concentrations = experimentData.getJSONObject(endpoint);

				long endpointID;
				try {
					endpointID = executor.getIDViaName("endpoint", endpoint);
				} catch (Throwable t) {
					Log.e(t);
					addError("Unable to find an endpoint in the database named '" + endpoint + "'.");
					continue;
				}

				int timestamp = 24;
				addError("Timestamp for endpoint '" + endpoint + "' has been defaulted to " + timestamp + "h. For now.");

				for (String concentration : getKeys(concentrations)) {
					boolean control = !numberUtils.isNumeric(concentration);

					long controlID;
					long concentrationID;
					if (control) {
						try {
							controlID = executor.getIDViaName("control", concentration);
						} catch (Throwable e) {
							Log.e(e);
							addError("I think this concentration is actually a control. But I can't find a control in the database with this name: '" + concentration + "'.");
							continue;
						}
						concentrationID = executor.insertConcentration(0, controlID);
					} else {
						controlID = executor.getIDViaName("control", "No control");
						double d = Double.parseDouble(concentration);
						concentrationID = executor.insertConcentration(d);
					}

					JSONArray results = concentrations.getJSONArray(concentration);
					Log.i(endpoint + " -> " + concentration + " [ID: " + concentrationID + "] (Control: " + control + " [ID: " + controlID + "]) -> Responses: " + results);

					for (int i = 0; i < results.length(); i++) {
						double result = results.getDouble(i);

						if (Double.isNaN(result)) {
							NaNCounts++;
						}

						try {
							executor.insertResponse(result, timestamp, endpointID, concentrationID, experimentID, outlierID);
						} catch (Throwable e) {
							Log.e(e);
							addError("Failed to insert response '" + result + "' for endpoint " + endpoint + " at " + timestamp + "h for concentration " + concentration + " into the database. Reason: " + e.getMessage().replace("\n", " "));
							continue;
						}

						insertedResponses++;
					}
				}
			}
		} catch (Throwable e) {
			Log.e("Failed to insert Experiment: " + getName(), e);
			addError("Failed to insert Experiment " + getName() + " into the database! Error Type: " + e.getClass().getSimpleName() + ". Reason: '" + e.getMessage() + "'");
		}
		Log.i("Finished inserting responses for " + getName() + ". Count: " + getInsertedResponses());
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

	public int getInsertedResponses() {
		return insertedResponses;
	}

	public int getNaNCount() {
		return NaNCounts;
	}

	private void addError(String text) {
		String s = getName() + ": " + text;
		Log.w("Inserter error: " + s);
		errors.add(s);
	}

	public boolean hasError() {
		return !errors.isEmpty();
	}

	public boolean hasNaNs() {
		return getNaNCount() != 0;
	}

	public ArrayList<String> getErrors() {
		return new ArrayList<>(errors);
	}
}