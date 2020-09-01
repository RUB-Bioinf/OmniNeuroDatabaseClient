package de.rub.bph.omnineuro.client.core.db;

import de.rub.bph.omnineuro.client.imported.log.Log;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

public class QueryExecutor {
	
	private Connection connection;
	private boolean logEnabled;
	private static String lastCachedQuery = null;
	
	public QueryExecutor(Connection connection) {
		this.connection = connection;
		setLogEnabled(true);
	}
	
	public synchronized ResultSet executeQuery(String query) throws SQLException {
		synchronized (connection) {
			setLastCachedQuery(query);
			if (connection.isClosed()) {
				Log.w("Connection closed unexpectedly! Reconnecting...");
				DBConnection c = DBConnection.getDBConnection();
				c.reconnect();
				this.connection = c.getConnection();
			}
		}
		
		Statement stmt = connection.createStatement();
		
		if (isLogEnabled()) {
			Log.i("Executing query: '" + query.replace("\n", " ").replace("  ", " ") + "'");
		}
		return stmt.executeQuery(query);
	}
	
	public synchronized boolean execute(String query) throws SQLException {
		setLastCachedQuery(query);
		Statement stmt = connection.createStatement();
		
		if (isLogEnabled()) {
			Log.i("Executing query: '" + query.replace("\n", " ".replace("  ", " ")) + "'");
		}
		return stmt.execute(query);
	}
	
	public synchronized ArrayList<Long> getIDs(String tableName) throws SQLException {
		ArrayList<String> list = getColumn(tableName, "id");
		ArrayList<Long> ids = new ArrayList<>();
		
		for (String s : list) {
			ids.add(Long.valueOf(s));
		}
		
		return ids;
	}
	
	public synchronized ArrayList<String> getColumn(String tableName, String columnName) throws SQLException {
		return getColumn(tableName, columnName, false);
	}
	
	public synchronized ArrayList<String> getColumn(String tableName, String columnName, boolean distinct) throws SQLException {
		String distinctText = "";
		if (distinct) distinctText = "DISTINCT";
		
		ResultSet set = executeQuery("SELECT " + distinctText + " " + columnName + " FROM " + tableName + ";");
		return extractStringFeature(set, columnName);
	}
	
	public synchronized ArrayList<Long> extractIDs(ResultSet set) throws SQLException {
		return extractLongFeature(set, "id");
	}
	
	public synchronized long getIDViaName(String tableName, String feature) throws SQLException, IllegalStateException {
		return getIDViaFeature(tableName, "name", feature);
	}
	
	public synchronized ArrayList<Long> getIDsViaFeature(String tableName, String columnName, String feature) throws SQLException, IllegalStateException {
		ArrayList<Long> res = new ArrayList<>();
		ResultSet set = executeQuery("SELECT id FROM " + tableName + " WHERE " + columnName + " = '" + feature + "';");
		
		while (set.next()) {
			res.add(set.getLong("id"));
		}
		
		return res;
	}
	
	public synchronized long getIDViaFeature(String tableName, String columnName, String feature) throws SQLException, IllegalStateException {
		ArrayList<Long> res = getIDsViaFeature(tableName, columnName, feature);
		if (res.size() == 1) {
			return res.get(0);
		}
		
		if (res.isEmpty()) {
			throw new IllegalStateException("Table '" + tableName + "' does not contain an entry '" + feature + "' in column '" + columnName + "'!");
		}
		
		throw new IllegalStateException("Table '" + tableName + "' has multiple IDs [" + res + "] for entry '" + feature + " in column " + columnName + "!");
	}
	
	public synchronized String getFeatureViaID(String tableName, String columnName, long id) throws SQLException, IllegalStateException {
		ArrayList<String> res = new ArrayList<>();
		ResultSet set = executeQuery("SELECT " + columnName + " FROM " + tableName + " WHERE id = " + id + ";");
		
		if (set.next()) {
			return set.getString(columnName);
		}
		
		throw new IllegalStateException("Table '" + tableName + "' does not contain id " + id + "!");
	}
	
	public synchronized String getFeatureViaFeature(String tableName, String sourceColumn, String targetColumn, String feature) throws SQLException, IllegalStateException {
		long id = getIDViaFeature(tableName, sourceColumn, feature);
		return getFeatureViaID(tableName, targetColumn, id);
	}
	
	public synchronized String getNameViaID(String tableName, long id) throws SQLException, IllegalStateException {
		return getFeatureViaID(tableName, "name", id);
	}
	
	public synchronized ResultSet getFeaturesViaID(String tableName, long id) throws SQLException {
		return executeQuery("SELECT * FROM " + tableName + " where id = " + id);
	}
	
	public synchronized ResultSet getFeaturesViaID(String tableName, String columnName, long id) throws SQLException {
		return executeQuery("SELECT " + columnName + " FROM " + tableName + " where id = " + id);
	}
	
	public synchronized long getLongMin(String tableName, String featureName) throws SQLException {
		return extractLongFeature(executeQuery("SELECT min(" + featureName + ") FROM " + tableName + ";"), "min").get(0);
	}
	
