package de.rub.bph.omnineuro.client.core.sheet.reader.versions.meta;

import de.rub.bph.omnineuro.client.imported.log.Log;
import org.apache.poi.openxml4j.exceptions.InvalidFormatException;
import org.apache.poi.ss.usermodel.FormulaEvaluator;
import org.apache.poi.ss.usermodel.WorkbookFactory;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;

public class ExternalMetadata {
	
	private static ExternalMetadata instance;
	private HashMap<String, FormulaEvaluator> data;
	
	private ExternalMetadata() {
		data = new HashMap<>();
	}
	
	public void init() throws IOException, InvalidFormatException {
		data.clear();
		Log.i("Starting to read external meta data.");
		
		FormulaEvaluator externalEvaluator;
		//externalEvaluator = WorkbookFactory.create(new File("C:\\05_Projects\\EFSA-DNT2\\Experimental work\\15JUN18_Experiments meta data sheet.xlsx")).getCreationHelper().createFormulaEvaluator();
		//externalEvaluator.evaluateAll();
		//workbooks.put("/05_Projects/EFSA-DNT2/Experimental%20work/21JUN19_EFSA_DNT2_Experiment_QS_sheet.xlsx", externalEvaluator);
		
		//externalEvaluator = WorkbookFactory.create(new File("C:\\05_Projects\\EFSA-DNT2\\Experimental work\\15JUN18_Experiments meta data sheet.xlsx")).getCreationHelper().createFormulaEvaluator();
		//externalEvaluator.evaluateAll();
		//workbooks.put("15JUN18_Experiments%20meta%20data%20sheet.xlsx", externalEvaluator);
		//
		//externalEvaluator = WorkbookFactory.create(new File("C:\\05_Projects\\EFSA-DNT2\\Experimental work\\15JUN18_Experiments meta data sheet.xlsx")).getCreationHelper().createFormulaEvaluator();
		//externalEvaluator.evaluateAll();
		//workbooks.put("15JUN18_Experiments meta data sheet.xlsx", externalEvaluator);
		//
		
		//FIXME Hardcoded paths to meta data. This should be done differently.
		externalEvaluator = WorkbookFactory.create(new File("C:\\Users\\nilfoe\\IdeaProjects\\OmniNeuroDatabaseClient\\data\\experiment_meta_data\\15JUN18_Experiments meta data sheet.xlsx")).getCreationHelper().createFormulaEvaluator();
		externalEvaluator.evaluateAll();
		data.put("/05_Projects/EFSA-DNT2/Experimental%20work/15JUN18_Experiments%20meta%20data%20sheet.xlsx", externalEvaluator);
		
		Log.i("Done reading meta data. Key Count: " + data.keySet().size());
	}
	
	public static ExternalMetadata getInstance() {
		if (instance == null) {
			instance = new ExternalMetadata();
		}
		
		return instance;
	}
	
	public HashMap<String, FormulaEvaluator> getMetaData() {
		return new HashMap<>(data);
	}
}
