package de.rub.bph.omnineuro.client.core.db;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;

/**
 * A helper class to build project specific queries
 */
public class OmniNeuroQueryExecutor extends QueryExecutor {
	
	public OmniNeuroQueryExecutor(Connection connection) {
		super(connection);
	}
	
	public synchronized boolean insertIndividual(long id, String name, long sexID, long speciesID) throws SQLException {
		return execute("INSERT INTO individual VALUES (" + id + ",'" + name + "'," + sexID + "," + speciesID + ");");
	}
	
	public synchronized boolean insertMutation(long id, String name) throws SQLException {
		return execute("INSERT INTO mutation VALUES (" + id + ",'" + name + "');");
	}
	
	public synchronized boolean insertCellLine(long id, String name) throws SQLException {
		return execute("INSERT INTO cell_line VALUES (" + id + ",'" + name + "');");
	}
	
	public synchronized boolean insertComment(String text, long experimentID) throws SQLException {
		return execute("INSERT INTO comment VALUES (DEFAULT, '" + text + "'," + experimentID + ");");
	}
	
	public synchronized boolean insertWell(String name) throws SQLException {
		return execute("INSERT INTO well VALUES (DEFAULT, '" + name + "');");
	}
	
	public synchronized boolean insertPassage(long experimentID, long timestamp, int p) throws SQLException {
		return execute("INSERT INTO passage VALUES (DEFAULT, " + experimentID + "," + timestamp + "," + p + ");");
	}
	
	public synchronized boolean insertExperiment(long id, long timestamp, String name, long projectID, long labID, long individualID, long mutationID, long compoundID, long cellTypeID, long assayID, long plateFormatID, long solventID, double solventConcentration, String controlWellID, long cell_line_id) throws SQLException {
		return execute("INSERT INTO experiment VALUES (" + id + "," + timestamp + ",'" + name + "'," + projectID +
				"," + labID + "," + individualID + "," + compoundID + "," + cellTypeID + "," + assayID + "," + plateFormatID + "," + solventID + "," + solventConcentration + ", '" + controlWellID + "', " + mutationID + ", " + cell_line_id + ");");
	}
	
	public synchronized boolean insertCompound(String name, String casNR, String abbreviation, boolean blinded) throws SQLException {
		return execute("INSERT INTO compound VALUES (DEFAULT, '" + name + "','" + casNR + "','" + abbreviation + "'," + String.valueOf(blinded) + ");");
	}
	
	public synchronized boolean resetDatabase() throws SQLException {
		boolean b = true;
		b &= deleteTable("comment", true);
		b &= deleteTable("response", true);
		b &= deleteTable("concentration", true);
		b &= deleteTable("passage", true);
		b &= deleteTable("experiment", true);
		b &= deleteTable("well", true);
		b &= deleteTable("individual", true);
		b &= deleteTable("mutation", true);
		b &= deleteBlindedCompounds();
		
		b &= insertWell("Unknown");
		b &= insertIndividual(0,"Unknown",getIDViaFeature("sex","label","undefined"),getIDViaName("species","unknown"));
		
		return b;
	}
	
	//public synchronized boolean insertResponse(double value, int timestamp, long endpointID, long concentrationID, long experimentID,long wellID) throws SQLException {
	//	long outlierTypeID = getIDViaName("outlier_type", "Unchecked");
	//	return insertResponse(value, timestamp, endpointID, concentrationID, experimentID, outlierTypeID,wellID);
	//}
	
	public synchronized boolean insertResponse(double value, int timestamp, long endpointID, long concentrationID, long experimentID, long wellID, long outlierTypeID, long detectionMethodID) throws SQLException {
		return execute("INSERT INTO response VALUES (DEFAULT, " + value + "," + timestamp + "," + endpointID + "," + concentrationID + "," + experimentID + "," + outlierTypeID + "," + wellID + "," + detectionMethodID + ");");
	}
	
	public synchronized long insertConcentration(double value) throws SQLException {
		long controlID = getIDViaName("control", "No control");
		return insertConcentration(value, controlID);
	}
	
	public synchronized long insertConcentration(double value, long controlID) throws SQLException {
		long id = getNextSequenceTableVal("concentration");
		execute("INSERT INTO concentration values (" + id + "," + value + "," + controlID + ");");
		return id;
	}
	
	public synchronized ArrayList<Integer> getTimestampsForEndpoint(long endpointID) throws SQLException {
		String query = "SELECT DISTINCT response.timestamp FROM response WHERE endpoint_id = " + endpointID + ";";
		ResultSet res = executeQuery(query);
		return extractIntegerFeature(res, "timestamp");
	}
	
	public synchronized HashMap<Long, ArrayList<Integer>> getTimestampsForEndpoints(List<Long> endpointIDs) throws SQLException, NumberFormatException {
		HashMap<Long, ArrayList<Integer>> map = new HashMap<>();
		for (Long l : endpointIDs) {
			map.put(l, getTimestampsForEndpoint(l));
		}
		return map;
	}
	
	public synchronized boolean deleteBlindedCompounds() throws SQLException {
		boolean success = execute("DELETE FROM compound WHERE blinded = true;");
		ArrayList<Long> ids = getIDs("compound");
		Collections.sort(ids);
		
		long largestID = ids.get(ids.size() - 1);
		success &= restartSequence("compound_id_seq", largestID + 1);
		
		return success;
	}

	/*
	/**
	 * Deletes an experiment and all its associated data
	 *
	 * @param id the id of omnisphero_mc_experiment
	 *
	public void deleteExperiment(long id) throws SQLException {
		execute("DELETE FROM omnisphero_mc_endpoint_data " +
				"WHERE omnisphero_mc_endpoint_data.experiment_id = " + id + ";");
		//execute(connection, "DELETE FROM omnisphero_mc_experiment " +
		//		"WHERE omnisphero_mc_experiment.id = " + id + ";");
		deleteRow("omnisphero_mc_experiment", id);
	}

	/**
	 * Deletes an experiment and all its associated data
	 *
	 * @param name the experiment number
	 *
	public boolean deleteExperiment(String name) throws SQLException {
		boolean deleted = false;
		ResultSet set = executeQuery("SELECT omnisphero_mc_experiment.id FROM omnisphero_mc_experiment " +
				"WHERE omnisphero_mc_experiment.name = '" + name + "';");
		while (set.next()) {
			deleteExperiment(set.getLong("id"));
			deleted = true;
		}

		return deleted;
	}
	*/
	
}
