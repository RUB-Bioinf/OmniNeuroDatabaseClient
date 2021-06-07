package de.rub.bph.omnineuro.client.core.sheet.reader;

import de.rub.bph.omnineuro.client.core.sheet.reader.versions.meta.ExternalMetadata;
import de.rub.bph.omnineuro.client.imported.log.Log;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.ss.util.CellReference;

import java.io.File;
import java.util.HashMap;

public class SheetReader {
	
	protected File sourceFile;
	protected Workbook workbook;
	protected Sheet sheet;
	private FormulaEvaluator evaluator;
	private HashMap<String, FormulaEvaluator> externalEvaluators;
	private int sheetIndex;
	
	public SheetReader(File sourceFile, Workbook workbook, int sheetIndex) {
		this.workbook = workbook;
		this.sourceFile = sourceFile;
		if (sheetIndex < 0) {
			throw new IllegalArgumentException("Failed to change the sheet index to: " + sheetIndex);
		}
		this.sheetIndex = sheetIndex;
		
		sheet = workbook.getSheetAt(sheetIndex);
		evaluator = workbook.getCreationHelper().createFormulaEvaluator();
	}
	
	public SheetReader(File sourceFile, Workbook workbook) {
		this(sourceFile, workbook, workbook.getActiveSheetIndex());
	}
	
	public SheetReader(File sourceFile, Workbook workbook, String sheetName) {
		this(sourceFile, workbook, workbook.getSheetIndex(sheetName));
	}
	
	public CellType getCellType(String cellName) {
		Cell cell = getCell(cellName);
		if (cell == null) {
			return null;
		}
		return cell.getCellTypeEnum();
	}
	
	public String getValueAt(String cellName) throws SheetReaderTask.SheetReaderException {
		return getValueAt(cellName, true);
	}
	
	public CellReference getCellReference(String cellName) {
		return new CellReference(cellName);
	}
	
	public Row getRow(String cellName) {
		return getRow(getCellReference(cellName));
	}
	
	public Row getRow(CellReference cellReference) {
		return sheet.getRow(cellReference.getRow());
	}
	
	public short getCol(String cellName) {
		return getCol(getCellReference(cellName));
	}
	
	public short getCol(CellReference cellReference) {
		return cellReference.getCol();
	}
	
	public Cell getCell(String cellName) {
		return getRow(cellName).getCell(getCol(cellName));
	}
	
	public String getValueAt(String cellName, boolean forceNumeric) throws SheetReaderTask.SheetReaderException {
		return getValueAt(cellName, forceNumeric, false, false);
	}
	
