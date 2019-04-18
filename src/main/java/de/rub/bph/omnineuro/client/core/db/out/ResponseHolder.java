package de.rub.bph.omnineuro.client.core.db.out;


import de.rub.bph.omnineuro.client.core.db.OmniNeuroQueryExecutor;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ResponseHolder {
	private int timestamp;
	private long endpointID;
	private double concentration;
	private String concentrationDescription;
	private double response;
	private boolean control;

	public ResponseHolder(long responseID, OmniNeuroQueryExecutor queryExecutor) throws SQLException {
		//timestamp = Integer.parseInt(queryExecutor.getFeatureViaID("response", "timestamp", responseID));
		//endpointID = Long.parseLong(queryExecutor.getFeatureViaID("response", "endpoint_id", responseID));
		//concentration = Long.parseLong(queryExecutor.getFeatureViaID("response", "concentration_id", responseID));
		//response = Double.parseDouble(queryExecutor.getFeatureViaID("response", "value", responseID));
		ResultSet resultSet = queryExecutor.getFeaturesViaID("response", responseID);
		resultSet.next();
		timestamp = resultSet.getInt("timestamp");
		endpointID = resultSet.getLong("endpoint_id");
		response = resultSet.getDouble("value");

		long concentrationID = resultSet.getLong("concentration_id");
		concentration = Double.parseDouble(queryExecutor.getFeatureViaID("concentration", "value", concentrationID));

		control = concentration == 0;
		if (control) {
			resultSet = queryExecutor.
					executeQuery("SELECT control.acronym FROM control,concentration WHERE control.id = concentration.control_id AND concentration.id = " + concentrationID);
			resultSet.next();
			concentrationDescription = resultSet.getString("acronym");
		} else {
			concentrationDescription = String.valueOf(concentration);
		}
	}

	public static ArrayList<Long> getUniqueEndpoints(List<ResponseHolder> holders) {
		ArrayList<Long> list = new ArrayList<>();
		for (ResponseHolder h : holders) {
			long l = h.endpointID;
			if (!list.contains(l)) list.add(l);
		}
		return list;
	}

	public static ArrayList<Integer> getUniqueTimestamps(List<ResponseHolder> holders) {
		ArrayList<Integer> list = new ArrayList<>();
		for (ResponseHolder h : holders) {
			int i = h.getTimestamp();
			if (!list.contains(i)) list.add(i);
		}
		return list;
	}

	public static ArrayList<String> getUniqueConcentrations(List<ResponseHolder> holders) {
		ArrayList<String> list = new ArrayList<>();
		for (ResponseHolder h : holders) {
			String s = h.getConcentrationDescription();
			if (!list.contains(s)) list.add(s);
		}
		return list;
	}

	@Override
	public String toString() {
		return "Response handler for " + getConcentrationDescription() + ", endpointID: " + getEndpointID() + " at " + getTimestamp() + "h.";
	}

	public boolean isControl() {
		return control;
	}

	public String getConcentrationDescription() {
		return concentrationDescription;
	}

	public int getTimestamp() {
		return timestamp;
	}

	public long getEndpointID() {
		return endpointID;
	}

	public double getConcentration() {
		return concentration;
	}

	public double getResponse() {
		return response;
	}

}