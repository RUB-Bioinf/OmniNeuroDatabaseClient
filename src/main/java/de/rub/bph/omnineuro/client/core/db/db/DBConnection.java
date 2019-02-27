package de.rub.bph.omnineuro.client.core.db.db;

import de.rub.bph.omnineuro.client.imported.log.Log;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;

public class DBConnection {

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
		return c != null && c.isClosed();
	}

	public void disconnect() throws SQLException {
		connection.close();
		connection = null;
	}

	public Connection connect(String ip, String port, String dbName, String name, String pw) throws SQLException, ClassNotFoundException {
		if (isConnected()) {
			return connection;
		}

		String uri = "jdbc:postgresql://" + ip + ":" + port + "/" + dbName;
		Log.i("DB URL: " + uri);

		//Class.forName("com.mysql.jdbc.Driver");
		//TODO: Add a driver to gradle?
		connection = DriverManager.getConnection(uri, name, pw);
		return connection;
	}

	public Connection getConnection() {
		return connection;
	}

}
