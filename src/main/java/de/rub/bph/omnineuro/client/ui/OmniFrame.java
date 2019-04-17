package de.rub.bph.omnineuro.client.ui;

import de.rub.bph.omnineuro.client.Client;
import de.rub.bph.omnineuro.client.core.ExperimentReaderStatistics;
import de.rub.bph.omnineuro.client.core.SheetReaderManager;
import de.rub.bph.omnineuro.client.core.db.DBConnection;
import de.rub.bph.omnineuro.client.core.db.OmniNeuroQueryExecutor;
import de.rub.bph.omnineuro.client.core.db.in.InsertManager;
import de.rub.bph.omnineuro.client.core.db.out.SheetExporterCompatManager;
import de.rub.bph.omnineuro.client.imported.log.Log;
import de.rub.bph.omnineuro.client.util.NumberUtils;
import de.rub.bph.omnineuro.client.util.TimestampLookupManager;
import org.json.JSONObject;

import javax.swing.*;
import java.awt.event.WindowEvent;
import java.awt.event.WindowListener;
import java.io.File;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;

public class OmniFrame extends NFrame implements DBCredentialsPanel.DBTextListener, DBCredentialsPanel.DBCredentialsActionListener, WindowListener {

	public static final String OUT_DIR_NAME_STATISTICS = "statistics";
	public static final String OUT_DIR_NAME_INSERTER = "inserts";

	private JPanel rootPanel;
	private DBCredentialsPanel DBCredentialsPanel;
	private JButton button1;
	private FolderChooserPanel importDirChooserPanel1;
	private FolderChooserPanel exportDirChooserPanel;
	private JSpinner threadsSP;
	private JButton startExportButton;
	private JButton resetDatabaseButton;

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
		startExportButton.addActionListener(actionEvent -> requestExport());
		resetDatabaseButton.addActionListener(actionEvent -> resetDatabase());
	}

	public void startImport() {
		if (!testDBConnection(true)) {
			Client.showErrorMessage("Failed to connect to the database.\nPlease run diagnostics and try again.\nCan't import anything to the DB if a connection can't be established.", this);
			return;
		} else {
			Log.i("Connection to the DB is possible. Starting import process.");
		}

		int cores = (int) threadsSP.getValue();
		long startTime = new Date().getTime();
		File dir = new File(importDirChooserPanel1.getText());
		TimestampLookupManager.reset();

		ArrayList<JSONObject> readExperiments = new ArrayList<>();

		if (dir.exists() && dir.isDirectory()) {
			readExperiments = readExcelSheets(dir, cores);
		} else {
			Client.showErrorMessage("The specified path does not exist or is invalid!", this);
			return;
		}

		if (readExperiments == null || readExperiments.isEmpty()) {
			showErrorMessage("No experiments located!");
			return;
		}

		InsertManager insertManager = new InsertManager(new File(dir, OUT_DIR_NAME_INSERTER), cores, readExperiments);
		insertManager.insert();

		long timeTaken = new Date().getTime() - startTime;
		StringBuilder msgBuilder = new StringBuilder("Job done. Execution time: " + NumberUtils.convertSecondsToHMmSs(timeTaken) + ".");
		msgBuilder.append("\n\nExperiment statistics:");
		for (String s : insertManager.getTrivia()) {
			msgBuilder.append("\n").append(s);
		}

		Client.showInfoMessage(msgBuilder.toString().trim(), this);
	}

	public ArrayList<JSONObject> readExcelSheets(File sourceDir, int cores) {
		SheetReaderManager readerManager = new SheetReaderManager(sourceDir, cores);
		ArrayList<JSONObject> readExperiments = readerManager.startReading();

		if (readExperiments == null || readExperiments.size() == 0) {
			Client.showInfoMessage("No Experiments were found!", this);
			return null;
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

		return readExperiments;
	}

	private boolean testDBConnection() {
		return testDBConnection(true);
	}

	private boolean testDBConnection(boolean silent) {
		Log.i("Testing DB Connection");
		DBConnection connection = DBConnection.getDBConnection();

		try {
			Connection con = connection.connect(DBCredentialsPanel.getHostname(), DBCredentialsPanel.getPort(), DBCredentialsPanel.getDatabaseName(), DBCredentialsPanel.getUserName(), DBCredentialsPanel.getPassword());
			Log.i("Connected without problems!");

			if (!silent) {
				showInfoMessage("Connection to the Database established without problems.");
			}
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			Log.e(e);

			if (!silent) {
				showErrorMessage(e);
			}
			return false;
		}
	}

	public void requestExport() {
		Log.i("User requested Export");

		if (!testDBConnection()) {
			Log.i("Connection to the database failed. Can't export if there's no connection available.");
			return;
		}

		/*
		ExportDialog dialog = new ExportDialog();
		dialog.setLocationRelativeTo(this);
		dialog.setVisible(true);
		 */

		int threads = (int) threadsSP.getValue();
		File dir = new File(exportDirChooserPanel.getText());
		if (dir.isFile()) {
			dir = dir.getParentFile();
		}

		if (!dir.exists()) {
			dir.mkdirs();
		}

		//TODO preselect experiments somwhere else
		ArrayList<Long> experimentIDs = new ArrayList<>();
		try {
			experimentIDs = new OmniNeuroQueryExecutor(DBConnection.getDBConnection().getConnection()).getIDs("experiment");
		} catch (SQLException e) {
			Log.e(e);
		}

		SheetExporterCompatManager compatManager = new SheetExporterCompatManager(threads, dir, experimentIDs);
		compatManager.export();
	}

	public void resetDatabase() {
		Log.i("Reset Database has been requested!");
		testDBConnection();

		DBConnection connection = DBConnection.getDBConnection();
		try {
			new OmniNeuroQueryExecutor(connection.getConnection()).resetDatabase();
		} catch (SQLException e) {
			Log.e(e);
		}
		Log.i("Finished DB reset. Did it work?");
	}

	@Override
	public void onAction() {
		Log.i("CredentialsPNL: Action listener: Testing DB Connection");
		testDBConnection(false);
	}

	@Override
	public void onTextChange(String hostname, String port, String databaseName, String username, String password) {
		Log.v("DB Credentials changed. [IP: '" + hostname + "', Port: '" + port + "', DB: '" + databaseName + "', Username: '" + username + "', PW: '" + password + "']");
	}

	private void createUIComponents() {
		importDirChooserPanel1 = new FolderChooserPanel(new File(FolderChooserPanel.CACHE_IMPORT_SOURCE_DIR_FILENAME), "Source directory: ");
		exportDirChooserPanel = new FolderChooserPanel(new File(FolderChooserPanel.CACHE_EXPORT_DIR_FILENAME), "Target directory: ");
	}

	@Override
	public void windowOpened(WindowEvent windowEvent) {
		Log.i("Window opened. Hello there! You are a bold one, to use this application!");
	}

	@Override
	public void windowClosing(WindowEvent windowEvent) {
		Log.i("Window closing.");

		DBConnection connection = DBConnection.getDBConnection();
		try {
			if (connection.isConnected()) {
				Log.i("Client connected to the Database. Trying to close connection.");
				connection.disconnect();
			} else {
				Log.i("Client not connected. No need to disconnect.");
			}
		} catch (Throwable e) {
			e.printStackTrace();
			Log.e("Failed to close DB Connection.", e);
			showErrorMessage("Failed to close Connection to the Database!", e);
		}
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
