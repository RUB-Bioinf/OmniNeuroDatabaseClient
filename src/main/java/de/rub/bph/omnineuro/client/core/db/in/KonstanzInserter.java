package de.rub.bph.omnineuro.client.core.db.in;

import de.rub.bph.omnineuro.client.core.db.out.holder.CompoundHolder;
import de.rub.bph.omnineuro.client.core.sheet.reader.SheetReader;
import de.rub.bph.omnineuro.client.imported.log.Log;
import de.rub.bph.omnineuro.client.util.WellBuilder;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import java.io.File;
import java.io.FileInputStream;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;

public class KonstanzInserter extends DBInserter {
	
	private static final long DECODED_ENDPOINT_FAILURE = -1;
	private static final int START_ROW_INDEX = 4;
	private File sourceFile;
	private HashMap<String, ArrayList<String>> lookupMapDMSO;
	
	public KonstanzInserter(File sourceFile, boolean attemptUnblinding) {
		super(attemptUnblinding);
		this.sourceFile = sourceFile;
		lookupMapDMSO = new HashMap<>();
	}
	
	private long decodeKonstanzEndpoint(String endpointName) throws SQLException {
		if (endpointName == null) {
			return DECODED_ENDPOINT_FAILURE;
		}
		
		endpointName = endpointName.trim();
		switch (endpointName) {
			case "Migration":
				return executor.getIDViaName("endpoint", "Migration");
			case "Viability":
				return executor.getIDViaName("endpoint", "Viabillity");
			case "neurite area":
				return executor.getIDViaName("endpoint", "Neurite Area");
			case "selected objects":
				return executor.getIDViaName("endpoint", "Selected Objects");
			case "valid objects":
				return executor.getIDViaName("endpoint", "Valid Objects");
			case "valid objects UKN4":
				return executor.getIDViaName("endpoint", "Valid Objects UKN4");
			case "selected objects UKN4":
				return executor.getIDViaName("endpoint", "Selected Objects UKN4");
			case "valid objects UKN5":
				return executor.getIDViaName("endpoint", "Valid Objects UKN5");
			case "selected objects UKN5":
				return executor.getIDViaName("endpoint", "Selected Objects UKN5");
			case "Migration UKN2":
				return executor.getIDViaName("endpoint", "Migration UKN2");
			case "Viability UKN2":
				return executor.getIDViaName("endpoint", "Viability UKN2");
			case "neurite area UKN5":
				return executor.getIDViaName("endpoint", "Neurite Area UKN5");
			case "neurite area UKN4":
				return executor.getIDViaName("endpoint", "Neurite Area UKN4");
			default:
				addError("Failed to decode a database compatible endpoint from '" + endpointName + "'!");
				return DECODED_ENDPOINT_FAILURE;
		}
	}
	
