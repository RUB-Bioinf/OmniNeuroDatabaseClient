package de.rub.bph.omnineuro.client.core.sheet.reader;

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.util.CellReference;
import org.json.JSONException;
import org.json.JSONObject;

import java.io.IOException;

public abstract class SheetReaderTask {

	protected Sheet sheet;

	public SheetReaderTask(Workbook workbook, String sheetName) throws IOException {
		sheet = workbook.getSheet(sheetName);
		workbook.close();
	}

	public Sheet getSheet() {
		return sheet;
	}

	protected void setSheet(Sheet sheet) {
		this.sheet = sheet;
	}

	public String getValueAt(String cellName) throws SheetReaderException {
		return getValueAt(cellName, true);
	}

	public String getValueAt(String cellName, boolean forceNumeric) throws SheetReaderException {
		CellReference cellReference = new CellReference(cellName);
		Row row = sheet.getRow(cellReference.getRow());
		if (row == null) {
			throw new SheetReaderException("(row is null)-Error fetching cell data at " + cellName + "! Looks like the row is not available!");
		}

		Cell cell = row.getCell(cellReference.getCol());
		if (cell == null) {
			if (forceNumeric) {
				throw new SheetReaderException("(cell is null)-Error fetching cell data at " + cellName + "! Looks like the cell is empty!");
			} else return "";
		}

		switch (cell.getCellTypeEnum()) {
			case ERROR:
				throw new SheetReaderException("Error in cell " + cellName);
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
						throw new SheetReaderException("Cannot get a STRING value from a ERROR formula cell at " + cellName + "!");
					}
				}
			case BLANK:
				return "";

			default:
				throw new SheetReaderException("Unexpected cell type ('" + cell.getCellTypeEnum().toString() + "') at " + cellName + "!");
		}
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

	public abstract JSONObject readSheet() throws JSONException, SheetReaderException;

	public void addRowPair(JSONObject data, int line) throws SheetReaderException, JSONException {
		data.put(getValueAt("A" + line), getValueAt("B" + line));
	}

	public class SheetReaderException extends Exception {
		public SheetReaderException(String s) {
			super(s);
		}
	}
}
