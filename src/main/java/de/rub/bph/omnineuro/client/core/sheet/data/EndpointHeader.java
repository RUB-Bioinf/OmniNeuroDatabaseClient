package de.rub.bph.omnineuro.client.core.sheet.data;

public class EndpointHeader {

	private String name;
	private int columnIndex;
	private int expectedValues;

	public EndpointHeader(String name, int columnIndex, int expectedValues) {
		this.name = name;
		this.columnIndex = columnIndex;
		this.expectedValues = expectedValues;
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

	@Override
	public String toString() {
		return "EndpointHeader{" +
				"name='" + name + '\'' +
				", columnIndex=" + columnIndex +
				", expectedValues=" + expectedValues +
				'}';
	}
}
