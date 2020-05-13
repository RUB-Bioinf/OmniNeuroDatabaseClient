package de.rub.bph.omnineuro.client.util;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Objects;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class WellBuilder implements Comparable<WellBuilder> {
	
	public static final String WELL_REGEX = "([A-Z]+)(\\d+)";
	private String row;
	private int col;
	
	public WellBuilder(String row, int col) {
		if (col <= 0) throw new IllegalArgumentException("Column for Well must be at least 1. Value provided: " + col);
		
		this.row = row.trim();
		this.col = col;
	}
	
	public static WellBuilder convertWell(String text) throws IllegalArgumentException {
		Pattern p = Pattern.compile(WELL_REGEX);
		Matcher m = p.matcher(text);
		
		if (m.matches()) {
			String part = m.group(1);
			int value = Integer.parseInt(m.group(2));
			
			return new WellBuilder(part, value);
		} else {
			throw new IllegalArgumentException("Failed to apply well regex ['\" + WELL_REGEX + \"'] to '" + text + "'");
		}
	}
	
	public static ArrayList<String> sortWellList(ArrayList<String> inputList) throws IllegalArgumentException {
		ArrayList<WellBuilder> wellList = new ArrayList<>();
		ArrayList<String> outList = new ArrayList<>();
		
		for (String well : inputList) {
			wellList.add(convertWell(well));
		}
		Collections.sort(wellList);
		
		for (WellBuilder builder : wellList) {
			outList.add(builder.getWellShortened());
		}
		return outList;
	}
	
	@Override
	public int hashCode() {
		return Objects.hash(getRow(), getCol());
	}
	
	@Override
	public boolean equals(Object o) {
		if (this == o) return true;
		if (!(o instanceof WellBuilder)) return false;
		WellBuilder that = (WellBuilder) o;
		return getCol() == that.getCol() &&
				Objects.equals(getRow(), that.getRow());
	}
	
	@Override
	public int compareTo(WellBuilder o) {
		if (getRow().equals(o.getRow())) {
			return Integer.compare(getCol(), o.getCol());
		}
		return getRow().compareTo(o.getRow());
	}
	
	public int getCol() {
		return col;
	}
	
	public void setCol(int col) {
		this.col = col;
	}
	
	public String getColAsString() {
		return String.valueOf(getCol());
	}
	
	public String getColExtended() {
		String col = getColAsString();
		if (getCol() < 10) {
			col = "0" + col;
		}
		return col;
	}
	
	public String getRow() {
		return row;
	}
	
	public void setRow(String row) {
		this.row = row;
	}
	
	public String getWell() {
		return getRow() + getColAsString();
	}
	
	public String getWellExtended() {
		return getRow() + getColExtended();
	}
	
	public String getWellShortened() {
		return getRow() + getCol();
	}
}
