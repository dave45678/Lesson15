package model;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.EntityTransaction;
import javax.persistence.Query;
import customTools.DbUtil;

public class DbCustomer {

	public static Customer getCustomer(long customerId)
	{
		EntityManager em = DbUtil.getEmFactory().createEntityManager();
		Customer customer = em.find(Customer.class, customerId);
		return customer;		
	}
	
	public static List<Customer> getAllCustomers(){
		EntityManager em = DbUtil.getEmFactory().createEntityManager();
		String qString = "select c from Customer c";
		
		ArrayList<Customer> customers = new ArrayList<Customer>();
		try{
			Query query = em.createQuery(qString);
			List<Customer> results = query.getResultList();
			for (Customer item : results) {
				customers.add(item);
			}

		}catch (Exception e){
			e.printStackTrace();
		}
		finally{
				em.close();
			}
		return customers;
	}
	
	public static void insert(Customer customer) {
		EntityManager em = DbUtil.getEmFactory().createEntityManager();
		EntityTransaction trans = em.getTransaction();
		trans.begin();
		try {
			em.persist(customer);
			trans.commit();
		} catch (Exception e) {
			e.printStackTrace();
			trans.rollback();
		} finally {
			em.close();
		}
	}

	public static void update(Customer customer) {
		EntityManager em = DbUtil.getEmFactory().createEntityManager();
		EntityTransaction trans = em.getTransaction();
		trans.begin();
		try {
			em.merge(customer);
			trans.commit();
		} catch (Exception e) {
			trans.rollback();
		} finally {
			em.close();
		}
	}

		
}
