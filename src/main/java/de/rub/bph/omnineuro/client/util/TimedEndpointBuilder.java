package de.rub.bph.omnineuro.client.util;

import java.util.Objects;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class TimedEndpointBuilder implements Comparable<TimedEndpointBuilder> {
	
	public static final String TIMED_ENDPOINT_REGEX = "([\\w\\W\\s]+) \\[(\\d+)h]";
	
	private String endpoint;
	private int timestamp;
	
	public TimedEndpointBuilder(String endpoint, int timestamp) {
		if (timestamp < 0)
			throw new IllegalArgumentException("Timestamp " + timestamp + " is less than zero for Endpoint builder!");
		if (endpoint == null || endpoint.trim().equals(""))
			throw new IllegalArgumentException("Endpoint is an empty string or null!");
		
		this.endpoint = endpoint.trim();
		this.timestamp = timestamp;
	}
	
	public static TimedEndpointBuilder parseBuilder(String buildString) {
		Pattern p = Pattern.compile(TIMED_ENDPOINT_REGEX);
		Matcher m = p.matcher(buildString);
		
		if (m.matches()) {
			String part = m.group(1);
			int value = Integer.parseInt(m.group(2));
			
			return new TimedEndpointBuilder(part, value);
		} else {
			throw new IllegalArgumentException("Failed to apply well regex ['" + TIMED_ENDPOINT_REGEX + "'] to '" + buildString+"'");
		}
	}
	
	@Override
	public int hashCode() {
		return Objects.hash(getEndpoint(), getTimestamp());
	}
	
	@Override
	public boolean equals(Object o) {
		if (this == o) return true;
		if (!(o instanceof TimedEndpointBuilder)) return false;
		TimedEndpointBuilder that = (TimedEndpointBuilder) o;
		return getTimestamp() == that.getTimestamp() &&
				getEndpoint().equals(that.getEndpoint());
	}
	
	@Override
	public int compareTo(TimedEndpointBuilder o) {
		if (getEndpoint().equals(o.getEndpoint())) {
			return Integer.compare(getTimestamp(), o.getTimestamp());
		}
		return getEndpoint().compareTo(o.getEndpoint());
		
	}
	
	public String getEndpoint() {
		return endpoint;
	}
	
	public void setEndpoint(String endpoint) {
		this.endpoint = endpoint;
	}
	
	public String getExtendedName() {
		return getEndpoint() + " [" + getTimestamp() + "h]";
	}
	
	public int getTimestamp() {
		return timestamp;
	}
	
	public void setTimestamp(int timestamp) {
		this.timestamp = timestamp;
	}
}
