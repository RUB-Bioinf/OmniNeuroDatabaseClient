package de.rub.bph.omnineuro.client.ui;

import de.rub.bph.omnineuro.client.Client;
import de.rub.bph.omnineuro.client.core.SheetReaderManager;
import de.rub.bph.omnineuro.client.imported.log.Log;

import javax.swing.*;
import java.io.File;

public class OmniFrame extends JFrame implements DBCredentialsPanel.DBTextListener, DBCredentialsPanel.DBCredentialsActionListener {
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
			return;
		}
		readExcelSheets(dir);
	}

	public void readExcelSheets(File sourceDir) {
		int cores = (int) threadsSP.getValue();
		SheetReaderManager readerManager = new SheetReaderManager(sourceDir, cores);
		readerManager.startReading();
	}

	@Override
	public void onAction() {
		Log.i("CredentialsPNL: Action listener!!");
	}

	@Override
	public void onTextChange(String hostname, String port, String databaseName, String username, String password) {
		Log.v("DB Credentials changed. [IP: '" + hostname + "', Port: '" + port + "', DB: '" + databaseName + "', Username: '" + username + "', PW: '" + password + "']");
	}
}
