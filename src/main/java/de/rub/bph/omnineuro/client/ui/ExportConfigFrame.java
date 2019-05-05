package de.rub.bph.omnineuro.client.ui;

import de.rub.bph.omnineuro.client.Client;
import de.rub.bph.omnineuro.client.config.ExportConfigManager;
import de.rub.bph.omnineuro.client.core.db.OmniNeuroQueryExecutor;
import de.rub.bph.omnineuro.client.imported.filemanager.FileManager;
import de.rub.bph.omnineuro.client.imported.log.Log;
import de.rub.bph.omnineuro.client.ui.component.ExportConfigDetailPanel;
import de.rub.bph.omnineuro.client.util.CodeHasher;
import de.rub.bph.omnineuro.client.util.ConfigurationFileDrop;
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

import static de.rub.bph.omnineuro.client.ui.OmniFrame.DEFAULT_LIMITER_HASH_LENGTH;
import static javax.swing.JFileChooser.APPROVE_OPTION;

public class ExportConfigFrame extends JFrame implements ListSelectionListener {
	
	public static final String JSON_SAFE_FILE_EXTENSION = "json";
	public static final String JSON_TAG_LIMITERS = "limiters";
	public static final String JSON_TAG_VERSION = "version";
	public static final String NEW_CONFIG_DEFAULT_TITLE = "New Configuration";
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
		this(parent, queryExecutor, getEmptyConfiguration(), NEW_CONFIG_DEFAULT_TITLE);
	}
	
	public ExportConfigFrame(Component parent, OmniNeuroQueryExecutor queryExecutor, JSONObject configuration) throws JSONException {
		this(parent, queryExecutor, configuration, new CodeHasher(configuration.toString()).getCodeHash(DEFAULT_LIMITER_HASH_LENGTH));
	}
	
	public ExportConfigFrame(Component parent, OmniNeuroQueryExecutor queryExecutor, JSONObject configuration, String configTitle) throws JSONException {
		this.queryExecutor = queryExecutor;
		add(rootPanel);
		setDefaultCloseOperation(DISPOSE_ON_CLOSE);
		
		if (configTitle == null || configTitle.trim().equals("")) {
			configTitle = NEW_CONFIG_DEFAULT_TITLE;
		}
		setTitle("Experiment configuration editor [" + configTitle + "]");
		
		//TODO cache filepath
		FileNameExtensionFilter filter = new FileNameExtensionFilter("JSON", JSON_SAFE_FILE_EXTENSION);
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
		new ConfigurationFileDrop(queryExecutor).register(this, true);
		
		metaDataList.addListSelectionListener(this);
		saveButton.addActionListener(actionEvent -> apply());
		applyAndSaveButton.addActionListener(e -> {
			apply();
			save();
		});
		loadButton.addActionListener(actionEvent -> load());
		
		pack();
		setMinimumSize(getSize());
		setSize((int) (getWidth() * 2.5), (int) (getHeight() * 1.5));
		setLocationRelativeTo(parent);
		setJMenuBar(createMenu());
		setVisible(true);
		updateSelectionPanel();
	}
	
	public JMenuBar createMenu() {
		JMenuBar menuBar = new JMenuBar();
		
		JMenu menu = new JMenu("File");
		JMenuItem item = new JMenuItem("New");
		item.addActionListener(actionEvent -> {
			try {
				new ExportConfigFrame(rootPanel, queryExecutor);
			} catch (JSONException e) {
				Log.e(e);
				Client.showErrorMessage("Failed to parse default data.", rootPanel, e);
			}
		});
		setMenuItemShortcut(item, 'N');
		menu.add(item);
		
		item = new JMenuItem("Duplicate");
		item.addActionListener(actionEvent -> {
			try {
				new ExportConfigFrame(rootPanel, queryExecutor, configuration);
			} catch (JSONException e) {
				Log.e(e);
				Client.showErrorMessage("Failed to parse current data.", rootPanel, e);
			}
		});
		setMenuItemShortcut(item, 'D');
		menu.add(item);
		
		item = new JMenuItem("Close");
		item.addActionListener(actionEvent -> {
			dispose();
		});
		setMenuItemShortcut(item, 'W');
		menu.add(item);
		
		menuBar.add(menu);
		
		return menuBar;
	}
	
	private void setMenuItemShortcut(JMenuItem menuItem, char key) {
		menuItem.setAccelerator(KeyStroke.getKeyStroke(key, Toolkit.getDefaultToolkit().getMenuShortcutKeyMask()));
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
		
		category = "Response Timestamp";
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
		
		//category = "Country";
		//metadataCategories.add(category);
		//panelActionMap.put(category, getActionConfigFrameName("country"));
		
		category = "Leader";
		metadataCategories.add(category);
		panelActionMap.put(category, getActionConfigFrameName("leader"));
		
		category = "Plate format";
		metadataCategories.add(category);
		panelActionMap.put(category, getActionConfigFrameName("plate_format"));
		
		category = "Controls";
		metadataCategories.add(category);
		panelActionMap.put(category, getActionConfigFrameName("control"));
		
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
		
		category = "Concentration";
		metadataCategories.add(category);
		panelActionMap.put(category, getActionConfigFrame("concentration", "value", "value_concentration", true));
		
		category = "Response Value";
		metadataCategories.add(category);
		panelActionMap.put(category, getActionConfigFrame("response", "value", "value_response", true));
		
		Collections.sort(metadataCategories);
		DefaultListModel<String> listModel = new DefaultListModel<>();
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
		if (state == APPROVE_OPTION) {
			File file = fileChooser.getSelectedFile();
			String filename = file.getAbsolutePath();
			String extension = "." + JSON_SAFE_FILE_EXTENSION;
			if (!filename.toLowerCase().endsWith(extension)) {
				filename = filename + extension;
				file = new File(filename);
			}
			if (file.exists()) {
				boolean overwrite = Client.showConfirmDialog("The file '" + file.getName() + "' already exists.\nDo you want to overwrite it?", this);
				if (!overwrite) {
					fileChooser.setCurrentDirectory(file.getParentFile());
					save();
					return;
				}
			}
			
			FileManager manager = new FileManager();
			try {
				manager.writeFile(file, configuration.toString(4));
				Log.i("Done. Saved file: " + file.getAbsolutePath() + " [" + file.length() + "B]");
				//TODO implement confirm overwrite dialog
			} catch (IOException | JSONException e) {
				Log.e(e);
				Client.showErrorMessage("Failed to save the configuration!", this, e);
			}
		} else {
			Log.i("Saving file canceled.");
		}
	}
	
	public void load() {
		int state = fileChooser.showOpenDialog(this);
		if (state == APPROVE_OPTION) {
			FileManager manager = new FileManager();
			File file = fileChooser.getSelectedFile();
			
			String text;
			try {
				text = manager.readFile(fileChooser.getSelectedFile());
			} catch (IOException e) {
				Log.e(e);
				Client.showErrorMessage("Failed to read file: " + file.getAbsolutePath(), this, e);
				return;
			}
			
			JSONObject loadedData;
			try {
				loadedData = new JSONObject(text);
				new ExportConfigFrame(this, queryExecutor, loadedData, file.getName());
			} catch (JSONException e) {
				Log.e(e);
				Client.showErrorMessage("The file you selected does not contain valid configuration data.", this, e);
			}
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
	
	private void updateSelectionPanel() {
		String selection = metaDataList.getSelectedValue();
		if (selection == null) {
			Log.w("Nothing has been selected.");
			setComponentToDetailPL(new JLabel("Nothing has been selected. Select a limiter from the list to edit it."));
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
	
	public String hashData() {
		return new CodeHasher(configuration).getCodeHash(DEFAULT_LIMITER_HASH_LENGTH);
	}
	
	@Override
	public void valueChanged(ListSelectionEvent listSelectionEvent) {
		Log.v("The value has changed: " + listSelectionEvent);
		if (!listSelectionEvent.getValueIsAdjusting()) {
			updateSelectionPanel();
		}
	}
	
	public JSONObject getConfiguration() {
		return configuration;
	}
	
	public static JSONObject getEmptyConfiguration() throws JSONException {
		JSONObject empty = new JSONObject();
		empty.put(JSON_TAG_VERSION, Client.VERSION);
		empty.put(JSON_TAG_LIMITERS, new JSONObject());
		return empty;
	}
}
