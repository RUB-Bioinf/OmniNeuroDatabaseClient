package de.rub.bph.omnineuro.client.ui;

import de.rub.bph.omnineuro.client.imported.filemanager.FileManager;
import de.rub.bph.omnineuro.client.imported.log.Log;

import javax.swing.*;
import javax.swing.event.DocumentEvent;
import javax.swing.event.DocumentListener;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.io.File;
import java.io.IOException;

public class FolderChooserPanel extends JPanel implements ActionListener, DocumentListener {
	public static final String CACHE_FILENAME = "source.cache";
	private JTextField textField1;
	private JButton browseBT;
	private JPanel holderPL;
	private JLabel textLB;

	private File cacheFile;

	public FolderChooserPanel(File cacheFile, String label) {
		this("", label);
		Log.i("Starting chooser from a (cache) file: " + cacheFile.getAbsolutePath());

		if (cacheFile.isDirectory()) {
			setText(cacheFile.getAbsolutePath());
			Log.i("Nope, it was just a basic directory. No caching needed.");
		} else {
			this.cacheFile = cacheFile;
			FileManager manager = new FileManager();

			String s;
			try {
				if (!cacheFile.exists()) cacheFile.createNewFile();
				s = manager.readFile(cacheFile);
				Log.i("Reading aforementioned cache: " + s);
			} catch (IOException e) {
				Log.e(e);
				s = "";
			}
			setText(s);

			textField1.getDocument().addDocumentListener(this);
		}
	}

	public FolderChooserPanel() {
		this("", "");
	}

	public FolderChooserPanel(String dirText, String labelText) {
		setText(dirText);
		textLB.setText(labelText);
		browseBT.addActionListener(this);
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

	public String getLabel() {
		return textLB.getText();
	}

	public void setLabel(String text) {
		textLB.setText(text);
	}

	@Override
	public void actionPerformed(ActionEvent actionEvent) {
		browse();
	}

	@Override
	public void insertUpdate(DocumentEvent documentEvent) {
		writeCache(textField1.getText());
	}

	@Override
	public void removeUpdate(DocumentEvent documentEvent) {
		writeCache(textField1.getText());
	}

	@Override
	public void changedUpdate(DocumentEvent documentEvent) {
		writeCache(textField1.getText());
	}

	public void writeCache(String text) {
		if (cacheFile == null) {
			return;
		}
		FileManager manager = new FileManager();
		try {
			manager.writeFile(cacheFile, text);
		} catch (IOException e) {
			Log.e("Failed to write cache file: '" + cacheFile.getAbsolutePath() + "'!", e);
			return;
		}
		Log.i("Chooser cache file: '" + cacheFile.getName() + "' written: '" + text + "'!");
	}
}
