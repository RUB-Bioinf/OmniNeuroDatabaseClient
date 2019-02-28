package de.rub.bph.omnineuro.client.ui;

import javax.swing.*;
import java.awt.*;

public class DialogFrame extends NFrame {
	public DialogFrame(String title, String message, Component parent) {
		setTitle(title);
		GridBagLayout gridBagLayout = new GridBagLayout();
		gridBagLayout.columnWidths = new int[]{0, 0};
		gridBagLayout.rowHeights = new int[]{0, 0};
		gridBagLayout.columnWeights = new double[]{1.0, Double.MIN_VALUE};
		gridBagLayout.rowWeights = new double[]{1.0, Double.MIN_VALUE};
		getContentPane().setLayout(gridBagLayout);

		JScrollPane scrollPane = new JScrollPane();
		scrollPane.setHorizontalScrollBarPolicy(ScrollPaneConstants.HORIZONTAL_SCROLLBAR_NEVER);
		GridBagConstraints gbc_scrollPane = new GridBagConstraints();
		gbc_scrollPane.fill = GridBagConstraints.BOTH;
		gbc_scrollPane.gridx = 0;
		gbc_scrollPane.gridy = 0;
		getContentPane().add(scrollPane, gbc_scrollPane);

		JTextPane txtpnAsdasda = new JTextPane();
		txtpnAsdasda.setText(message);
		txtpnAsdasda.setFont(new Font("Monospaced", Font.PLAIN, 14));
		txtpnAsdasda.setEditable(false);
		scrollPane.setViewportView(txtpnAsdasda);

		pack();
		setLocationRelativeTo(parent);
		setVisible(true);
	}

}
