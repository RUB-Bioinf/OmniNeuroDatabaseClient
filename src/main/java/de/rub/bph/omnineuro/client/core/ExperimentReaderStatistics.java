package de.rub.bph.omnineuro.client.core;

import de.rub.bph.omnineuro.client.imported.filemanager.FileManager;
import de.rub.bph.omnineuro.client.imported.log.Log;
import de.rub.bph.omnineuro.client.util.NumberUtils;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Iterator;

public class ExperimentReaderStatistics {

	public static final String ERROR_VALUE_NAN = "NaN";
	public static final String ERROR_VALUE_NV = "#NV";

	private ArrayList<JSONObject> experiments;
	private FileManager manager;
	private File outDir;

	public ExperimentReaderStatistics(ArrayList<JSONObject> experiments, File outDir) {
		this.experiments = experiments;
		this.outDir = outDir;
		manager = new FileManager();
	}

	public void calculateAll() throws IOException, JSONException {
		calculateExperimentCount();
		calculateConcentrationErrors();
		calculateMetaErrors();
	}

	public void calculateExperimentCount() throws JSONException, IOException {
		StringBuilder builder = new StringBuilder();
		builder.append("Sheet count: ").append(experiments.size());
		builder.append("\n");

		for (JSONObject experiment : experiments) {
			builder.append(getExperimentName(experiment));
			builder.append("\n");
		}

		manager.writeFile(new File(outDir, "readExperiments.txt"), builder.toString());
		//TODO add experiment output for version?
	}

	public void calculateConcentrationErrors() throws JSONException, IOException {
		StringBuilder builder = new StringBuilder("Experiment;Endpoint;Timestamp;Replica;Description;\n");

		NumberUtils numberUtils = new NumberUtils();
		for (JSONObject experiment : experiments) {
			String name = getExperimentName(experiment);

			JSONObject endpoints = experiment.getJSONObject("ExperimentData").getJSONObject("Endpoints");
			Iterator ep = endpoints.keys();
			while (ep.hasNext()) {
				String key = ep.next().toString();

				JSONObject endpoint = endpoints.getJSONObject(key);
				int timestamp = endpoint.getInt("timestamp");
				JSONObject responses = endpoint.getJSONObject("responses");

				for (String concentration : keyList(responses)) {
					if (concentration.equals(ERROR_VALUE_NV)) {
						builder.append(name + ";" + key + ";" + timestamp + ";-;Unknown concentration: '" + concentration + "';\n");
						continue;
					}

					JSONArray replicas = responses.getJSONArray(concentration);
					for (int i = 0; i < replicas.length(); i++) {
						String s = replicas.get(i).toString();
						if (!numberUtils.isNumeric(s) || s.equals(ERROR_VALUE_NAN)) {
							builder.append(name + ";" + key + ";" + timestamp + ";" + i + ";Value is not a number!;\n");
							continue;
						}

						/*
						double d = Double.parseDouble(s);
						if (d == 0) {
							//String w = name + ";" + key + ";" + i + ";Value zero!;\n";
							//builder.append(w);
							//Log.w("Warning: " + w);
							continue;
						}
						if (d < 0) {
							//String w = name + ";" + key + ";" + i + ";Negative value: " + d + ";\n";
							//builder.append(w);
							//Log.w("Warning: " + w);
							continue;
						}
						*/
					}
				}
			}
		}

		manager.writeFile(new File(outDir, "concentrationErrors.csv"), builder.toString());
	}

	public void calculateMetaErrors() throws JSONException, IOException {
		StringBuilder builder = new StringBuilder("Experiment;Type;Description;\n");

		String[] keys = new String[]{"Controls", "General", "OperationProcedures", "Reagents"};
		int errorCount = 0;

		for (JSONObject experiment : experiments) {
			JSONObject metaData = experiment.getJSONObject("MetaData");
			String name = getExperimentName(experiment);

			for (String key : keys) {
				JSONObject categoryData = metaData.getJSONObject(key);
				int c = categoryData.getInt("ErrorsCount");
				errorCount += c;

				JSONArray errors = categoryData.getJSONArray("Errors");
				for (int i = 0; i < c; i++) {
					builder.append(name + ";" + key + ";" + errors.get(i) + ";\n");
				}

				JSONObject data = categoryData.getJSONObject("Data");
				Iterator dataIterator = data.keys();
				while (dataIterator.hasNext()) {
					String dataKey = dataIterator.next().toString();
					String value = data.getString(dataKey);

					if (value == null || value.equals("")) {
						builder.append(name + ";" + key + ";No entry for key '" + dataKey + "';\n");
					}
					if (value == null || value.equals("NaN")) {
						builder.append(name + ";" + key + ";Invalid value for key '" + dataKey + "';\n");
					}

					Log.v("K/V data comparison: '" + dataKey + "' -> '" + value + "'");
				}
			}
		}

		builder.append("Error count: " + errorCount);
		manager.writeFile(new File(outDir, "metaErrors.csv"), builder.toString());
	}

	private String getExperimentName(JSONObject experiment) throws JSONException {
		File f = new File(experiment.getString("SourceFile"));
		return f.getName();
	}

	private ArrayList<String> keyList(JSONObject o) {
		ArrayList<String> list = new ArrayList<>();
		Iterator iterator = o.keys();
		while (iterator.hasNext()) list.add(iterator.next().toString());
		return list;
	}
}
