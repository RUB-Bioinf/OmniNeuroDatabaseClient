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
	private ArrayList<String> casOutRows;
	
	public KonstanzInserter(File sourceFile, boolean attemptUnblinding) {
		super(attemptUnblinding);
		this.sourceFile = sourceFile;
		lookupMapDMSO = new HashMap<>();
		casOutRows = new ArrayList<>();
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
			case "Viabilty UKN2":
			case "Viability UKN2":
				return executor.getIDViaName("endpoint", "Viability UKN2");
			case "neurite area UKN5":
				return executor.getIDViaName("endpoint", "Neurite Area UKN5");
			case "neurite area UKN4":
				return executor.getIDViaName("endpoint", "Neurite Area UKN4");
			default:
				addError("FATAL ERROR! Failed to decode a database compatible endpoint from '" + endpointName + "'!");
				return DECODED_ENDPOINT_FAILURE;
		}
	}
	
	protected void addCASRow(String row) {
		casOutRows.add(row);
	}
	
	@Override
	public void run() {
		long timestampExperiment = new Date(0).getTime();
		int timestampEndpoint = 24;
		addError("TODO later: get the timestamp (experiment, endpoint) from file: " + sourceFile.getName());
		addError("TODO later: read the individual from file: " + sourceFile.getName());
		addError("TODO later: read the detection method from file: " + sourceFile.getName());
		addError("TODO later: get workgroup name for " + sourceFile.getName());
		
		int cachedRow = -1;
		String cachedWell = "<None>";
		try {
			FileInputStream excelFile = new FileInputStream(sourceFile);
			XSSFWorkbook workbook = new XSSFWorkbook(excelFile);
			workbook.setActiveSheet(0);
			String CASCol = "K";
			
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
				CASCol = "L";
			}
			
			int rowTarget = rowCount + START_ROW_INDEX;
			for (int i = START_ROW_INDEX; i < rowTarget; i++) {
				cachedRow = i;
				cachedWell = "<Unknown>";
				
				// EXTRACT INFORMATION FROM SHEET
				String sampleID = reader.getValueAt("A" + i);
				String plateID = reader.getValueAt("B" + i);
				
				for (int j = 0; j < 99; j++) {
					// Extrawurst for UKN 4.
					// Sometimes UKN4 plateID contains the plate number. That has to be removed.
					// Example of undesireable plate: UKN4_PreProject_Acet_plate 1_N1
					String plate = "_plate " + j;
					if (plateID.contains(plate)) {
						addError("Warning! '" + plateID + "' contained plate ID in the experiment. Deleting '" + plate + "'!");
						plateID = plateID.replace(plate, "");
					}
				}
				
				boolean hasWell = true;
				String wellName;
				try {
					String wellRow = reader.getValueAt("C" + i);
					int wellCol = (int) Double.parseDouble(reader.getValueAt("D" + i, true));
					WellBuilder wellBuilder = new WellBuilder(wellRow, wellCol);
					wellName = wellBuilder.getWellExtended();
				} catch (Exception e) {
					hasWell = false;
					wellName = "Z" + cachedRow;
					CASCol = "J";
				}
				cachedWell = wellName;
				
				String wellType = reader.getValueAt("E" + i);
				String wellQuality = reader.getValueAt("F" + i);
				
				String CAS = null;
				try {
					String CASCell = CASCol + i;
					CAS = reader.getValueAt(CASCell, false).trim();
					Log.v("Cas at " + CASCell + " found: " + CAS);
					if (CAS.equals("") || CAS.equals("NaN")) CAS = null;
				} catch (Exception e) {
					Log.e("Failed to read the CAS Number. But that's okay, switching to 'No CAS Mode.'", e);
					CAS = null;
				}
				boolean CASMode = CAS != null;
				
				if (CASMode) {
					// Extrawurst for 'Paraquat dichloride hydrate'.
					// Konstanz used CAS: 1910-42-5
					// IUF CAS: 75365-73-0
					// TODO this is technical debt
					if (CAS.equals("1910-42-5") || sampleID.toLowerCase().trim().equals("paraquat dichloride hydrate")) {
						CAS = "75365-73-0";
						addError("Technical debt. Replaced PARAQ CAS to match DB.");
					}
				}
				
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
				if (hasWell) {
					try {
						response2 = Double.parseDouble(reader.getValueAt("I" + i, true));
					} catch (Exception e) {
						addError("Failed to the response to " + endpoint2 + " at I" + i + ". Error: " + e.getMessage());
					}
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
							if (CASMode) {
								boolean foundCas;
								try {
									//Let's see if that CAS exists in the DB as a registered compound
									compoundID = executor.getIDViaFeature("compound", "cas_no", CAS);
									foundCas = true;
								} catch (Exception exx) {
									try {
										String unblindedCAS = executor.getFeatureViaFeature("unblinded_compound_mapping", "name", "unblinded_cas_number", CAS);
										addBlindingRow("Blinded entry: " + CAS + " was unblinded to: " + unblindedCAS);
										compoundID = executor.getIDViaFeature("compound", "cas_no", unblindedCAS);
										attemptUnblinding = false;
										foundCas = true;
									} catch (Exception exxx) {
										//What if the CAS does not exists in the DB, but the Compound name?
										String actualCAS = null;
										try {
											long actualID = executor.getIDViaName("compound", sampleID);
											actualCAS = executor.getFeatureViaID("compound", "cas_no", actualID);
										} catch (Exception exxxx) {
											// all good. nvm.
										}
										if (actualCAS != null) {
											String outRowExtra = sfName + ";" + sampleID + ";" + plateID + ";" + CAS + ";DUPLICATE;;;;DUPLICATE COMPOUND NAME BUT DIFFERENT CAS:;" + actualCAS;
											addCASRow(outRowExtra);
										}
										
										//So our CAS was not in the DB and not in the unblinded mapping. Let's insert it as a new compound then.
										addError("This compound was not found in the DB! Name: '" + sampleID + "'. CAS: " + CAS);
										executor.insertCompound(sampleID, CAS, sampleID, true);
										foundCas = false;
										compoundID = executor.getIDViaName("compound", sampleID);
									}
								}
								
								String casName = executor.getNameViaID("compound", compoundID);
								String abbreviation = executor.getFeatureViaID("compound", "abbreviation", compoundID);
								boolean equals = casName.equals(sampleID);
								String outRow = sfName + ";" + sampleID + ";" + plateID + ";" + CAS + ";" + String.valueOf(foundCas).toUpperCase() + ";" + casName + ";" + abbreviation + ";" + String.valueOf(equals).toUpperCase();
								addCASRow(outRow);
							} else {
								try {
									compoundID = executor.getIDViaName("compound", sampleID);
								} catch (Exception exx) {
									try {
										compoundID = executor.getIDViaFeature("compound", "abbreviation", sampleID);
									} catch (Exception ex) {
										//ex.printStackTrace();
										executor.insertCompound(sampleID, sampleID, sampleID, true);
										compoundID = executor.getIDViaName("compound", sampleID);
									}
								}
							}
							
							if (attemptUnblinding) {
								if (isControl) {
									addBlindingRow(sampleID + " [Line " + i + "] is not a blinded compound. It's a control.");
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
							long mutationID = AXESInserter.getInvalidMutationID();
							String controlPlateID = "<Unknown>";
							
							experimentID = executor.getNextSequenceTableVal("experiment");
							executor.insertExperiment(experimentID, timestampExperiment, experimentName, projectID, workgroupID, individualID, mutationID, compoundID, cellTypeID, assayID, plateFormatID, solventID, solventConcentration, controlPlateID);
						}
						Log.v("Experiment ID extracted: " + experimentID);
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
						if (!experimentName.startsWith("Narciclasine#UKN4_PreProject_Narci_plate")) {
							// Hier eine Extrawurst, weil auf der selben plate als compound und auch als kontrolle verwendet wurde
							//TODO this should be discussed and deleted! Technical debt gedetected!!
							executor.deleteRow("experiment", experimentID);
						}
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
					addError("FATAL Error! " + sfName + ": Error on row " + i + " to be inserted into the experiment: " + e.getMessage());
					addCASRow(sfName + ";" + sampleID + ";" + plateID + ";FATAL ERROR on row " + i);
					continue;
				}
				Log.v("Successfully inserted row " + i + " from file: " + sfName);
			}
			workbook.close();
		} catch (Throwable e) {
			Log.e("Fatal Error in sheet " + sourceFile.getName(), e);
			addError("Fatal Error in: " + sourceFile.getName() + ". Type: " + e.getClass().getSimpleName() + ": '" + e.getMessage() + "'! Last known row: " + cachedRow + ". Last known well: " + cachedWell);
		}
		
		setFinished();
	}
	
	@Override
	public String getName() {
		return sourceFile.getName();
	}
	
	public ArrayList<String> getCASRows() {
		return new ArrayList<>(casOutRows);
	}
}
