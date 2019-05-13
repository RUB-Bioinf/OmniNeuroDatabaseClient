package de.rub.bph.omnineuro.client.ui;

import de.rub.bph.omnineuro.client.Client;
import de.rub.bph.omnineuro.client.config.ExportConfigManager;
import de.rub.bph.omnineuro.client.core.ExperimentReaderStatistics;
import de.rub.bph.omnineuro.client.core.SheetReaderManager;
import de.rub.bph.omnineuro.client.core.db.DBConnection;
import de.rub.bph.omnineuro.client.core.db.OmniNeuroQueryExecutor;
import de.rub.bph.omnineuro.client.core.db.in.InsertManager;
import de.rub.bph.omnineuro.client.core.db.out.ResponseIDLimiter;
import de.rub.bph.omnineuro.client.core.db.out.SheetExporterCompatManager;
import de.rub.bph.omnineuro.client.imported.filemanager.FileManager;
import de.rub.bph.omnineuro.client.imported.log.Log;
import de.rub.bph.omnineuro.client.util.CodeHasher;
import de.rub.bph.omnineuro.client.util.ConfigurationFileDrop;
import de.rub.bph.omnineuro.client.util.NumberUtils;
import de.rub.bph.omnineuro.client.util.TimestampLookupManager;
import org.json.JSONException;
import org.json.JSONObject;

import javax.swing.*;
import java.awt.event.WindowEvent;
import java.awt.event.WindowListener;
import java.io.File;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;

public class OmniFrame extends NFrame implements DBCredentialsPanel.DBTextListener, DBCredentialsPanel.DBCredentialsActionListener, WindowListener, ExportConfigManager.ExportConfigManagerListener {
	
	public static final int DEFAULT_LIMITER_HASH_LENGTH = 6;
	public static final String OUT_DIR_NAME_INSERTER = "inserts";
	public static final String OUT_DIR_NAME_STATISTICS = "statistics";
	private JPanel rootPanel;
	private DBCredentialsPanel DBCredentialsPanel;
	private JButton button1;
	private FolderChooserPanel importDirChooserPanel1;
	private FolderChooserPanel exportDirChooserPanel;
	private JSpinner threadsSP;
	private JButton startExportButton;
	private JButton resetDatabaseButton;
	private JLabel configurationStatusLB;
	private JButton configurationEditorButton;
	private JButton searchForHashButton;
	private JPanel configurationDDPL;
	private JCheckBox commaCB;
	
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
		
		startExportButton.addActionListener(actionEvent -> requestExport());
		resetDatabaseButton.addActionListener(actionEvent -> resetDatabase());
		configurationEditorButton.addActionListener(actionEvent -> actionOpenConfigWindow());
		searchForHashButton.addActionListener(actionEvent -> {
			ExportConfigManager configManager1 = ExportConfigManager.getInstance();
			try {
				CodeHasher.searchHash(4387870, DEFAULT_LIMITER_HASH_LENGTH, configManager1.getCurrentConfig().toString(), "NILS", 500);
			} catch (IOException e) {
				Log.e(e);
			}
		});
		
		ExportConfigManager configManager = ExportConfigManager.getInstance();
		configManager.addListener(this);
		configManager.refreshCache();
		loadConfigCache();
		new ConfigurationFileDrop().register(configurationDDPL, true);
		
		searchForHashButton.setVisible(false);
		setVisible(true);
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
	
	public void actionOpenConfigWindow() {
		if (!testDBConnection(true)) {
			Client.showErrorMessage("Failed to connect to the database. Without the connection, a configuration can't be made.", this);
			return;
		}
		
		Connection connection = DBConnection.getDBConnection().getConnection();
		ExportConfigManager configManager = ExportConfigManager.getInstance();
		JSONObject currentConfig = configManager.getCurrentConfig();
		if (currentConfig == null) {
			try {
				currentConfig = ExportConfigFrame.getEmptyConfiguration();
			} catch (Throwable e) {
				Log.e(e);
				Client.showErrorMessage("You didn't set up a default limiter configuration. The client wanted to set up an empty one for you, but that failed!", this, e);
				return;
			}
		}
		
		try {
			new ExportConfigFrame(this, new OmniNeuroQueryExecutor(connection), currentConfig);
		} catch (Throwable e) {
			Log.e(e);
			Client.showErrorMessage("Failed to prepare limiter configuration!", this, e);
		}
	}
	
