package de.rub.bph.omnineuro.client.ui;

import de.rub.bph.omnineuro.client.core.db.OmniNeuroQueryExecutor;

import javax.swing.*;
import java.awt.*;

public class ExportConfigFrame extends JFrame {

	OmniNeuroQueryExecutor queryExecutor;
	private JPanel rootPanel;

	public ExportConfigFrame(Component parent, OmniNeuroQueryExecutor queryExecutor) {
		this.queryExecutor = queryExecutor;
		add(rootPanel);
		setTitle("Experiment configuration editor");

		pack();
		setMinimumSize(getSize());
		setLocationRelativeTo(parent);
		setVisible(true);
	}

}
