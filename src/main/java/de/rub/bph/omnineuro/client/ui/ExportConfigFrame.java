package de.rub.bph.omnineuro.client.ui;

import de.rub.bph.omnineuro.client.Client;
import de.rub.bph.omnineuro.client.config.ExportConfigManager;
import de.rub.bph.omnineuro.client.core.db.OmniNeuroQueryExecutor;
import de.rub.bph.omnineuro.client.imported.log.Log;
import de.rub.bph.omnineuro.client.ui.component.ExportConfigDetailPanel;
import org.json.JSONException;
import org.json.JSONObject;

import javax.swing.*;
import javax.swing.event.ListSelectionEvent;
import javax.swing.event.ListSelectionListener;
import java.awt.*;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;

public class ExportConfigFrame extends JFrame implements ListSelectionListener {

	public static final String JSON_TAG_LIMITERS = "limiters";
	private OmniNeuroQueryExecutor queryExecutor;
	private ArrayList<String> metadataCategories;
	private HashMap<String, Runnable> panelActionMap;
	private JPanel rootPanel;
	private JButton saveButton;
	private JButton saveAndExportButton;
	private JButton importButton;
	private JList<String> metaDataList;
	private JPanel configDetailPL;
	private JSONObject configuration;

	public ExportConfigFrame(Component parent, OmniNeuroQueryExecutor queryExecutor) {
		this(parent, queryExecutor, new JSONObject());
	}

	public ExportConfigFrame(Component parent, OmniNeuroQueryExecutor queryExecutor, JSONObject configuration) {
		this.queryExecutor = queryExecutor;
		add(rootPanel);
		setTitle("Experiment configuration editor");
		setDefaultCloseOperation(DISPOSE_ON_CLOSE);

		if (!configuration.has(JSON_TAG_LIMITERS)) {
			try {
				configuration.put(JSON_TAG_LIMITERS, new JSONObject());
			} catch (JSONException e) {
				Log.e(e);
				Client.showErrorMessage("Failed to prepare limiter configuration!", this, e);
				return;
			}
		}
		this.configuration = configuration;

		fillList();

		metaDataList.addListSelectionListener(this);
		saveButton.addActionListener(actionEvent -> save());

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
		panelActionMap.put(category, getActionConfigFrame("experiment", "timestamp", "timestamp", true));

		category = "Experiment Name";
		metadataCategories.add(category);
		panelActionMap.put(category, getActionConfigFrame("experiment", "name", "experiment_id", false));

		category = "Endpoint";
		metadataCategories.add(category);
		panelActionMap.put(category, getActionConfigFrameName("endpoint"));

		category = "Department";
		metadataCategories.add(category);
		panelActionMap.put(category, getActionConfigFrameName("department"));

		category = "Species";
		metadataCategories.add(category);
		panelActionMap.put(category, getActionConfigFrameName("species"));

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

	private void save() {
		Log.i("Saving cached config: " + configuration.toString());

		ExportConfigManager configManager = ExportConfigManager.getInstance();
		configManager.setCurrentConfig(configuration);
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

	public JSONObject getConfiguration() {
		return configuration;
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

	@Override
	public void valueChanged(ListSelectionEvent listSelectionEvent) {
		Log.v("The value has changed: " + listSelectionEvent);
		if (!listSelectionEvent.getValueIsAdjusting()) {
			updateSelectionPanel();
		}
	}
}
