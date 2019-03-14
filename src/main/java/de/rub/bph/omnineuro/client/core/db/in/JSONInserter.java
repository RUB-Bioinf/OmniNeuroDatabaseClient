package de.rub.bph.omnineuro.client.core.db.in;

import org.json.JSONObject;

public class JSONInserter implements Runnable{

	private JSONObject data;

	public JSONInserter(JSONObject data) {
		this.data = data;
	}

	public void insert(){
		run();
	}

	@Override
	public void run() {

	}
}
