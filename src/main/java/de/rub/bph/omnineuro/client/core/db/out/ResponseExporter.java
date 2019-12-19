package de.rub.bph.omnineuro.client.core.db.out;

import de.rub.bph.omnineuro.client.core.db.DBConnection;

import java.io.File;
import java.util.ArrayList;

public abstract class ResponseExporter extends SheetExporter {
	
	protected ArrayList<Long> responseIDs;
	
	public ResponseExporter(File targetDir, DBConnection connection, ArrayList<Long> responseIDs, boolean useComma) {
		super(targetDir, connection, useComma);
		this.responseIDs = responseIDs;
	}
	
	public ArrayList<Long> getResponseIDs() {
		return responseIDs;
	}
}