	public String getValueAt(String cellName, boolean forceNumeric, boolean evaluateFormulas, boolean ignoreMissingWorkbooks) throws SheetReaderTask.SheetReaderException {
		Row row = getRow(cellName);
		evaluator.setIgnoreMissingWorkbooks(ignoreMissingWorkbooks);
		
		try {
			ExternalMetadata externalMetadata = ExternalMetadata.getInstance();
			HashMap<String, FormulaEvaluator> workbooks = new HashMap<String, FormulaEvaluator>();
			if (!ignoreMissingWorkbooks) {
				workbooks.put(sourceFile.getName(), evaluator);
				workbooks.putAll(externalMetadata.getMetaData());
				evaluator.setupReferencedWorkbooks(workbooks);
			}
		} catch (Throwable e) {
			Log.e(e);
			evaluator.setIgnoreMissingWorkbooks(false);
			evaluateFormulas = false;
		}
		
		//if (evaluateFormulas) {
		//	evaluator.evaluateAll();
		//}
		
		if (row == null) {
			throw new SheetReaderTask.SheetReaderException("(row is null)-Error fetching cell data at " + cellName + " in '" + getFileName() + "' in '" + sheet.getSheetName() + "'! Looks like the row is not available!");
		}
		
		Cell cell = row.getCell(getCol(cellName));
		if (cell == null) {
			if (forceNumeric) {
				throw new SheetReaderTask.SheetReaderException("(cell is null)-Error fetching cell data at " + cellName + " in '" + getFileName() + "' in '" + sheet.getSheetName() + "'! Looks like the cell is empty!");
			} else return "";
		}
		
		String readVal = null;
		switch (cell.getCellTypeEnum()) {
			case ERROR:
				throw new SheetReaderTask.SheetReaderException("Cell is type 'Error' in " + getDetailedCellName(cellName));
			case NUMERIC:
				readVal = String.valueOf(cell.getNumericCellValue());
				readVal = readVal.trim();
				return readVal;
			case STRING:
				readVal = cell.getStringCellValue();
				if (readVal != null) {
					readVal = readVal.trim();
				}
				return readVal;
			case FORMULA:
				if (forceNumeric) {
					try {
						return String.valueOf(cell.getNumericCellValue());
					} catch (Exception e) {
						//try {
						//	CellValue formulaValue = evaluator.evaluate(cell);
						//	return String.valueOf(formulaValue.getNumberValue());
						//} catch (Throwable e2) {
						//	return "NaN";
						//}
						return "NaN";
					}
				} else {
					try {
						return cell.getStringCellValue();
					} catch (Exception e) {
						if (evaluateFormulas) {
							try {
								CellValue formulaValue = evaluator.evaluate(cell);
								String cellValString = null;
								switch (formulaValue.getCellTypeEnum()) {
									case FORMULA:
										cellValString = formulaValue.getStringValue();
										break;
									case NUMERIC:
										cellValString = String.valueOf(formulaValue.getNumberValue());
										break;
									case BOOLEAN:
										cellValString = String.valueOf(formulaValue.getBooleanValue());
										break;
									case STRING:
										cellValString = String.valueOf(formulaValue.getStringValue());
										break;
									default:
										String errorText = "Unknown result of formula " + cell.getCellFormula() + " in " + cellName + ": " + formulaValue.getCellTypeEnum();
										Log.w(errorText);
								}
								
								if (cellValString == null || cellValString.length() == 0 || cellValString.equals("null")) {
									throw new IllegalArgumentException("Failed to evaluate formula: " + cell.getCellFormula() + " in " + getDetailedCellName(cellName));
								}
								Log.i("Successfully evaluated formula: " + cell.getCellFormula() + " to " + cellValString);
								return cellValString;
							} catch (Throwable e2) {
								throw new SheetReaderTask.SheetReaderException("Cannot get a STRING value from a ERROR formula cell at " + getDetailedCellName(cellName) + ". Failed to evaluate formula: '" + cell.getCellFormula() + "'! Reason: " + e2.getMessage());
							}
						} else {
							try {
								String cellValString = null;
								switch (cell.getCachedFormulaResultTypeEnum()) {
									case BOOLEAN:
										cellValString = String.valueOf(cell.getBooleanCellValue());
										break;
									case NUMERIC:
										cellValString = String.valueOf(cell.getNumericCellValue());
										break;
									case STRING:
										cellValString = cell.getRichStringCellValue().toString();
										break;
									case ERROR:
										cellValString = "NaN";
										break;
								}
								
								if (cellValString == null || cellValString.length() == 0 || cellValString.equals("null")) {
									throw new IllegalArgumentException("Failed to read cached formula: " + cell.getCellFormula() + " at " + getDetailedCellName(cellName));
								}
								Log.v("Successfully read cached formula: " + cell.getCellFormula() + " to " + cellValString);
								return cellValString;
							} catch (Throwable e2) {
								throw new SheetReaderTask.SheetReaderException("Cannot get a STRING value from a cached " + cell.getCachedFormulaResultTypeEnum() + "-formula cell at " + getDetailedCellName(cellName) + ". Failed to evaluate formula: '" + cell.getCellFormula() + "'! Reason: " + e2.getMessage());
							}
						}
					}
				}
			case BLANK:
				return "";
			
			default:
				throw new SheetReaderTask.SheetReaderException("Unexpected cell type ('" + cell.getCellTypeEnum().toString() + "') at " + cellName + "!");
		}
	}
	
	private String getDetailedCellName(String cellName) {
		return "[" + getSourceFile().getName() + ", " + getWorkbook().getSheetName(getSheetIndex()) + ", " + cellName + "]";
	}
	
	public void addExternalEvaluators(HashMap<String, FormulaEvaluator> evaluators) {
		externalEvaluators.putAll(evaluators);
	}
	
	public int getContinuousRowEntries(String colName, int start) {
		Log.i("Looking for continuous entries from " + colName + start + " onwards.");
		int offset = 0;
		
		while (true) {
			String cellName = colName + (start + offset);
			Log.v("Discovering if there exists an entry for: " + cellName);
			
			String cell;
			try {
				cell = getValueAt(cellName, false);
			} catch (SheetReaderException e) {
				//e.printStackTrace();
				Log.i("Nope. Nothing found. Stopping at offset: " + offset);
				break;
			}
			
			if (cell == null || cell.trim().equals("")) {
				break;
			}
			
			Log.v("Yup. There was something written there: " + cell.trim());
			offset++;
		}
		
		Log.i("Results: From " + colName + start + " onwards, there were " + offset + " row(s) of data!");
		return offset;
	}
	
	public boolean hasValueAt(String cellName) {
		String cell;
		try {
			cell = getValueAt(cellName, false);
		} catch (SheetReaderException e) {
			return false;
		}
		return cell != null && !cell.trim().equals("");
	}
	
	/**
	 * Credits go to:
	 * https://stackoverflow.com/questions/10813154/how-do-i-convert-a-number-to-a-letter-in-java
	 *
	 * @param index The column index
	 * @return The column name
	 */
	public String getExcelColumn(int index) {
		if (index < 0) {
			return "-" + getExcelColumn(-index - 1);
		}
		
		int quot = index / 26;
		int rem = index % 26;
		char letter = (char) ((int) 'A' + rem);
		if (quot == 0) {
			return "" + letter;
		} else {
			return getExcelColumn(quot - 1) + letter;
		}
	}
	
	public String getFileName() {
		return getSourceFile().getName();
	}
	
	public int getSheetIndex() {
		return sheetIndex;
	}
	
	public File getSourceFile() {
		return sourceFile;
	}
	
	public Workbook getWorkbook() {
		return workbook;
	}
	
	public class SheetReaderException extends Exception {
		
		public SheetReaderException(String s) {
			super(s);
		}
	}
	
}



