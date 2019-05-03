package de.rub.bph.omnineuro.client.core.db.out;

import de.rub.bph.omnineuro.client.core.db.DBConnection;
import de.rub.bph.omnineuro.client.core.db.OmniNeuroQueryExecutor;
import de.rub.bph.omnineuro.client.imported.log.Log;
import de.rub.bph.omnineuro.client.util.JSONOperator;
import org.apache.commons.collections4.ListUtils;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import static de.rub.bph.omnineuro.client.ui.ExportConfigFrame.JSON_TAG_LIMITERS;
import static de.rub.bph.omnineuro.client.ui.component.ExportConfigDetailPanel.*;

public class ExperimentIDLimiter {
	
	private ArrayList<Long> originalExperimentIDs;
	private JSONObject limiterConfigs;
	private OmniNeuroQueryExecutor queryExecutor;
	
	public ExperimentIDLimiter(ArrayList<Long> originalExperimentIDs, JSONObject limiterConfigs) throws JSONException {
		this(originalExperimentIDs, limiterConfigs, new OmniNeuroQueryExecutor(DBConnection.getDBConnection().getConnection()));
	}
	
	public ExperimentIDLimiter(ArrayList<Long> originalExperimentIDs, JSONObject limiterConfigs, OmniNeuroQueryExecutor queryExecutor) throws JSONException {
		this.originalExperimentIDs = originalExperimentIDs;
		this.queryExecutor = queryExecutor;
		
		if (limiterConfigs.has(JSON_TAG_LIMITERS)) {
			limiterConfigs = limiterConfigs.getJSONObject(JSON_TAG_LIMITERS);
		}
		this.limiterConfigs = limiterConfigs;
	}
	
	public ArrayList<Long> applyAllLimiters() throws SQLException, JSONException {
		ArrayList<Long> limited = new ArrayList<>(getOriginalExperimentIDs());
		for (String s : getLimiterNames()) {
			List<Long> retained = ListUtils.retainAll(limited, applyLimiter(s));
			limited = new ArrayList<>(retained);
		}
		return limited;
	}
	
	public ArrayList<Long> applyLimiter(String limiterName) throws SQLException, JSONException {
		JSONObject limiter = limiterConfigs.getJSONObject(limiterName);
		String limiterType = limiter.getString(JSON_ARG_LIMITER_TYPE);
		
		switch (limiterType) {
			case JSON_ARG_LIMITER_TYPE_SPECIFIC:
				return applyLimiterSpecific(limiterName, limiter);
			case JSON_ARG_LIMITER_TYPE_RANGE:
				//return applyLimiterRange(limiterName, limiter);
				throw new IllegalStateException("Ranges not yet supported.");
				//TODO support them then!
			default:
				throw new IllegalArgumentException("Failed to resolve limiter type: " + limiterType);
		}
	}
	
	public ArrayList<Long> applyLimiterSpecific(String limiterName, JSONObject limiter) throws SQLException, JSONException {
		JSONArray entries = limiter.getJSONArray(JSON_ARG_LIMITER_DATA);
		
		if (entries.length() == 0) {
			Log.w("The specific limiter for '" + limiterName + "' was empty! Nothing will be fetched from the DB!");
			return new ArrayList<Long>();
		}
		
		switch (limiterName) {
			case "department":
				return applyT2NameLimiterSpecific("department", "workgroup", entries);
			case "initiator":
				return applyT2NameLimiterSpecific("initiator", "project", entries);
			case "leader":
				return applyT2NameLimiterSpecific("leader", "workgroup", entries);
			case "species":
				return applyT2NameLimiterSpecific("species", "individual", entries);
			case "sex":
				return applyT2LimiterSpecific("sex", "individual", "label", entries);
			case "project":
				return applyT1NameLimiterSpecific("project", entries);
			case "workgroup":
				return applyT1NameLimiterSpecific("workgroup", entries);
			case "compound":
				return applyT1NameLimiterSpecific("compound", entries);
			case "cell_type":
				return applyT1NameLimiterSpecific("cell_type", entries);
			case "individual":
				return applyT1NameLimiterSpecific("individual", entries);
			case "plate_format":
				return applyT1NameLimiterSpecific("plate_format", entries);
			case "assay":
				return applyT1NameLimiterSpecific("assay", entries);
			case "experiment_id":
				return applyT0LimiterSpecific("name", entries);
			case "timestamp_experiment":
				return applyT0LimiterSpecific("timestamp", entries);
			case "timestamp_response":
				return applyTN1LimiterSpecific("timestamp", entries);
			case "value_concentration":
				return applyTN2LimiterSpecific("concentration", "value", entries);
			case "value_response":
				return applyTN1LimiterSpecific("value", entries);
			case "endpoint":
				return applyTN2LimiterSpecific("endpoint", "name", entries);
			case "outlier_type":
				return applyTN2LimiterSpecific("outlier_type", "name", entries);
			default:
				Log.e("Invalid limiter: " + limiterName + ". This isn't implemented (yet)!");
				throw new IllegalArgumentException("Invalid limiter: '" + limiterName + "'! Try again or remove this limiter. The database can't handle this!");
		}
	}
	
