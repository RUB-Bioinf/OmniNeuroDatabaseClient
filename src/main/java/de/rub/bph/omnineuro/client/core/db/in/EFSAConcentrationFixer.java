package de.rub.bph.omnineuro.client.core.db.in;

import de.rub.bph.omnineuro.client.core.sheet.reader.SheetReader;
import de.rub.bph.omnineuro.client.imported.log.Log;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import java.io.File;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Random;

public class EFSAConcentrationFixer extends DBInserter {
	
	private static final int START_ROW_INDEX = 2;
	private File sourceFile;
	
	public EFSAConcentrationFixer(File sourceFile) {
		super(new Random().nextBoolean());
		this.sourceFile = sourceFile;
	}
	
	@Override
	public void run() {
		Log.i("Working with: " + sourceFile.getAbsolutePath());
		int lastKnownLine = 0;
		int discoveredConcentrations = 0;
		int changedConcentrations = 0;
		
		try {
			XSSFWorkbook workbook = new XSSFWorkbook(sourceFile);
			SheetReader reader = new SheetReader(sourceFile, workbook, 0);
			
			int rowCount = reader.getContinuousRowEntries("A", START_ROW_INDEX);
			Log.i(sourceFile.getName() + " has " + rowCount + " entries.");
			
			
			for (int i = START_ROW_INDEX; i < rowCount; i++) {
				String cas = reader.getValueAt("B" + i);
				String faultyConcentration = reader.getValueAt("C" + i);
				String actualConcentration = reader.getValueAt("D" + i);
				Log.i("Read line: " + i + ": " + cas + " - " + faultyConcentration + " -> " + actualConcentration);
				
				String query = "SELECT DISTINCT concentration.id FROM concentration, response,experiment,compound " +
						"WHERE concentration.id = response.concentration_id AND response.experiment_id = experiment.id AND compound.id = experiment.compound_id " +
						"AND compound.cas_no = '" + cas + "' AND concentration.value = " + faultyConcentration + " ORDER BY id;";
				ResultSet set = executor.executeQuery(query);
				ArrayList<Long> compoundIDs = executor.extractIDs(set);
				discoveredConcentrations = discoveredConcentrations + compoundIDs.size();
				
				Log.i("Number of responses for row: " + rowCount + ": " + compoundIDs.size());
				for (long id : compoundIDs) {
					query = "UPDATE concentration SET value = " + actualConcentration + " WHERE id = " + id + ";";
					executor.execute(query);
					
					changedConcentrations++;
				}
			}
			
			Log.i("Reading done. Fixed responses: " + changedConcentrations + "/" + discoveredConcentrations);
		} catch (Throwable e) {
			e.printStackTrace();
			addError("Fatal error while reading the file " + sourceFile.getName() + " at line " + lastKnownLine + "! Reason: " + e.getMessage());
		}
		
		addError("Changed responses: " + changedConcentrations);
		addError("Affected responses found: " + discoveredConcentrations);
	}
	
	@Override
	public String getName() {
		return null;
	}
}
