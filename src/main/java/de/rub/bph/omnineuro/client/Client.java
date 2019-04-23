package de.rub.bph.omnineuro.client;

import de.rub.bph.omnineuro.client.imported.log.Log;
import de.rub.bph.omnineuro.client.ui.DialogFrame;
import de.rub.bph.omnineuro.client.ui.OmniFrame;

import javax.swing.*;
import java.awt.*;
import java.sql.SQLException;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

public class Client {

	public static final String VERSION = "0.1";
	public static final String TITLE = "OmniNeuro Databasse client";

	public static void main(String[] args) {
		SwingUtilities.invokeLater(() -> {
			try {
				UIManager.setLookAndFeel(UIManager.getSystemLookAndFeelClassName());
			} catch (ClassNotFoundException | InstantiationException | UnsupportedLookAndFeelException
					| IllegalAccessException e) {
				e.printStackTrace();
			}
			Log.i("Initialling Client Frame");
			new OmniFrame();
		});
	}

	public static void showInfoMessage(String message, Component parent) {
		Log.i("Info-Message displayed: '" + cropString(message) + "'");
		JOptionPane.showMessageDialog(parent, message, "Information", JOptionPane.INFORMATION_MESSAGE);
	}

	public static void showDialogFrame(String message, String title, Component parent) {
		new DialogFrame(title, message, parent);
	}

	public static void showDialogFrameError(String message, Exception e, Component parent) {
		new DialogFrame("Error", "An internal Exception occurred.\n" + message + "\n\n" + e.getClass().getName() + "\n'" + e.getMessage(), parent);
	}

	public static void showErrorMessage(String message, Component parent, boolean concurrent) {
		Runnable r = () -> {
			Log.i("Error-Message displayed: '" + cropString(message) + "'");
			JOptionPane.showMessageDialog(parent, message, "Information", JOptionPane.ERROR_MESSAGE);
		};

		if (concurrent) {
			ExecutorService service = Executors.newFixedThreadPool(1);
			service.submit(r);
		} else r.run();
	}

	public static void showErrorMessage(String message, Component parent) {
		showErrorMessage(message, parent, false);
	}

	public static void showErrorMessage(String message, Component parent, Throwable exception) {
		if (exception instanceof SQLException) {
			if (message.trim().equals("")) {
				showSQLErrorMessage((SQLException) exception, parent);
			} else {
				showSQLErrorMessage(message, (SQLException) exception, parent);
			}
		} else {
			String s = ("\n\n" + message).trim();
			exception.printStackTrace();
			showErrorMessage(
					"An internal Exception occurred.\n" + s + "\n\n" + exception.getClass().getName() + "\n'"
							+ exception.getMessage()
							+ "'\n\nIf this message keeps occurring check your network connection and / or consult your system admin.",
					parent);
		}
	}

	public static void showSQLErrorMessage(String message, SQLException e, Component parent) {
		e.printStackTrace();
		String s = ("\n\n" + message).trim();
		showErrorMessage(
				"An internal SQL Exception occurred.\n" + s + "\n\n" + e.getMessage()
						+ "\n\nIf this message keeps occurred check your network connection and / or consult your system admin.",
				parent);
	}

	public static void showSQLErrorMessage(SQLException e, Component parent) {
		showSQLErrorMessage("", e, parent);
	}

	public static boolean showConfirmDialog(String message, Component parent) {
		int i = JOptionPane.showConfirmDialog(parent, message, "Please confirm.", JOptionPane.YES_NO_OPTION,
				JOptionPane.INFORMATION_MESSAGE);
		boolean yes = i == JOptionPane.YES_OPTION;
		Log.i("A Confirm Message was displayed. Confirm-Result: " + yes + ". Message content: '" + cropString(message)
				+ "'.");
		return yes;
	}

	public static String cropString(String text) {
		String s = text.replace("\n", " ");
		while (s.contains("  ")) {
			s = s.replaceAll("  ", " ");
		}
		return s.trim();
	}

}
