package de.rub.bph.omnineuro.client.core.db;

import de.rub.bph.omnineuro.client.imported.log.Log;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

public class QueryExecutor {

	private Connection connection;

	public QueryExecutor(Connection connection) {
		this.connection = connection;
	}

	public synchronized ResultSet executeQuery(String query) throws SQLException {
		Statement stmt = connection.createStatement();
		Log.i("Executing query: '" + query + "'");
		return stmt.executeQuery(query);
	}

	public synchronized boolean execute(String query) throws SQLException {
		Statement stmt = connection.createStatement();
		Log.i("Executing query: '" + query + "'");
		return stmt.execute(query);
	}

	public synchronized ArrayList<Long> getIDs(String tableName) throws SQLException {
		ArrayList<String> list = getColumn(tableName, "id");
		ArrayList<Long> ids = new ArrayList<>();

		for (String s : list) ids.add(Long.valueOf(s));

		return ids;
	}

	public synchronized ArrayList<String> getColumn(String tableName, String columnName) throws SQLException {
		ResultSet set = executeQuery("SELECT " + columnName + " FROM " + tableName + ";");
		return extractFeature(set, columnName);
	}

	public synchronized ArrayList<Long> extractIDs(ResultSet set) throws SQLException {
		ArrayList<Long> res = new ArrayList<>();

		for (String s : extractFeature(set, "id")) {
			res.add(Long.parseLong(s));
		}

		return res;
	}

	public synchronized long getIDViaName(String tableName, String feature) throws SQLException, IllegalStateException {
		return getIDViaFeature(tableName, "name", feature);
	}

	public synchronized long getIDViaFeature(String tableName, String columnName, String feature) throws SQLException, IllegalStateException {
		ArrayList<Long> res = new ArrayList<>();
		ResultSet set = executeQuery("SELECT id FROM " + tableName + " WHERE " + columnName + " = '" + feature + "';");

		while (set.next()) {
			res.add(set.getLong("id"));
		}

		if (res.isEmpty()) {
			throw new IllegalStateException("Table '" + tableName + "' does not contain an entry '" + feature + "' in column '" + columnName + "'!");
		}

		if (res.size() == 1) {
			return res.get(0);
		}
		throw new IllegalStateException("Table '" + tableName + "' has multiple IDs [" + res + "] for entry '" + feature + " in column " + columnName + "!");
	}

	public synchronized ArrayList<String> extractFeature(ResultSet set, String feature) throws SQLException {
		ArrayList<String> res = new ArrayList<>();

		while (set.next()) {
			res.add(set.getObject(feature).toString());
		}

		return res;
	}

	public synchronized Object getCell(String tableName, String columnName, long id) throws SQLException {
		String query = "SELECT " + columnName + " FROM " + tableName + " WHERE id = " + id + ";";
		ResultSet set = executeQuery(query);
		set.next();

		return set.getObject(columnName);
	}

	public void deleteRow(String tableName, long id) throws SQLException {
		execute("DELETE FROM " + tableName + " " +
				"WHERE " + tableName + ".id = " + id + ";");
	}

	public long getNextSequenceTableVal(String tableName) throws SQLException {
		return getNextSequenceVal(tableName + "_id_seq");
	}

	public long getNextSequenceVal(String sequenceName) throws SQLException {
		ResultSet set = executeQuery("SELECT nextval('" + sequenceName + "');");
		if (set.next()) {
			return set.getLong(1);
		}
		throw new SQLException("Unable to retrieve a value for sequence '" + sequenceName + "'!");
	}

	public boolean restartSequence(String name) throws SQLException {
		return execute("ALTER SEQUENCE " + name + " RESTART;");
	}

	public boolean restartTableSequence(String tableName) throws SQLException {
		return restartSequence(tableName + "_id_seq");
	}

	public boolean deleteTable(String tableName, boolean resetSequence) throws SQLException {
		if (resetSequence) {
			return deleteTable(tableName, tableName + "_id_seq");
		} else {
			return deleteTable(tableName, null);
		}
	}

	public boolean deleteTable(String tableName) throws SQLException {
		return deleteTable(tableName, false);
	}

	public boolean deleteTable(String tableName, String sequenceName) throws SQLException {
		boolean b = execute("DELETE FROM " + tableName + ";");

		if (sequenceName != null) {
			b &= restartSequence(sequenceName);
		}
		return b;
	}

	public Connection getConnection() {
		return connection;
	}


}
