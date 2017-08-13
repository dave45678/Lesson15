# Lesson 13 - Using Database Relationships with Spring Boot - ManyToMany 
## The Walkthrough 

1. Create a Spring Boot Application 
	* Name it SpringBoot_13 
	* Add the dependencies for the web and for thymeleaf 
	* Hit next until you finish the wizard, and then wait until it's done.    

2. Create a Class
	* Right click on com.example.demo and click New -> Class
	* Name it Movie.java
	* Edit it to look like this:
```java
import javax.persistence.*;
import java.util.Set;

@Entity
public class Movie {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private long id;
    private String title;
    private long year;
    private String description;

    @ManyToMany
    @JoinTable(
            name="movie_actor",
            joinColumns=@JoinColumn(name="MOVIE_ID", referencedColumnName = "ID"),
            inverseJoinColumns = @JoinColumn(name="ACTOR_ID", referencedColumnName = "ID"))
    private Set<Actor> cast;
}
```

3. Autogenerate getters and setters
	* Right-click on the word Movie and select generate -> Getters and Setters
	* Select all the fields listed and click OK

4. Create a Class
	* Right click on com.example.demo and click New -> Class
	* Name it Actor.java
	* Edit it to look like this:
```java
import javax.persistence.*;
import java.util.Set;

@Entity
public class Actor {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private long id;
    private String name;
    private String realname;

    @ManyToMany(mappedBy = "cast")
    private Set<Movie> movies;
}
```

5. Autogenerate getters and setters
	* Right-click on the word Actor and select generate -> Getters and Setters
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
	* Name it ActorRepository.java
	* Edit it to look like this:
```java
import org.springframework.data.repository.CrudRepository;

public interface ActorRepository extends CrudRepository<Actor, Long>{
}
```

8. Create a Controller 
	* Right click on com.example.demo and click New -> Class 
	* Name it HomeController.java 
	* Edit it to look like this: 
``` java
import com.example.demo.models.Actor;
import com.example.demo.models.Movie;
import com.example.demo.repositories.ActorRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import java.util.HashSet;
import java.util.Set;

@Controller
public class HomeController {

    @Autowired
    ActorRepository actorRepository;

    @RequestMapping("/")
    public String index(Model model){
        // First let's create an actor
        Actor actor = new Actor();
        actor.setName("Sandra Bullock");
        actor.setRealname("Sandra Mae Bullowski");
        
        // Now let's create a movie
        Movie movie = new Movie();
        movie.setTitle("Emoji Movie");
        movie.setYear(2017);
        movie.setDescription("About Emojis...");
        
        // Add the movie to an empty list
        Set<Movie> movies = new HashSet<Movie>();
        movies.add(movie);
        
        // Add the list of movies to the actor's movie list
        actor.setMovies(movies);
        
        // Save the actor to the database
        actorRepository.save(actor);
        
        // Grad all the actors from the database and send them to 
        // the template
        model.addAttribute("actors", actorRepository.findAll());
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
<div th:each="actor : ${actors}">
    <h2 th:text="${actor.name}"></h2>
    <h6 th:inline="text">AKA [[${actor.realname}]]</h6>
<ul>
    <th:block  th:each="movie : ${actor.movies}">
    <li th:inline="text"><b>[[${movie.title}]]</b> released in [[${movie.year}]].</li>
    </th:block>
</ul>
</div>
</body>
</html>
```

10. Run your application and open a browser, if you type in the URL http://localhost:8080 you should see something like this: 
![Relationships](https://github.com/ajhenley/unofficialguides/blob/master/IntroToSpringBoot/img/Lesson13.png)

