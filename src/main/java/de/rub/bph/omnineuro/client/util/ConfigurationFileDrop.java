package de.rub.bph.omnineuro.client.util;

import de.rub.bph.omnineuro.client.Client;
import de.rub.bph.omnineuro.client.core.db.DBConnection;
import de.rub.bph.omnineuro.client.core.db.OmniNeuroQueryExecutor;
import de.rub.bph.omnineuro.client.imported.filemanager.FileManager;
import de.rub.bph.omnineuro.client.imported.log.Log;
import de.rub.bph.omnineuro.client.imported.rharder.FileDrop;
import de.rub.bph.omnineuro.client.ui.ExportConfigFrame;
import org.json.JSONException;
import org.json.JSONObject;

import java.awt.*;
import java.io.File;
import java.io.IOException;

public class ConfigurationFileDrop implements FileDrop.Listener {

	private boolean registered;
	private Component component;
	private OmniNeuroQueryExecutor queryExecutor;

	public ConfigurationFileDrop(OmniNeuroQueryExecutor queryExecutor) {
		this.queryExecutor = queryExecutor;
		registered = false;
	}

	public ConfigurationFileDrop() {
		this(null);
	}

	public void register(Component component, boolean recursive) {
		if (component == null) {
			throw new IllegalArgumentException("The component is null!");
		}
		if (isRegistered()) {
			throw new IllegalStateException("Can't register two components. This FileDrop is already used up.");
		}

		this.component = component;
		new FileDrop(component, recursive, this);
		registered = true;
	}

	public boolean isRegistered() {
		return registered;
	}

	@Override
	public void filesDropped(File[] files) {
		if (files == null) {
			Log.w("Files dropped. But they were null.");
			return;
		}

		OmniNeuroQueryExecutor executor;
		if (queryExecutor == null) {
			executor = new OmniNeuroQueryExecutor(DBConnection.getDBConnection().getConnection());
		} else {
			executor = queryExecutor;
		}

		Log.i("Files have been dropped into the GUI. Count: " + files.length);
		FileManager manager = new FileManager();
		for (File f : files) {
			Log.i("File has been dropped: " + f.getAbsolutePath());

			if (f.isDirectory()) {
				Log.i("The provided dropped file is a directory. Checking its contents then.");
				filesDropped(f.listFiles());
				return;
			}

			try {
				new ExportConfigFrame(component, executor, new JSONObject(manager.readFile(f)), f.getName());
			} catch (JSONException | IOException e) {
				Log.e(e);
				Client.showErrorMessage("Failed to read data from file:\n" + f.getAbsolutePath() + "\n\nAre you sure this is a valid configuration file?", component, e);
			}
		}
	}
}
