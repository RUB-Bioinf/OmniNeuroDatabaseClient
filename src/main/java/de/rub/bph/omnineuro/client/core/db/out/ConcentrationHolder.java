package de.rub.bph.omnineuro.client.core.db.out;

import de.rub.bph.omnineuro.client.core.db.OmniNeuroQueryExecutor;

import java.sql.SQLException;
import java.util.Objects;

public class ConcentrationHolder {
	
	private static final long DEFAULT_CONTROL_ID_NON_CONTROL = -1;
	private long id;
	private long controlID;
	private double value;
	private String controlName;
	private String controlAcronym;
	
	public ConcentrationHolder(long id, OmniNeuroQueryExecutor executor) throws SQLException, NumberFormatException {
		this.id = id;
		this.controlID = DEFAULT_CONTROL_ID_NON_CONTROL;
		
		value = Double.parseDouble(executor.getFeatureViaID("concentration", "value", id));
		if (value == 0) {
			controlID = Long.parseLong(executor.getFeatureViaID("concentration", "control_id", id));
			controlName = executor.getNameViaID("control", controlID);
			controlAcronym = executor.getFeatureViaID("control", "acronym", controlID);
		}
	}
	
	@Override
	public int hashCode() {
		return Objects.hash(getId(), getControlID(), getValue());
	}
	
	@Override
	public boolean equals(Object o) {
		if (this == o) return true;
		if (!(o instanceof ConcentrationHolder)) return false;
		ConcentrationHolder that = (ConcentrationHolder) o;
		return getId() == that.getId() &&
				getControlID() == that.getControlID() &&
				Double.compare(that.getValue(), getValue()) == 0;
	}
	
	public String getControlAcronym() {
		return controlAcronym;
	}
	
	public long getControlID() {
		return controlID;
	}
	
	public String getControlName() {
		return controlName;
	}
	
	public String getDescription() {
		if (isControl()) {
			return getControlName();
		}
		return String.valueOf(getValue());
	}
	
	public long getId() {
		return id;
	}
	
	public double getValue() {
		return value;
	}
	
	public boolean isControl() {
		return getControlID() != DEFAULT_CONTROL_ID_NON_CONTROL;
	}
}
