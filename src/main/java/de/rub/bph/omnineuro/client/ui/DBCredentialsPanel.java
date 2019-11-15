package de.rub.bph.omnineuro.client.ui;

import de.rub.bph.omnineuro.client.imported.filemanager.FileManager;
import de.rub.bph.omnineuro.client.imported.log.Log;
import org.w3c.dom.Document;
import org.xml.sax.SAXException;

import javax.swing.*;
import javax.swing.event.DocumentEvent;
import javax.swing.event.DocumentListener;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;
import java.io.File;
import java.io.IOException;
import java.util.ArrayList;

public class DBCredentialsPanel extends JPanel {
	
	public static final String FILENAME_DB_CREDENTIALS = "db_credentials.xml";
	
	private JTextField hostnameTF;
	private JTextField portTF;
	private JTextField DBNameTF;
	private JTextField usernameTF;
	private JPasswordField PWTF;
	private JPanel holderPL;
	
	private ArrayList<DBCredentialsActionListener> credentialListenerList;
	private ArrayList<DBTextListener> textListenerList;
	
	public DBCredentialsPanel() {
		hostnameTF.addActionListener(actionEvent -> onAction());
		hostnameTF.getDocument().addDocumentListener(new DocumentListener() {
			@Override
			public void insertUpdate(DocumentEvent documentEvent) {
				onTextChange();
			}
			
			@Override
			public void removeUpdate(DocumentEvent documentEvent) {
				onTextChange();
			}
			
			@Override
			public void changedUpdate(DocumentEvent documentEvent) {
				onTextChange();
			}
		});
		
		portTF.addActionListener(actionEvent -> onAction());
		portTF.getDocument().addDocumentListener(new DocumentListener() {
			@Override
			public void insertUpdate(DocumentEvent documentEvent) {
				onTextChange();
			}
			
			@Override
			public void removeUpdate(DocumentEvent documentEvent) {
				onTextChange();
			}
			
			@Override
			public void changedUpdate(DocumentEvent documentEvent) {
				onTextChange();
			}
		});
		
		DBNameTF.addActionListener(actionEvent -> onAction());
		DBNameTF.getDocument().addDocumentListener(new DocumentListener() {
			@Override
			public void insertUpdate(DocumentEvent documentEvent) {
				onTextChange();
			}
			
			@Override
			public void removeUpdate(DocumentEvent documentEvent) {
				onTextChange();
			}
			
			@Override
			public void changedUpdate(DocumentEvent documentEvent) {
				onTextChange();
			}
		});
		
		usernameTF.addActionListener(actionEvent -> onAction());
		usernameTF.getDocument().addDocumentListener(new DocumentListener() {
			@Override
			public void insertUpdate(DocumentEvent documentEvent) {
				onTextChange();
			}
			
			@Override
			public void removeUpdate(DocumentEvent documentEvent) {
				onTextChange();
			}
			
			@Override
			public void changedUpdate(DocumentEvent documentEvent) {
				onTextChange();
			}
		});
		
		PWTF.addActionListener(actionEvent -> onAction());
		PWTF.getDocument().addDocumentListener(new DocumentListener() {
			@Override
			public void insertUpdate(DocumentEvent documentEvent) {
				onTextChange();
			}
			
			@Override
			public void removeUpdate(DocumentEvent documentEvent) {
				onTextChange();
			}
			
			@Override
			public void changedUpdate(DocumentEvent documentEvent) {
				onTextChange();
			}
		});
		
		credentialListenerList = new ArrayList<>();
		textListenerList = new ArrayList<>();
		
		File credentialsFile = getCredentialsFile();
		if (credentialsFile.exists()) {
			try {
				readCredentialFile(credentialsFile);
			} catch (ParserConfigurationException | IOException | SAXException e) {
				Log.e("Failed to read provided credential file: " + credentialsFile.getAbsolutePath(), e);
			}
		} else {
			Log.e("DB Credentials file not found. You could add your own if it had this path: " + credentialsFile.getAbsolutePath());
		}
	}
	
	private void readCredentialFile(File credentialsFile) throws ParserConfigurationException, IOException, SAXException {
		DocumentBuilderFactory documentBuilderFactory = DocumentBuilderFactory.newInstance();
		DocumentBuilder documentBuilder = documentBuilderFactory.newDocumentBuilder();
		Document document = documentBuilder.parse(credentialsFile);
		
		extractCredential(document, "Location", hostnameTF);
		extractCredential(document, "Port", portTF);
		extractCredential(document, "DBName", DBNameTF);
		extractCredential(document, "Username", usernameTF);
		extractCredential(document, "Password", PWTF);
	}
	
	private void extractCredential(Document document, String tag, JTextField textField) {
		try {
			String location = document.getElementsByTagName(tag).item(0).getTextContent();
			textField.setText(location);
			Log.i("Extracted field '" + tag + "' from credentials without problems!");
		} catch (Exception e) {
			Log.e(e);
		}
	}
	
	private void onAction() {
		for (DBCredentialsActionListener listener : credentialListenerList) {
			listener.onAction();
		}
	}
	
	private void onTextChange() {
		for (DBTextListener listener : textListenerList) {
			listener.onTextChange(getHostname(), getPort(), getDatabaseName(), getUserName(), getPassword());
		}
	}
	
	public void addActionListener(DBCredentialsActionListener listener) {
		credentialListenerList.add(listener);
	}
	
	public void addTextListener(DBTextListener listener) {
		textListenerList.add(listener);
	}
	
	public boolean isModified(DBCredentialsPanel data) {
		return false;
	}
	
	public static File getCredentialsFile() {
		FileManager manager = new FileManager();
		return new File(manager.getExternalDir(), FILENAME_DB_CREDENTIALS);
	}
	
	public String getDatabaseName() {
		return DBNameTF.getText();
	}
	
	public String getHostname() {
		return hostnameTF.getText();
	}
	
	public String getPassword() {
		return String.valueOf(PWTF.getPassword());
	}
	
	public String getPort() {
		return portTF.getText();
	}
	
	public String getUserName() {
		return usernameTF.getText();
	}
	
	public interface DBCredentialsActionListener {
		
		void onAction();
	}
	
	public interface DBTextListener {
		
		void onTextChange(String hostname, String port, String databaseName, String username, String password);
	}
}



