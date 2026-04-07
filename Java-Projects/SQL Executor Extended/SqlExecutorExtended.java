/*
* ====================================================================
 * Procedure to execute a user-entered query. The procedure handles SELECT,
 * UPDATE, and DELETE queries. It is not intended to be used for INSERT queries.
 * <p>
 * The results of an UPDATE and DELETE query are given in the number of rows
 * effected.
 * <p>
 * The results of a SELECT query are displayed to the user in a grid display on
 * the output.
* ====================================================================
*/

package com.jm2.tools;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.List;
import java.util.regex.Pattern;

import com.follett.fsc.core.k12.beans.User;
import com.follett.fsc.core.k12.business.ModelBroker;
import com.follett.fsc.core.k12.tools.procedures.ProcedureJavaSource;
import com.follett.fsc.core.k12.web.AppConstants;
import com.follett.fsc.core.k12.web.AppGlobals;
import com.x2dev.utils.DataGrid;

/**
 * @author JM
 */
public class SqlExecuter extends ProcedureJavaSource {
	/**
	 * Name for the "query type" input parameter. This value is a String.
	 */
	public static final String QUERY_TYPE_PARAM = "queryType";

	/**
	 * Name for the "refresh cache" input parameter. This value is a Boolean.
	 */
	public static final String REFRESH_CACHE_PARAM = "refresh";

	/**
	 * Name for the user-entered SQL parameter. This value is a String.
	 */
	public static final String SQL_INPUT_PARAM = "sql";

	/**
	 * Name for user-entered Row Limiter parameter. It's a String
	 */
	public static final String SQL_LIMITER_INPUT = "limiter";
	
	/*
	 * Name for user account authorized to run this tool. String
	 */
	public static final String AUTH_LOGIN_ID_PARAM = "";

	/*
	 * Additional constants
	 */
	private static final String SPACE = " ";
	private static final Pattern WHITESPACE_PATTERN = Pattern.compile("\\s+");

	public enum QueryType {
		SELECT, UPDATE, DELETE, INSERT
	}

	/**
	 * @see com.x2dev.sis.tools.procedures.ProcedureJavaSource#execute()
	 */
	@Override
	protected void execute() throws Exception {
		String sql = (String) getParameter(SQL_INPUT_PARAM);
		sql = WHITESPACE_PATTERN.matcher(sql).replaceAll(SPACE);

		QueryType queryType = QueryType.valueOf((String) getParameter(QUERY_TYPE_PARAM));

		Connection connection = null;
		String deploymentId = getBroker().getPersistenceKey().getDeploymentId();
		String aspensupport = AppGlobals.getConfigProperty(AppConstants.MONITOR_USER, deploymentId);
		if (getUser().getLoginName().equals(aspensupport) || getUser().getLoginName().equals(AUTH_LOGIN_ID_PARAM)) {
			try {
				connection = getBroker().borrowConnection();
				Statement statement = connection.createStatement();
				
				switch (queryType) {
				case SELECT:
					ResultSet results = statement.executeQuery(sql);
					
					DataGrid grid = new DataGrid();
					grid.append(results);
					grid.beforeTop();
					
					/*
					 * Go through the grid and set all the null values to have a
					 * string value of "NULL". Otherwise, it will be impossible to
					 * distinguish between blanks and nulls in the results.
					 */
					List<String> columnHeaders = grid.getColumns();
					while (grid.next()) {
						for (String columnHeader : columnHeaders) {
							if (grid.get(columnHeader) == null) {
								grid.set(columnHeader, "NULL");
							}
						}
					}
					
					grid.beforeTop();
					
					String count = (String) getParameter(SQL_LIMITER_INPUT);
					logMessage(grid.format(false, false, false, Integer.valueOf(count)));
					break;
					
				case INSERT:
					boolean result = statement.execute(sql);
					logMessage("Insert result: " + result);
					break;
					
				case UPDATE:
				case DELETE:
					int updated = 0;
					updated = statement.executeUpdate(sql);
					logMessage(updated + " row(s) affected");
					break;
				}
			} catch (SQLException sqle) {
				logMessage(sqle.toString());
			} finally {
				if (connection != null) {
					getBroker().returnConnection();
				}
			}
		} else {
			logMessage("You are not authorized to run this tool.");
		}

		if ((Boolean) getParameter(REFRESH_CACHE_PARAM)) {
			(new ModelBroker(getPrivilegeSet())).clearCache();
		}
	}

	/* (non-Javadoc)
	 * @see com.follett.fsc.core.k12.tools.ToolJavaSource#getUser()
	 */
	@Override
	protected User getUser() {
		return super.getUser();
	}
}