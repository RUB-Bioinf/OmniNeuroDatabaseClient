package de.rub.bph.omnineuro.client.util;


import javax.swing.*;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

public class DateLabelFormatter extends JFormattedTextField.AbstractFormatter {
	
	private SimpleDateFormat dateFormatter;
	
	public DateLabelFormatter(String datePattern) {
		dateFormatter = new SimpleDateFormat(datePattern);
	}
	
	@Override
	public Object stringToValue(String text) throws ParseException {
		return dateFormatter.parseObject(text);
	}
	
	@Override
	public String valueToString(Object value) throws ParseException, NumberFormatException {
		if (value == null) return "";
		
		if (value instanceof Date) {
			Date date = (Date) value;
			return dateFormatter.format(date);
		}
		
		if (value instanceof Calendar) {
			Calendar cal = (Calendar) value;
			return dateFormatter.format(cal.getTime());
		}
		
		if (value instanceof String) {
			long l = Long.parseLong((String) value);
			return valueToString(new Date(l));
		}
		
		return valueToString(value.toString());
	}
	
}
