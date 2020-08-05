package de.rub.bph.omnineuro.client.util.concurrent;

import java.util.Date;
import java.util.List;

public abstract class TimedRunnable implements Runnable {
	
	private boolean finished;
	private Date startTime;
	private Date finishedTime;
	
	public TimedRunnable() {
		this.finished = false;
		this.startTime = new Date();
		this.finishedTime = null;
	}
	
	public static double getAverageRuntime(List<TimedRunnable> list) {
		int count = 0;
		long timeSum = 0;
		
		for (TimedRunnable tr : list) {
			if (tr.isFinished()) {
				timeSum += tr.getRuntime();
				count++;
			}
		}
		
		if (count == 0) return Double.NaN;
		return ((double) timeSum) / ((double) count);
	}
	
	public static long calculateETA(List<TimedRunnable> list, int remainingTasks, int threads) {
		return calculateETA(getAverageRuntime(list), remainingTasks, threads);
	}
	
	public static long calculateETA(double avgRuntime, int remainingTasks, int threads) {
		if (threads <= 0) threads = 1;
		
		return (long) (avgRuntime * (((double) remainingTasks) / ((double) threads)));
	}
	
	public void setFinished() {
		this.finished = true;
		finishedTime = new Date();
	}
	
	public Date getFinishedTime() {
		return finishedTime;
	}
	
	public long getRuntime() {
		if (!isFinished())
			throw new IllegalStateException("This runnable is still running. Cannot determine the runtime! - " + toString());
		
		return getFinishedTime().getTime() - getStartTime().getTime();
	}
	
	public Date getStartTime() {
		return new Date(startTime.getTime());
	}
	
	public boolean isFinished() {
		return finished;
	}
	
}
