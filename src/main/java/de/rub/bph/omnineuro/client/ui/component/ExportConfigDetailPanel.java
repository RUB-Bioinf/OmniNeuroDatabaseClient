package de.rub.bph.omnineuro.client.ui.component;

import de.rub.bph.omnineuro.client.Client;
import de.rub.bph.omnineuro.client.core.db.OmniNeuroQueryExecutor;
import de.rub.bph.omnineuro.client.imported.log.Log;
import de.rub.bph.omnineuro.client.util.CodeHasher;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import javax.swing.*;
import javax.swing.event.DocumentEvent;
import javax.swing.event.DocumentListener;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collections;

import static de.rub.bph.omnineuro.client.ui.OmniFrame.DEFAULT_LIMITER_HASH_LENGTH;

public class ExportConfigDetailPanel implements MemorizedList.MarkedSelectionListener {
	
	public static final String JSON_ARG_LIMITER_DATA = "data";
	public static final String JSON_ARG_LIMITER_TYPE = "type";
	public static final String JSON_ARG_LIMITER_TYPE_RANGE = "range";
	public static final String JSON_ARG_LIMITER_TYPE_RANGE_CEILING = "ceiling";
	public static final String JSON_ARG_LIMITER_TYPE_RANGE_FLOOR = "floor";
	public static final String JSON_ARG_LIMITER_TYPE_SPECIFIC = "list";
	private JPanel holderPL;
	private JRadioButton useEverythingRadioButton;
	private JRadioButton useSpecificEntriesRadioButton;
	private JRadioButton useRangeRadioButton;
	private MemorizedList entriesSelectionList;
	private JPanel rangePL;
	private JPanel specificPL;
	private JLabel entryMinMaxPL;
	private JTextField ceilingTF;
	private JTextField floorTF;
	private JLabel rangePreviewPL;
	private OmniNeuroQueryExecutor queryExecutor;
	private String tableName;
	private String featureName;
	private String limiterName;
	private JSONObject data;
	private boolean enableRange;
	private String rangeMin, rangeMax;
	
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
				JSONObject entries = limiter.getJSONObject(JSON_ARG_LIMITER_DATA);
				if (entries.has(JSON_ARG_LIMITER_TYPE_RANGE_FLOOR)) {
					String f = entries.getString(JSON_ARG_LIMITER_TYPE_RANGE_FLOOR);
					floorTF.setText(f);
				}
				if (entries.has(JSON_ARG_LIMITER_TYPE_RANGE_CEILING)) {
					String c = entries.getString(JSON_ARG_LIMITER_TYPE_RANGE_CEILING);
					ceilingTF.setText(c);
				}
				updateRangePreviewLB();
			}
		} else {
			useEverythingRadioButton.setSelected(true);
		}
		updateTypePLs();
	}
	
	private void setUpRangePL() throws SQLException {
	
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
		//TODO update this on every single change
		//TODO report updates to parent frame
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
		Log.i("I have changed to 'Range'.");
		try {
			JSONObject limiter = new JSONObject();
			limiter.put(JSON_ARG_LIMITER_TYPE, JSON_ARG_LIMITER_TYPE_RANGE);
			JSONObject rangeData = new JSONObject();
			//rangeData.put(JSON_ARG_LIMITER_TYPE_RANGE_CEILING, rangeMax);
			//rangeData.put(JSON_ARG_LIMITER_TYPE_RANGE_FLOOR, rangeMin);
			limiter.put(JSON_ARG_LIMITER_DATA, rangeData);
			data.put(limiterName, limiter);
		} catch (JSONException e) {
			Log.e(e);
			Client.showErrorMessage("Heavy internal error.", holderPL, e);
		}
		updateRangePreviewLB();
	}
	
	private void createUIComponents() {
		ArrayList<String> entries = new ArrayList<>();
		try {
			entries = readDatabase();
		} catch (SQLException e) {
			Log.e(e);
			Client.showSQLErrorMessage("Failed to retrieve data for selected limiter: " + limiterName + " [" + tableName + "].", e, holderPL);
		}
		
		// Specific entries
		Collections.sort(entries);
		entriesSelectionList = new MemorizedList(entries);
		entriesSelectionList.addMarkingListener(this);
		ceilingTF = new JTextField();
		floorTF = new JTextField();
		entryMinMaxPL = new JLabel("Range entries here");
		
		// Range entries
		if (enableRange) {
			Log.i("Setting up range Panel.");
			double min;
			double max;
			try {
				min = queryExecutor.getDoubleMin(tableName, featureName);
				max = queryExecutor.getDoubleMax(tableName, featureName);
			} catch (SQLException e) {
				Log.e(e);
				Client.showErrorMessage("Failed to get minimum and maximum values from the database!", holderPL, e);
				return;
			}
			Log.i("For " + tableName + " min: " + min + ". Max: " + max);
			
			entryMinMaxPL = new JLabel("Currently in the database: Values between " + min + " and " + max + ".");
			DocumentListener docListener = new DocumentListener() {
				@Override
				public void insertUpdate(DocumentEvent documentEvent) {
					updateRangePreviewLB();
				}
				
				@Override
				public void removeUpdate(DocumentEvent documentEvent) {
					updateRangePreviewLB();
				}
				
				@Override
				public void changedUpdate(DocumentEvent documentEvent) {
					updateRangePreviewLB();
				}
			};
			
			rangeMax = String.valueOf(max);
			rangeMin = String.valueOf(min);
			ceilingTF.getDocument().addDocumentListener(docListener);
			floorTF.getDocument().addDocumentListener(docListener);
			//ceilingTF.setText(rangeMax);
			//floorTF.setText(rangeMin);
		}
	}
	
	private void updateRangePreviewLB() {
		if (rangePreviewPL == null) {
			Log.w("The preview label does not exist yet. The world isn't ready yet to see those ranges!");
			return;
		}
		
		String min = floorTF.getText().trim();
		String max = ceilingTF.getText().trim();
		
		boolean minEmpty = min.equals("");
		boolean maxEmpty = max.equals("");
		Log.v("Updating previewPL: Floor: '" + min + "'. Ceil: '" + max + "'.");
		
		StringBuilder builder = new StringBuilder("Selecting all data ");
		if (minEmpty && maxEmpty) builder = new StringBuilder("Floor and Ceiling should not be empty");
		
		String val = null;
		if (minEmpty && !maxEmpty) {
			builder.append("less than");
			val = max;
		}
		if (!minEmpty && maxEmpty) {
			builder.append("more than");
			val = min;
		}
		if (!maxEmpty && !minEmpty) {
			builder.append("between");
			val = min + " and " + max;
		}
		if (val != null) {
			builder.append(" or equal to ");
			builder.append(val);
		}
		builder.append(".");
		rangePreviewPL.setText(builder.toString());
		
		JSONObject rangeData = new JSONObject();
		try {
			if (!minEmpty) {
				rangeData.put(JSON_ARG_LIMITER_TYPE_RANGE_FLOOR, min);
			}
			if (!maxEmpty) {
				rangeData.put(JSON_ARG_LIMITER_TYPE_RANGE_CEILING, max);
			}
			data.getJSONObject(limiterName).put(JSON_ARG_LIMITER_DATA, rangeData);
		} catch (JSONException e) {
			Log.e(e);
			Client.showErrorMessage("Internal data failure! Please try again!", holderPL, e);
		}
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
	
	public String getFeatureName() {
		return featureName;
	}
	
	public JPanel getHolderPL() {
		return holderPL;
	}
	
	public String getLimiterName() {
		return limiterName;
	}
	
	public String getTableName() {
		return tableName;
	}
}
