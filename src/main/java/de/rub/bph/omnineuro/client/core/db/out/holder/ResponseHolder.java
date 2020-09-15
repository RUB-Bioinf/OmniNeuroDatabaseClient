package de.rub.bph.omnineuro.client.core.db.out.holder;


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
	private long compoundID;
	private String assayName;
	private String endpointName;
	private String experimentName;
	private String well;
	private double response;
	private long wellID;
	private String cellLine;
	private String mutation;
	private String cellType;
	private ConcentrationHolder concentrationHolder;
	
	public ResponseHolder(long responseID, OmniNeuroQueryExecutor queryExecutor) throws SQLException {
		ResultSet responseResultSet = queryExecutor.getFeaturesViaID("response", responseID);
		responseResultSet.next();
		timestamp = responseResultSet.getInt("timestamp");
		endpointID = responseResultSet.getLong("endpoint_id");
		response = responseResultSet.getDouble("value");
		
		experimentID = responseResultSet.getLong("experiment_id");
		ResultSet experimentResultSet = queryExecutor.getFeaturesViaID("experiment", experimentID);
		experimentResultSet.next();
		experimentName = experimentResultSet.getString("name");
		compoundID = experimentResultSet.getLong("compound_id");
		long mutationID = experimentResultSet.getLong("mutation_id");
		long cellTypeID = experimentResultSet.getLong("cell_type_id");
		long cellLineID = experimentResultSet.getLong("cell_line_id");
		
		assayID = Long.parseLong(queryExecutor.getFeatureViaID("experiment", "assay_id", experimentID));
		assayName = queryExecutor.getNameViaID("assay", assayID);
		
		long concentrationID = responseResultSet.getLong("concentration_id");
		concentrationHolder = new ConcentrationHolder(concentrationID, queryExecutor);
		endpointName = queryExecutor.getNameViaID("endpoint", endpointID);
		
		wellID = responseResultSet.getLong("well_id");
		well = queryExecutor.getNameViaID("well", wellID);
		
		cellLine = queryExecutor.getNameViaID("mutation", mutationID);
		mutation = queryExecutor.getNameViaID("cell_type", cellTypeID);
		cellType = queryExecutor.getNameViaID("cell_line", cellLineID);
		
		if (holderCreationCountMap == null) {
			resetCreationCounts();
		}
		if (!holderCreationCountMap.containsKey(hashCode())) {
			holderCreationCountMap.put(hashCode(), 0);
		}
		holderCreationCountMap.put(hashCode(), holderCreationCountMap.get(hashCode()) + 1);
	}
	
	public static void resetCreationCounts() {
		holderCreationCountMap = new HashMap<>();
	}
	
	@Override
	public int hashCode() {
		return Objects.hash(getTimestamp(), getEndpointID(), getExperimentID(), getResponse(), getWellID(), getConcentrationHolder(), getMutation(), getCellLine(), getCellType());
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
	
	public boolean isControl() {
		return getConcentrationHolder().isControl();
	}
	
	public int getCreationCount() {
		return getResponseHolderCreationCount(this);
	}
	
	public static int getResponseHolderCreationCount(ResponseHolder holder) {
		return holderCreationCountMap.get(holder.hashCode());
	}
	
	public long getAssayID() {
		return assayID;
	}
	
	public int getTimestamp() {
		return timestamp;
	}
	
	public long getEndpointID() {
		return endpointID;
	}
	
	public long getExperimentID() {
		return experimentID;
	}
	
	public double getResponse() {
		return response;
	}
	
	public long getWellID() {
		return wellID;
	}
	
	public ConcentrationHolder getConcentrationHolder() {
		return concentrationHolder;
	}
	
	public String getMutation() {
		return mutation;
	}
	
	public String getCellLine() {
		return cellLine;
	}
	
	public String getCellType() {
		return cellType;
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
	
	public String getExperimentName() {
		return experimentName;
	}
	
	public void setExperimentName(String experimentName) {
		this.experimentName = experimentName;
	}
	
	public static ArrayList<String> getUniqueWells(List<ResponseHolder> holders) {
		ArrayList<String> list = new ArrayList<>();
		for (ResponseHolder h : holders) {
			String s = h.getWell();
			if (!list.contains(s)) list.add(s);
		}
		return list;
	}
	
	public String getWell() {
		return well;
	}
	
	public static ArrayList<String> getUniqueAssays(List<ResponseHolder> holders) {
		ArrayList<String> list = new ArrayList<>();
		for (ResponseHolder h : holders) {
			String s = h.getAssayName();
			if (!list.contains(s)) list.add(s);
		}
		return list;
	}
	
	public String getAssayName() {
		return assayName;
	}
	
	public static ArrayList<String> getUniqueEndpointNames(List<ResponseHolder> holders) {
		ArrayList<String> list = new ArrayList<>();
		for (ResponseHolder h : holders) {
			String s = h.getEndpointName();
			if (!list.contains(s)) list.add(s);
		}
		return list;
	}
	
	public String getEndpointName() {
		return endpointName;
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
	
	public String getConcentrationDescription() {
		return getConcentrationHolder().getDescription();
	}
	
	public long getCompoundID() {
		return compoundID;
	}
	
	public double getConcentration() {
		return getConcentrationHolder().getValue();
	}
	
	public long getConcentrationID() {
		return getConcentrationHolder().getId();
	}
	
	public boolean isUniquelyCreated() {
		return getCreationCount() == 1;
	}
}