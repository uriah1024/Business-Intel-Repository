import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.Collection;
import java.util.LinkedList;

import org.apache.commons.lang3.StringUtils;
import org.apache.ojb.broker.query.Criteria;

import com.follett.fsc.core.framework.persistence.SubQuery;
import com.follett.fsc.core.k12.beans.X2BaseBean;
import com.follett.fsc.core.k12.tools.procedures.ProcedureJavaSource;
import com.x2dev.sis.model.beans.GradebookColumnDefinition;
import com.x2dev.sis.model.beans.GradebookColumnType;

public class FixMisAlignedAssignments extends ProcedureJavaSource
{
    private static final String QUERY_MISALIGNED_ASSIGNMENTS = "SELECT GCD_OID, SKL_SCHOOL_NAME, MST_COURSE_VIEW, STF_NAME_VIEW, GCD_COLUMN_NAME FROM GRADEBOOK_COLUMN_DEFINITION \n" + 
                                                               "INNER JOIN STAFF ON GCD_STF_OID = STF_OID\n" + 
                                                               "INNER JOIN SCHEDULE_MASTER ON GCD_MST_OID = MST_OID\n" + 
                                                               "INNER JOIN COURSE_SCHOOL ON MST_CSK_OID = CSK_OID\n" + 
                                                               "INNER JOIN SCHOOL ON CSK_SKL_OID = SKL_OID\n" + 
                                                               "INNER JOIN GRADEBOOK_COLUMN_TYPE ON GCD_GCT_OID = GCT_OID\n" + 
                                                               "WHERE GCD_MST_OID <> GCT_MST_OID AND GCD_LAST_MODIFIED > '1438464367000'\n" + 
                                                               "ORDER BY STF_NAME_VIEW, SKL_SCHOOL_NAME, MST_COURSE_VIEW";

    /**
     * @see com.follett.fsc.core.k12.tools.procedures.ProcedureJavaSource#execute()
     */
    @Override
    protected void execute() throws Exception
    {

    	boolean previewMode = ((Boolean) getParameter("previewOnly")).booleanValue();

        int matchesFound = 0;
        int updated = 0;
        int skipped = 0;
        
        Collection<String> assignmentsToFix = new LinkedList<String>(); 
        Connection dbConnection = getBroker().borrowConnection();
        
        logMessage("Assignments needing repair: \r\n");
        try
        {
            Statement dbStatement = dbConnection.createStatement();
            ResultSet results = dbStatement.executeQuery(QUERY_MISALIGNED_ASSIGNMENTS);
                    
            try
            {
                while (results.next())
                {
                    String gcdOid = results.getString(1);
                    assignmentsToFix.add(gcdOid);
                    matchesFound++;
                    
                    logMessage(results.getString(1) + ", " + 
	                    	   results.getString(2) + ", " + 
	                    	   results.getString(3) + ", " + 
	                    	   results.getString(4) + ", " + 
	                    	   results.getString(5));
                }
            }
            finally
            {
                results.close();
            }   
        }
        finally
        {
            if (dbConnection != null)
            {
                getBroker().returnConnection();
            }
        }
        
        logMessage("\r\n\r\n Running updates... " + (previewMode ? "[PREVIEW ONLY]" : "") + "\r\n");
        
        for (String gcdOid : assignmentsToFix)
        {
            GradebookColumnDefinition assignment = (GradebookColumnDefinition) getBroker().getBeanByOid(GradebookColumnDefinition.class, gcdOid);
            
            String sectionOid = assignment.getMasterScheduleOid();
            GradebookColumnType badCategory = assignment.getColumnType();
            
            Criteria correctCategoryCriteira = new Criteria();
            correctCategoryCriteira.addEqualTo(GradebookColumnType.COL_COLUMN_TYPE, badCategory.getColumnType());
            correctCategoryCriteira.addEqualTo(GradebookColumnType.COL_MASTER_SCHEDULE_OID, sectionOid);
            
            SubQuery correctCategoryQuery = new SubQuery(GradebookColumnType.class, X2BaseBean.COL_OID, correctCategoryCriteira);
            String correctCategoryOid = (String) getBroker().getSubQueryValueByQuery(correctCategoryQuery);
            
            if (!StringUtils.isEmpty(correctCategoryOid))
            {
                assignment.setColumnTypeOid(correctCategoryOid);
                
                if (!previewMode)
                {
                	getBroker().saveBeanForced(assignment);
                	updated++;
                }
                logMessage("Updated assignment '" + assignment.getOid() + "' to have category '" + correctCategoryOid + "'");
            }
            else
            {
                logMessage("Unable to find matching category for  assignment '" + assignment.getOid() + "', category name of '" + badCategory.getColumnType() + "'");
                skipped++;
            }
        }
        
        logMessage("\r\n\r\nSummary - found " + matchesFound + " impacted assignments, " + updated + " assignments updated, " + skipped + " assignments skipped.");
    }
}