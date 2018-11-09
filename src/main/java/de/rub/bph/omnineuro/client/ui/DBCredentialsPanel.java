package de.rub.bph.omnineuro.client.ui;

import javax.swing.*;
import javax.swing.event.DocumentEvent;
import javax.swing.event.DocumentListener;
import java.util.ArrayList;

public class DBCredentialsPanel extends JPanel {
	private JTextField hostnameTF;
	private JTextField portTF;
	private JTextField DBNameTF;
	private JTextField usernameTF;
	private JPasswordField PWTF;
	private JPanel holderPL;

	private ArrayList<DBCredentialsActionListener> credentialListenerList;
	private ArrayList<DBTextListener> actionListenerList;

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
		actionListenerList = new ArrayList<>();
	}

	private void onAction() {
		for (DBCredentialsActionListener listener : credentialListenerList) {
			listener.onAction();
		}

		for (DBCredentialsActionListener listener : credentialListenerList) {
			listener.onAction();
		}
	}

	private void onTextChange() {
		for (DBTextListener listener : actionListenerList) {
			listener.onTextChange();
		}
	}

	public void addActionListener(DBCredentialsActionListener listener) {
		credentialListenerList.add(listener);
	}

	public void addActionListener(DBTextListener listener) {
		actionListenerList.add(listener);
	}

	public void setData(DBCredentialsPanel data) {
	}

	public void getData(DBCredentialsPanel data) {
	}

	public boolean isModified(DBCredentialsPanel data) {
		return false;
	}

	public static interface DBCredentialsActionListener {
		public void onAction();
	}

	public static interface DBTextListener {
		public void onTextChange();
	}
}



