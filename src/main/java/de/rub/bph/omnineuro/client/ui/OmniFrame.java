package de.rub.bph.omnineuro.client.ui;

import de.rub.bph.omnineuro.client.Client;
import de.rub.bph.omnineuro.client.core.sheet.MetaDataReader;
import de.rub.bph.omnineuro.client.core.sheet.reader.ExperimentDataReader;
import de.rub.bph.omnineuro.client.imported.filemanager.FileManager;
import de.rub.bph.omnineuro.client.imported.log.Log;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.json.JSONException;
import org.json.JSONObject;

import javax.swing.*;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;

public class OmniFrame extends JFrame implements DBCredentialsPanel.DBTextListener, DBCredentialsPanel.DBCredentialsActionListener {
	public static final int JSON_ROW_SPACES = 4;
	public static final String JSON_ENTRY_METADATA = "MetaData";
	public static final String JSON_ENTRY_SOURCEFILE = "SourceFile";
	public static final String EXCEL_SHEET_SUBNAME_METADATA = "exp. protocol";
	public static final String EXCEL_SHEET_SUBNAME_EXPERIMENT_DATA = "DB import";
	private static final String JSON_ENTRY_EXPERIMENTDATA = "ExperimentData";
	private JPanel rootPanel;
	private DBCredentialsPanel DBCredentialsPanel;
	private JButton button1;
	private FolderChooserPanel folderChooserPanel1;

	public OmniFrame() {
		add(rootPanel);

		button1.addActionListener(actionEvent -> testDBReader());

		DBCredentialsPanel.addActionListener(this);
		DBCredentialsPanel.addTextListener(this);

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

		readSheet(f);
	}

	public boolean readSheet(File file) {
		Workbook workbook = null;
		JSONObject experiment = new JSONObject();

		Log.i("Reading Excel file: " + file.getAbsolutePath());
		try {
			FileInputStream excelFile = new FileInputStream(file);
			Log.i("File read. Interpreting it now.");
			workbook = new XSSFWorkbook(excelFile);
		} catch (IOException e) {
			Log.e(e);
			return false;
		}
		Log.i("Interpretation complete.");

		// META DATA

		Log.i("Starting up meta data instructions!");
		MetaDataReader metaDataReader = null;
		FileManager fileManager = new FileManager();
		try {
			metaDataReader = new MetaDataReader(workbook, EXCEL_SHEET_SUBNAME_METADATA);
		} catch (IOException e) {
			Log.e(e);
			return false;
		}

		// EXPERIMENT DATA

		Log.i("Starting up experiment data instructions!");
		ExperimentDataReader experimentDataReader = null;
		try {
			experimentDataReader = new ExperimentDataReader(workbook, EXCEL_SHEET_SUBNAME_EXPERIMENT_DATA, new JSONObject());
		} catch (IOException e) {
			Log.e(e);
			return false;
		}

		try {
			experiment.put(JSON_ENTRY_METADATA, metaDataReader.readSheet());
			experiment.put(JSON_ENTRY_EXPERIMENTDATA, experimentDataReader.readSheet());
			experiment.put(JSON_ENTRY_SOURCEFILE, file.getAbsolutePath());
		} catch (Exception e) {
			e.printStackTrace();
			Log.e("FATAL ERROR! Failed to resolve meta data!", e);
			return false;
		}

		File outFile = new File(fileManager.getJSONOutDir(), file.getName().replace(".xlsx", "") + ".json");
		Log.i("Writing file to: " + outFile.getAbsolutePath());
		try {
			fileManager.writeFile(outFile, experiment.toString(JSON_ROW_SPACES));
		} catch (IOException | JSONException e) {
			e.printStackTrace();
		}
		Log.i("Experiment data read: " + experiment.toString());

		return true;
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
