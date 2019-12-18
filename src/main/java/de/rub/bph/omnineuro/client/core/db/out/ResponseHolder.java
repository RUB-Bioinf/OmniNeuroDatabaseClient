package de.rub.bph.omnineuro.client.core.db.out;


import de.rub.bph.omnineuro.client.core.db.OmniNeuroQueryExecutor;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Objects;

public class ResponseHolder {
	
	private static HashMap<Integer, Integer> holderCreationCountMap;
	private int timestamp;
	private long endpointID;
	private long experimentID;
	private long assayID;
	private String assayName;
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
		
		assayID = Long.parseLong(queryExecutor.getFeatureViaID("experiment", "assay_id", experimentID));
		assayName = queryExecutor.getNameViaID("assay", assayID);
		
		long concentrationID = resultSet.getLong("concentration_id");
		concentrationHolder = new ConcentrationHolder(concentrationID, queryExecutor);
		endpointName = queryExecutor.getNameViaID("endpoint", endpointID);
		
		wellID = resultSet.getLong("well_id");
		well = queryExecutor.getNameViaID("well", wellID);
		
		if (holderCreationCountMap == null) {
			resetCreationCounts();
		}
		if (!holderCreationCountMap.containsKey(hashCode())) {
			holderCreationCountMap.put(hashCode(), 0);
		}
		holderCreationCountMap.put(hashCode(), holderCreationCountMap.get(hashCode()) + 1);
	}
	
	public static int getResponseHolderCreationCount(ResponseHolder holder) {
		return holderCreationCountMap.get(holder.hashCode());
	}
	
	public static void resetCreationCounts() {
		holderCreationCountMap = new HashMap<>();
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
	
	public static ArrayList<String> getUniqueAssays(List<ResponseHolder> holders) {
		ArrayList<String> list = new ArrayList<>();
		for (ResponseHolder h : holders) {
			String s = h.getAssayName();
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
	public int hashCode() {
		return Objects.hash(getTimestamp(), getEndpointID(), getExperimentID(), getResponse(), getWellID(), getConcentrationHolder());
	}
	
	@Override
	public boolean equals(Object o) {
		if (this == o) return true;
		if (!(o instanceof ResponseHolder)) return false;
		ResponseHolder holder = (ResponseHolder) o;
		return getTimestamp() == holder.getTimestamp() &&
				getEndpointID() == holder.getEndpointID() &&
				getAssayID() == holder.getAssayID() &&
				getExperimentID() == holder.getExperimentID() &&
				Double.compare(holder.getResponse(), getResponse()) == 0 &&
				getWellID() == holder.getWellID() &&
				getConcentrationHolder().equals(holder.getConcentrationHolder());
	}
	
	@Override
	public String toString() {
		return "Response handler for " + getConcentrationDescription() + " [Control status: " + isControl() + "], endpoint: " + getEndpointName() + " at " + getTimestamp() + "h from well " + getWell() + " in experiment " + getExperimentName() + " from " + getAssayName() +
				". Response value: " + getResponse() + ". Hash: " + hashCode() + " [Created " + getCreationCount() + " times].";
	}
	
	public long getAssayID() {
		return assayID;
	}
	
	public String getAssayName() {
		return assayName;
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
	
	public int getCreationCount() {
		return getResponseHolderCreationCount(this);
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
	
	public boolean isUniquelyCreated() {
		return getCreationCount() == 1;
	}
}