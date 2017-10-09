package model;

import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

public class DbUtil {
	static final String PERSISTENCE_UNIT = "Lesson14";
	
	private static final EntityManagerFactory factory = 
		Persistence.createEntityManagerFactory(PERSISTENCE_UNIT);

	public static EntityManagerFactory getEmFactory() {
		return factory;
	}
}
