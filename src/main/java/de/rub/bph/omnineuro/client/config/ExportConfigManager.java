package de.rub.bph.omnineuro.client.config;

import de.rub.bph.omnineuro.client.imported.filemanager.FileManager;
import de.rub.bph.omnineuro.client.imported.log.Log;
import org.json.JSONObject;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;

public class ExportConfigManager {

	public static final String CACHE_FILENAME = "exportCfg.cache";
	private static ExportConfigManager configManager;

	private JSONObject currentConfig;
	private ArrayList<ExportConfigManagerListener> listeners;

	private ExportConfigManager() {
		listeners = new ArrayList<>();
		refreshCache();
	}

	public static ExportConfigManager getInstance() {
		if (configManager == null) configManager = new ExportConfigManager();

		return configManager;
	}

	public void refreshCache() {
		String s = null;
		JSONObject config = null;

		if (existsCache()) {
			try {
				s = readCacheFile();
				config = new JSONObject(s);
			} catch (Throwable e) {
				Log.e("Failed to read export config file. ", e);
			}
		} else {
			Log.i("Did you know? You could place a export config file here: " + getCacheFile().getAbsolutePath());
		}
		setCurrentConfig(config);
	}

	private String readCacheFile() throws IOException {
		if (!existsCache()) {
			return null;
		}

		FileManager manager = new FileManager();
		return manager.readFile(getCacheFile());
	}

	public boolean existsCache() {
		return getCacheFile().exists();
	}

	public void addListener(ExportConfigManagerListener... listener) {
		listeners.addAll(Arrays.asList(listener));
	}

	public File getCacheFile() {
		return new File(CACHE_FILENAME);
	}

	public JSONObject getCurrentConfig() {
		return currentConfig;
	}

	public void setCurrentConfig(JSONObject currentConfig) {
		this.currentConfig = currentConfig;
		for (ExportConfigManagerListener listener : listeners) {
			listener.onConfigChange(getCurrentConfig());
		}
	}

	public void clear() {
		setCurrentConfig(null);
	}

	public interface ExportConfigManagerListener {

		public void onConfigChange(JSONObject newConfig);

	}
}
