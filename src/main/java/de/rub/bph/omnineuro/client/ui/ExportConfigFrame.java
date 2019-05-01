package de.rub.bph.omnineuro.client.ui;

import de.rub.bph.omnineuro.client.Client;
import de.rub.bph.omnineuro.client.config.ExportConfigManager;
import de.rub.bph.omnineuro.client.core.db.OmniNeuroQueryExecutor;
import de.rub.bph.omnineuro.client.imported.filemanager.FileManager;
import de.rub.bph.omnineuro.client.imported.log.Log;
import de.rub.bph.omnineuro.client.ui.component.ExportConfigDetailPanel;
import org.json.JSONException;
import org.json.JSONObject;

import javax.swing.*;
import javax.swing.event.ListSelectionEvent;
import javax.swing.event.ListSelectionListener;
import javax.swing.filechooser.FileNameExtensionFilter;
import java.awt.*;
import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;

public class ExportConfigFrame extends JFrame implements ListSelectionListener {

	public static final String JSON_TAG_LIMITERS = "limiters";
	public static final String JSON_TAG_VERSION = "version";

	private OmniNeuroQueryExecutor queryExecutor;
	private ArrayList<String> metadataCategories;
	private HashMap<String, Runnable> panelActionMap;
	private JPanel rootPanel;
	private JButton saveButton;
	private JButton applyAndSaveButton;
	private JButton loadButton;
	private JList<String> metaDataList;
	private JPanel configDetailPL;
	private JSONObject configuration;
	private JFileChooser fileChooser;

	public ExportConfigFrame(Component parent, OmniNeuroQueryExecutor queryExecutor) throws JSONException {
		this(parent, queryExecutor, getEmptyConfiguration());
	}

	public ExportConfigFrame(Component parent, OmniNeuroQueryExecutor queryExecutor, JSONObject configuration) throws JSONException {
		this.queryExecutor = queryExecutor;
		add(rootPanel);
		setTitle("Experiment configuration editor");
		setDefaultCloseOperation(DISPOSE_ON_CLOSE);

		//TODO read filepath
		FileNameExtensionFilter filter = new FileNameExtensionFilter("JSON", "json");
		fileChooser = new JFileChooser();
		fileChooser.addChoosableFileFilter(filter);

		if (!configuration.has(JSON_TAG_LIMITERS)) {
			configuration.put(JSON_TAG_LIMITERS, new JSONObject());
		}
		if (!configuration.has(JSON_TAG_VERSION)) {
			configuration.put(JSON_TAG_VERSION, Client.VERSION);
		}

		this.configuration = configuration;

		fillList();

		metaDataList.addListSelectionListener(this);
		saveButton.addActionListener(actionEvent -> apply());
		applyAndSaveButton.addActionListener(e -> {
			apply();
			save();
		});

		pack();
		setMinimumSize(getSize());
		setLocationRelativeTo(parent);
		setVisible(true);
		updateSelectionPanel();
	}

	private void fillList() {
		metadataCategories = new ArrayList<>();
		panelActionMap = new HashMap<>();
		String category;

		category = "Project";
		metadataCategories.add(category);
		panelActionMap.put(category, getActionConfigFrameName("project"));

		category = "Experiment Plating Date";
		metadataCategories.add(category);
		panelActionMap.put(category, getActionConfigFrame("experiment", "timestamp", "timestamp_experiment", true));

		category = "Experiment Name";
		metadataCategories.add(category);
		panelActionMap.put(category, getActionConfigFrame("experiment", "name", "experiment_id", false));

		category = "Response timestamp";
		metadataCategories.add(category);
		panelActionMap.put(category, getActionConfigFrame("response", "timestamp", "timestamp_response", false));

		category = "Endpoint";
		metadataCategories.add(category);
		panelActionMap.put(category, getActionConfigFrameName("endpoint"));

		category = "Department";
		metadataCategories.add(category);
		panelActionMap.put(category, getActionConfigFrameName("department"));

		category = "Species";
		metadataCategories.add(category);
		panelActionMap.put(category, getActionConfigFrameName("species"));

		category = "Cell Type";
		metadataCategories.add(category);
		panelActionMap.put(category, getActionConfigFrameName("cell_type"));

		category = "Compound";
		metadataCategories.add(category);
		panelActionMap.put(category, getActionConfigFrameName("compound"));

		category = "Initiator";
		metadataCategories.add(category);
		panelActionMap.put(category, getActionConfigFrameName("initiator"));

		category = "Workgroup";
		metadataCategories.add(category);
		panelActionMap.put(category, getActionConfigFrameName("workgroup"));

		category = "Country";
		metadataCategories.add(category);
		panelActionMap.put(category, getActionConfigFrameName("country"));

		category = "Leader";
		metadataCategories.add(category);
		panelActionMap.put(category, getActionConfigFrameName("leader"));

		category = "Plate format";
		metadataCategories.add(category);
		panelActionMap.put(category, getActionConfigFrameName("plate_format"));

		category = "Assay";
		metadataCategories.add(category);
		panelActionMap.put(category, getActionConfigFrameName("assay"));

		category = "Outlier status";
		metadataCategories.add(category);
		panelActionMap.put(category, getActionConfigFrameName("outlier_type"));

		category = "Individual";
		metadataCategories.add(category);
		panelActionMap.put(category, getActionConfigFrameName("individual"));

		category = "Sex";
		metadataCategories.add(category);
		panelActionMap.put(category, getActionConfigFrame("sex", "label", "sex", false));

		Collections.sort(metadataCategories);
		DefaultListModel<String> listModel = new DefaultListModel<String>();
		for (String s : metadataCategories) {
			listModel.addElement(s);
		}
		metaDataList.setModel(listModel);
	}

