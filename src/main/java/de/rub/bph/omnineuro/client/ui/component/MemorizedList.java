package de.rub.bph.omnineuro.client.ui.component;

import de.rub.bph.omnineuro.client.imported.log.Log;

import javax.swing.*;
import javax.swing.event.ListSelectionEvent;
import javax.swing.event.ListSelectionListener;
import java.awt.*;
import java.awt.event.KeyAdapter;
import java.awt.event.KeyEvent;
import java.awt.event.MouseAdapter;
import java.awt.event.MouseEvent;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

public class MemorizedList extends JList<String> implements ListSelectionListener {
	
	public static final Color DEFAULT_COLOR_MARKED = Color.BLACK;
	public static final Color DEFAULT_COLOR_UNMARKED = Color.GRAY;
	public static final int KEY_CODE_ENTER = KeyEvent.VK_ENTER;
	private ArrayList<String> entries;
	private boolean[] markedEntries;
	private Color unMarkedColor, markedColor;
	private ArrayList<MarkedSelectionListener> listeners;
	
	public MemorizedList() {
		this(new ArrayList<>());
	}
	
	public MemorizedList(String... entries) {
		this(new ArrayList<String>(Arrays.asList(entries)));
	}
	
	public MemorizedList(ArrayList<String> entries) {
		setEntries(entries);
		setSelectionMode(ListSelectionModel.MULTIPLE_INTERVAL_SELECTION);
		
		setMarkedColor(DEFAULT_COLOR_MARKED);
		setUnMarkedColor(DEFAULT_COLOR_UNMARKED);
		listeners = new ArrayList<>();
		
		setCellRenderer(new MemorizedListRenderer());
		addListSelectionListener(this);
		addMouseListener(new MouseAdapter() {
			@Override
			public void mouseClicked(MouseEvent mouseEvent) {
				super.mouseClicked(mouseEvent);
				int streak = mouseEvent.getClickCount();
				Log.v("The mouse was clicked in a memorized list! Click streak: " + streak);
				
				if (streak % 2 == 0) {
					toggleMarkedSelection();
				}
			}
		});
		addKeyListener(new KeyAdapter() {
			@Override
			public void keyPressed(KeyEvent keyEvent) {
				super.keyPressed(keyEvent);
				int code = keyEvent.getKeyCode();
				Log.v("A key was pressed in a memorized list: " + keyEvent.getKeyChar() + " [" + code + "]");
				if (code == KEY_CODE_ENTER) {
					toggleMarkedSelection();
				}
			}
		});
	}
	
	public void toggleMarkedSelection() {
		for (String s : getSelectedValuesList()) {
			toggleMarked(s);
		}
	}
	
	public boolean toggleMarked(int index) {
		setMarked(!isMarked(index), index);
		return isMarked(index);
	}
	
	public boolean toggleMarked(String element) {
		return toggleMarked(entries.indexOf(element));
	}
	
	public void setMarked(boolean value, List<String> entries) {
		for (String s : entries) {
			setMarked(value, s);
		}
	}
	
	public void setMarked(boolean value, int index) {
		markedEntries[index] = value;
		repaint();
		for (MarkedSelectionListener listener : listeners) {
			listener.onMarkingChange(this);
		}
	}
	
	public void setMarked(boolean value, String... entries) {
		for (String s : entries) {
			setMarked(value, s);
		}
	}
	
	public void setMarked(boolean value, String entry) {
		setMarked(value, entries.indexOf(entry));
	}
	
	public boolean isMarked(int index) {
		return markedEntries[index];
	}
	
	public boolean isMarked(String entry) {
		return isMarked(entries.indexOf(entry));
	}
	
	public void addMarkingListener(MarkedSelectionListener listener) {
		listeners.add(listener);
	}
	
	public boolean removeMarkingListener(MarkedSelectionListener listener) {
		return listeners.remove(listener);
	}
	
	public void clearMarkingListeners() {
		listeners.clear();
	}
	
	@Override
	public void valueChanged(ListSelectionEvent listSelectionEvent) {
		if (!listSelectionEvent.getValueIsAdjusting()) {
			Log.v("The list selection has changed!");
		}
	}
	
	public ArrayList<String> getEntries() {
		return new ArrayList<>(entries);
	}
	
	public void setEntries(String... entries) {
		setEntries(new ArrayList<String>(Arrays.asList(entries)));
	}
	
	public void setEntries(ArrayList<String> entries) {
		this.entries = entries;
		markedEntries = new boolean[entries.size()];
		
		DefaultListModel<String> model = new DefaultListModel<String>();
		for (String s : entries) {
			model.addElement(s);
		}
		setModel(model);
	}
	
	public Color getMarkedColor() {
		return markedColor;
	}
	
	public void setMarkedColor(Color markedColor) {
		this.markedColor = markedColor;
	}
	
	public int getMarkedCount() {
		return getMarkedEntries().size();
	}
	
	public ArrayList<String> getMarkedEntries() {
		ArrayList<String> marks = new ArrayList<>();
		for (int i = 0; i < entries.size(); i++) {
			if (markedEntries[i]) marks.add(entries.get(i));
		}
		return marks;
	}
	
	public Color getUnMarkedColor() {
		return unMarkedColor;
	}
	
	public void setUnMarkedColor(Color unMarkedColor) {
		this.unMarkedColor = unMarkedColor;
	}
	
	private class MemorizedListRenderer extends DefaultListCellRenderer {
		
		public Component getListCellRendererComponent(JList list, Object value, int index, boolean isSelected, boolean cellHasFocus) {
			Component c = super.getListCellRendererComponent(list, value, index, isSelected, cellHasFocus);
			if (isMarked(index)) {
				c.setForeground(markedColor);
			} else {
				c.setForeground(unMarkedColor);
			}
			
			return c;
		}
	}
	
	public interface MarkedSelectionListener {
		
		public void onMarkingChange(MemorizedList source);
	}
	
}
