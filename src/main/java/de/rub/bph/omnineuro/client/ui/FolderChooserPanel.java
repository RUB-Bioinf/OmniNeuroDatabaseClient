package de.rub.bph.omnineuro.client.ui;

import de.rub.bph.omnineuro.client.imported.filemanager.FileManager;
import de.rub.bph.omnineuro.client.imported.log.Log;

import javax.swing.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.io.File;
import java.io.IOException;

public class FolderChooserPanel extends JPanel {
	private JTextField textField1;
	private JButton browseBT;
	private JPanel holderPL;

	public FolderChooserPanel(File file) {
		if (file.isDirectory()) {
			setText(file.getAbsolutePath());
		} else {
			FileManager manager = new FileManager();
			String s;
			try {
				s = manager.readFile(file);
			} catch (IOException e) {
				Log.e(e);
				s = "";
			}
			setText(s);
		}
	}

	public FolderChooserPanel() {
		this("", "");
		browseBT.addActionListener(new ActionListener() {

			@Override
			public void actionPerformed(ActionEvent actionEvent) {
				browse();
			}
		});
	}

	public FolderChooserPanel(String text, String test2) {
		Log.i("Oh boi, setting da text: " + text);
		setText(text);
	}

	private void browse() {
		JFileChooser chooser = new JFileChooser();
		chooser.setCurrentDirectory(new File(getText()));
		chooser.setFileSelectionMode(JFileChooser.DIRECTORIES_ONLY);
		int response = chooser.showOpenDialog(this);
		if (response == JFileChooser.APPROVE_OPTION) {
			setText(chooser.getSelectedFile().getAbsolutePath());
		}
	}

	public String getText() {
		return textField1.getText();
	}

	public void setText(String text) {
		textField1.setText(text);
	}
}
