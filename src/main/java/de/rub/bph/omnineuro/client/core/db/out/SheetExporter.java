package de.rub.bph.omnineuro.client.core.db.out;

import de.rub.bph.omnineuro.client.core.db.DBConnection;

import java.io.File;
import java.util.ArrayList;

public abstract class SheetExporter implements Runnable {

	protected File targetDir;
	protected DBConnection connection;
	protected ArrayList<Long> experimentIDs;

	public SheetExporter(File targetDir, DBConnection connection, ArrayList<Long> experimentIDs) {
		this.targetDir = targetDir;
		this.connection = connection;
		this.experimentIDs = experimentIDs;
	}

	public File getTargetDir() {
		return targetDir;
	}

	public ArrayList<Long> getExperimentIDs() {
		return experimentIDs;
	}
}
