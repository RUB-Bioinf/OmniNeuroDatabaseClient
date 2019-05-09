package de.rub.bph.omnineuro.client.ui.component;

import de.rub.bph.omnineuro.client.Client;
import de.rub.bph.omnineuro.client.core.db.OmniNeuroQueryExecutor;
import de.rub.bph.omnineuro.client.imported.log.Log;
import de.rub.bph.omnineuro.client.util.CodeHasher;
import de.rub.bph.omnineuro.client.util.DateLabelFormatter;
import org.jdatepicker.impl.JDatePanelImpl;
import org.jdatepicker.impl.JDatePickerImpl;
import org.jdatepicker.impl.UtilDateModel;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import javax.swing.*;
import javax.swing.event.DocumentEvent;
import javax.swing.event.DocumentListener;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Properties;

import static de.rub.bph.omnineuro.client.ui.OmniFrame.DEFAULT_LIMITER_HASH_LENGTH;

public class ExportConfigDetailPanel implements MemorizedList.MarkedSelectionListener {
	
	public static final String DEFAULT_DATE_PICKER_DATE_FORMAT = "yyyy-MM-dd";
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
	private JDatePickerImpl dateCeilingPicker;
	private JDatePickerImpl dateFloorPicker;
	private OmniNeuroQueryExecutor queryExecutor;
	private String tableName;
	private String featureName;
	private String limiterName;
	private JSONObject data;
	private boolean enableRange;
	private String rangeMin, rangeMax;
	private boolean dateMode;
	private SimpleDateFormat configDateFormatter;
	
	public ExportConfigDetailPanel(OmniNeuroQueryExecutor queryExecutor, String tableName, String featureName, String limiterName, JSONObject data, boolean enableRange, boolean dateMode) {
		this.queryExecutor = queryExecutor;
		this.dateMode = dateMode;
		this.limiterName = limiterName;
		this.tableName = tableName;
		this.featureName = featureName;
		this.data = data;
		this.enableRange = enableRange;
		configDateFormatter = new SimpleDateFormat(DEFAULT_DATE_PICKER_DATE_FORMAT);
		
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
					if (dateMode) {
						dateFloorPicker.getJFormattedTextField().setText(configDateFormatter.format(Long.parseLong(f)));
					}
				}
				if (entries.has(JSON_ARG_LIMITER_TYPE_RANGE_CEILING)) {
					String c = entries.getString(JSON_ARG_LIMITER_TYPE_RANGE_CEILING);
					ceilingTF.setText(c);
					if (dateMode) {
						dateCeilingPicker.getJFormattedTextField().setText(configDateFormatter.format(Long.parseLong(c)));
					}
				}
				updateRangePreviewLB();
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
		
		if (dateMode) {
			entriesSelectionList.setTextFormatter(new DateLabelFormatter(DEFAULT_DATE_PICKER_DATE_FORMAT));
		}
		
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
		
		// Range entries
		if (enableRange) {
			Log.i("Setting up range Panel.");
			try {
				rangeMin = queryExecutor.getTextMin(tableName, featureName);
				rangeMax = queryExecutor.getTextMax(tableName, featureName);
				
			} catch (SQLException e) {
				Log.e(e);
				Client.showErrorMessage("Failed to get minimum and maximum values from the database!", holderPL, e);
				return;
			}
			String textMin = rangeMin;
			String textMax = rangeMax;
			Log.i("For " + tableName + " min: " + rangeMin + ". Max: " + rangeMax);
			if (dateMode) {
				configDateFormatter = new SimpleDateFormat(DEFAULT_DATE_PICKER_DATE_FORMAT);
				long min = Long.parseLong(rangeMin);
				long max = Long.parseLong(rangeMax);
				textMax = configDateFormatter.format(max);
				textMin = configDateFormatter.format(min);
			}
			
			entryMinMaxPL = new JLabel("Currently in the database: Values between " + textMin + " and " + textMax + ".");
			ceilingTF.getDocument().addDocumentListener(docListener);
			floorTF.getDocument().addDocumentListener(docListener);
			//ceilingTF.setText(rangeMax);
			//floorTF.setText(rangeMin);
		}
		
		//Date styles
		
		UtilDateModel ceilingModel = new UtilDateModel();
		UtilDateModel floorModel = new UtilDateModel();
		Properties ceilingProperties = new Properties();
		ceilingProperties.put("text.today", "Today");
		ceilingProperties.put("text.month", "Month");
		ceilingProperties.put("text.year", "Year");
		Properties floorProperties = new Properties(ceilingProperties);
		JDatePanelImpl dateFloorPanel = new JDatePanelImpl(floorModel, floorProperties);
		JDatePanelImpl dateCeilingPanel = new JDatePanelImpl(ceilingModel, ceilingProperties);
		dateCeilingPicker = new JDatePickerImpl(dateCeilingPanel, new DateLabelFormatter(DEFAULT_DATE_PICKER_DATE_FORMAT));
		dateFloorPicker = new JDatePickerImpl(dateFloorPanel, new DateLabelFormatter(DEFAULT_DATE_PICKER_DATE_FORMAT));
		dateCeilingPicker.getJFormattedTextField().getDocument().addDocumentListener(docListener);
		dateFloorPicker.getJFormattedTextField().getDocument().addDocumentListener(docListener);
		
		dateFloorPicker.setVisible(dateMode);
		dateCeilingPicker.setVisible(dateMode);
		ceilingTF.setVisible(!dateMode);
		floorTF.setVisible(!dateMode);
	}
	
	private void updateRangePreviewLB() {
		Log.i("Updating the range preview labels!");
		if (rangePreviewPL == null) {
			Log.w("The preview label does not exist yet. The world isn't ready yet to see those ranges!");
			return;
		}
		
		String min;
		String max;
		if (dateMode) {
			min = dateFloorPicker.getJFormattedTextField().getText();
			max = dateCeilingPicker.getJFormattedTextField().getText();
		} else {
			min = floorTF.getText().trim();
			max = ceilingTF.getText().trim();
		}
		
		boolean minEmpty = min.equals("");
		boolean maxEmpty = max.equals("");
		Log.v("Updating previewPL: Floor: '" + min + "'. Ceil: '" + max + "'.");
		
		StringBuilder builder = new StringBuilder("Selecting all data ");
		if (minEmpty && maxEmpty) builder = new StringBuilder("Floor and Ceiling should not be empty");
		
		String val = null;
		if (minEmpty && !maxEmpty) {
			if (dateMode) {
				builder.append("earlier");
			} else {
				builder.append("less");
			}
			builder.append(" than");
			val = max;
		}
		if (!minEmpty && maxEmpty) {
			if (dateMode) {
				builder.append("later");
			} else {
				builder.append("less");
			}
			builder.append(" than");
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
		
		if (dateMode) {
			if (!minEmpty) {
				try {
					min = String.valueOf(configDateFormatter.parse(min).getTime());
				} catch (Throwable e) {
					Log.e(e);
					Client.showErrorMessage("Can't convert the input '" + min + "' into UNIX timestamp!", holderPL, e);
				}
			}
			if (!maxEmpty) {
				try {
					max = String.valueOf(configDateFormatter.parse(max).getTime());
				} catch (Throwable e) {
					Log.e(e);
					Client.showErrorMessage("Can't convert the input '" + max + "' into UNIX timestamp!", holderPL, e);
				}
			}
		}
		
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
