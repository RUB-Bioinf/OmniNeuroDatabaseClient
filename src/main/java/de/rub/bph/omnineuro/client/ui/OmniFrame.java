package de.rub.bph.omnineuro.client.ui;

import de.rub.bph.omnineuro.client.Client;
import de.rub.bph.omnineuro.client.core.ExperimentReaderStatistics;
import de.rub.bph.omnineuro.client.core.SheetReaderManager;
import de.rub.bph.omnineuro.client.imported.log.Log;
import org.json.JSONObject;

import javax.swing.*;
import java.io.File;
import java.util.ArrayList;
import java.util.Date;

public class OmniFrame extends JFrame implements DBCredentialsPanel.DBTextListener, DBCredentialsPanel.DBCredentialsActionListener {
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

		long timeTaken = new Date().getTime()-startTime;
		Client.showInfoMessage("Job done. Execution time: "+timeTaken+" ms.",this);
	}

	@Override
	public void onAction() {
		Log.i("CredentialsPNL: Action listener!!");
	}

	@Override
	public void onTextChange(String hostname, String port, String databaseName, String username, String password) {
		Log.v("DB Credentials changed. [IP: '" + hostname + "', Port: '" + port + "', DB: '" + databaseName + "', Username: '" + username + "', PW: '" + password + "']");
	}

	private void createUIComponents() {
		folderChooserPanel1 = new FolderChooserPanel(new File(FolderChooserPanel.CACHE_FILENAME), "Source directory: ");
	}
}