	public ArrayList<Long> applyTN2LimiterSpecific(String t2TableName, String feature, JSONArray entries) throws JSONException, SQLException {
		Log.i("Applying specific T-2 (response) " + feature + "-limiter at " + t2TableName + " on " + entries.length() + " elements.");
		String query = "SELECT DISTINCT experiment.id FROM experiment,response," + t2TableName + " WHERE response.experiment_id = experiment.id" +
				" AND response." + t2TableName + "_id = " + t2TableName + ".id AND (" + concatenatedConditions(t2TableName + "." + feature, entries) + ");";
		return applyLimiterSQL(query);
	}
	
	public ArrayList<Long> applyTN1LimiterSpecific(String feature, JSONArray entries) throws JSONException, SQLException {
		Log.i("Applying specific T-1 (response) " + feature + "-limiter on " + entries.length() + " elements.");
		String query = "SELECT experiment.id FROM experiment,response WHERE response.experiment_id = experiment.id AND (" + concatenatedConditions(feature, entries) + ");";
		return applyLimiterSQL(query);
	}
	
	public ArrayList<Long> applyT0LimiterSpecific(String feature, JSONArray entries) throws JSONException, SQLException {
		Log.i("Applying specific T0 (so on experiments) " + feature + "-limiter on " + entries.length() + " elements.");
		String query = "SELECT id FROM experiment WHERE (" + concatenatedConditions(feature, entries) + ");";
		return applyLimiterSQL(query);
	}
	
	/**
	 * Creates a Tier-1 SQL query, where the table in question is directly mentioned in the experiment, and the column is called 'name'.
	 */
	public ArrayList<Long> applyT1NameLimiterSpecific(String tableName, JSONArray entries) throws JSONException, SQLException {
		Log.i("Applying specific T1 limiter for table: " + tableName + " on " + entries.length() + " elements.");
		String query = "SELECT experiment.id FROM experiment," + tableName + " WHERE " + tableName + ".id = experiment." + tableName + "_id AND ("
				+ concatenatedConditions(tableName + ".name", entries) + ");";
		return applyLimiterSQL(query);
	}
	
	/**
	 * Creates a Tier-2 SQL query, where the table in question is mentioned via a second table in the experiment, and the column is called 'name'.
	 */
	public ArrayList<Long> applyT2NameLimiterSpecific(String t2TableName, String t1TableName, JSONArray entries) throws JSONException, SQLException {
		return applyT2LimiterSpecific(t2TableName, t1TableName, "name", entries);
	}
	
	public ArrayList<Long> applyT2LimiterSpecific(String t2TableName, String t1TableName, String featureName, JSONArray entries) throws JSONException, SQLException {
		Log.i("Applying specific '" + featureName + "' T2 limiter for table: " + t2TableName + " via " + t1TableName + " on " + entries.length() + " elements.");
		String query = "SELECT experiment.id FROM experiment," + t1TableName + "," + t2TableName + " WHERE " + t1TableName + ".id = experiment." + t1TableName + "_id" +
				" AND " + t1TableName + "." + t2TableName + "_id = " + t2TableName + ".id" +
				" AND (" + concatenatedConditions(t2TableName + "." + featureName, entries) + ");";
		return applyLimiterSQL(query);
	}

	/*
	public ArrayList<Long> applyLimiterDepartmentSpecific(JSONArray entries) throws JSONException, SQLException {
		String query = "SELECT experiment.id FROM experiment,department,workgroup WHERE workgroup.id = experiment.workgroup_id AND workgroup.department_id = department.id AND ("
				+ concatenatedConditions("department.name", entries) + ");";
		return applyLimiterSQL(query);
	}

	public ArrayList<Long> applyLimiterProjectSpecific(JSONArray entries) throws JSONException, SQLException {
		String query = "SELECT experiment.id FROM experiment,project WHERE project.id = experiment.project_id AND ("
				+ concatenatedConditions("project.name", entries) + ");";
		return applyLimiterSQL(query);
	}

	public ArrayList<Long> applyLimiterWorkgroupSpecific(JSONArray entries) throws SQLException, JSONException {
		String query = "SELECT experiment.id FROM experiment,workgroup WHERE workgroup.id = experiment.workgroup_id AND ("
				+ concatenatedConditions("workgroup.name", entries) + ");";
		return applyLimiterSQL(query);
	}
	 */
	
	private String concatenatedConditions(String columnName, JSONArray entries) throws JSONException {
		StringBuilder builder = new StringBuilder();
		for (int i = 0; i < entries.length(); i++) {
			builder.append(columnName);
			builder.append(" = '");
			builder.append(entries.get(i));
			builder.append("'");
			
			if (i != entries.length() - 1) {
				builder.append(" OR ");
			}
		}
		return builder.toString();
	}
	
	private ArrayList<Long> applyLimiterSQL(String query) throws SQLException {
		ResultSet set = queryExecutor.executeQuery(query);
		return queryExecutor.extractLongFeature(set, "id");
	}
	
	public boolean hasLimiters() {
		return !getLimiterNames().isEmpty();
	}
	
	public ArrayList<String> getLimiterNames() {
		return JSONOperator.getKeys(limiterConfigs);
	}
	
	public ArrayList<Long> getOriginalExperimentIDs() {
		return originalExperimentIDs;
	}
}
