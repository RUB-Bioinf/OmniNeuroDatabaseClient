package de.rub.bph.omnineuro.client.core.db.out;

import de.rub.bph.omnineuro.client.core.db.DBConnection;
import de.rub.bph.omnineuro.client.core.db.OmniNeuroQueryExecutor;
import de.rub.bph.omnineuro.client.core.db.out.r.CompoundSheetExporter;
import de.rub.bph.omnineuro.client.imported.log.Log;
import de.rub.bph.omnineuro.client.util.concurrent.ConcurrentExecutionManager;

import java.io.File;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.concurrent.Executors;

public class SheetExporterCompatManager extends ConcurrentExecutionManager {

	public static final String ROOT_FILENAME = "exports";
	public static final String EXPORT_DIRNAME_COMPOUNDS = "exports";

	private File sourceDir;
	private OmniNeuroQueryExecutor queryExecutor;
	private DBConnection connection;
	private ArrayList<Long> experimentIDs;

	public SheetExporterCompatManager(int threads, File sourceDir, ArrayList<Long> experimentIDs) {
		super(threads);
		if (!sourceDir.getName().equals(ROOT_FILENAME)) {
			sourceDir = new File(sourceDir, ROOT_FILENAME);
			sourceDir.mkdirs();
		}
		this.sourceDir = sourceDir;
		this.experimentIDs = experimentIDs;
		Log.i("There are " + experimentIDs.size() + " experiments in the database, matching the user's criteria.");

		service = Executors.newFixedThreadPool(threads);
		connection = DBConnection.getDBConnection();
		queryExecutor = new OmniNeuroQueryExecutor(connection.getConnection());
	}

	public void export() {
		//TODO distinguish parameters here and add via sub functions?

		try {
			exportCompoundSheet();
		} catch (SQLException e) {
			Log.e(e);
		}

		waitForTasks();
	}

	public void exportCompoundSheet() throws SQLException { //TODO restrictive Params here?
		ArrayList<Long> compoundIDs = new ArrayList<>();
		HashMap<Long, ArrayList<Long>> compoundExperimentMap = new HashMap<>();

		for (long id : experimentIDs) {
			String s = queryExecutor.getFeatureViaID("experiment", "compound_id", id);
			if (s != null) {
				Long compoundID = Long.valueOf(s);
				if (!compoundIDs.contains(compoundID)) {
					compoundIDs.add(compoundID);
					compoundExperimentMap.put(compoundID, new ArrayList<>());
				}
				compoundExperimentMap.get(compoundID).add(id);
			} else {
				Log.w("Experiment ID " + id + " does not have a compound ID!");
			}
		}
		Log.i("There are " + compoundIDs.size() + " derived compound IDs matching the user's preferred experiments.");

		File targetDir = new File(sourceDir, EXPORT_DIRNAME_COMPOUNDS);
		targetDir.mkdirs();

		for (Long id : compoundIDs) {
			Log.i("I am working with this compound id " + id + ". Name: " + queryExecutor.getNameViaID("compound", id));
			service.submit(new CompoundSheetExporter(targetDir, connection, id, compoundExperimentMap.get(id)));
		}
	}

}
