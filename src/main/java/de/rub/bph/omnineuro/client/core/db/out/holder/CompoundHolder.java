package de.rub.bph.omnineuro.client.core.db.out.holder;

import de.rub.bph.omnineuro.client.core.db.OmniNeuroQueryExecutor;

import java.sql.ResultSet;
import java.sql.SQLException;

public class CompoundHolder {
	
	private String name, cas, abbreviation;
	private long compoundID;
	private boolean blinded;
	
	public CompoundHolder(String name, String cas, String abbreviation, long compoundID, boolean blinded) {
		this.name = name;
		this.cas = cas;
		this.abbreviation = abbreviation;
		this.compoundID = compoundID;
		this.blinded = blinded;
	}
	
	public static CompoundHolder getCompoundHolderViaID(long compoundID, OmniNeuroQueryExecutor queryExecutor) throws SQLException {
		ResultSet set = queryExecutor.getFeaturesViaID("compound", compoundID);
		set.next();
		
		String name = set.getString("name");
		String cas = set.getString("cas_no");
		String abbreviation = set.getString("abbreviation");
		boolean blinded = set.getBoolean("blinded");
		
		return new CompoundHolder(name, cas, abbreviation, compoundID, blinded);
	}
	
	public String getAbbreviation() {
		return abbreviation;
	}
	
	public String getCas() {
		return cas;
	}
	
	public long getCompoundID() {
		return compoundID;
	}
	
	public String getName() {
		return name;
	}
	
	public boolean isBlinded() {
		return blinded;
	}
}
