package model;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.EntityTransaction;
import javax.persistence.Query;
import model.Actor;

public class DbActor {

	public static Actor getActor(long actorId)
	{
		EntityManager em = DbUtil.getEmFactory().createEntityManager();
		Actor course = em.find(Actor.class, actorId);
		return course;		
	}
	
	public static List<Actor> getAllActors(){
		EntityManager em = DbUtil.getEmFactory().createEntityManager();
		String qString = "select m from Actor m";
		
		ArrayList<Actor> actors = new ArrayList<Actor>();
		try{
			Query query = em.createQuery(qString);
			List<Actor> results = query.getResultList();
			for (Actor item : results) {
				actors.add(item);
			}

		}catch (Exception e){
			e.printStackTrace();
		}
		finally{
				em.close();
			}
		return actors;
	}
	

	public static void insert(Actor actor) {
		EntityManager em = DbUtil.getEmFactory().createEntityManager();
		EntityTransaction trans = em.getTransaction();
		trans.begin();
		try {
			em.persist(actor);
			trans.commit();
		} catch (Exception e) {
			e.printStackTrace();
			trans.rollback();
		} finally {
			em.close();
		}
	}

	public static void update(Actor actor) {
		EntityManager em = DbUtil.getEmFactory().createEntityManager();
		EntityTransaction trans = em.getTransaction();
		trans.begin();
		try {
			em.merge(actor);
			trans.commit();
		} catch (Exception e) {
			System.out.println(e);
			trans.rollback();
		} finally {
			em.close();
		}
	}

		
}