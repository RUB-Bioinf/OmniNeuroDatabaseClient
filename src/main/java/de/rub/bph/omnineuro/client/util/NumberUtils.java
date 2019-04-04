package de.rub.bph.omnineuro.client.util;

import java.util.HashMap;

public class NumberUtils {

	private HashMap<String, Boolean> numericCacheMap;

	public NumberUtils() {
		numericCacheMap = new HashMap<>();
	}

	public boolean isNumeric(String value) {
		if (numericCacheMap.containsKey(value)) {
			return numericCacheMap.get(value);
		}

		boolean b = true;
		try {
			Double.parseDouble(value);
		} catch (NumberFormatException e) {
			b = false;
		}
		numericCacheMap.put(value, b);
		return b;
	}

}
