import java.util.logging.Level;

import com.follett.fsc.core.framework.persistence.UpdateQuery;
import com.follett.fsc.core.k12.tools.procedures.ProcedureJavaSource;
import com.follett.fsc.core.k12.web.UserDataContainer;
import com.x2dev.sis.model.beans.SisStudent;
import com.x2dev.utils.X2BaseException;

/**
 * "Clear Busing Info" procedure will clear the busing import fields()</code>.
 * 
 * --- will not support or modify this tool beyond the original provision.
 * --- is not responsible for the misuse of this tool and/or the resulting
 * outcome of its use.
 * @author JM
 */
public class ClearBusingInfo2 extends ProcedureJavaSource {

    /**
     * @see com.x2dev.sis.tools.procedures.ProcedureJavaSource#execute()
     */
    @Override
    protected void execute() throws Exception {
    	
		/*
		 * Reset all fields specifically assigned below. There is no room for error here.
		 * This tool was specifically built to force class and field declaration, so that
		 * a data restore is not mistakenly required.
		 */
    	 resetFields(SisStudent.class, "fieldB038");
    	 resetFields(SisStudent.class, "fieldB039");
    	 resetFields(SisStudent.class, "fieldA007");
    	 resetFields(SisStudent.class, "fieldA003");
    	 resetFields(SisStudent.class, "fieldA004");
    	 resetFields(SisStudent.class, "fieldA005");
    	 resetFields(SisStudent.class, "fieldD010");
    	 resetFields(SisStudent.class, "fieldA006");
    	 resetFields(SisStudent.class, "fieldD007");
    	 resetFields(SisStudent.class, "fieldA008");
    }

	private int resetFields(Class beanClass, String fieldJavaName) {
		
		int recordsUpdated = 0;
		
        /*
         * For each bean of type beanClass, null the value for that record
         */
		UpdateQuery query = new UpdateQuery(beanClass, null, fieldJavaName, null);
		recordsUpdated = getBroker().executeUpdateQuery(query);
		
		//Update the user right away
		logMessage("Reset " + fieldJavaName + " to null a total of " + String.valueOf(recordsUpdated) + " times.");
		
		//Log the message for historical record keeping.
		logToolMessage(Level.INFO, "Reset " + fieldJavaName + " to null a total of " + String.valueOf(recordsUpdated) + " times.", false);
		
		return recordsUpdated;
	}
	
	@Override
	protected void saveState(UserDataContainer userData) throws X2BaseException {
		
		// We want to update the database from the application directly. Do not send to the report server.
		super.saveState(userData);
		runOnApplicationServer();
	}
}