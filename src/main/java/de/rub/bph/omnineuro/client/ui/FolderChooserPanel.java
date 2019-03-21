package de.rub.bph.omnineuro.client.ui;

import de.rub.bph.omnineuro.client.Client;
import de.rub.bph.omnineuro.client.imported.filemanager.FileManager;
import de.rub.bph.omnineuro.client.imported.log.Log;

import javax.swing.*;
import javax.swing.event.DocumentEvent;
import javax.swing.event.DocumentListener;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.io.File;
import java.io.IOException;

public class FolderChooserPanel extends JPanel implements DocumentListener {
	public static final String CACHE_IMPORT_SOURCE_DIR_FILENAME = "db_import_source_dir.cache";
	public static final String CACHE_EXPORT_DIR_FILENAME = "db_export_dir.cache";
	private JTextField textField1;
	private JButton chooseBT;
	private JPanel holderPL;
	private JLabel textLB;
	private JButton browseBT;

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
		browseBT.addActionListener(new ActionListener() {
			@Override
			public void actionPerformed(ActionEvent actionEvent) {
				browseDirectory();
			}
		});
		chooseBT.addActionListener(new ActionListener() {
			@Override
			public void actionPerformed(ActionEvent actionEvent) {
				chooseDirectory();
			}
		});
	}

	public void browseDirectory() {
		File dir = new File(getText());
		Log.i("Attempting to browse directory: " + dir.getAbsolutePath());

		if (!dir.exists()) {
			Client.showErrorMessage("Please select a valid directory path, accessible by this device.", this);
			return;
		}
		if (!dir.isDirectory()) {
			Client.showErrorMessage("The selected file is not a valid folder.", this);
			return;
		}

		if (!Desktop.isDesktopSupported()) {
			Client.showErrorMessage("This device does not support browsing a file!", this);
			return;
		}
		try {
			Desktop d = Desktop.getDesktop();
			d.open(dir);
		} catch (Throwable e) {
			Log.e(e);
			Client.showErrorMessage("Failed to browse the directory", this, e);
		}
	}

	private void chooseDirectory() {
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
		} catch (Throwable e) {
			Log.e("Failed to write cache file: '" + cacheFile.getAbsolutePath() + "'!", e);
			return;
		}
		Log.i("Chooser cache file: '" + cacheFile.getName() + "' written: '" + text + "'!");
	}
}
