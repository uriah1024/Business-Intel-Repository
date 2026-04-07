import java.util.ArrayList;
import java.util.Collection;
import java.util.logging.Level;

import org.apache.ojb.broker.query.Criteria;
import org.apache.ojb.broker.query.QueryByCriteria;

import com.follett.fsc.core.framework.persistence.X2Criteria;
import com.follett.fsc.core.k12.beans.School;
import com.follett.fsc.core.k12.beans.SchoolCalendar;
import com.follett.fsc.core.k12.tools.procedures.ProcedureJavaSource;
import com.follett.fsc.core.k12.web.ApplicationContext;
import com.follett.fsc.core.k12.web.UserDataContainer;
import com.x2dev.sis.model.beans.ScheduleTerm;
import com.x2dev.sis.model.beans.ScheduleTermDate;
import com.x2dev.sis.model.beans.SisSchool;
import com.x2dev.sis.model.beans.SisSchoolCalendarDate;
import com.x2dev.sis.model.business.CalendarManager;
import com.x2dev.utils.X2BaseException;
import com.x2dev.utils.types.PlainDate;

/**
 * Checks the last in session date for each school calendar and warns users when
 * that date does not match the end date on schedule terms.
 *
 * @author TS JM
 * 2018
 */
public class SessionEndDateChecker extends ProcedureJavaSource {

	private static final String INPUT_END_DATE_CHECK = "endDateCheck";
	private static final String INPUT_START_DATE_CHECK = "startDateCheck";
	private static final Boolean LOG_MATCHES = Boolean.FALSE;
	private UserDataContainer m_userData = null;

	/**
	 * @see com.follett.fsc.core.k12.tools.procedures.ProcedureJavaSource#execute()
	 */
	@Override
	protected void execute() throws Exception {
		logMessage("Starting procedure");

		Collection<SisSchool> schools = new ArrayList<SisSchool>();
		if (ApplicationContext.SCHOOL.equals(m_userData.getApplicationContext()) && m_userData.getSchool() != null) {
			schools.add((SisSchool) m_userData.getSchool());
		} else {
			schools = loadActiveSchools();
		}

		for (SisSchool school : schools) {
			boolean endDateCheck = ((Boolean) getParameter(INPUT_END_DATE_CHECK)).booleanValue();
			boolean startDateCheck = ((Boolean) getParameter(INPUT_START_DATE_CHECK)).booleanValue();
			if (school.getActiveSchedule() != null) {
				if (endDateCheck) {
					validateSchoolEndDate(school);
				}
				if (startDateCheck) {
					validateSchoolStartDate(school);
				}
			} else {
				// No active schedule found - skip school
				logMessage("\n****NOTICE**** \n  Skipping school.\n"
						+ "  No active schedule found for: " + school.getName() +"\n**************\n");
			}
		}
		logMessage("Ending procedure");
	}

	/**
	 * Validates last in session date of the school matches the end date of
	 * schedule terms with the last term map bit enabled.
	 *
	 * @param school
	 */
	private void validateSchoolEndDate(SisSchool school) {

		logMessage("Validating school End Date for: " + school.getName());
		SisSchoolCalendarDate lastInSessionDate = loadLastInSessionDateAcrossAllSchoolCalendars(school);

		if (lastInSessionDate != null) {
			Collection<ScheduleTerm> scheduleTerms = school.getActiveSchedule().getScheduleTerms();

			for (ScheduleTerm term : scheduleTerms) {
				if (validateTermEndDate(term)) {
					Collection<ScheduleTermDate> scheduleTermDates = term.getScheduleTermDates();
					PlainDate latestEndDate = null;
					for (ScheduleTermDate date : scheduleTermDates) {
						if (latestEndDate == null
								|| (date.getEndDate() != null && date.getEndDate().after(latestEndDate))) {
							latestEndDate = date.getEndDate();
						}
					}
					if (latestEndDate != null) {
						if (latestEndDate.compareTo(lastInSessionDate.getDate()) != 0) {
							// Dates do not match - log this record
							logResults(school, lastInSessionDate, latestEndDate, term, false);
						} else if (LOG_MATCHES.booleanValue()) {
							logResults(school, lastInSessionDate, latestEndDate, term, true);
						}
					}
				}
			}
		}
		logMessage(" !! Validation for " + school.getName() + " Complete !!");
	}

	/**
	 * Validates last in session date of the school matches the end date of
	 * schedule terms with the last term map bit enabled.
	 *
	 * @param school
	 */
	private void validateSchoolStartDate(SisSchool school) {

		logMessage("Validating school Start Date for: " + school.getName());
		SisSchoolCalendarDate firstInSessionDate = loadFirstInSessionDateAcrossAllSchoolCalendars(school);

		if (firstInSessionDate != null) {
			Collection<ScheduleTerm> scheduleTerms = school.getActiveSchedule().getScheduleTerms();

			for (ScheduleTerm term : scheduleTerms) {
				if (validateTermStartDate(term)) {
					Collection<ScheduleTermDate> scheduleTermDates = term.getScheduleTermDates();
					PlainDate latestStartDate = null;
					for (ScheduleTermDate date : scheduleTermDates) {
						if (latestStartDate == null
								|| (date.getStartDate() != null && date.getStartDate().before(latestStartDate))) {
							latestStartDate = date.getStartDate();
						}
					}
					if (latestStartDate != null) {
						if (latestStartDate.compareTo(firstInSessionDate.getDate()) != 0) {
							// Dates do not match - log this record
							logResults(school, firstInSessionDate, latestStartDate, term, false);
						} else if (LOG_MATCHES.booleanValue()) {
							logResults(school, firstInSessionDate, latestStartDate, term, true);
						}
					}
				}
			}
		}
		logMessage(" !! Validation for " + school.getName() + " Complete !!");
	}

