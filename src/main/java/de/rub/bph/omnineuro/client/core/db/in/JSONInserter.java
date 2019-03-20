package de.rub.bph.omnineuro.client.core.db.in;

import de.rub.bph.omnineuro.client.core.db.DBConnection;
import de.rub.bph.omnineuro.client.core.sheet.data.DateInterpreter;
import de.rub.bph.omnineuro.client.imported.log.Log;
import org.json.JSONException;
import org.json.JSONObject;

import java.io.File;
import java.sql.Connection;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

public class JSONInserter implements Runnable {

	private ArrayList<String> errors;
	private JSONObject data;
	private Connection connection;
	private String name;

	public JSONInserter(JSONObject data) {
		this.data = data;
		connection = DBConnection.getDBConnection().getConnection();
		errors = new ArrayList<>();

		name = "<Unknown>";
		try {
			File f = new File(data.getString("SourceFile"));
			name = f.getName();
		} catch (Throwable e) {
			Log.e(e);
		}
	}

	public String getName() {
		return name;
	}

	public void insert() {
		run();
	}

	@Override
	public void run() {
		try {
			//First: Get all the metadata from the experiment JSON
			Log.i("Running inserter on experiment: " + data.getString("SourceFile"));

			JSONObject metaData = data.getJSONObject("MetaData");
			String comment = metaData.getString("Comments");

			JSONObject metaDataGeneral = metaData.getJSONObject("General").getJSONObject("Data");
			String projectName = metaDataGeneral.getString("Project");
			String assay = metaDataGeneral.getString("Assay");
			String experimentName = metaDataGeneral.getString("ExperimentID");
			String individual = metaDataGeneral.getString("Individual");
			String compound = metaDataGeneral.getString("Compound");
			String cellType = metaDataGeneral.getString("Cell type");
			String species = metaDataGeneral.getString("Species");
			String plateFormat = metaDataGeneral.getString("Plateformat");

			Date date = new Date(0);
			String platingDate = metaDataGeneral.getString("Plating date (ddMONjj)");
			try {
				date = new DateInterpreter(platingDate).interpretDate();
				Log.i("Self check on date: " + platingDate + " -> " + new SimpleDateFormat("dd.MM.yyyy").format(date));
			} catch (Throwable e) {
				Log.e("Failed to interpret plating date!", e);
				addError("Unable to interpret plating date: '" + platingDate + "'! Are you sure this is the right format?");
			}

			String sourceLab = "IUF";
			addError("Sourcelab for " + getName() + " has been defaulted to '" + sourceLab + "'");

			String sex = "unknown";
			addError("Sex for " + getName() + " has been defaulted to '" + sex + "'");

			if (compound.equals("NaN")) {
				addError("Compound is unknown!");
			}

			//Next: Insert it into the database
			Log.i("TODO: Actually insert it...");
		} catch (JSONException e) {
			Log.e("Failed to insert Experiment: " + getName(), e);
			addError("Failed to insert Experiment " + getName() + " into the database! Reason: " + e.getMessage());
		}
	}

	private void addError(String text) {
		errors.add(getName() + ": " + text);
	}

	public ArrayList<String> getErrors() {
		return new ArrayList<>(errors);
	}
}
