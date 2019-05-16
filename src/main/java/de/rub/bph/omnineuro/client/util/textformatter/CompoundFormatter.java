package de.rub.bph.omnineuro.client.util.textformatter;

import de.rub.bph.omnineuro.client.core.db.OmniNeuroQueryExecutor;
import de.rub.bph.omnineuro.client.imported.log.Log;

import javax.swing.*;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.ParseException;
import java.util.HashMap;
import java.util.Set;

public class CompoundFormatter extends JFormattedTextField.AbstractFormatter {
	
	private HashMap<String, String> nameMap;
	
	public CompoundFormatter(OmniNeuroQueryExecutor queryExecutor) throws SQLException {
		nameMap = new HashMap<>();
		ResultSet set = queryExecutor.executeQuery("SELECT name,abbreviation,cas_no,blinded from compound;");
		while (set.next()) {
			String name = set.getString("name");
			String abbreviation = set.getString("abbreviation");
			boolean blinded = set.getBoolean("blinded");
			StringBuilder builder = new StringBuilder();
			
			builder.append(name);
			if (blinded) {
				builder.append(" (Blinded)");
			} else {
				builder.append(" [");
				builder.append(abbreviation);
				builder.append("]");
			}
			
			nameMap.put(name, builder.toString());
		}
		
		Set<String> keys = nameMap.keySet();
		Log.i("Finished setting up a compound formatter. Known key count: " + keys.size());
		Log.i("And the entries: " + set);
	}
	
	@Override
	public Object stringToValue(String s) throws ParseException {
		for (String key : nameMap.keySet()) {
			String value = nameMap.get(key);
			
			if (s.equals(value)) {
				return key;
			}
		}
		Log.i("This is what the formatter knows tho: " + nameMap.keySet());
		throw new IllegalArgumentException("The entry '" + s + "' is unknown to this formatter!");
	}
	
	@Override
	public String valueToString(Object o) throws ParseException {
		String s = o.toString();
		return nameMap.get(s);
	}
}
