package de.rub.bph.omnineuro.client.ui;

import de.rub.bph.omnineuro.client.config.ExportConfigManager;
import de.rub.bph.omnineuro.client.core.db.OmniNeuroQueryExecutor;
import de.rub.bph.omnineuro.client.imported.log.Log;
import org.json.JSONException;
import org.json.JSONObject;

import javax.swing.*;
import javax.swing.event.ListSelectionEvent;
import javax.swing.event.ListSelectionListener;
import java.awt.*;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.HashMap;

public class ExportConfigFrame extends JFrame implements ListSelectionListener {

	private OmniNeuroQueryExecutor queryExecutor;
	private ArrayList<String> metadataCategories;
	private HashMap<String, Runnable> panelActionMap;
	private JPanel rootPanel;
	private JButton saveButton;
	private JButton saveAndExportButton;
	private JButton importButton;
	private JList<String> metaDataList;

	private JSONObject myConfiguration;

	public ExportConfigFrame(Component parent, OmniNeuroQueryExecutor queryExecutor) {
		this(parent, queryExecutor, new JSONObject());
	}

	public ExportConfigFrame(Component parent, OmniNeuroQueryExecutor queryExecutor, JSONObject configuration) {
		this.myConfiguration = configuration;
		this.queryExecutor = queryExecutor;
		add(rootPanel);
		setTitle("Experiment configuration editor");
		setDefaultCloseOperation(DISPOSE_ON_CLOSE);


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
		panelActionMap.put(category, getActionDefault());

		category = "Experiment Plating Date";
		metadataCategories.add(category);
		panelActionMap.put(category, getActionDefault());

		category = "Experiment Name";
		metadataCategories.add(category);
		panelActionMap.put(category, getActionDefault());

		category = "Endpoint";
		metadataCategories.add(category);
		panelActionMap.put(category, getActionDefault());

		category = "Department";
		metadataCategories.add(category);
		panelActionMap.put(category, getActionDefault());

		category = "Species";
		metadataCategories.add(category);
		panelActionMap.put(category, getActionDefault());

		category = "Sex";
		metadataCategories.add(category);
		panelActionMap.put(category, getActionDefault());

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
		Log.i("Saving cached config: " + myConfiguration.toString());

		ExportConfigManager configManager = ExportConfigManager.getInstance();
		configManager.setCurrentConfig(myConfiguration);
	}

	private Runnable getActionDefault() {
		return new Runnable() {
			@Override
			public void run() {
				Log.i("Haha! :D");

				try {
					myConfiguration.put(new Date().toString(), "Boii");
				} catch (JSONException e) {
					e.printStackTrace();
				}
			}
		};
	}

	@Override
	public void valueChanged(ListSelectionEvent listSelectionEvent) {
		Log.v("The value has changed: " + listSelectionEvent);
		if (!listSelectionEvent.getValueIsAdjusting()) {
			updateSelectionPanel();
		}
	}
}
