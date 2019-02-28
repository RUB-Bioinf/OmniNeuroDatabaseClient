package de.rub.bph.omnineuro.client.ui;

import javax.swing.*;
import java.sql.SQLException;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

public class NFrame extends JFrame {

	public void showInfoMessage(String message) {
		System.out.println("Info-Message displayed: '" + cropString(message) + "'");
		JOptionPane.showMessageDialog(this, message, "Information", JOptionPane.INFORMATION_MESSAGE);
	}

	/*
	public void showDialogFrame(String message, String title) {
		new DialogFrame(title, message);
	}

	public void showDialogFrameError(String message, Exception e) {
		new DialogFrame("Error", "An internal Exception occurred.\n" + message + "\n\n" + e.getClass().getName() + "\n'" + e.getMessage());
	}
	*/

	public void showErrorMessage(String message, boolean concurrent) {
		Runnable r = () -> {
			System.out.println("Error-Message displayed: '" + cropString(message) + "'");
			JOptionPane.showMessageDialog(this, message, "Information", JOptionPane.ERROR_MESSAGE);
		};

		if (concurrent) {
			ExecutorService service = Executors.newFixedThreadPool(1);
			service.submit(r);
		} else r.run();
	}

	public void showErrorMessage(String message) {
		showErrorMessage(message, false);
	}

	public void showErrorMessage(Throwable throwable) {
		showErrorMessage(null, throwable);
	}

	public void showErrorMessage(String message, Throwable exception) {
		if (message == null) {
			message="";
		}

		if (exception instanceof SQLException) {
			if (message.trim().equals("")) {
				showSQLErrorMessage((SQLException) exception);
			} else {
				showSQLErrorMessage(message, (SQLException) exception);
			}
		} else {
			String s = ("\n\n" + message).trim();
			exception.printStackTrace();
			showErrorMessage(
					"An internal Exception occurred.\n" + s + "\n\n" + exception.getClass().getName() + "\n'"
							+ exception.getMessage()
							+ "'\n\nIf this message keeps occurring check your network connection and / or consult your system admin.");
		}
	}

	public void showSQLErrorMessage(String message, SQLException e) {
		e.printStackTrace();
		String s = ("\n\n" + message).trim();
		showErrorMessage(
				"An internal SQL Exception occurred.\n" + s + "\n\n" + e.getMessage()
						+ "\n\nIf this message keeps occurred check your network connection and / or consult your system admin.");
	}

	public void showSQLErrorMessage(SQLException e) {
		showSQLErrorMessage("", e);
	}

	public boolean showConfirmDialog(String message) {
		int i = JOptionPane.showConfirmDialog(this, message, "Please confirm.", JOptionPane.YES_NO_OPTION,
				JOptionPane.INFORMATION_MESSAGE);
		boolean yes = i == JOptionPane.YES_OPTION;
		System.out.println("A Confirm Message was displayed. Confirm-Result: " + yes + ". Message content: '" + cropString(message)
				+ "'.");
		return yes;
	}


	private String cropString(String text) {
		String s = text.replace("\n", " ");
		while (s.contains("  ")) {
			s = s.replaceAll("  ", " ");
		}
		return s.trim();
	}

}