	/**
	 * Logs the match results.
	 *
	 * @param school
	 * @param lastInSessionDate
	 * @param latestEndDate
	 * @param term
	 */
	private void logResults(SisSchool school, SisSchoolCalendarDate lastInSessionDate, PlainDate latestEndDate,
			ScheduleTerm term, boolean isMatch) {
		logMessage("\n----" + 
			(isMatch ? "match identified - " 
					 : 
						" WARNING ----\n - date mismatch - \n") + 
						"    School: " + school.getName() + "\n" +
						"    Calendar session date: " + lastInSessionDate.getDate().toString() + "\n" +
						"    Term: " + term.getCode() + "\n" +
						"    Term date: " + latestEndDate + "\n" +
						"-------------------------\n");
	}

	/**
	 * Determines if the term should have it's end date validated.
	 *
	 * Logic is if the term map has the last bit checked, the term should be
	 * validated.
	 *
	 * @param term
	 *
	 * @return boolean
	 */
	protected boolean validateTermEndDate(ScheduleTerm term) {
		String termMap = term.getBaseTermMap();
		if (termMap != null && !termMap.isEmpty()) {
			char[] map = termMap.toCharArray();
			logToolMessage(Level.INFO, "" + termMap, false);
			if (map[(map.length - 1)] == '1') {
				return true;
			}
		}
		return false;
	}
	
	/**
	 * Determines if the term should have it's start date validated.
	 *
	 * Logic is if the term map has the first bit checked, the term should be
	 * validated.
	 *
	 * @param term
	 *
	 * @return boolean
	 */
	protected boolean validateTermStartDate(ScheduleTerm term) {
		String termMap = term.getBaseTermMap();
		if (termMap != null && !termMap.isEmpty()) {
			if (termMap.startsWith("1")) {
				return true;
			}
		}
		return false;
	}

	/**
	 * Loads last in session date across all calendars for a school.
	 *
	 * @param school
	 *
	 * @return SisSchoolCalendarDate
	 */
	private SisSchoolCalendarDate loadLastInSessionDateAcrossAllSchoolCalendars(SisSchool school) {
		Collection<SchoolCalendar> calendars = loadCurrentSchoolCalendars(school);
		SisSchoolCalendarDate lastInSessionDate = null;

		for (SchoolCalendar calendar : calendars) {

			SisSchoolCalendarDate calendarLastSessionDate = CalendarManager.getLastInSessionDate(calendar, getBroker());

			if (calendarLastSessionDate != null && calendarLastSessionDate.getDate() != null) {
				if (lastInSessionDate == null
						|| lastInSessionDate.getDate().before(calendarLastSessionDate.getDate())) {
					lastInSessionDate = calendarLastSessionDate;
				}
			}
		}

		return lastInSessionDate;
	}

	/**
	 * Loads last in session date across all calendars for a school.
	 *
	 * @param school
	 *
	 * @return SisSchoolCalendarDate
	 */
	private SisSchoolCalendarDate loadFirstInSessionDateAcrossAllSchoolCalendars(SisSchool school) {
		Collection<SchoolCalendar> calendars = loadCurrentSchoolCalendars(school);
		SisSchoolCalendarDate firstInSessionDate = null;

		for (SchoolCalendar calendar : calendars) {

			SisSchoolCalendarDate calendarFirstSessionDate = CalendarManager.getFirstInSessionDate(calendar,
					getBroker());

			if (calendarFirstSessionDate != null && calendarFirstSessionDate.getDate() != null) {
				if (firstInSessionDate == null
						|| firstInSessionDate.getDate().after(calendarFirstSessionDate.getDate())) {
					firstInSessionDate = calendarFirstSessionDate;
				}
			}
		}

		return firstInSessionDate;
	}

	/**
	 * Loads the school calendars for the current school and context.
	 *
	 * @param school
	 *
	 * @return Collection<SchoolCalendar>
	 */
	private Collection<SchoolCalendar> loadCurrentSchoolCalendars(School school) {
		Criteria calendarCriteria = new Criteria();
		calendarCriteria.addEqualTo(SchoolCalendar.COL_DISTRICT_CONTEXT_OID, school.getCurrentContextOid());
		calendarCriteria.addEqualTo(SchoolCalendar.COL_SCHOOL_OID, school.getOid());

		QueryByCriteria calendarQuery = new QueryByCriteria(SchoolCalendar.class, calendarCriteria);

		return getBroker().getCollectionByQuery(calendarQuery);
	}

	/**
	 * Loads all active, non-archive schools.
	 *
	 * @return Collection<SisSchool>
	 */
	private Collection<SisSchool> loadActiveSchools() {
		X2Criteria schoolCriteria = new X2Criteria();
		schoolCriteria.addEqualTo(SisSchool.COL_INACTIVE_INDICATOR, Boolean.FALSE);
		schoolCriteria.addEqualTo(SisSchool.COL_ARCHIVE_INDICATOR, Boolean.FALSE);

		QueryByCriteria schoolQuery = new QueryByCriteria(SisSchool.class, schoolCriteria);

		return getBroker().getCollectionByQuery(schoolQuery);
	}

	/**
	 * @see com.follett.fsc.core.k12.tools.ToolJavaSource#saveState(com.follett.fsc.core.k12.web.UserDataContainer)
	 */
	@Override
	protected void saveState(UserDataContainer userData) throws X2BaseException {
		runOnApplicationServer();

		m_userData = userData;
	}
}