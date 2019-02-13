package de.rub.bph.omnineuro.client.core.sheet.reader;

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.util.CellReference;
import org.json.JSONException;
import org.json.JSONObject;

import java.io.File;

public class SheetReader {

	protected File source;
	protected Sheet sheet;

	public SheetReader(File source) {
		this.source = source;
	}

	public Sheet getSheet() {
		return sheet;
	}

	protected void setSheet(Sheet sheet) {
		this.sheet = sheet;
	}

	public String getValueAt(String cellName) throws SheetReaderException {
		CellReference cellReference = new CellReference(cellName);
		Row row = sheet.getRow(cellReference.getRow());
		if (row == null) {
			throw new SheetReaderException("(row is null)-Error fetching cell data at " + cellName + " in " + source.getAbsolutePath()
					+ " Looks like the row is not available!");
		}

		Cell cell = row.getCell(cellReference.getCol());
		if (cell == null) {
			throw new SheetReaderException("(cell is null)-Error fetching cell data at " + cellName + " in "
					+ source.getAbsolutePath() + " Looks like the cell is empty!");
			// error in
			// X:\bioinfdata\work\datenstruktur_iuf\VIP\experiments\Arbeitspakete\4.2\auswertung_debug\Migration\Human\BMBF_JB-V109_VPA_692_M72.xlsx
		}

		switch (cell.getCellTypeEnum()) {
			case ERROR:
				throw new SheetReaderException("Error field at " + source.getAbsolutePath() + " in " + cellName);
			case NUMERIC:
				return String.valueOf(cell.getNumericCellValue());
			case STRING:
				return cell.getStringCellValue();
			case FORMULA:
				try {
					return String.valueOf(cell.getNumericCellValue());
				} catch (Exception e) {
					// e.printStackTrace();

					return "NaN";
				}
			case BLANK:
				return "";

			default:
				throw new SheetReaderException("Unexpected cell type ('" + cell.getCellTypeEnum().toString() + "') for "
						+ source.getAbsolutePath() + " at " + cellName + "!");
		}
	}

	public class SheetReaderException extends Exception {
		public SheetReaderException(String s) {
			super(s);
		}
	}

	public void addRowPair(JSONObject data,int line) throws SheetReaderException, JSONException {
		data.put(getValueAt("A"+line),getValueAt("B"+line));
	}
}