	public void requestExport() {
		long startTime = new Date().getTime();
		ExportConfigManager configManager = ExportConfigManager.getInstance();
		boolean useComma = commaCB.isSelected();
		
		if (!testDBConnection()) {
			Log.i("Connection to the database failed. Can't export if there's no connection available.");
			Client.showErrorMessage("Connection to the database failed. Can't export if there's no connection available.", this);
			return;
		}
		
		if (!configManager.hasConfig()) {
			Client.showErrorMessage("No export limiter configuration set. That's required to do, if you want to export anything.", this);
			return;
		}
		
		int threads = (int) threadsSP.getValue();
		File dir = new File(exportDirChooserPanel.getText());
		if (dir.isFile()) {
			dir = dir.getParentFile();
		}
		if (!dir.exists()) {
			dir.mkdirs();
		}
		
		OmniNeuroQueryExecutor executor = new OmniNeuroQueryExecutor(DBConnection.getDBConnection().getConnection());
		ArrayList<Long> responseIDs;
		
		try {
			responseIDs = executor.getIDs("response");
		} catch (SQLException e) {
			Log.e(e);
			Client.showSQLErrorMessage("Failed to receive experiment data from the database.", e, this);
			return;
		}
		
		ArrayList<Long> limitedResponseIDs;
		JSONObject limiters = configManager.getCurrentConfig();
		try {
			ResponseIDLimiter limiter = new ResponseIDLimiter(responseIDs, limiters);
			limitedResponseIDs = limiter.applyAllLimiters();
		} catch (Throwable e) {
			Log.e(e);
			Client.showErrorMessage("Failed to apply limiters and configuration to the database!", this, e);
			return;
		}
		Log.i("After running the limiters, " + responseIDs.size() + " has been reduced to " + limitedResponseIDs.size() + ".");
		
		if (limitedResponseIDs.isEmpty()) {
			Client.showErrorMessage("No responses to export. The database has " + responseIDs.size() + " responses, but after " +
					"applying the limiters, none were left.", this);
			return;
		}
		
		SheetExporterCompatManager compatManager = new SheetExporterCompatManager(threads, dir, limitedResponseIDs, useComma);
		compatManager.export();
		
		long duration = new Date().getTime() - startTime;
		String formattedTimeTaken = NumberUtils.convertSecondsToHMmSs(duration);
		Client.showInfoMessage("Job done. Execution time: " + formattedTimeTaken + "\n\nDetailed export reports will be shown here, but only in a later version.", this);
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
		Client.showInfoMessage("All experiments and responses have been deleted from the database. Certain project specific meta data is untouched.", this);
	}
	
	public void updateConfigListenerText(JSONObject newConfig) {
		Log.i("Export config has been updated!");
		
		if (newConfig == null) {
			configurationStatusLB.setText("No configuration loaded.");
		} else {
			configurationStatusLB.setText("Configuration loaded. Code: " + new CodeHasher(newConfig.toString()).getCodeHash(DEFAULT_LIMITER_HASH_LENGTH));
		}
	}
	
	private void saveConfigCache() {
		Log.i("Saving config cache.");
		ExportConfigManager configManager = ExportConfigManager.getInstance();
		FileManager fileManager = new FileManager();
		File file = configManager.getCacheFile();
		JSONObject config = configManager.getCurrentConfig();
		
		if (config == null) {
			Log.i("No config in use, so nothing will be saved.");
			return;
		}
		
		try {
			fileManager.writeFile(file, config.toString(4));
		} catch (Throwable e) {
			Log.e("Failed to cache config to: '" + file.getAbsolutePath() + "'. Config: " + config.toString(), e);
			return;
		}
		Log.i("Saved config cache to: " + file.getAbsolutePath());
	}
	
	private void loadConfigCache() {
		ExportConfigManager configManager = ExportConfigManager.getInstance();
		FileManager fileManager = new FileManager();
		File file = configManager.getCacheFile();
		
		if (!file.exists()) {
			Log.i("Wanted to load config cache. But the file was not found: " + file.getAbsolutePath());
			return;
		}
		
		String text = null;
		try {
			text = fileManager.readFile(file);
			configManager.setCurrentConfig(new JSONObject(text));
		} catch (IOException | JSONException e) {
			Log.e(e);
		}
	}
	
	private void createUIComponents() {
		importDirChooserPanel1 = new FolderChooserPanel(new File(FolderChooserPanel.CACHE_IMPORT_SOURCE_DIR_FILENAME), "Source directory: ");
		exportDirChooserPanel = new FolderChooserPanel(new File(FolderChooserPanel.CACHE_EXPORT_DIR_FILENAME), "Target directory: ");
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
	
	@Override
	public void onConfigChange(JSONObject newConfig) {
		updateConfigListenerText(newConfig);
		saveConfigCache();
	}
}
