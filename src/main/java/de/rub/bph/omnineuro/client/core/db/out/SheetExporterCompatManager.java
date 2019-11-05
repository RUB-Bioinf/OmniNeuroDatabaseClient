package de.rub.bph.omnineuro.client.core.db.out;

import de.rub.bph.omnineuro.client.Client;
import de.rub.bph.omnineuro.client.config.ExportConfigManager;
import de.rub.bph.omnineuro.client.core.db.DBConnection;
import de.rub.bph.omnineuro.client.core.db.OmniNeuroQueryExecutor;
import de.rub.bph.omnineuro.client.core.db.out.efsa.BlindedCompoundsExporter;
import de.rub.bph.omnineuro.client.core.db.out.r.CompoundSheetExporter;
import de.rub.bph.omnineuro.client.imported.filemanager.FileManager;
import de.rub.bph.omnineuro.client.imported.log.Log;
import de.rub.bph.omnineuro.client.util.CodeHasher;
import de.rub.bph.omnineuro.client.util.concurrent.ConcurrentExecutionManager;
import org.apache.commons.collections4.ListUtils;
import org.json.JSONObject;

import java.io.File;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.concurrent.Executors;

import static de.rub.bph.omnineuro.client.ui.OmniFrame.DEFAULT_LIMITER_HASH_LENGTH;

public class SheetExporterCompatManager extends ConcurrentExecutionManager {
	
	public static final String EXPORT_DIRNAME_COMPOUNDS = "compounds";
	public static final String EXPORT_DIRNAME_EFSA = "efsa";
	public static final String ROOT_FILENAME_BASE = "exports";
	
	private File sourceDir;
	private OmniNeuroQueryExecutor queryExecutor;
	private DBConnection connection;
	private ArrayList<Long> responseIDs;
	private JSONObject config;
	private boolean useComma;
	private ArrayList<CompoundSheetExporter> exporters;
	
	public SheetExporterCompatManager(int threads, File sourceDir, ArrayList<Long> responseIDs, boolean useComma) {
		super(threads);
		this.useComma = useComma;
		
		config = ExportConfigManager.getInstance().getCurrentConfig();
		String dirTag = "";
		if (config != null) {
			CodeHasher hasher = new CodeHasher(config.toString());
			dirTag = "-" + hasher.getCodeHash(DEFAULT_LIMITER_HASH_LENGTH);
		}
		
		String rootDirName = ROOT_FILENAME_BASE + dirTag;
		if (!sourceDir.getName().equals(ROOT_FILENAME_BASE)) {
			sourceDir = new File(sourceDir, rootDirName);
			sourceDir.mkdirs();
		}
		
		this.sourceDir = sourceDir;
		this.responseIDs = responseIDs;
		
		File configFile = new File(sourceDir, "config" + dirTag + ".json");
		FileManager manager = new FileManager();
		try {
			manager.writeFile(configFile, config.toString(4));
		} catch (Throwable e) {
			Log.e("Failed to write current config as a reminder here: " + configFile.getAbsolutePath() + ". This fails silently.", e);
		}
		
		service = Executors.newFixedThreadPool(threads);
		connection = DBConnection.getDBConnection();
		queryExecutor = new OmniNeuroQueryExecutor(connection.getConnection());
	}
	
	public void export() {
		//TODO distinguish parameters here and add via sub functions?
		
		try {
			exportEFSASheet();
		} catch (SQLException e) {
			Log.e(e);
			Client.showErrorMessage("Failed to export experiment data!\nA more detailed message will be displayed in the future.", null, e);
		}
		
		try {
			exporters = exportCompoundSheet();
		} catch (Throwable e) {
			Log.e(e);
			Client.showErrorMessage("Failed to export experiment data!\nA more detailed message will be displayed in the future.", null, e);
		}
		
		waitForTasks();
	}
	
	public void exportEFSASheet() throws SQLException {
		String query = "SELECT DISTINCT response.id FROM response, experiment, compound WHERE compound.blinded = TRUE AND compound.id = experiment.compound_id AND\n" +
				"experiment.id = response.experiment_id AND (response.endpoint_id = 1 OR response.endpoint_id = 2 OR response.endpoint_id = 4);";
		ResultSet set = queryExecutor.executeQuery(query);
		ArrayList<Long> foundResponseIDs = queryExecutor.extractIDs(set);
		ArrayList<Long> retained = foundResponseIDs;
		//ArrayList<Long> retained = new ArrayList<>(ListUtils.retainAll(foundResponseIDs, responseIDs));
		
		File targetDir = new File(sourceDir, EXPORT_DIRNAME_EFSA);
		targetDir.mkdirs();
		
		BlindedCompoundsExporter exporter = new BlindedCompoundsExporter(targetDir, connection, retained, useComma);
		exporter.run();
	}
	
	public ArrayList<CompoundSheetExporter> exportCompoundSheet() throws SQLException { //TODO restrictive Params here?
		ArrayList<Long> compoundIDs = queryExecutor.getIDs("compound");
		ArrayList<Long> retainedCompoundIDs = new ArrayList<>();
		HashMap<Long, ArrayList<Long>> compoundResponseMap = new HashMap<>();
		
		for (long compoundID : compoundIDs) {
			String query = "SELECT DISTINCT response.id FROM response,compound,experiment WHERE response.experiment_id=experiment.id " +
					"AND experiment.compound_id=compound.id AND compound.id = " + compoundID + ";";
			ResultSet set = queryExecutor.executeQuery(query);
			ArrayList<Long> foundResponseIDs = queryExecutor.extractIDs(set);
			
			ArrayList<Long> retained = new ArrayList<>(ListUtils.retainAll(foundResponseIDs, responseIDs));
			Log.i("Found " + retained.size() + " mutual elements from all responses [" + foundResponseIDs.size() + "] and limited [" + responseIDs.size() + "] for compound ID " + compoundID);
			
			if (!retained.isEmpty()) {
				compoundResponseMap.put(compoundID, retained);
				retainedCompoundIDs.add(compoundID);
			}
		}
		
		if (retainedCompoundIDs.isEmpty()) {
			throw new IllegalStateException("No compounds were found in the database that match the limiter. This happened so late in the algorithm that" +
					" this error should not be reached. If so, this is a really severe error where data has been lost!");
		}
		
		File targetDir = new File(sourceDir, EXPORT_DIRNAME_COMPOUNDS);
		targetDir.mkdirs();
		
		ArrayList<CompoundSheetExporter> exporterList = new ArrayList<>();
		for (Long id : retainedCompoundIDs) {
			Log.i("I am working with this compound id " + id + ". Name: " + queryExecutor.getNameViaID("compound", id));
			
			CompoundSheetExporter exporter = new CompoundSheetExporter(targetDir, connection, id, compoundResponseMap.get(id), useComma);
			exporterList.add(exporter);
			service.submit(exporter);
		}
		
		return exporterList;
	}
	
	public ArrayList<String> getErrors() {
		ArrayList<String> tempList = new ArrayList<>();
		for (CompoundSheetExporter exporter : exporters) {
			tempList.addAll(exporter.getErrors());
		}
		return tempList;
	}
	
	public ArrayList<Long> getResponseIDs() {
		return responseIDs;
	}
	
	public File getSourceDir() {
		return sourceDir;
	}
	
	public int getTaskCount() {
		return exporters.size();
	}
	
	public boolean isUseComma() {
		return useComma;
	}
}
