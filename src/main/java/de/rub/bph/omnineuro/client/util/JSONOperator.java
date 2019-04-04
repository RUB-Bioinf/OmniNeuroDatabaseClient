package de.rub.bph.omnineuro.client.util;

import org.json.JSONObject;

import java.util.ArrayList;
import java.util.Iterator;

public class JSONOperator {

	protected ArrayList<String> getKeys(JSONObject data) {
		ArrayList<String> list = new ArrayList<>();

		Iterator experimentKeys = data.keys();
		while (experimentKeys.hasNext()) {
			String key = experimentKeys.next().toString();
			list.add(key);
		}
		return list;
	}

}
