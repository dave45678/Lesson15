import static org.junit.Assert.*;

import java.util.ArrayList;

import org.junit.Before;
import org.junit.Test;

import model.DbDirector;
import model.Director;
import model.Movie;

public class DirectorTests {

	@Before
	public void setUp() throws Exception {
		
	}

//	@Test
//	public void test() {
//		ArrayList<Movie> movies = (ArrayList<Movie>)DbDirector.getAllMoviesByDirector(1);
//		
//		System.out.println(movies.get(0).getTitle());
//		assertTrue(movies.get(0).getTitle().length()>0);
//	}
	@Test
	public void listDirectorsAndMovies(){
		//System.out.println(DbDirector.getDirector(1).getName());
		ArrayList<Director> directors = (ArrayList<Director>) DbDirector.getAllDirectors();
		for (Director d:directors){
			System.out.printf("%s %s",d.getName(),d.getMovies().get(0).getTitle());
		}
		
		assertTrue(directors.get(0).getMovies().get(0).getTitle().length()>0);
	}

}
