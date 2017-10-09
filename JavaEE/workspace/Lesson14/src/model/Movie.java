package model;

import java.io.Serializable;
import javax.persistence.*;


/**
 * The persistent class for the movie database table.
 * 
 */
@Entity
@Table(name="movie")
@NamedQuery(name="Movie.findAll", query="SELECT m FROM Movie m")
public class Movie implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	private int movieId;

	private String description;

	private String title;

	private int year;

	//bi-directional many-to-one association to Director
	@ManyToOne
	@JoinColumn(name="directorId")
	private Director director;

	public Movie() {
	}

	public int getMovieId() {
		return this.movieId;
	}

	public void setMovieId(int movieId) {
		this.movieId = movieId;
	}

	public String getDescription() {
		return this.description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getTitle() {
		return this.title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public int getYear() {
		return this.year;
	}

	public void setYear(int year) {
		this.year = year;
	}

	public Director getDirector() {
		return this.director;
	}

	public void setDirector(Director director) {
		this.director = director;
	}

}