package de.rub.bph.omnineuro.client.core.sheet.data;

public class EndpointHeader {

	private String name;
	private int columnIndex;
	private int expectedValues;
	private int timestamp;

	public EndpointHeader(String name, int columnIndex, int expectedValues, int timestamp) {
		this.name = name;
		this.columnIndex = columnIndex;
		this.expectedValues = expectedValues;
		this.timestamp = timestamp;
	}

	public int getTimestamp() {
		return timestamp;
	}

	public void setTimestamp(int timestamp) {
		this.timestamp = timestamp;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public int getColumnIndex() {
		return columnIndex;
	}

	public void setColumnIndex(int columnIndex) {
		this.columnIndex = columnIndex;
	}

	public int getExpectedValues() {
		return expectedValues;
	}

	public void setExpectedValues(int expectedValues) {
		this.expectedValues = expectedValues;
	}
}
