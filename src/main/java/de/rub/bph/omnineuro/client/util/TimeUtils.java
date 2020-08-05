package de.rub.bph.omnineuro.client.util;

import de.rub.bph.omnineuro.client.imported.log.Log;

import java.text.DateFormat;
import java.util.Date;

public class TimeUtils {
	
	private static final int DEFAULT_LEVEL_OF_DETAIL = DateFormat.MEDIUM;
	
	public TimeUtils() {
	}
	
	public String formatAbsolute(long time) {
		return formatDateAbsolute(new Date(time), DEFAULT_LEVEL_OF_DETAIL, DEFAULT_LEVEL_OF_DETAIL);
	}
	
	public String formatAbsolute(Date time, int levelOfDetailTime, int levelOfDetailDate) {
		return formatDateAbsolute(time, levelOfDetailDate) + " - " + formatTimeAbsolute(time, levelOfDetailTime);
	}
	
	public String formatAbsolute(Date date) {
		return formatAbsolute(date.getTime());
	}
	
	public String formatTimeAbsolute(Date date, int levelOfDetail) {
		return DateFormat.getTimeInstance(levelOfDetail).format(date);
	}
	
	public String formatDateAbsolute(Date date, int levelOfDetail) {
		return DateFormat.getDateInstance(levelOfDetail).format(date);
	}
	
	public String formatDateAbsolute(long date, int levelOfDetailTime, int levelOfDetailDate) {
		return formatDateAbsolute(new Date(date), levelOfDetailTime, levelOfDetailDate);
	}
	
	public String formatDateAbsolute(Date date, int levelOfDetailTime, int levelOfDetailDate) {
		return formatDateAbsolute(date, levelOfDetailTime) + " - " + formatTimeAbsolute(date, levelOfDetailDate);
	}
	
	public int getLoDviaPreference(String lod) {
		int i = -1;
		try {
			i = Integer.parseInt(lod);
		} catch (NumberFormatException e) {
			Log.i("Warning: Could not interpret this as a number: " + lod);
		}
		
		switch (i) {
			case 0:
				return DateFormat.FULL;
			case 1:
				return DateFormat.LONG;
			case 2:
				return DateFormat.MEDIUM;
			case 3:
				return DateFormat.SHORT;
		}
		
		Log.i("Warning: Level of Detail not found, reverting to default. Input: " + lod);
		return DEFAULT_LEVEL_OF_DETAIL;
	}
	
}