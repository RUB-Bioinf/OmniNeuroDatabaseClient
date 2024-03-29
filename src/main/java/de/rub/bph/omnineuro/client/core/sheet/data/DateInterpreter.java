package de.rub.bph.omnineuro.client.core.sheet.data;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.HashMap;

public class DateInterpreter {
	
	//Date format expected: ddMONjj
	
	private static HashMap<String, Integer> monthMap;
	private String input;
	
	public DateInterpreter(String input) {
		this.input = input;
	}
	
	public static DateInterpreter parseDate(long date) {
		return DateInterpreter.parseDate(new Date(date));
	}
	
	public static DateInterpreter parseDate(Date date) {
		SimpleDateFormat sdfDay = new SimpleDateFormat("dd");
		SimpleDateFormat sdfMon = new SimpleDateFormat("MM");
		SimpleDateFormat sdfYear = new SimpleDateFormat("yy");
		
		String monthPart = sdfMon.format(date);
		
		String finalMonth = null;
		int mon = Integer.parseInt(monthPart) - 1;
		for (String s : monthMap.keySet()) {
			if (monthMap.get(s) == mon) {
				finalMonth = s.toUpperCase();
			}
		}
		if (finalMonth == null) throw new IllegalArgumentException("Failed to parse date: " + date);
		
		String input = sdfDay.format(date) + finalMonth + sdfYear.format(date);
		return new DateInterpreter(input);
	}
	
	public static void initMonthMap() {
		if (monthMap != null) return;
		
		monthMap = new HashMap<>();
		monthMap.put("jan", 0);
		monthMap.put("feb", 1);
		monthMap.put("mar", 2);
		monthMap.put("apr", 3);
		monthMap.put("may", 4);
		monthMap.put("jun", 5);
		monthMap.put("jul", 6);
		monthMap.put("aug", 7);
		monthMap.put("sep", 8);
		monthMap.put("oct", 9);
		monthMap.put("nov", 10);
		monthMap.put("dec", 11);
	}
	
	public Calendar interpretCalender() throws NumberFormatException, IndexOutOfBoundsException, IllegalArgumentException {
		Calendar calendar = new GregorianCalendar();
		
		String m = getMON().toLowerCase();
		if (!monthMap.containsKey(m)) {
			throw new IllegalArgumentException("Interpreted month '" + m + "' from '" + getInput() + "' could not be interpreted. Difference in cases are ignored.");
		}
		
		int d = Integer.parseInt(getDD());
		int mon = monthMap.get(m);
		int year = 2000 + Integer.parseInt(getYY());
		
		calendar.set(Calendar.DAY_OF_MONTH, d);
		calendar.set(Calendar.MONTH, mon);
		calendar.set(Calendar.YEAR, year);
		
		return calendar;
	}
	
	public Date interpretDate() throws NumberFormatException, IndexOutOfBoundsException, IllegalArgumentException {
		return interpretCalender().getTime();
	}
	
	public String getBaseDate() {
		return getDD() + getMON() + getYY();
	}
	
	public String getDD() {
		return input.substring(0, 2);
	}
	
	public String getInput() {
		return input;
	}
	
	public String getMON() {
		return input.substring(2, 5);
	}
	
	public String getYY() {
		return input.substring(5, 7);
	}
}
