package de.rub.bph.omnineuro.client.core.db.in;

import de.rub.bph.omnineuro.client.imported.log.Log;
import de.rub.bph.omnineuro.client.util.TimedEndpointBuilder;
import de.rub.bph.omnineuro.client.util.WellBuilder;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Random;

public class OutlierInserter extends DBInserter {
	
	private File sourceFile;
	private long projectID;
	private long assayID;
	
	private long confirmedOutlierID, confirmedPlausibleID;
	
	public OutlierInserter(File sourceFile) {
		super(new Random().nextBoolean());
		this.sourceFile = sourceFile;
	}
	
	private String removeGansefusschen(String input) {
		String s = new String(input);
		if (s.startsWith("\"")) {
			s = s.substring(1);
		}
		if (s.endsWith("\"")) {
			s = s.substring(0, s.length() - 1);
		}
		return s;
	}
	
	@Override
	public void run() {
		try {
			confirmedOutlierID = executor.getIDViaName("outlier_type", "Confirmed Outlier");
			confirmedPlausibleID = executor.getIDViaName("outlier_type", "Confirmed Plausible");
		} catch (SQLException e) {
			Log.e(e);
			addError("Could not receive basic outlier Database IDs! " + e.getMessage());
			return;
		}
		
		ArrayList<String> discoveredExperiments = new ArrayList<>();
		int lineCount = 0;
		executor.setLogEnabled(false);
		
		try (BufferedReader reader = new BufferedReader(new FileReader(sourceFile))) {
			String line = reader.readLine();
			while (line != null) {
				lineCount++;
				try {
					if (lineCount > 1) {
						String[] row = line.split(";");
						TimedEndpointBuilder timedEndpointBuilder = TimedEndpointBuilder.parseBuilder(removeGansefusschen(row[0]));
						String experimentName = row[1];
						WellBuilder wellBuilder;
						try {
							wellBuilder = WellBuilder.convertWell(removeGansefusschen((row[2])));
						} catch (Throwable e) {
							Log.e(e);
							addError("Fatal error: Failed to deduct well from " + row[2] + " in experiment " + experimentName + " in row " + lineCount + "!");
							line = reader.readLine();
							continue;
						}
						experimentName = removeGansefusschen(experimentName);
						String endpointName = timedEndpointBuilder.getEndpoint();
						int timestamp = timedEndpointBuilder.getTimestamp();
						
						discoveredExperiments.add(experimentName);
						if (endpointName.equals("Viability")) {
							endpointName = "Viabillity";
						}
						if (endpointName.equals("Percent Mean Migration Distance all Neurons")) {
							endpointName = "Percent Mean Migration Distance all neurons";
						}
						
						long wellID = executor.getIDViaName("well", wellBuilder.getWellShortened());
						long endpointID = executor.getIDViaName("endpoint", endpointName);
						
						String query = "UPDATE response set outlier_type_id = " + confirmedOutlierID + " FROM endpoint, experiment WHERE response.experiment_id = experiment.id AND response.timestamp = " + timestamp + " AND endpoint.id  = " + endpointID + " AND experiment.name = '" + experimentName + "' AND response.well_id = " + wellID + ";";
						Log.v("Query: " + query);
						executor.execute(query);
						incrementInsertedResponsesCount();
						Log.i(experimentName + " on well " + wellBuilder.getWellExtended() + " is now an outlier.");
					}
				} catch (Throwable e) {
					Log.e("Error in line " + lineCount + " of file " + sourceFile.getName(), e);
					addError("Error in line " + lineCount + ": " + e.getClass().getSimpleName() + ": " + e.getMessage());
				}
				line = reader.readLine();
			}
			reader.close();
		} catch (Throwable e) {
			Log.e(e);
			addError("Fatal error in " + sourceFile.getName() + ": " + e.getClass().getSimpleName() + ": " + e.getMessage());
		}
		
		addError("Experiments detected [" + discoveredExperiments.size() + "]: " + discoveredExperiments.toString(), true);
	}
	
	@Override
	public String getName() {
		return sourceFile.getName();
	}
}
