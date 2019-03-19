package de.rub.bph.omnineuro.client.ui;

import de.rub.bph.omnineuro.client.Client;
import de.rub.bph.omnineuro.client.imported.log.Log;

import javax.swing.*;
import java.awt.event.*;

public class ExportDialog extends JDialog {
	private JPanel contentPane;
	private JButton buttonOK;
	private JButton buttonCancel;
	private JTextField textField1;

	public ExportDialog() {
		setContentPane(contentPane);
		setModal(true);
		getRootPane().setDefaultButton(buttonOK);
		setTitle(Client.TITLE+": Export");

		buttonOK.addActionListener(e -> onOK());

		buttonCancel.addActionListener(e -> onCancel());

		// call onCancel() when cross is clicked
		setDefaultCloseOperation(DO_NOTHING_ON_CLOSE);
		addWindowListener(new WindowAdapter() {
			public void windowClosing(WindowEvent e) {
				onCancel();
			}
		});

		// call onCancel() on ESCAPE
		contentPane.registerKeyboardAction(e -> onCancel(), KeyStroke.getKeyStroke(KeyEvent.VK_ESCAPE, 0), JComponent.WHEN_ANCESTOR_OF_FOCUSED_COMPONENT);

		pack();
		setMinimumSize(getSize());
	}

	private void onOK() {
		Log.i("User pressed 'OK'!");
		// add your code here
		dispose();
	}

	private void onCancel() {
		Log.i("User canceled everything!");
		// add your code here if necessary
		dispose();
	}

	public static void main(String[] args) {
		ExportDialog dialog = new ExportDialog();
		dialog.pack();
		dialog.setVisible(true);
		System.exit(0);
	}
}
