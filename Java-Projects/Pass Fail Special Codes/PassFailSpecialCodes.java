import static com.follett.fsc.core.k12.business.ModelProperty.PATH_DELIMITER;

import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Set;

import org.apache.commons.lang.exception.ExceptionUtils;
import org.apache.ojb.broker.query.Criteria;
import org.apache.ojb.broker.query.QueryByCriteria;

import com.follett.fsc.core.framework.persistence.BeanQuery;
import com.follett.fsc.core.framework.persistence.X2Criteria;
import com.follett.fsc.core.k12.beans.Person;
import com.follett.fsc.core.k12.beans.ReferenceCode;
import com.follett.fsc.core.k12.beans.SystemPreferenceDefinition;
import com.follett.fsc.core.k12.beans.User;
import com.follett.fsc.core.k12.beans.X2BaseBean;
import com.follett.fsc.core.k12.business.PreferenceManager;
import com.follett.fsc.core.k12.business.X2Broker;
import com.follett.fsc.core.k12.tools.procedures.ProcedureJavaSource;
import com.x2dev.sis.model.beans.GradebookSpecialCode;
import com.x2dev.sis.model.beans.SisStaff;
import com.x2dev.utils.StringUtils;
import com.x2dev.utils.ThreadUtils;
import com.x2dev.utils.X2BaseException;

public class PassFailSpecialCodes extends ProcedureJavaSource {
	/*
	 * Input indicators
	 */
	private static final String STAFF_TYPE_IND_PARAM = "staffTypeIND";
	private static final String STAFF_BARGAINING_IND_PARAM = "staffBargainUnitIND";
	private static final String STAFF_DEPARTMENT_IND_PARAM = "staffDepartmentIND";

	/*
	 * Input selectors
	 */
	private static final String PARAM_SCHOOL_OIDS = "schoolOids";
	private static final String STAFF_TYPE_PARAM = "staffType";
	private static final String STAFF_BARGAIN_PARAM = "staffBargainUnit";
	private static final String STAFF_DEPARTMENT_PARAM = "staffDepartmentCode";
	private static final String SPECIAL_CODE_PASS_PARAM = "specialCodePass";
	private static final String SPECIAL_CODE_FAIL_PARAM = "specialCodeFail";
	private ArrayList<String> m_schoolOids;
	private ArrayList<String> m_staffType;
	private ArrayList<String> m_staffBargainUnits;
	private ArrayList<String> m_staffDepartment;
	private HashMap<String, Collection<GradebookSpecialCode>> m_specialCodeByColumn = new HashMap<String, Collection<GradebookSpecialCode>>();

	// Preview Mode
	private static final String PREVIEW_MODE = "previewMode";

	// Verbose Logging
	private static final String VERBOSE_PARAM = "verboseLogging";

	private X2Broker m_broker;

	/*
	 * (non-Javadoc)
	 *
	 * @see com.follett.fsc.core.k12.tools.ToolJavaSource#initialize()
	 */
	@Override
	protected void initialize() throws X2BaseException {
		m_broker = getBroker();
		// Get user input for security roles to modify
		m_staffType = StringUtils.convertDelimitedStringToList((String) getParameter(STAFF_TYPE_PARAM), ',', true);
		m_staffBargainUnits = StringUtils.convertDelimitedStringToList((String) getParameter(STAFF_BARGAIN_PARAM), ',',
				true);
		m_staffDepartment = StringUtils.convertDelimitedStringToList((String) getParameter(STAFF_DEPARTMENT_PARAM), ',',
				true);
		m_schoolOids = StringUtils.convertDelimitedStringToList((String) getParameter(PARAM_SCHOOL_OIDS), ',', true);
	}

