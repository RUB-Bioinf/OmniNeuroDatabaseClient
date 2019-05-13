package de.rub.bph.omnineuro.client.core.db.out;

import de.rub.bph.omnineuro.client.core.db.DBConnection;

import java.io.File;
import java.util.ArrayList;

public abstract class SheetExporter implements Runnable {
	
	protected File targetDir;
	protected DBConnection connection;
	protected ArrayList<Long> responseIDs;
	protected boolean useComma;
	protected ArrayList<String> errorList;
	
	public SheetExporter(File targetDir, DBConnection connection, ArrayList<Long> responseIDs, boolean useComma) {
		this.targetDir = targetDir;
		this.useComma = useComma;
		this.connection = connection;
		this.responseIDs = responseIDs;
		
		errorList = new ArrayList<>();
	}
	
	public boolean hasErrors() {
		return !getErrors().isEmpty();
	}
	
	public ArrayList<String> getErrors() {
		return new ArrayList<>(errorList);
	}
	
	public ArrayList<Long> getResponseIDs() {
		return responseIDs;
	}
	
	public File getTargetDir() {
		return targetDir;
	}
	
	public boolean isUseComma() {
		return useComma;
	}
	
}
