package de.rub.bph.omnineuro.client.util;

import de.rub.bph.omnineuro.client.imported.filemanager.FileManager;
import de.rub.bph.omnineuro.client.imported.log.Log;
import org.json.JSONException;
import org.json.JSONObject;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;

public class TimestampLookupManager {

	public static final String FILE_DIRECOTRY = "data";
	public static final String FILENAME = "timestamp_lookup.json";
	public static final int TIMESTAMP_NOT_INCLUDED = -1;
	private static TimestampLookupManager instance;
	private HashMap<String, Integer> timestampMap;
	private HashMap<String, String> nameMap;

	private TimestampLookupManager() {
		timestampMap = new HashMap<>();
		nameMap = new HashMap<>();
		try {
			readDataJSON();
		} catch (Throwable e) {
			Log.e("Failed to get timestamp lookup table! Expected table location: " + getDataFile().getAbsolutePath(), e);
		}
	}

	public static void reset() {
		instance = null;
	}

	public static TimestampLookupManager getInstance() {
		if (instance == null) {
			instance = new TimestampLookupManager();
		}
		return instance;
	}

	private synchronized void readDataJSON() throws IOException, JSONException {
		File f = getDataFile();
		if (!f.exists()) {
			Log.w("Warning! External data JSON does not exist. File expected here: " + f.getAbsolutePath());
		}

		FileManager manager = new FileManager();
		JSONOperator operator = new JSONOperator();
		String text = manager.readFile(f);
		JSONObject data = new JSONObject(text);
		Log.i("Read timestamp data successfully: " + data.toString());

		ArrayList<String> keys = operator.getKeys(data);
		Log.i("Interpreting timestamp data. Count: " + keys.size());
		for (String key : keys) {
			JSONObject endpoint = data.getJSONObject(key);
			int timestamp = endpoint.getInt("timestamp");
			String name = endpoint.getString("name");
			timestampMap.put(key, timestamp);
			nameMap.put(key, name);
			Log.v("Timestamp interpreting: " + key + " -> " + name + ", " + timestamp + "h");
		}
	}

	public File getDataFile() {
		return new File(FILE_DIRECOTRY, FILENAME);
	}

	public boolean hasEndpoint(String key) {
		return timestampMap.containsKey(key);
	}

	public Integer getTimestamp(String endpointName) {
		if (!hasEndpoint(endpointName)) {
			return TIMESTAMP_NOT_INCLUDED;
		}

		return timestampMap.get(endpointName);
	}

	public String getName(String endpointName) {
		if (!hasEndpoint(endpointName)) {
			return null;
		}

		return nameMap.get(endpointName);
	}

}
