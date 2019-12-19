package de.rub.bph.omnineuro.client.core.db.out;

import de.rub.bph.omnineuro.client.config.ExportConfigManager;
import de.rub.bph.omnineuro.client.imported.filemanager.FileManager;
import de.rub.bph.omnineuro.client.imported.log.Log;
import de.rub.bph.omnineuro.client.util.CodeHasher;
import de.rub.bph.omnineuro.client.util.concurrent.ConcurrentExecutionManager;
import org.json.JSONObject;

import java.io.File;
import java.util.ArrayList;

import static de.rub.bph.omnineuro.client.ui.OmniFrame.DEFAULT_LIMITER_HASH_LENGTH;

public abstract class SheetExporterCompatManager extends ConcurrentExecutionManager {
	
	public static final String ROOT_FILENAME_BASE = "exports";
	protected File sourceDir;
	
	public SheetExporterCompatManager(int threads, File sourceDir) {
		super(threads);
		this.sourceDir = sourceDir;
	}
	
	protected void modifySourceDirBasedOnConfig(JSONObject config) {
		modifySourceDirBasedOnConfig(config, ROOT_FILENAME_BASE);
	}
	
	protected void modifySourceDirBasedOnConfig(JSONObject config, String rootFileName) {
		File tempDir = sourceDir;
		config = ExportConfigManager.getInstance().getCurrentConfig();
		String dirTag = "";
		if (config != null) {
			CodeHasher hasher = new CodeHasher(config.toString());
			dirTag = "-" + hasher.getCodeHash(DEFAULT_LIMITER_HASH_LENGTH);
		}
		
		String rootDirName = rootFileName + dirTag;
		if (!tempDir.getName().equals(rootFileName)) {
			tempDir = new File(tempDir, rootDirName);
			tempDir.mkdirs();
		}
		
		File configFile = new File(sourceDir, "config" + dirTag + ".json");
		FileManager manager = new FileManager();
		try {
			manager.writeFile(configFile, config.toString(4));
		} catch (Throwable e) {
			Log.e("Failed to write current config as a reminder here: " + configFile.getAbsolutePath() + ". This fails silently.", e);
		}
		
		this.sourceDir = tempDir;
	}
	
	public abstract void export();
	
	public abstract ArrayList<String> getErrors();
	
	public File getSourceDir() {
		return sourceDir;
	}
	
	public abstract int getTaskCount();
}
