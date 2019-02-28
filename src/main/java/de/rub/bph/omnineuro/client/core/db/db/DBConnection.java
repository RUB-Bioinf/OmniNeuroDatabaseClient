package de.rub.bph.omnineuro.client.core.db.db;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {

	public static final String POTGRESQL_JDBC_URI_BASE = "jdbc:postgresql://";
	private static DBConnection myConnection;
	private Connection connection;

	private DBConnection() {

	}

	public static DBConnection getDBConnection() {
		if (myConnection == null) {
			myConnection = new DBConnection();
		}
		return myConnection;
	}

	public boolean isConnected() throws SQLException {
		Connection c = getConnection();
		return c != null && !c.isClosed();
	}

	public void disconnect() throws SQLException {
		connection.close();
		connection = null;
	}

	public Connection connect(String ip, String port, String dbName, String name, String pw) throws SQLException, ClassNotFoundException {
		if (isConnected()) {
			return connection;
		}

		//Class.forName("com.mysql.jdbc.Driver");
		//TODO: Add a driver to gradle?
		connection = DriverManager.getConnection(getURI(ip, port, dbName), name, pw);
		return connection;
	}

	public String getURI(String ip, String port, String dbName) {
		return POTGRESQL_JDBC_URI_BASE + ip + ":" + port + "/" + dbName;
	}

	public Connection getConnection() {
		return connection;
	}

}