	public synchronized long getLongMax(String tableName, String featureName) throws SQLException {
		return extractLongFeature(executeQuery("SELECT max(" + featureName + ") FROM " + tableName + ";"), "max").get(0);
	}
	
	public synchronized double getDoubleMin(String tableName, String featureName) throws SQLException {
		return extractDoubleFeature(executeQuery("SELECT min(" + featureName + ") FROM " + tableName + ";"), "min").get(0);
	}
	
	public synchronized double getDoubleMax(String tableName, String featureName) throws SQLException {
		return extractDoubleFeature(executeQuery("SELECT max(" + featureName + ") FROM " + tableName + ";"), "max").get(0);
	}
	
	public synchronized String getTextMin(String tableName, String featureName) throws SQLException {
		return extractStringFeature(executeQuery("SELECT min(" + featureName + ") FROM " + tableName + ";"), "min").get(0);
	}
	
	public synchronized String getTextMax(String tableName, String featureName) throws SQLException {
		return extractStringFeature(executeQuery("SELECT max(" + featureName + ") FROM " + tableName + ";"), "max").get(0);
	}
	
	public synchronized ResultSet getValuesBetween(String tableName, String featureName, long min, long max) throws SQLException {
		if (max < min) {
			long temp = min;
			min = max;
			max = temp;
		}
		return getValuesBetween(tableName, featureName, String.valueOf(min), String.valueOf(max));
	}
	
	public synchronized ResultSet getValuesBetween(String tableName, String featureName, String min, String max) throws SQLException {
		return executeQuery("SELECT DISTINCT " + featureName + " FROM " + tableName + " WHERE " + featureName + " BETWEEN '" + min + "' AND '" + max + "';");
	}
	
	public synchronized ArrayList<String> extractStringFeature(ResultSet set, String feature) throws SQLException {
		ArrayList<String> res = new ArrayList<>();
		
		while (set.next()) {
			res.add(String.valueOf(set.getObject(feature)));
		}
		
		return res;
	}
	
	public synchronized ArrayList<Double> extractDoubleFeature(ResultSet set, String feature) throws SQLException, NumberFormatException {
		ArrayList<Double> res = new ArrayList<>();
		
		while (set.next()) {
			res.add(Double.parseDouble(set.getObject(feature).toString()));
		}
		
		return res;
	}
	
	public synchronized ArrayList<Integer> extractIntegerFeature(ResultSet set, String feature) throws SQLException, NumberFormatException {
		ArrayList<Integer> res = new ArrayList<>();
		
		while (set.next()) {
			res.add(Integer.parseInt(set.getObject(feature).toString()));
		}
		
		return res;
	}
	
	public synchronized ArrayList<Long> extractLongFeature(ResultSet set, String feature) throws SQLException, NumberFormatException {
		ArrayList<Long> res = new ArrayList<>();
		
		while (set.next()) {
			res.add(Long.parseLong(set.getObject(feature).toString()));
		}
		
		return res;
	}
	
	public synchronized Object getCell(String tableName, String columnName, long id) throws SQLException {
		String query = "SELECT " + columnName + " FROM " + tableName + " WHERE id = " + id + ";";
		ResultSet set = executeQuery(query);
		set.next();
		
		return set.getObject(columnName);
	}
	
	public int selectRowCount(String table, String columnName, boolean distinct) throws SQLException {
		String query = ("SELECT count(");
		if (distinct) {
			query = query + "DISTINCT ";
		}
		query = query + columnName + ") FROM " + table + ";";
		ResultSet set = executeQuery(query);
		boolean b = set.next();
		if (!b) return 0;
		
		return set.getInt("count");
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
	
	public boolean restartSequence(String name, long startValue) throws SQLException {
		if (startValue == 0) {
			restartSequence(name);
		}
		
		return execute("ALTER SEQUENCE " + name + " RESTART WITH " + startValue + ";");
	}
	
	public boolean restartTableSequence(String tableName) throws SQLException {
		return restartSequence(tableName + "_id_seq");
	}
	
	public synchronized boolean updateTable(String tableName, String columnName, String newEntry, long id) throws SQLException {
		return execute("UPDATE " + tableName + " SET " + columnName + " = " + newEntry + " WHERE id = " + id + ";");
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
	
	public synchronized boolean isExecutableQuery(String query) {
		try {
			executeQuery(query);
		} catch (SQLException e) {
			return false;
		}
		return true;
	}
	
	public Connection getConnection() {
		return connection;
	}
	
	public static synchronized String getLastCachedQuery() {
		return lastCachedQuery;
	}
	
	private static synchronized void setLastCachedQuery(String pLastCachedQuery) {
		lastCachedQuery = pLastCachedQuery;
	}
	
	public boolean isLogEnabled() {
		return logEnabled;
	}
	
	public void setLogEnabled(boolean logEnabled) {
		this.logEnabled = logEnabled;
	}
	
}
