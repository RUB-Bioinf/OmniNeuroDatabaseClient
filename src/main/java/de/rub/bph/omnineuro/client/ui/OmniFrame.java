package de.rub.bph.omnineuro.client.ui;

import de.rub.bph.omnineuro.client.Client;
import de.rub.bph.omnineuro.client.core.sheet.ReaderManager;
import de.rub.bph.omnineuro.client.imported.filemanager.FileManager;
import de.rub.bph.omnineuro.client.imported.log.Log;
import org.json.JSONException;
import org.json.JSONObject;

import javax.swing.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.io.File;
import java.io.IOException;

public class OmniFrame extends JFrame implements DBCredentialsPanel.DBTextListener, DBCredentialsPanel.DBCredentialsActionListener {
	public static final int JSON_ROW_SPACES = 4;
	public static final String JSON_ENTRY_METADATA = "MetaData";
	public static final String JSON_ENTRY_SOURCEFILE = "SourceFile";
	private JPanel rootPanel;
	private DBCredentialsPanel DBCredentialsPanel1;
	private JButton button1;

	public OmniFrame() {
		add(rootPanel);

		button1.addActionListener(new ActionListener() {
			@Override
			public void actionPerformed(ActionEvent actionEvent) {
				testDBReader();
			}
		});

		DBCredentialsPanel1.addActionListener(this);
		DBCredentialsPanel1.addTextListener(this);

		setTitle("OmniNeuro [Release " + Client.VERSION + "]");
		setDefaultCloseOperation(EXIT_ON_CLOSE);
		pack();
		setMinimumSize(getMinimumSize());
		setLocationRelativeTo(null);
		setVisible(true);
	}

	@Deprecated
	private void testDBReader() {
		Log.i("Testing DB Reader.");
		File f = new File("sheets\\NPC2-5_layout_24JAN18.xlsx");

		readSheet(f, "exp. protocol", 4);
	}

	public void readSheet(File file, String sheetName, int threads) {
		ReaderManager readerManager = null;
		FileManager fileManager = new FileManager();

		try {
			readerManager = new ReaderManager(file, sheetName);
		} catch (IOException e) {
			Log.e(e);
			return;
		}

		JSONObject experiment = new JSONObject();
		try {
			experiment.put(JSON_ENTRY_METADATA, readerManager.readSheet());
			experiment.put(JSON_ENTRY_SOURCEFILE, file.getAbsolutePath());
		} catch (Exception e) {
			e.printStackTrace();
			Log.e("FATAL ERROR! Failed to resolve meta data!", e);
			return;
		}
		Log.i("Experiment data read: " + experiment.toString());

		File outFile = new File(fileManager.getJSONOutDir(), file.getName().replace(".xlsx", "") + ".json");
		Log.i("Writing file to: " + outFile.getAbsolutePath());
		try {
			fileManager.writeFile(outFile, experiment.toString(JSON_ROW_SPACES));
		} catch (IOException | JSONException e) {
			e.printStackTrace();
		}
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