	private void apply() {
		Log.i("Saving cached config: " + configuration.toString());

		ExportConfigManager configManager = ExportConfigManager.getInstance();
		configManager.setCurrentConfig(configuration);
	}

	private void save() {
		Log.i("User wants to save the current configuration.");
		int state = fileChooser.showSaveDialog(this);
		if (state == JFileChooser.APPROVE_OPTION) {
			File file = fileChooser.getSelectedFile();
			FileManager manager = new FileManager();
			try {
				manager.writeFile(file, configuration.toString(4));
				Log.i("Done. Saved file: "+file.getAbsolutePath()+" ["+file.length()+"B]");
				//TODO implement confirm overwrite dialog
			} catch (IOException | JSONException e) {
				Log.e(e);
				Client.showErrorMessage("Failed to save the configuration!", this, e);
			}
		} else {
			Log.i("Saving file canceled.");
		}
	}

	private Runnable getActionConfigFrameName(String tableName) {
		return getActionConfigFrame(tableName, "name", tableName, false);
	}

	private Runnable getActionConfigFrame(String tableName, String featureName, String limiterName, boolean allowRange) {
		return () -> {
			JSONObject limiters = null;
			try {
				limiters = getConfiguration().getJSONObject(JSON_TAG_LIMITERS);
			} catch (JSONException e) {
				Log.e(e);
				Client.showErrorMessage("Failed to build internal limiters data.", rootPane, e);
				return;
			}

			setComponentToDetailPL(new ExportConfigDetailPanel(queryExecutor, tableName, featureName, limiterName, limiters, allowRange).getHolderPL());
		};
	}

	@Override
	public void valueChanged(ListSelectionEvent listSelectionEvent) {
		Log.v("The value has changed: " + listSelectionEvent);
		if (!listSelectionEvent.getValueIsAdjusting()) {
			updateSelectionPanel();
		}
	}

	private void updateSelectionPanel() {
		String selection = metaDataList.getSelectedValue();
		if (selection == null) {
			Log.w("Nothing has been selected.");
			setComponentToDetailPL(new JLabel("Nothing has been selected."));
			return;
		}

		if (!panelActionMap.containsKey(selection)) {
			Log.w("Selection '" + selection + "' does not exist in the lookup map!");
			return;
		}

		Runnable r = panelActionMap.get(selection);
		r.run();
	}

	public void setComponentToDetailPL(Component component) {
		Log.i("Setting a new component to the detail pane.");
		configDetailPL.removeAll();

		if (component == null) {
			Log.e("The component is null. Nothing to display.");
			revalidate();
			return;
		}

		GridBagConstraints gbc = new GridBagConstraints();
		gbc.weightx = gbc.weighty = 1.0;
		gbc.fill = GridBagConstraints.BOTH;
		gbc.gridwidth = gbc.gridheight = GridBagConstraints.REMAINDER;

		Log.i("Applying component: " + component.getClass().getSimpleName());
		configDetailPL.add(component, gbc);
		revalidate();
	}

	public static JSONObject getEmptyConfiguration() throws JSONException {
		JSONObject empty = new JSONObject();
		empty.put(JSON_TAG_VERSION, Client.VERSION);
		empty.put(JSON_TAG_LIMITERS, new JSONObject());
		return empty;
	}

	public JSONObject getConfiguration() {
		return configuration;
	}
}
