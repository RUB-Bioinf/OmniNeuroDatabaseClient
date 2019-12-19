package de.rub.bph.omnineuro.client.core.db.in;

import de.rub.bph.omnineuro.client.core.db.DBConnection;
import de.rub.bph.omnineuro.client.core.db.OmniNeuroQueryExecutor;
import de.rub.bph.omnineuro.client.core.db.out.holder.CompoundHolder;
import de.rub.bph.omnineuro.client.imported.log.Log;

import java.sql.Connection;
import java.util.ArrayList;

public abstract class DBInserter implements Runnable {
	
	protected static OmniNeuroQueryExecutor executor;
	protected boolean attemptUnblinding;
	private ArrayList<String> errors, errorsWoNaN;
	private int NaNCounts;
	private ArrayList<String> blindingInfo;
	private int insertedResponsesCount;
	
	public DBInserter(boolean attemptUnblinding) {
		blindingInfo = new ArrayList<>();
		this.attemptUnblinding = attemptUnblinding;
		Connection connection = DBConnection.getDBConnection().getConnection();
		if (executor == null) {
			executor = new OmniNeuroQueryExecutor(connection);
		}
		executor.setLogEnabled(false);
		
		errors = new ArrayList<>();
		errorsWoNaN = new ArrayList<>(errors);
		NaNCounts = 0;
		insertedResponsesCount = 0;
	}
	
	protected CompoundHolder attemptUnblinding(String blindedName) {
		long blindingLookupID = -1;
		String unblindedCAS = null;
		try {
			blindingLookupID = executor.getIDViaName("unblinded_compound_mapping", blindedName);
			unblindedCAS = executor.getFeatureViaID("unblinded_compound_mapping", "unblinded_cas_number", blindingLookupID);
		} catch (Throwable e) {
			Log.e(e);
		}
		if (blindingLookupID != -1) {
			try {
				long compoundID = executor.getIDViaFeature("compound", "cas_no", unblindedCAS);
				String unblindedCompoundAbbreviation = executor.getFeatureViaID("compound", "abbreviation", compoundID);
				String unblindedCompoundName = executor.getNameViaID("compound", compoundID);
				
				addBlindingRow(blindedName + " was unblinded as " + unblindedCompoundName + " [" + unblindedCompoundAbbreviation + "]. CAS: " + unblindedCAS);
				return new CompoundHolder(unblindedCompoundName, unblindedCAS, unblindedCompoundAbbreviation, compoundID, false);
			} catch (Throwable e) {
				Log.e(e);
				String error = blindedName + " is a blinded compound, but failed to fetch the unblinded compound. Unblinded CAS: " + unblindedCAS + ". Reason: " + e.getClass().getSimpleName() + ": " + e.getMessage();
				addBlindingRow(error);
				addError(error);
			}
		} else {
			String error = blindedName + " is a blinded compound, but the unblinded CAS was not in the database.";
			addBlindingRow(error);
			addError(error);
		}
		return null;
	}
	
	protected void addBlindingRow(String row) {
		blindingInfo.add(row);
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
	
	public void incrementInsertedResponsesCount() {
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
	
	public ArrayList<String> getBlindingInfo() {
		return new ArrayList<>(blindingInfo);
	}
	
	public ArrayList<String> getErrors() {
		return new ArrayList<>(errors);
	}
	
	public ArrayList<String> getErrorsWithoutNaN() {
		return new ArrayList<>(errorsWoNaN);
	}
	
	public int getInsertedResponsesCount() {
		return insertedResponsesCount;
	}
	
	public int getNaNCount() {
		return NaNCounts;
	}
	
	public abstract String getName();
	
}
