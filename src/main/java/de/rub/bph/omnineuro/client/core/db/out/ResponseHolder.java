package de.rub.bph.omnineuro.client.core.db.out;


import de.rub.bph.omnineuro.client.core.db.OmniNeuroQueryExecutor;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ResponseHolder {
	
	private int timestamp;
	private long endpointID;
	private long experimentID;
	private String endpointName;
	private String experimentName;
	private String well;
	private double response;
	private long wellID;
	private ConcentrationHolder concentrationHolder;
	
	public ResponseHolder(long responseID, OmniNeuroQueryExecutor queryExecutor) throws SQLException {
		ResultSet resultSet = queryExecutor.getFeaturesViaID("response", responseID);
		resultSet.next();
		timestamp = resultSet.getInt("timestamp");
		endpointID = resultSet.getLong("endpoint_id");
		response = resultSet.getDouble("value");
		
		experimentID = resultSet.getLong("experiment_id");
		experimentName = queryExecutor.getNameViaID("experiment", experimentID);
		
		long concentrationID = resultSet.getLong("concentration_id");
		concentrationHolder = new ConcentrationHolder(concentrationID, queryExecutor);
		endpointName = queryExecutor.getNameViaID("endpoint", endpointID);
		
		wellID = resultSet.getLong("well_id");
		well = queryExecutor.getNameViaID("well", wellID);
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
		return "Response handler for " + getConcentrationDescription() + " [Control status: " + isControl() + "], endpoint: " + getEndpointName() + " at " + getTimestamp() + "h from well " + getWell() + ". Response value: " + getResponse();
	}
	
	public double getConcentration() {
		return getConcentrationHolder().getValue();
	}
	
	public String getConcentrationDescription() {
		return getConcentrationHolder().getDescription();
	}
	
	public ConcentrationHolder getConcentrationHolder() {
		return concentrationHolder;
	}
	
	public long getConcentrationID() {
		return getConcentrationHolder().getId();
	}
	
	public long getEndpointID() {
		return endpointID;
	}
	
	public String getEndpointName() {
		return endpointName;
	}
	
	public long getExperimentID() {
		return experimentID;
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
	
	public long getWellID() {
		return wellID;
	}
	
	public boolean isControl() {
		return getConcentrationHolder().isControl();
	}
}