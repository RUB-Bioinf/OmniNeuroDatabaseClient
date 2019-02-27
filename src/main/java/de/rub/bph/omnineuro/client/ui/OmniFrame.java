package de.rub.bph.omnineuro.client.ui;

import de.rub.bph.omnineuro.client.Client;
import de.rub.bph.omnineuro.client.core.ExperimentReaderStatistics;
import de.rub.bph.omnineuro.client.core.SheetReaderManager;
import de.rub.bph.omnineuro.client.core.db.db.DBConnection;
import de.rub.bph.omnineuro.client.imported.log.Log;
import org.json.JSONObject;

import javax.swing.*;
import java.awt.event.WindowEvent;
import java.awt.event.WindowListener;
import java.io.File;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;

public class OmniFrame extends JFrame implements DBCredentialsPanel.DBTextListener, DBCredentialsPanel.DBCredentialsActionListener, WindowListener {

	public static final String OUT_DIR_NAME_STATISTICS = "statistics";
	private JPanel rootPanel;
	private DBCredentialsPanel DBCredentialsPanel;
	private JButton button1;
	private FolderChooserPanel folderChooserPanel1;
	private JSpinner threadsSP;

	public OmniFrame() {
		add(rootPanel);

		button1.addActionListener(actionEvent -> startImport());

		int cores = Runtime.getRuntime().availableProcessors();
		Log.i("This device has " + cores + " CPU cores available!");
		threadsSP.setModel(new SpinnerNumberModel(cores - 1, 1, Integer.MAX_VALUE, 1));

		DBCredentialsPanel.addActionListener(this);
		DBCredentialsPanel.addTextListener(this);
		addWindowListener(this);

		setTitle("OmniNeuro [Release " + Client.VERSION + "]");
		setDefaultCloseOperation(EXIT_ON_CLOSE);
		pack();
		setMinimumSize(getMinimumSize());
		setLocationRelativeTo(null);
		setVisible(true);
	}

	public void startImport() {
		File dir = new File(folderChooserPanel1.getText());
		if (dir.exists() && dir.isDirectory()) {
			readExcelSheets(dir);
		} else {
			Client.showErrorMessage("The specified path does not exist or is invalid!", this);
		}
	}

	public void readExcelSheets(File sourceDir) {
		long startTime = new Date().getTime();
		int cores = (int) threadsSP.getValue();
		SheetReaderManager readerManager = new SheetReaderManager(sourceDir, cores);
		ArrayList<JSONObject> readExperiments = readerManager.startReading();

		if (readExperiments == null || readExperiments.size() == 0) {
			Client.showInfoMessage("No Experiments were found!", this);
			return;
		}

		File statisticsDir = new File(sourceDir, OUT_DIR_NAME_STATISTICS);
		Log.i("Saving statistics to: " + statisticsDir.getAbsolutePath());

		ExperimentReaderStatistics statistics = new ExperimentReaderStatistics(readExperiments, statisticsDir);
		try {
			statistics.calculateAll();
		} catch (Exception e) {
			Log.e(e);
			Client.showErrorMessage("Failed to calculate statistics, due to: " + e.getMessage(), this);
		}

		long timeTaken = new Date().getTime() - startTime;
		Client.showInfoMessage("Job done. Execution time: " + timeTaken + " ms.", this);
	}

	private void testDBConnection() {
		Log.i("Testing DB Connection");
		DBConnection connection = DBConnection.getDBConnection();

		try {
			Connection con = connection.connect(DBCredentialsPanel.getDatabaseName(),DBCredentialsPanel.getPort(),DBCredentialsPanel.getDatabaseName(),DBCredentialsPanel.getUserName(),DBCredentialsPanel.getPassword());
			Log.i("Connected without problems!");
		} catch (Exception e) {
			e.printStackTrace();
			Log.e(e);
		}
	}

	@Override
	public void onAction() {
		Log.i("CredentialsPNL: Action listener!!");
		testDBConnection();
	}

	@Override
	public void onTextChange(String hostname, String port, String databaseName, String username, String password) {
		Log.v("DB Credentials changed. [IP: '" + hostname + "', Port: '" + port + "', DB: '" + databaseName + "', Username: '" + username + "', PW: '" + password + "']");
	}

	private void createUIComponents() {
		folderChooserPanel1 = new FolderChooserPanel(new File(FolderChooserPanel.CACHE_FILENAME), "Source directory: ");
	}

	@Override
	public void windowOpened(WindowEvent windowEvent) {
		Log.i("Window opened. Hello there! You are a bold one, to use this application!");

		DBConnection connection = DBConnection.getDBConnection();
		try {
			if (connection.isConnected()){
				Log.i("Client connected to the Database. Trying to close connection.");
				connection.disconnect();
			}
		} catch (Throwable e) {
			e.printStackTrace();
			Log.e("Failed to close DB Connection.",e);
		}
	}

	@Override
	public void windowClosing(WindowEvent windowEvent) {
		Log.i("Window closing.");
	}

	@Override
	public void windowClosed(WindowEvent windowEvent) {
		Log.i("Window closed. Goodbye.");
	}

	@Override
	public void windowIconified(WindowEvent windowEvent) {

	}

	@Override
	public void windowDeiconified(WindowEvent windowEvent) {

	}

	@Override
	public void windowActivated(WindowEvent windowEvent) {

	}

	@Override
	public void windowDeactivated(WindowEvent windowEvent) {

	}
}
