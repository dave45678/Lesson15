# Lesson 14 - Using Database Relationships with Spring Boot - OneToMany 
## The Walkthrough 

1. Create a Spring Boot Application 
	* Name it SpringBoot_14 
	* Add the dependencies for the web, jpa, h2 and thymeleaf 
	* Hit next until you finish the wizard, and then wait until it's done.    

2. Create a Class
	* Right click on com.example.demo and click New -> Class
	* Name it Director.java
	* Edit it to look like this:
```java
@Entity
public class Director {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private long id;
    private String name;
    private String genre;

    @OneToMany(mappedBy = "director", cascade = CascadeType.ALL, fetch = FetchType.EAGER)
    public Set<Movie> movies;
}
```

3. Autogenerate getters and setters
	* Right-click on the word Director and select generate -> Getters and Setters
	* Select all the fields listed and click OK

4. Create a Class
	* Right click on com.example.demo and click New -> Class
	* Name it Movie.java
	* Edit it to look like this:
```java
@Entity
public class Movie {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private long id;
    private String title;
    private long year;
    private String description;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "director_id")
    private Director director;
}
```

5. Autogenerate getters and setters
	* Right-click on the word Movie and select generate -> Getters and Setters
	* Select all the fields listed and click OK

6. Create a Repository
	* Right click on com.example.demo and click New -> Class
	* Name it MovieRepository.java
	* Edit it to look like this:
```java
import org.springframework.data.repository.CrudRepository;

public interface MovieRepository extends CrudRepository<Movie, Long>{
}
```

7. Create a Repository
	* Right click on com.example.demo and click New -> Class
	* Name it DirectorRepository.java
	* Edit it to look like this:
```java
import org.springframework.data.repository.CrudRepository;

public interface DirectorRepository extends CrudRepository<Director, Long>{
}
```

8. Create a Controller 
	* Right click on com.example.demo and click New -> Class 
	* Name it HomeController.java 
	* Edit it to look like this: 
``` java
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import java.util.HashSet;
import java.util.Set;

@Controller
public class HomeController {

    @Autowired
    DirectorRepository directorRepository;

    @RequestMapping("/")
    public String index(Model model){
        // First let's create a director
        Director director = new Director();
        director.setName("Stephen Bullock");
        director.setGenre("Sci Fi");

        // Now let's create a movie
        Movie movie = new Movie();
        movie.setTitle("Star Movie");
        movie.setYear(2017);
        movie.setDescription("About Stars...");

        // Add the movie to an empty list
        Set<Movie> movies = new HashSet<Movie>();
        movies.add(movie);

        movie = new Movie();
        movie.setTitle("DeathStar Ewoks");
        movie.setYear(2011);
        movie.setDescription("About Ewoks on the DeathStar...");
        movies.add(movie);

        // Add the list of movies to the director's movie list
        director.setMovies(movies);

        // Save the director to the database
        directorRepository.save(director);

        // Grad all the directors from the database and send them to
        // the template
        model.addAttribute("directors", directorRepository.findAll());
        return "index";
    }
}
```

9. Create a Template 
  	* Right click on templates and click New -> Html 
	* Name it index.html 
	* Edit it to look like this: 
```html
<!DOCTYPE html>
<html lang="en" xmlns:th="www.thymeleaf.org">
<head>
    <meta charset="UTF-8" />
    <title>Title</title>
</head>
<body>
<div th:each="director : ${directors}">
    <h2 th:text="${director.name}"></h2>
    <h6 th:inline="text">specializing in [[${director.genre}]]</h6>
    <ul>
        <th:block  th:each="movie : ${director.movies}">
            <li th:inline="text"><b>[[${movie.title}]]</b> released in [[${movie.year}]].</li>
        </th:block>
    </ul>
</div>
</body>
</html>
```

10. Run your application and open a browser, if you type in the URL http://localhost:8080 you should see something like this: 
![Relationships](https://github.com/ajhenley/unofficialguides/blob/master/IntroToSpringBoot/img/Lesson14.png)

