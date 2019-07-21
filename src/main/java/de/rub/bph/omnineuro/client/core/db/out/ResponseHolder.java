package de.rub.bph.omnineuro.client.core.db.out;


import de.rub.bph.omnineuro.client.core.db.OmniNeuroQueryExecutor;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ResponseHolder {
	
	private int timestamp;
	private long endpointID;
	private String endpointName;
	private String experimentName;
	private String well;
	private double concentration;
	private String concentrationDescription;
	private double response;
	private boolean control;
	
	public ResponseHolder(long responseID, OmniNeuroQueryExecutor queryExecutor) throws SQLException {
		//timestamp = Integer.parseInt(queryExecutor.getFeatureViaID("response", "timestamp", responseID));
		//endpointID = Long.parseLong(queryExecutor.getFeatureViaID("response", "endpoint_id", responseID));
		//concentration = Long.parseLong(queryExecutor.getFeatureViaID("response", "concentration_id", responseID));
		//response = Double.parseDouble(queryExecutor.getFeatureViaID("response", "value", responseID));
		ResultSet resultSet = queryExecutor.getFeaturesViaID("response", responseID);
		resultSet.next();
		timestamp = resultSet.getInt("timestamp");
		endpointID = resultSet.getLong("endpoint_id");
		response = resultSet.getDouble("value");
		
		long experimentID = resultSet.getLong("experiment_id");
		experimentName = queryExecutor.getNameViaID("experiment", experimentID);
		
		long concentrationID = resultSet.getLong("concentration_id");
		concentration = Double.parseDouble(queryExecutor.getFeatureViaID("concentration", "value", concentrationID));
		endpointName = queryExecutor.getNameViaID("endpoint", endpointID);
		
		long wellID = resultSet.getLong("well_id");
		well = queryExecutor.getNameViaID("well", wellID);
		
		control = concentration == 0;
		if (control) {
			resultSet = queryExecutor.
					executeQuery("SELECT control.acronym FROM control,concentration WHERE control.id = concentration.control_id AND concentration.id = " + concentrationID);
			resultSet.next();
			concentrationDescription = resultSet.getString("acronym");
		} else {
			concentrationDescription = String.valueOf(concentration);
		}
	}
	
	public static ArrayList<Long> getUniqueEndpointIDs(List<ResponseHolder> holders) {
		ArrayList<Long> list = new ArrayList<>();
		for (ResponseHolder h : holders) {
			long l = h.getEndpointID();
			if (!list.contains(l)) list.add(l);
		}
		return list;
	}
	
	public static ArrayList<String> getUniqueExperimentNames(List<ResponseHolder> holders) {
		ArrayList<String> list = new ArrayList<>();
		for (ResponseHolder h : holders) {
			String s = h.getExperimentName();
			if (!list.contains(s)) list.add(s);
		}
		return list;
	}
	
	public static ArrayList<String> getUniqueWells(List<ResponseHolder> holders) {
		ArrayList<String> list = new ArrayList<>();
		for (ResponseHolder h : holders) {
			String s = h.getWell();
			if (!list.contains(s)) list.add(s);
		}
		return list;
	}
	
	public static ArrayList<String> getUniqueEndpointNames(List<ResponseHolder> holders) {
		ArrayList<String> list = new ArrayList<>();
		for (ResponseHolder h : holders) {
			String s = h.getEndpointName();
			if (!list.contains(s)) list.add(s);
		}
		return list;
	}
	
	public static ArrayList<Integer> getUniqueTimestamps(List<ResponseHolder> holders) {
		ArrayList<Integer> list = new ArrayList<>();
		for (ResponseHolder h : holders) {
			int i = h.getTimestamp();
			if (!list.contains(i)) list.add(i);
		}
		return list;
	}
	
	public static ArrayList<String> getUniqueConcentrations(List<ResponseHolder> holders) {
		ArrayList<String> list = new ArrayList<>();
		for (ResponseHolder h : holders) {
			String s = h.getConcentrationDescription();
			if (!list.contains(s)) list.add(s);
		}
		return list;
	}
	
	@Override
	public String toString() {
		return "Response handler for " + getConcentrationDescription() + " [Control status: " + isControl() + "], endpoint: " + getEndpointName() + " at " + getTimestamp() + "h from well "+getWell()+". Response value: " + getResponse();
	}
	
	public double getConcentration() {
		return concentration;
	}
	
	public String getConcentrationDescription() {
		return concentrationDescription;
	}
	
	public long getEndpointID() {
		return endpointID;
	}
	
	public String getEndpointName() {
		return endpointName;
	}
	
	public String getExperimentName() {
		return experimentName;
	}
	
	public void setExperimentName(String experimentName) {
		this.experimentName = experimentName;
	}
	
	public double getResponse() {
		return response;
	}
	
	public int getTimestamp() {
		return timestamp;
	}
	
	public String getWell() {
		return well;
	}
	
	public boolean isControl() {
		return control;
	}
}