	/*
	 * (non-Javadoc)
	 *
	 * @see
	 * com.follett.fsc.core.k12.tools.procedures.ProcedureJavaSource#execute()
	 */
	@Override
	protected void execute() throws Exception {
		String specialCodePassValue = ((String) getParameter(SPECIAL_CODE_PASS_PARAM));
		String specialCodeFailValue = ((String) getParameter(SPECIAL_CODE_FAIL_PARAM));

		// If no codes were supplied, do no further work.
		if (StringUtils.isBlank(specialCodePassValue) && StringUtils.isBlank(specialCodeFailValue)) {
			String message = "This tool is intended to generate at least one code. "
					+ "Please supply a code when running this tool.\n\n";
			throw new NullPointerException(message);
		}

		boolean preview = ((Boolean) getParameter(PREVIEW_MODE)).booleanValue();
		boolean verbose = ((Boolean) getParameter(VERBOSE_PARAM)).booleanValue();

		if (preview) {
			logMessage("Running Procedure in ***PREVIEW MODE***");
		} else {
			logMessage("Running Procedure");
		}
		// Prepare SQL based on inputs
		String activeStaff = PreferenceManager.getPreferenceValue(getOrganization(),
				SystemPreferenceDefinition.STAFF_ACTIVE_CODE);
		boolean staffTypeIND = ((Boolean) getParameter(STAFF_TYPE_IND_PARAM)).booleanValue();
		boolean staffBargainIND = ((Boolean) getParameter(STAFF_BARGAINING_IND_PARAM)).booleanValue();
		boolean staffDeptIND = ((Boolean) getParameter(STAFF_DEPARTMENT_IND_PARAM)).booleanValue();

		/*
		 * Query for all active teachers at user selected schools
		 */
		X2Criteria criteria = new X2Criteria();
		criteria.addEqualTo(SisStaff.COL_STATUS, activeStaff);
		criteria.addEqualTo(
				SisStaff.REL_PERSON + PATH_DELIMITER + Person.REL_USER + PATH_DELIMITER + User.COL_LOGIN_STATUS, 0);
		if (!m_schoolOids.isEmpty()) {
			criteria.addIn(SisStaff.COL_SCHOOL_OID, m_schoolOids);
		}
		if (staffTypeIND) {
			criteria.addIn(SisStaff.COL_STAFF_TYPE, loadReferenceCodes(m_staffType));
		}
		if (staffBargainIND) {
			criteria.addIn(SisStaff.COL_BARGAINING_UNIT, loadReferenceCodes(m_staffBargainUnits));
		}
		if (staffDeptIND) {
			criteria.addIn(SisStaff.COL_DEPARTMENT_CODE, loadReferenceCodes(m_staffDepartment));
		}

		QueryByCriteria query = new QueryByCriteria(SisStaff.class, criteria);
		Collection<SisStaff> teachers = m_broker.getCollectionByQuery(query);
		if (verbose) {
//			logMessage("Executed Query:\n" + m_broker.getSelectSql(query) + "\n");
			logMessage("Criteria:\n" + criteria.toString() + "\n");
		}

		int count = m_broker.getCount(query);
		String passValue = "";
		String failValue = "";
		if (StringUtils.isBlank(specialCodePassValue)) {
			passValue = "<blank>";
		} else {
			passValue = specialCodePassValue;
		}
		if (StringUtils.isBlank(specialCodeFailValue)) {
			failValue = "<blank>";
		} else {
			failValue = specialCodeFailValue;
		}
		logMessage(count + " staff found based on your input. " + "Adding " + passValue + " and " + failValue
				+ " codes for staff.\n");
		if (preview) {
			logMessage("\n\t***Preview Mode: These records were not saved.***\n\t");
		}

		boolean success = false;
		m_broker.beginTransaction();
		ThreadUtils.checkInterrupt();
		try {
			/*
			 * We need to first check to see if the code we're going to generate
			 * already exists. If it does, we need to stop generating a code for
			 * that staff and report to the user running the tool that the staff
			 * has a matching code that may be for either the same purpose, or a
			 * different one, and to contact them regarding the code.
			 */
			for (SisStaff staff : teachers) {
				ThreadUtils.checkInterrupt();
				String name = staff.getNameView();
				logMessage(name + ": Processing...");
				// Static values to populate records for creation.
				int exemptFromCalculations = GradebookSpecialCode.BEHAVIOR_EXEMPT;
				String color = "#6666FF"; // default
				boolean missingIndicator = false;
				String shortcut = null;
				String staffOid = staff.getOid();

				if (verbose) {
					logMessage("Analyzing existing special codes for this staff....");
				}
				// Assume no matches exist unless proven otherwise.
				boolean noPassMatch = true;
				boolean noFailMatch = true;
				Collection<GradebookSpecialCode> existingCodes = getSpecialCodes(staffOid);
				for (GradebookSpecialCode code : existingCodes) {
					ThreadUtils.checkInterrupt();

					if (StringUtils.isBlank(specialCodePassValue)) {
						noPassMatch = false;
					} else {
						if ((code.getCode().contains(specialCodePassValue)
								|| code.getCode().equals(specialCodePassValue))
								&& code.getBehavior() == exemptFromCalculations
								&& code.getMissingIndicator() == false) {
							logMessage("\n***A matching or similar PASS code was found for " + name + "."
									+ " Please review or contact this staff to determine the purpose of this code."
									+ " No PASS record will be created for this staff.***\n");
							noPassMatch = false;
						}
					}
					if (StringUtils.isBlank(specialCodeFailValue)) {
						noFailMatch = false;
					} else {
						if ((code.getCode().contains(specialCodeFailValue)
								|| code.getCode().equals(specialCodeFailValue))
								&& code.getBehavior() == exemptFromCalculations
								&& code.getMissingIndicator() == false) {
							logMessage("\n***A matching or similar FAIL code was found for " + name + "."
									+ " Please review or contact this staff to determine the purpose of this code."
									+ " No FAIL record will be created for this staff.***\n");
							noFailMatch = false;
						}
					}
				}

				if (noPassMatch) {
					GradebookSpecialCode specialCodePass = X2BaseBean.newInstance(GradebookSpecialCode.class,
							m_broker.getPersistenceKey());
					specialCodePass.setBehavior(exemptFromCalculations);
					specialCodePass.setCode(specialCodePassValue);
					specialCodePass.setColor(color);
					specialCodePass.setMissingIndicator(missingIndicator);
					specialCodePass.setShortcut(shortcut);
					specialCodePass.setStaffOid(staffOid);
					if (verbose) {
						logMessage("No PASS code found. Adding...");
						verboseMessage(specialCodePass, name);
					}
					if (!preview) {
						m_broker.saveBean(specialCodePass);
						if (verbose) {
							logMessage(specialCodePassValue + " code saved.");
						}
					}
				}

				if (noFailMatch) {
					GradebookSpecialCode specialCodeFail = X2BaseBean.newInstance(GradebookSpecialCode.class,
							m_broker.getPersistenceKey());
					specialCodeFail.setBehavior(exemptFromCalculations);
					specialCodeFail.setCode(specialCodeFailValue);
					specialCodeFail.setColor(color);
					specialCodeFail.setMissingIndicator(missingIndicator);
					specialCodeFail.setShortcut(shortcut);
					specialCodeFail.setStaffOid(staffOid);
					if (verbose) {
						logMessage("No FAIL code found. Adding...");
						verboseMessage(specialCodeFail, name);
					}
					if (!preview) {
						m_broker.saveBean(specialCodeFail);
						if (verbose) {
							logMessage(specialCodeFailValue + " code saved.");
						}
					}
				}
			}
			if (Thread.currentThread().isInterrupted()) {
				destroy();
			} else {
				logMessage("\nTask complete.");
				success = true;
			}
		} catch (Exception e) {
			ExceptionUtils.getFullStackTrace(e);
		} finally {
			if (success) {
				logMessage("Transaction completed successfully - committing transaction.\n\n");
				m_broker.commitTransaction();
			} else {
				logMessage("Transaction failed - Rolling back transaction.\n\n");
				m_broker.rollbackTransaction();
			}
		}
	}

