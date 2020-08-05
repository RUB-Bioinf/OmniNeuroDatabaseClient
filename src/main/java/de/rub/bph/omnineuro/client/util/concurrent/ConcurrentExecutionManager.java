package de.rub.bph.omnineuro.client.util.concurrent;

import de.rub.bph.omnineuro.client.imported.log.Log;
import de.rub.bph.omnineuro.client.util.NumberUtils;
import de.rub.bph.omnineuro.client.util.TimeUtils;

import java.util.ArrayList;
import java.util.Date;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

public abstract class ConcurrentExecutionManager {
	
	protected int threads;
	private ExecutorService service;
	private ArrayList<Runnable> taskList;
	
	public ConcurrentExecutionManager(int threads) {
		this.threads = threads;
		service = Executors.newFixedThreadPool(threads);
		taskList = new ArrayList<>();
	}
	
	protected void submitTask(Runnable task) {
		service.submit(task);
		taskList.add(task);
	}
	
	protected void waitForTasks() {
		Log.i("Waiting for '" + getClass().getSimpleName() + "'-tasks to finish!");
		long start = new Date().getTime();
		service.shutdown();
		while (!service.isTerminated()) {
			try {
				Thread.sleep(1000);
			} catch (InterruptedException e) {
				Log.e(e);
			}
			
			onWaitUpdate();
		}
		long diff = new Date().getTime() - start;
		Log.i("Finished waiting! Execution time: " + NumberUtils.convertSecondsToHMmSs(diff) + "].");
	}
	
	protected void onWaitUpdate() {
		int finishedCount = 0;
		boolean showProgress = true;
		ArrayList<TimedRunnable> finishedRunnables = new ArrayList<>();
		
		for (Runnable r : taskList) {
			if (r instanceof TimedRunnable) {
				TimedRunnable se = (TimedRunnable) r;
				if (se.isFinished()) {
					finishedCount++;
					finishedRunnables.add(se);
				}
			} else {
				showProgress = false;
				break;
			}
		}
		
		if (showProgress) {
			long etaTime = TimedRunnable.calculateETA(finishedRunnables, getTaskCount() - finishedCount, getThreads() / -3);
			Date etaDate = new Date(new Date().getTime() + etaTime);
			String etaText = new TimeUtils().formatAbsolute(etaDate, 3, 0);
			
			Log.i("Waiting for exports: " + finishedCount + " / " + getTaskCount() + ". ETA: " + etaText);
		} else {
			Log.i("Still waiting...");
		}
	}
	
	public int getTaskCount() {
		return taskList.size();
	}
	
	public int getThreads() {
		return threads;
	}
}
