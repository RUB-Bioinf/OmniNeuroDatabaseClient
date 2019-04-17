package de.rub.bph.omnineuro.client.core.db.out.r;

import de.rub.bph.omnineuro.client.core.db.DBConnection;
import de.rub.bph.omnineuro.client.core.db.OmniNeuroQueryExecutor;
import de.rub.bph.omnineuro.client.core.db.out.ResponseHolder;
import de.rub.bph.omnineuro.client.core.db.out.SheetExporter;
import de.rub.bph.omnineuro.client.imported.log.Log;

import java.io.File;
import java.sql.SQLException;
import java.util.ArrayList;

public class CompoundSheetExporter extends SheetExporter {

	private long compoundID;
	private String compoundName, compoundAbbreviation;
	private OmniNeuroQueryExecutor queryExecutor;
	private File outFile;
	private boolean successfull;

	public CompoundSheetExporter(File targetDir, DBConnection connection, long compoundID, ArrayList<Long> experimentIDs) throws SQLException {
		super(targetDir, connection, experimentIDs);
		this.compoundID = compoundID;
		successfull = false;

		queryExecutor = new OmniNeuroQueryExecutor(connection.getConnection());
		queryExecutor.setLogEnabled(false);
		compoundName = queryExecutor.getNameViaID("compound", compoundID);
		compoundAbbreviation = queryExecutor.getFeatureViaID("compound", "abbreviation", compoundID);

		outFile = new File(targetDir, compoundAbbreviation + ".csv");
		Log.i("Writing " + compoundName + " results to: " + outFile.getAbsolutePath());
		Log.i("Compound " + getCompoundAbbreviation() + " has " + experimentIDs.size() + " experiments in the DB.");
	}

	@Override
	public void run() {
		try {
			ArrayList<Long> responseIDs = new ArrayList<>();
			for (long id : getExperimentIDs()) {
				responseIDs.addAll(queryExecutor.getIDsViaFeature("response", "experiment_id", String.valueOf(id)));
			}
			Log.i("Compound " + getCompoundAbbreviation() + " has " + responseIDs.size() + " responses in the database.");

			ArrayList<ResponseHolder> responseHolders;
			for (long id : responseIDs) {
				ResponseHolder holder = new ResponseHolder(id, queryExecutor);
				Log.i("I have a holder. Control: " + holder.isControl() + ". Concentration: " + holder.getConcentrationDescription());
			}

			successfull = true;
		} catch (Throwable e) {
			Log.e("Failed to create " + getCompoundAbbreviation() + " ['" + getCompoundName() + "'] export file because of an " + e.getClass().getSimpleName() + "-Error!", e);
		}
	}

	public long getCompoundID() {
		return compoundID;
	}

	public boolean isSuccessfull() {
		return successfull;
	}

	public String getCompoundName() {
		return compoundName;
	}

	public String getCompoundAbbreviation() {
		return compoundAbbreviation;
	}

	public File getOutFile() {
		return outFile;
	}

}
