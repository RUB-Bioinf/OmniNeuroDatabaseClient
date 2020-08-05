package de.rub.bph.omnineuro.client.core.db.out;

import de.rub.bph.omnineuro.client.core.db.DBConnection;
import de.rub.bph.omnineuro.client.imported.log.Log;
import de.rub.bph.omnineuro.client.util.concurrent.TimedRunnable;

import java.io.File;
import java.util.ArrayList;

public abstract class SheetExporter extends TimedRunnable {
	
	protected File targetDir;
	protected DBConnection connection;
	protected boolean useComma;
	protected ArrayList<String> errorList;
	
	public SheetExporter(File targetDir, DBConnection connection, boolean useComma) {
		this.targetDir = targetDir;
		this.useComma = useComma;
		this.connection = connection;
		
		errorList = new ArrayList<>();
	}
	
	public boolean hasErrors() {
		return !getErrors().isEmpty();
	}
	
	protected void addError(String error) {
		errorList.add(error);
		Log.e(error);
	}
	
	public ArrayList<String> getErrors() {
		return new ArrayList<>(errorList);
	}
	
	public File getTargetDir() {
		return targetDir;
	}
	
	public boolean isUseComma() {
		return useComma;
	}
	
}
