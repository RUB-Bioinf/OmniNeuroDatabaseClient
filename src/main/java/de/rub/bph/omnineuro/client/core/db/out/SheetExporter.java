package de.rub.bph.omnineuro.client.core.db.out;

import de.rub.bph.omnineuro.client.core.db.DBConnection;

import java.io.File;
import java.util.ArrayList;

public abstract class SheetExporter implements Runnable {
	
	protected File targetDir;
	protected DBConnection connection;
	protected ArrayList<Long> responseIDs;
	
	public SheetExporter(File targetDir, DBConnection connection, ArrayList<Long> responseIDs) {
		this.targetDir = targetDir;
		this.connection = connection;
		this.responseIDs = responseIDs;
	}
	
	public ArrayList<Long> getResponseIDs() {
		return responseIDs;
	}
	
	public File getTargetDir() {
		return targetDir;
	}
	
}
