package de.rub.bph.omnineuro.client.ui.component;

import de.rub.bph.omnineuro.client.Client;
import de.rub.bph.omnineuro.client.core.db.OmniNeuroQueryExecutor;
import de.rub.bph.omnineuro.client.imported.log.Log;
import de.rub.bph.omnineuro.client.util.CodeHasher;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import javax.swing.*;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collections;

import static de.rub.bph.omnineuro.client.ui.OmniFrame.DEFAULT_LIMITER_HASH_LENGTH;

public class ExportConfigDetailPanel implements MemorizedList.MarkedSelectionListener {

	public static final String JSON_ARG_VERSION = "version";
	public static final String JSON_ARG_LIMITER_TYPE = "type";
	public static final String JSON_ARG_LIMITER_DATA = "data";
	public static final String JSON_ARG_LIMITER_TYPE_SPECIFIC = "list";
	public static final String JSON_ARG_LIMITER_TYPE_RANGE = "range";

	private JPanel holderPL;
	private JRadioButton useEverythingRadioButton;
	private JRadioButton useSpecificEntriesRadioButton;
	private JRadioButton useRangeRadioButton;
	private MemorizedList entriesSelectionList;
	private JScrollPane specificPL;
	private JPanel rangePL;
	private OmniNeuroQueryExecutor queryExecutor;
	private String tableName;
	private String featureName;
	private String limiterName;
	private JSONObject data;
	private boolean enableRange;

	public ExportConfigDetailPanel(OmniNeuroQueryExecutor queryExecutor, String tableName, String featureName, String limiterName, JSONObject data, boolean enableRange) {
		this.queryExecutor = queryExecutor;
		this.limiterName = limiterName;
		this.tableName = tableName;
		this.featureName = featureName;
		this.data = data;
		this.enableRange = enableRange;

		Log.i("Preparing ConfigDetailPanel for table: '" + tableName + "' on '" + featureName + "' as: '" + limiterName + "'.");
		Log.i("Data as given on create: " + data);

		useEverythingRadioButton.addActionListener(actionEvent -> {
			onTypeChangeAll();
			updateTypePLs();
		});
		useSpecificEntriesRadioButton.addActionListener(actionEvent -> {
			onTypeChangeSpecific();
			updateTypePLs();
		});
		useRangeRadioButton.addActionListener(actionEvent -> {
			onTypeChangeRange();
			updateTypePLs();
		});

		try {
			readDataObject();
		} catch (JSONException e) {
			e.printStackTrace();
			Client.showErrorMessage("Heavy error occurred in the internal data structure!", holderPL, e);
		}
	}

	private ArrayList<String> readDatabase() throws SQLException {
		String query = "SELECT DISTINCT " + featureName + " FROM " + tableName + " ORDER BY " + featureName + ";";
		ResultSet set = queryExecutor.executeQuery(query);

		ArrayList<String> entries = new ArrayList<>();
		while (set.next()) {
			entries.add(set.getString(featureName));
		}
		return entries;
	}

	private void readDataObject() throws JSONException {
		useRangeRadioButton.setEnabled(enableRange);
		if (data.has(limiterName)) {
			JSONObject limiter = data.getJSONObject(limiterName);
			String type = limiter.getString(JSON_ARG_LIMITER_TYPE);

			if (type.equals(JSON_ARG_LIMITER_TYPE_SPECIFIC)) {
				useSpecificEntriesRadioButton.setSelected(true);
				JSONArray entries = limiter.getJSONArray(JSON_ARG_LIMITER_DATA);
				ArrayList<String> entryList = new ArrayList<>();
				for (int i = 0; i < entries.length(); i++) {
					String s = entries.getString(i);
					entryList.add(s);
				}
				Log.i("These would have been selected: " + entryList);
				entriesSelectionList.setMarked(true, (entryList));
			}
			if (type.equals(JSON_ARG_LIMITER_TYPE_RANGE)) {
				useRangeRadioButton.setSelected(true);
			}
		} else {
			useEverythingRadioButton.setSelected(true);
		}
		updateTypePLs();
	}

	private void updateTypePLs() {
		Log.i("Updating type panels. First: Everything vanishes!");
		specificPL.setVisible(false);
		rangePL.setVisible(false);

		if (useSpecificEntriesRadioButton.isSelected()) {
			specificPL.setVisible(true);
			Log.i("Specifics are made visible.");
		}
		if (useRangeRadioButton.isSelected()) {
			rangePL.setVisible(true);
			Log.i("Ranges are made visible.");
		}
		holderPL.validate();

		Log.i("Current data code: " + new CodeHasher(data.toString()).getCodeHash(DEFAULT_LIMITER_HASH_LENGTH));
	}

	public void onTypeChangeAll() {
		data.remove(limiterName);
	}

	public void onTypeChangeSpecific() {
		try {
			JSONObject limiter = new JSONObject();
			limiter.put(JSON_ARG_LIMITER_TYPE, JSON_ARG_LIMITER_TYPE_SPECIFIC);
			limiter.put(JSON_ARG_LIMITER_DATA, new JSONArray());
			data.put(limiterName, limiter);
		} catch (JSONException e) {
			Log.e(e);
			Client.showErrorMessage("Heavy internal error.", holderPL, e);
		}
	}

	public void onTypeChangeRange() {
		//TODO implement
	}

	public String getTableName() {
		return tableName;
	}

	public String getFeatureName() {
		return featureName;
	}

	public String getLimiterName() {
		return limiterName;
	}

	public JPanel getHolderPL() {
		return holderPL;
	}

	private void createUIComponents() {
		ArrayList<String> entries = new ArrayList<>();
		try {
			entries = readDatabase();
		} catch (SQLException e) {
			Log.e(e);
			Client.showSQLErrorMessage("Failed to retrieve data for selected limiter: " + limiterName + " [" + tableName + "].", e, holderPL);
		}

		Collections.sort(entries);
		entriesSelectionList = new MemorizedList(entries);
		entriesSelectionList.addMarkingListener(this);
	}

	@Override
	public void onMarkingChange(MemorizedList source) {
		ArrayList<String> markedItems = source.getMarkedEntries();
		Log.i("The marking of a list has changed! Currently " + markedItems.size() + " selected entries: " + markedItems);

		JSONArray markings = new JSONArray(markedItems);
		try {
			data.getJSONObject(limiterName).put(JSON_ARG_LIMITER_DATA, markings);
		} catch (JSONException e) {
			Log.e(e);
			Client.showErrorMessage("Internal data failure! Please try again!", holderPL, e);
		}
	}
}
