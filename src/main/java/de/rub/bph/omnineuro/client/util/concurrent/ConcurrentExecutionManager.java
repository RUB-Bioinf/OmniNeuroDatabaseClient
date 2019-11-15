package de.rub.bph.omnineuro.client.util.concurrent;

import de.rub.bph.omnineuro.client.imported.log.Log;
import de.rub.bph.omnineuro.client.util.NumberUtils;

import java.util.Date;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

public class ConcurrentExecutionManager {
	
	protected ExecutorService service;
	
	protected int threads;
	
	public ConcurrentExecutionManager(int threads) {
		this.threads = threads;
		service = Executors.newFixedThreadPool(threads);
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
			Log.i("Still waiting...");
		}
		long diff = new Date().getTime() - start;
		Log.i("Finished waiting! Execution time: " + NumberUtils.convertSecondsToHMmSs(diff) + "].");
	}
	
	public int getThreads() {
		return threads;
	}
}
