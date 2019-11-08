package de.rub.bph.omnineuro.client.core.sheet.reader;

import de.rub.bph.omnineuro.client.imported.log.Log;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.ss.util.CellReference;

public class SheetReader {
	
	protected Workbook workbook;
	protected Sheet sheet;
	
	public SheetReader(Workbook workbook, int sheetIndex) {
		this.workbook = workbook;
		if (sheetIndex < 0) {
			throw new IllegalArgumentException("Failed to change the sheet index to: " + sheetIndex);
		}
		sheet = workbook.getSheetAt(sheetIndex);
	}
	
	public SheetReader(Workbook workbook) {
		this(workbook, workbook.getActiveSheetIndex());
	}
	
	public SheetReader(Workbook workbook, String sheetName) {
		this(workbook, workbook.getSheetIndex(sheetName));
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
	
	public CellType getCellType(String cellName) {
		return getCell(cellName).getCellTypeEnum();
	}
	
	public String getValueAt(String cellName, boolean forceNumeric) throws SheetReaderTask.SheetReaderException {
		Row row = getRow(cellName);
		if (row == null) {
			throw new SheetReaderTask.SheetReaderException("(row is null)-Error fetching cell data at " + cellName + "'! Looks like the row is not available!");
		}
		
		Cell cell = row.getCell(getCol(cellName));
		if (cell == null) {
			if (forceNumeric) {
				throw new SheetReaderTask.SheetReaderException("(cell is null)-Error fetching cell data at " + cellName + "! Looks like the cell is empty!");
			} else return "";
		}
		
		switch (cell.getCellTypeEnum()) {
			case ERROR:
				throw new SheetReaderTask.SheetReaderException("Error in cell " + cellName);
			case NUMERIC:
				return String.valueOf(cell.getNumericCellValue());
			case STRING:
				return cell.getStringCellValue();
			case FORMULA:
				if (forceNumeric) {
					try {
						return String.valueOf(cell.getNumericCellValue());
					} catch (Exception e) {
						return "NaN";
					}
				} else {
					try {
						return cell.getStringCellValue();
					} catch (Exception e) {
						throw new SheetReaderTask.SheetReaderException("Cannot get a STRING value from a ERROR formula cell at " + cellName + "!");
					}
				}
			case BLANK:
				return "";
			
			default:
				throw new SheetReaderTask.SheetReaderException("Unexpected cell type ('" + cell.getCellTypeEnum().toString() + "') at " + cellName + "!");
		}
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
	
	public Workbook getWorkbook() {
		return workbook;
	}
	
	public class SheetReaderException extends Exception {
		
		public SheetReaderException(String s) {
			super(s);
		}
	}
}