	@Override
	public void run() {
		long timestampExperiment = new Date(0).getTime();
		int timestampEndpoint = 24;
		addError("Failed to get the timestamp (experiment, endpoint) from file: " + sourceFile.getName());
		addError("Failed to read the individual from file: " + sourceFile.getName());
		addError("Failed to read the detection method from file: " + sourceFile.getName());
		addError("Failed to get workgroup name for " + sourceFile.getName());
		
		int cachedRow = -1;
		String cachedWell = "<None>";
		try {
			FileInputStream excelFile = new FileInputStream(sourceFile);
			XSSFWorkbook workbook = new XSSFWorkbook(excelFile);
			workbook.setActiveSheet(0);
			
			int rowIndex = START_ROW_INDEX;
			SheetReader reader = new SheetReader(sourceFile, workbook);
			int rowCount = reader.getContinuousRowEntries("A", START_ROW_INDEX);
			Log.i(sourceFile.getName() + " has " + rowCount + " entries.");
			
			long confirmedOutlierID = executor.getIDViaName("outlier_type", "Confirmed Outlier");
			long confirmedPlausibleID = executor.getIDViaName("outlier_type", "Confirmed Plausible");
			long uncheckedOutlierID = executor.getIDViaName("outlier_type", "Unchecked");
			
			String sfName = sourceFile.getName();
			String assay;
			if (sfName.contains("UKN2")) {
				assay = "UKN2";
			} else if (sfName.contains("UKN5")) {
				assay = "UKN5";
			} else if (sfName.contains("UKN4")) {
				assay = "UKN4";
			} else throw new IllegalArgumentException("Failed to deduct the assay from this filename: " + sfName);
			
			boolean extendedEndpoints = false;
			String endpoint1 = reader.getValueAt("H3");
			String endpoint2 = reader.getValueAt("I3");
			String endpoint3 = null;
			
			if (reader.hasValueAt("J3")) {
				extendedEndpoints = true;
				endpoint3 = reader.getValueAt("J3");
			}
			
			for (int i = START_ROW_INDEX; i < rowCount; i++) {
				cachedRow = i;
				cachedWell = "<Unknown>";
				
				// EXTRACT INFORMATION FROM SHEET
				String sampleID = reader.getValueAt("A" + i);
				String plateID = reader.getValueAt("B" + i);
				
				String wellRow = reader.getValueAt("C" + i);
				int wellCol = (int) Double.parseDouble(reader.getValueAt("D" + i, true));
				WellBuilder wellBuilder = new WellBuilder(wellRow, wellCol);
				String wellName = wellBuilder.getWellExtended();
				cachedWell = wellName;
				
				String wellType = reader.getValueAt("E" + i);
				String wellQuality = reader.getValueAt("F" + i);
				
				long outlierID = confirmedOutlierID;
				try {
					int wellQualityNumeric = (int) Double.parseDouble(wellQuality);
					if (wellQualityNumeric == 1) {
						outlierID = confirmedPlausibleID;
					}
				} catch (Exception e) {
					Log.e(e);
					addError("Failed to determine outlier status from entry at F" + i + ": '" + wellQuality + "'. Response marked as unchecked! Error: " + e.getClass().getName() + ": " + e.getMessage());
					outlierID = uncheckedOutlierID;
				}
				
				double concentration = Double.NaN;
				double response1 = Double.NaN;
				double response2 = Double.NaN;
				double response3 = Double.NaN;
				
				try {
					concentration = Double.parseDouble(reader.getValueAt("G" + i, true));
				} catch (Exception e) {
					addError("Failed to read concentration at G" + i + ". Error: " + e.getMessage());
				}
				try {
					response1 = Double.parseDouble(reader.getValueAt("H" + i, true));
				} catch (Exception e) {
					addError("Failed to the response to " + endpoint1 + " at H" + i + ". Error: " + e.getMessage());
				}
				try {
					response2 = Double.parseDouble(reader.getValueAt("I" + i, true));
				} catch (Exception e) {
					addError("Failed to the response to " + endpoint2 + " at I" + i + ". Error: " + e.getMessage());
				}
				if (extendedEndpoints) {
					try {
						response3 = Double.parseDouble(reader.getValueAt("J" + i, true));
					} catch (Exception e) {
						addError("Failed to the response to " + endpoint3 + " at J" + i + ". Error: " + e.getMessage());
					}
				}
				String experimentName = sampleID + "#" + plateID;
				
				// DATABASE STUFF
				long concentrationID;
				long controlID;
				boolean isControl;
				switch (wellType) {
					case "t":
						concentrationID = executor.insertConcentration(concentration);
						isControl = false;
						break;
					case "n":
						controlID = executor.getIDViaName("control", "Solvent control (SC)");
						concentrationID = executor.insertConcentration(0, controlID);
						isControl = true;
						break;
					case "p":
						isControl = true;
						controlID = executor.getIDViaName("control", "Positive control (PC)");
						concentrationID = executor.insertConcentration(0, controlID);
						break;
					default:
						throw new IllegalArgumentException("Could not identify well type: '" + wellType + "'");
				}
				
				String unBlindedSampleID = sampleID;
				try {
					long experimentID;
					synchronized (executor) {
						try {
							experimentID = executor.getIDViaName("experiment", experimentName);
						} catch (Exception e) {
							Log.i("Experiment " + experimentName + " wasn't in the DB yet. Adding.");
							long projectID = executor.getIDViaName("project", "EFSA DNT2");
							long assayID = executor.getIDViaName("assay", assay);
							long cellTypeID = executor.getIDViaName("cell_type", "iPSCs");
							long individualID = executor.getIDViaName("individual", "SBAD2");
							long plateFormatID = 0;
							long workgroupID = 3;
							
							long compoundID;
							try {
								compoundID = executor.getIDViaName("compound", sampleID);
							} catch (Exception ex) {
								//ex.printStackTrace();
								executor.insertCompound(sampleID, sampleID, sampleID, true);
								compoundID = executor.getIDViaName("compound", sampleID);
							}
							
							if (attemptUnblinding) {
								if (isControl) {
									addBlindingRow(sampleID + " is not a blinded compound.");
								} else {
									CompoundHolder compoundHolder = attemptUnblinding(sampleID);
									if (compoundHolder != null) {
										sampleID = compoundHolder.getName();
										compoundID = compoundHolder.getCompoundID();
									}
								}
							}
							
							//TODO Add solvent ID to UKN assay experiments
							long solventID = -1;
							double solventConcentration = -1d;
							String controlPlateID = "<Unknown>";
							
							experimentID = executor.getNextSequenceTableVal("experiment");
							executor.insertExperiment(experimentID, timestampExperiment, experimentName, projectID, workgroupID, individualID, compoundID, cellTypeID, assayID, plateFormatID, solventID, solventConcentration, controlPlateID);
						}
						Log.i("Experiment ID extracted: " + experimentID);
					}
					
					long wellID;
					synchronized (executor) {
						try {
							wellID = executor.getIDViaName("well", wellName);
						} catch (Exception e) {
							executor.insertWell(wellName);
							wellID = executor.getIDViaName("well", wellName);
						}
					}
					long detectionMethodID = executor.getIDViaName("detection_method", "Unknown");
					
					ArrayList<Long> experimentIDList = new ArrayList<>();
					if (isControl) {
						executor.deleteRow("experiment", experimentID);
						ArrayList<String> experimentList = lookupMapDMSO.get(plateID);
						for (String s : experimentList) {
							long id = executor.getIDViaName("experiment", s + "#" + plateID);
							experimentIDList.add(id);
						}
					} else {
						if (!lookupMapDMSO.containsKey(plateID)) {
							lookupMapDMSO.put(plateID, new ArrayList<>());
						}
						ArrayList<String> sampleIDList = lookupMapDMSO.get(plateID);
						sampleIDList.add(unBlindedSampleID);
						lookupMapDMSO.put(plateID, sampleIDList);
						experimentIDList.add(experimentID);
					}
					
					long endpointID1 = decodeKonstanzEndpoint(endpoint1);
					long endpointID2 = decodeKonstanzEndpoint(endpoint2);
					long endpointID3 = decodeKonstanzEndpoint(endpoint3);
					
					for (long id : experimentIDList) {
						if (endpointID1 != DECODED_ENDPOINT_FAILURE && !Double.isNaN(response1)) {
							executor.insertResponse(response1, timestampEndpoint, endpointID1, concentrationID, id, wellID, outlierID, detectionMethodID);
							incrementInsertedResponsesCount();
						}
						
						if (endpointID2 != DECODED_ENDPOINT_FAILURE && !Double.isNaN(response2)) {
							executor.insertResponse(response2, timestampEndpoint, endpointID2, concentrationID, id, wellID, outlierID, detectionMethodID);
							incrementInsertedResponsesCount();
						}
						
						if (extendedEndpoints && endpointID3 != DECODED_ENDPOINT_FAILURE && !Double.isNaN(response3)) {
							executor.insertResponse(response3, timestampEndpoint, endpointID3, concentrationID, id, wellID, outlierID, detectionMethodID);
							incrementInsertedResponsesCount();
						}
					}
				} catch (Exception e) {
					Log.e(e);
					addError("Error prevented " + sfName + " caused on row " + i + " to be inserted into the experiment: " + e.getMessage());
					continue;
				}
				Log.i("Successfully inserted row " + i + " from file: " + sfName);
			}
			workbook.close();
		} catch (Throwable e) {
			Log.e("Fatal Error in sheet " + sourceFile.getName(), e);
			addError("Fatal Error in: " + sourceFile.getName() + ". Type: " + e.getClass().getSimpleName() + ": '" + e.getMessage() + "'! Last known row: " + cachedRow + ". Last known well: " + cachedWell);
		}
	}
	
	@Override
	public String getName() {
		return sourceFile.getName();
	}
}
