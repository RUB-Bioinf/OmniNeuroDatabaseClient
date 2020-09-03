package de.rub.bph.omnineuro.client.core.db.out.holder;

import de.rub.bph.omnineuro.client.core.db.OmniNeuroQueryExecutor;
import org.json.JSONException;
import org.json.JSONObject;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Objects;

public class MutationPooler implements Comparable<MutationPooler> {
	
	private String cellLine;
	private String mutation;
	private String cellType;
	
	public MutationPooler(String cellLine, String mutation, String cellType) {
		this.cellLine = cellLine;
		this.mutation = mutation;
		this.cellType = cellType;
	}
	
	public static MutationPooler createFromResponse(long responseID, OmniNeuroQueryExecutor queryExecutor) throws SQLException {
		ResultSet responseResultSet = queryExecutor.getFeaturesViaID("response", responseID);
		responseResultSet.next();
		
		long experimentID = responseResultSet.getLong("experiment_id");
		return createFromExperiment(experimentID, queryExecutor);
	}
	
	public static MutationPooler createFromExperiment(long experimentID, OmniNeuroQueryExecutor queryExecutor) throws SQLException {
		ResultSet experimentResultSet = queryExecutor.getFeaturesViaID("experiment", experimentID);
		experimentResultSet.next();
		
		long mutationID = experimentResultSet.getLong("mutation_id");
		long cellTypeID = experimentResultSet.getLong("cell_type_id");
		long cellLineID = experimentResultSet.getLong("cell_line_id");
		
		String cellLine = queryExecutor.getNameViaID("mutation", mutationID);
		String mutation = queryExecutor.getNameViaID("cell_type", cellTypeID);
		String cellType = queryExecutor.getNameViaID("cell_line", cellLineID);
		
		return new MutationPooler(cellLine, mutation, cellType);
	}
	
	public static ArrayList<MutationPooler> getAllPossiblePoolers(OmniNeuroQueryExecutor queryExecutor) throws SQLException {
		ArrayList<MutationPooler> poolers = new ArrayList<>();
		ArrayList<Long> experimentIDs = queryExecutor.getIDs("experiment");
		ArrayList<Integer> knownHashes = new ArrayList<>();
		
		for (long id : experimentIDs) {
			MutationPooler pooler = createFromExperiment(id, queryExecutor);
			int hash = pooler.hashCode();
			if (!knownHashes.contains(hash)) {
				poolers.add(pooler);
				knownHashes.add(hash);
			}
		}
		Collections.sort(poolers);
		return poolers;
	}
	
	@Override
	public int hashCode() {
		return Objects.hash(getCellLine(), getMutation(), getCellType());
	}
	
	@Override
	public boolean equals(Object o) {
		if (this == o) return true;
		if (o == null || getClass() != o.getClass()) return false;
		MutationPooler that = (MutationPooler) o;
		return Objects.equals(getCellLine(), that.getCellLine()) &&
				Objects.equals(getMutation(), that.getMutation()) &&
				Objects.equals(getCellType(), that.getCellType());
	}
	
	@Override
	public String toString() {
		return "MutationPooler{" +
				"cellLine='" + cellLine + '\'' +
				", mutation='" + mutation + '\'' +
				", cellType='" + cellType + '\'' +
				'}';
	}
	
	public String getCellLine() {
		return cellLine;
	}
	
	public String getMutation() {
		return mutation;
	}
	
	public String getCellType() {
		return cellType;
	}
	
	public boolean acceptsResponseHolder(ResponseHolder holder) {
		return getCellLine().equals(holder.getCellLine()) &&
				getMutation().equals(holder.getMutation()) &&
				getCellType().equals(holder.getCellType());
	}
	
	public JSONObject toJSON() throws JSONException {
		JSONObject object = new JSONObject();
		object.put("Cell Line", getCellLine());
		object.put("Cell Type", getCellType());
		object.put("Mutation", getMutation());
		return object;
	}
	
	@Override
	public int compareTo(MutationPooler mutationPooler) {
		return toSingleLine().compareTo(mutationPooler.toSingleLine());
	}
	
	public String toSingleLine() {
		return getMutation() + "-" + getCellLine() + "-" + getCellType();
	}
}
