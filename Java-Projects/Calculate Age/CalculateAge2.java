import java.util.logging.Level;

import org.apache.ojb.broker.query.Criteria;
import org.apache.ojb.broker.query.QueryByCriteria;

import com.follett.fsc.core.k12.beans.CalculatedField;
import com.follett.fsc.core.k12.beans.Person;
import com.follett.fsc.core.k12.beans.QueryIterator;
import com.follett.fsc.core.k12.beans.X2BaseBean;
import com.follett.fsc.core.k12.business.CalculatedFieldProcedure;
import com.follett.fsc.core.k12.business.X2Broker;
import com.follett.fsc.core.k12.business.dictionary.DataDictionary;
import com.follett.fsc.core.k12.business.dictionary.DataDictionaryField;
import com.follett.fsc.core.k12.web.AppGlobals;
import com.x2dev.utils.types.PlainDate;

/**
 * Calculate Age 2
 * This procedure was completely rewritten to now use the person table and update the table by alias.
 * We now use the built-in methods for constructing the age of a person, rather than manually attempting to do so.
 * This procedure will not work on newly generated records, and only the assigned trigger fields being updated and
 * saved will cause the aliased field to populate. At a minimum, this should be the person table's date of birth.
 * 
 * @author JM
 */
public class CalculateAge2 implements CalculatedFieldProcedure
{
	
	/**
	 * Set parameter for Person table alias
	 */
	public static final String PERSON_AGE_ALIAS = "person-age"; 

	@Override
	public void updateAllBeans(CalculatedField field, X2Broker broker) 
	{
    	Criteria criteria = new Criteria();
        QueryByCriteria query = new QueryByCriteria(Person.class, criteria);
        
        QueryIterator iterator = broker.getIteratorByQuery(query);
        
        try
        {
        	while (iterator.hasNext())
        	{
	            Person person = (Person) iterator.next();
	            updateBean(field, person, broker);
	        }
        }
        finally
        {
            iterator.close();
        }
		
	}

	@Override
	public void updateBean(CalculatedField field, X2BaseBean bean, X2Broker broker) 
	{
		updateAge((Person) bean, broker);
	}

	@Override
	public void updateReferencedBeans(CalculatedField field, X2BaseBean bean, X2Broker broker) 
	{
		updateAge((Person) bean, broker);
	}
	
	/**
	 * Updates each person record's age based on date of birth for the alias 'person-age'.
	 * We update and save the bean no matter what.
	 * @param person
	 * @param broker
	 */
	private void updateAge(Person person, X2Broker broker)
	{
		PlainDate dateOfBirth = person.getDob();
		PlainDate today = new PlainDate();
		String age = null;
		
		if (person != null && dateOfBirth != null)
		{
			if (dateOfBirth.after(today)) 
			{
				AppGlobals.getLog().log(Level.WARNING, "Person: " + person.getOid() + ", DOB: " 
						+ dateOfBirth + ", Can't be born in the future. They have been set to an age of '0'.");
				age = "0";
			}
			
			else
			{
				person.getAge();
				age = Integer.toString(person.getAge());
			}
		}
		
		DataDictionary dictionary = DataDictionary.getDistrictDictionary(broker.getPersistenceKey());
		DataDictionaryField ddField = dictionary.findDataDictionaryFieldByAlias(PERSON_AGE_ALIAS);
		
		if (ddField != null)
		{
			person.setFieldValueByAlias(PERSON_AGE_ALIAS, age);
			
		}
		
		else
		{
			throw new NullPointerException("No alias of 'person-age' assigned to Person table");
		}
		
        broker.saveBean(person);
	}
}