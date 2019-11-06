package de.rub.bph.omnineuro.client.core.db.in;

import de.rub.bph.omnineuro.client.core.db.DBConnection;
import de.rub.bph.omnineuro.client.core.db.OmniNeuroQueryExecutor;
import de.rub.bph.omnineuro.client.imported.log.Log;

import java.sql.Connection;
import java.util.ArrayList;

public abstract class DBInserter implements Runnable {
	
	protected static OmniNeuroQueryExecutor executor;
	private ArrayList<String> errors, errorsWoNaN;
	private int NaNCounts;
	
	public int getInsertedResponsesCount() {
		return insertedResponsesCount;
	}
	
	private int insertedResponsesCount;
	
	public DBInserter() {
		Connection connection = DBConnection.getDBConnection().getConnection();
		if (executor == null) {
			executor = new OmniNeuroQueryExecutor(connection);
		}
		
		errors = new ArrayList<>();
		errorsWoNaN = new ArrayList<>(errors);
		NaNCounts = 0;
		insertedResponsesCount = 0;
	}
	
	protected void addError(String text) {
		addError(text, false);
	}
	
	protected void addError(String text, boolean isNaN) {
		String s = getName() + ": " + text;
		Log.w("Inserter error: " + s);
		errors.add(s);
		
		if (!isNaN) {
			errorsWoNaN.add(s);
		}
	}
	
	public void incrementNaNCount() {
		NaNCounts++;
	}
	
	public void incrementInsertedResponsesCount(){
		insertedResponsesCount++;
	}
	
	public void insert() {
		run();
	}
	
	public boolean hasError() {
		return !errors.isEmpty();
	}
	
	public boolean hasNaNs() {
		return getNaNCount() != 0;
	}
	
	public ArrayList<String> getErrors() {
		return new ArrayList<>(errors);
	}
	
	public ArrayList<String> getErrorsWithoutNaN() {
		return new ArrayList<>(errorsWoNaN);
	}
	
	public int getNaNCount() {
		return NaNCounts;
	}
	
	public abstract String getName();
}
