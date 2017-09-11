package model;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.EntityTransaction;
import javax.persistence.Query;
import model.Movie;

public class DbMovie {

	public static Movie getMovie(long movieId)
	{
		EntityManager em = DbUtil.getEmFactory().createEntityManager();
		Movie course = em.find(Movie.class, movieId);
		return course;		
	}
	
	public static List<Movie> getAllMovies(){
		EntityManager em = DbUtil.getEmFactory().createEntityManager();
		String qString = "select m from Movie m";
		
		ArrayList<Movie> movies = new ArrayList<Movie>();
		try{
			Query query = em.createQuery(qString);
			List<Movie> results = query.getResultList();
			for (Movie item : results) {
				movies.add(item);
			}

		}catch (Exception e){
			e.printStackTrace();
		}
		finally{
				em.close();
			}
		return movies;
	}
	
	/*
	 * List<Object[]> rows = query.getResultList();
	List<MyObject> result = new ArrayList<>(rows.size());
	for (Object[] row : rows) {
    result.add(new MyObject((String) row[0],
                            (Long) row[1],
                            ...));
}

	 */
	
	
	public static List<Movie> postBullhorn (){
		EntityManager em = DbUtil.getEmFactory().createEntityManager();
		String qString = "select b from Bullhorn b";
		
		List<Movie> posts = null;
		try{
			Query query = em.createQuery(qString);
			posts = query.getResultList();

		}catch (Exception e){
			e.printStackTrace();
		}
		finally{
				em.close();
			}
		return posts;
	}
	
	
	
	
	
	
	
	
	public static void insert(Movie movie) {
		EntityManager em = DbUtil.getEmFactory().createEntityManager();
		EntityTransaction trans = em.getTransaction();
		trans.begin();
		try {
			em.persist(movie);
			trans.commit();
		} catch (Exception e) {
			e.printStackTrace();
			trans.rollback();
		} finally {
			em.close();
		}
	}

	public static void update(Movie movie) {
		EntityManager em = DbUtil.getEmFactory().createEntityManager();
		EntityTransaction trans = em.getTransaction();
		trans.begin();
		try {
			em.merge(movie);
			trans.commit();
		} catch (Exception e) {
			System.out.println(e);
			trans.rollback();
		} finally {
			em.close();
		}
	}

		
}
