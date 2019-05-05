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

public class ResponseIDLimiter {
	
	private ArrayList<Long> originalExperimentIDs;
	private JSONObject limiterConfigs;
	private OmniNeuroQueryExecutor queryExecutor;
	
	public ResponseIDLimiter(ArrayList<Long> originalExperimentIDs, JSONObject limiterConfigs) throws JSONException {
		this(originalExperimentIDs, limiterConfigs, new OmniNeuroQueryExecutor(DBConnection.getDBConnection().getConnection()));
	}
	
	public ResponseIDLimiter(ArrayList<Long> originalExperimentIDs, JSONObject limiterConfigs, OmniNeuroQueryExecutor queryExecutor) throws JSONException {
		this.originalExperimentIDs = originalExperimentIDs;
		this.queryExecutor = queryExecutor;
		
		if (limiterConfigs == null) {
			throw new IllegalArgumentException("No limiters have been set");
		}
		
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
				return applyT3LimiterSpecific("department", "workgroup", "name", entries);
			case "initiator":
				return applyT3LimiterSpecific("initiator", "project", "name", entries);
			case "leader":
				return applyT3LimiterSpecific("leader", "workgroup", "name", entries);
			case "species":
				return applyT3LimiterSpecific("species", "individual", "name", entries);
			case "sex":
				return applyT3LimiterSpecific("sex", "individual", "label", entries);
			case "project":
				return applyT2LimiterSpecific("project", "experiment", "name", entries);
			case "workgroup":
				return applyT2LimiterSpecific("workgroup", "experiment", "name", entries);
			case "compound":
				return applyT2LimiterSpecific("compound", "experiment", "name", entries);
			case "cell_type":
				return applyT2LimiterSpecific("cell_type", "experiment", "name", entries);
			case "individual":
				return applyT2LimiterSpecific("individual", "experiment", "name", entries);
			case "plate_format":
				return applyT2LimiterSpecific("plate_format", "experiment", "name", entries);
			case "assay":
				return applyT2LimiterSpecific("assay", "experiment", "name", entries);
			case "control":
				return applyT2LimiterSpecific("control", "concentration", "name", entries);
			case "experiment_id":
				return applyT1LimiterSpecific("experiment", "name", entries);
			case "timestamp_experiment":
				return applyT1LimiterSpecific("experiment", "timestamp", entries);
			case "timestamp_response":
				return applyT0LimiterSpecific("timestamp", entries);
			case "value_concentration":
				return applyT1LimiterSpecific("concentration", "value", entries);
			case "value_response":
				return applyT0LimiterSpecific("value", entries);
			case "endpoint":
				return applyT1LimiterSpecific("endpoint", "name", entries);
			case "outlier_type":
				return applyT1LimiterSpecific("outlier_type", "name", entries);
			default:
				Log.e("Invalid limiter: " + limiterName + ". This isn't implemented (yet)!");
				throw new IllegalArgumentException("Invalid limiter: '" + limiterName + "'! Try again or remove this limiter. The database can't handle this!");
		}
	}
	
	public ArrayList<Long> applyT0LimiterSpecific(String feature, JSONArray entries) throws JSONException, SQLException {
		Log.i("Applying specific T0 (so on responses) " + feature + "-limiter on " + entries.length() + " elements.");
		String query = "SELECT DISTINCT id FROM response WHERE (" + concatenatedConditions(feature, entries) + ");";
		return applyLimiterSQL(query);
	}
	
	/**
	 * Creates a Tier-1 SQL query, where the table in question is directly mentioned in the experiment, and the column is called 'name'.
	 */
	public ArrayList<Long> applyT1LimiterSpecific(String t1tableName, String featureName, JSONArray entries) throws JSONException, SQLException {
		Log.i("Applying specific T1 " + featureName + "-limiter for table: " + t1tableName + " on " + entries.length() + " elements.");
		String query = "SELECT DISTINCT response.id FROM response," + t1tableName + " WHERE " + t1tableName + ".id = response." + t1tableName + "_id AND ("
				+ concatenatedConditions(t1tableName + "." + featureName, entries) + ");";
		return applyLimiterSQL(query);
	}
	
	public ArrayList<Long> applyT2LimiterSpecific(String t2TableName, String t1TableName, String featureName, JSONArray entries) throws JSONException, SQLException {
		Log.i("Applying specific '" + featureName + "' T2 limiter for table: " + t2TableName + " via " + t1TableName + " on " + entries.length() + " elements.");
		String query = "SELECT DISTINCT response.id FROM response, " + t1TableName + "," + t2TableName + " WHERE response." + t1TableName + "_id = " + t1TableName + ".id AND " + t1TableName + "." + t2TableName + "_id = " + t2TableName + ".id" +
				" AND (" + concatenatedConditions(t2TableName + "." + featureName, entries) + ");";
		return applyLimiterSQL(query);
	}
	
	public ArrayList<Long> applyT3LimiterSpecific(String t3TableName, String t2TableName, String featureName, JSONArray entries) throws JSONException, SQLException {
		Log.i("Applying specific '" + featureName + "' T2 limiter for table: " + t3TableName + " via " + t2TableName + " on " + entries.length() + " elements.");
		String query = "SELECT DISTINCT response.id FROM response, experiment," + t2TableName + "," + t3TableName + " WHERE response.experiment_id = experiment.id AND" +
				" experiment." + t2TableName + "_id = " + t2TableName + ".id" +
				" AND " + t2TableName + "." + t3TableName + "_id = " + t3TableName + ".id" +
				" AND (" + concatenatedConditions(t3TableName + "." + featureName, entries) + ");";
		return applyLimiterSQL(query);
	}
	
	/*
	//TODO delete this?
	public ArrayList<Long> applyT2NameLimiterSpecific(String t2TableName, String t1TableName, JSONArray entries) throws JSONException, SQLException {
		return applyT2LimiterSpecific(t2TableName, t1TableName, "name", entries);
	}

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