	/*
	 * Provides additional details for review after run time.
	 */
	public void verboseMessage(GradebookSpecialCode code, String staffName) {
		logMessage("Created the following record for: " + staffName + "\n\t" + "Code: " + code.getCode() + "\n\t"
				+ "Behavior Type: Exempt from calculations (" + code.getBehavior() + ")\n\t" + "Color HTML value: "
				+ code.getColor() + "\n\t" + "Report as missing? " + code.getMissingIndicator() + "\n");
	}

	/*
	 * Finds the code value for the passed OID and returns it for use.
	 */
	public Set<String> loadReferenceCodes(ArrayList<String> list) {
		Set<String> codesSet = new HashSet<String>();
		if (!list.isEmpty()) {
			X2Criteria rcdCriteria = new X2Criteria();
			rcdCriteria.addIn(X2BaseBean.COL_OID, list);
			BeanQuery rcdQuery = new BeanQuery(ReferenceCode.class, rcdCriteria);
			Collection<ReferenceCode> codes = m_broker.getCollectionByQuery(rcdQuery);
			if (codes != null) {
				for (ReferenceCode code : codes) {
					ThreadUtils.checkInterrupt();
					codesSet.add(code.getCode());
				}
			}
		}
		return codesSet;
	}

	/**
	 * Returns the gradebook special codes for the passed staff OID.
	 *
	 * @param staffOid String
	 *
	 * @return Collection<GradebookSpecialCode>
	 */
	public Collection<GradebookSpecialCode> getSpecialCodes(String staffOid) {

		Collection<GradebookSpecialCode> specialCodes = m_specialCodeByColumn.get(staffOid);

		if (specialCodes == null && !StringUtils.isEmpty(staffOid)) {
			Criteria criteria = new Criteria();
			criteria.addEqualTo(GradebookSpecialCode.COL_STAFF_OID, staffOid);

			QueryByCriteria query = new QueryByCriteria(GradebookSpecialCode.class, criteria);
			specialCodes = m_broker.getCollectionByQuery(query);

			m_specialCodeByColumn.put(staffOid, specialCodes);
		}

		return specialCodes;
	}

	/**
	 * This method destroys and releases any resources it used.
	 */
	public void destroy() {
		m_specialCodeByColumn.clear();
		m_specialCodeByColumn = null;
		m_staffType.clear();
		m_staffType = null;
		m_staffBargainUnits.clear();
		m_staffBargainUnits = null;
		m_staffDepartment.clear();
		m_staffDepartment = null;
	}
}