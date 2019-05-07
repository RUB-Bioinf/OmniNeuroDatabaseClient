package de.rub.bph.omnineuro.client.core.db;

import de.rub.bph.omnineuro.client.imported.log.Log;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {
	
	public static final String POTGRESQL_JDBC_URI_BASE = "jdbc:postgresql://";
	private static DBConnection myConnection;
	private Connection connection;
	private String ip;
	private String port;
	private String dbName;
	private String userName;
	
	private DBConnection() {
	
	}
	
	public void disconnect() throws SQLException {
		connection.close();
		connection = null;
	}
	
	public Connection connect(String ip, String port, String dbName, String userName, String pw) throws SQLException {
		if (isConnected()) {
			return connection;
		}
		
		connection = DriverManager.getConnection(getURI(ip, port, dbName), userName, pw);
		this.ip = ip;
		this.port = port;
		this.dbName = dbName;
		this.userName = userName;
		return connection;
	}
	
	public String getURI(String ip, String port, String dbName) {
		return POTGRESQL_JDBC_URI_BASE + ip + ":" + port + "/" + dbName;
	}
	
	@Override
	public String toString() {
		boolean connected;
		try {
			connected = isConnected();
		} catch (SQLException e) {
			Log.e(e);
			return "DB Connection object. Error occurred while checking the connected status. Can't tell if it is connected!";
		}
		if (connected) {
			return "DB Connection Object. Status: Connected to " + getIp() + ":" + getPort() + " on " + getDbName() + " as " + getUserName();
		} else {
			return "DB Connection Object. Status: Not connected.";
		}
	}
	
	public Connection getConnection() {
		return connection;
	}
	
	public static DBConnection getDBConnection() {
		if (myConnection == null) {
			myConnection = new DBConnection();
		}
		return myConnection;
	}
	
	public String getDbName() {
		return dbName;
	}
	
	public String getIp() {
		return ip;
	}
	
	public String getPort() {
		return port;
	}
	
	public String getUserName() {
		return userName;
	}
	
	public boolean isConnected() throws SQLException {
		Connection c = getConnection();
		return c != null && !c.isClosed();
	}
	
}
