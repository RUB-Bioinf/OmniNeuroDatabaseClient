package de.rub.bph.omnineuro.client.core.db;

import java.sql.Connection;
import java.sql.SQLException;

/**
 * A helper class to build project specific queries
 */
public class OmniNeuroQueryExecutor extends QueryExecutor {

	public OmniNeuroQueryExecutor(Connection connection) {
		super(connection);
	}

	public boolean insertIndividual(long id, String name, long sexID, long speciesID) throws SQLException {
		return execute("INSERT INTO individual VALUES (" + id + ",'" + name + "'," + sexID + "," + speciesID + ");");
	}

	public boolean insertComment(String text, long experimentID) throws SQLException {
		return execute("INSERT INTO comment VALUES (DEFAULT, '" + text + "'," + experimentID + ");");
	}

	public boolean insertExperiment(long id, long timestamp, String name, long projectID, long labID, long individualID, long compoundID, long cellTypeID, long assayID, long plateFormatID) throws SQLException {
		return execute("INSERT INTO experiment VALUES (" + id + "," + timestamp + ",'" + name + "'," + projectID +
				"," + labID + "," + individualID + "," + compoundID + "," + cellTypeID + "," + assayID + "," + plateFormatID + ");");
	}

	public boolean resetDatabase() throws SQLException {
		boolean b = true;
		b &= deleteTable("comment", true);
		b &= deleteTable("experiment", true);
		b &= deleteTable("measurement", true);

		return b;
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
