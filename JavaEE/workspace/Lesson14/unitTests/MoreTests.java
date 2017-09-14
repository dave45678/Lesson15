import static org.junit.Assert.*;

import org.junit.Before;
import org.junit.Test;
import model.DbDirector;
import model.Director;
import model.Movie;



public class MoreTests {


	@Test
	public void listMoviesByDirectory(){
		System.out.println(DbDirector.getAllDirectors().size());
	    //assertTrue(1);
	}
}
