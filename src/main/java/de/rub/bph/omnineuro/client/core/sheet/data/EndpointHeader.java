package de.rub.bph.omnineuro.client.core.sheet.data;

import java.util.Objects;

public class EndpointHeader {
	
	private String name;
	private int columnIndex;
	private int expectedValues;
	private int timestamp;
	private int rowIndex;
	private String detectionMethod;
	
	public EndpointHeader(String name, int columnIndex, int expectedValues, int timestamp, int rowIndex, String detectionMethod) {
		this.name = name;
		this.columnIndex = columnIndex;
		this.expectedValues = expectedValues;
		this.timestamp = timestamp;
		this.rowIndex = rowIndex;
		this.detectionMethod = detectionMethod;
	}
	
	public int getColumnIndex() {
		return columnIndex;
	}
	
	public void setColumnIndex(int columnIndex) {
		this.columnIndex = columnIndex;
	}
	
	public String getDetectionMethod() {
		return detectionMethod;
	}
	
	public void setDetectionMethod(String detectionMethod) {
		this.detectionMethod = detectionMethod;
	}
	
	public int getExpectedValues() {
		return expectedValues;
	}
	
	public void setExpectedValues(int expectedValues) {
		this.expectedValues = expectedValues;
	}
	
	public String getName() {
		return name;
	}
	
	public void setName(String name) {
		this.name = name;
	}
	
	public int getRowIndex() {
		return rowIndex;
	}
	
	public void setRowIndex(int rowIndex) {
		this.rowIndex = rowIndex;
	}
	
	public int getTimestamp() {
		return timestamp;
	}
	
	public void setTimestamp(int timestamp) {
		this.timestamp = timestamp;
	}
	
	@Override
	public int hashCode() {
		return Objects.hash(getName(), getColumnIndex(), getExpectedValues(), getTimestamp(), getRowIndex(), getDetectionMethod());
	}
	
	@Override
	public boolean equals(Object o) {
		if (this == o) return true;
		if (o == null || getClass() != o.getClass()) return false;
		EndpointHeader that = (EndpointHeader) o;
		return getColumnIndex() == that.getColumnIndex() &&
				getExpectedValues() == that.getExpectedValues() &&
				getTimestamp() == that.getTimestamp() &&
				getRowIndex() == that.getRowIndex() &&
				Objects.equals(getName(), that.getName()) &&
				Objects.equals(getDetectionMethod(), that.getDetectionMethod());
	}
	
	@Override
	public String toString() {
		return "EndpointHeader{" +
				"name='" + name + '\'' +
				", columnIndex=" + columnIndex +
				", rowIndex=" + rowIndex +
				", expectedValues=" + expectedValues +
				", timestamp=" + timestamp +
				", detectionMethod='" + detectionMethod + '\'' +
				'}';
	}
}
