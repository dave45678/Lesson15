# Lesson 9 - Looping through list with Thymeleaf in Spring Boot 
## The Walkthrough 

1. Create a Spring Boot Application 
	* Name it SpringBoot_07 
	* Add the dependencies for web, thymeleaf, jpa and h2 
	* Hit next until you finish the wizard, and then wait until it's done.    

2. Create a Class 
	* Right click on com.example.demo and click New -> Class 
	* Name it Job.java 
	* Edit it to look like this: 
```java
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

@Entity
public class Job {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private long id;

    @NotNull
    @Size(min=4)
    private String title;

    @NotNull
    @Size(min=3)
    private String employer;

    @NotNull
    @Size(min=10)
    private String description;
}
```

3. Autogenerate getters and setters
  * Right-click on the word Job and select generate -> Getters and Setters
  * Select all the fields list and click OK

4. Create a Repository 
	* Right click on com.example.demo and click New -> Class 
	* Name it JobRepository.java 
	* Edit it to look like this: 
```java
import org.springframework.data.repository.CrudRepository;

public interface JobRepository extends CrudRepository<Job, Long> {    
}
```

5. Create a Controller 
	* Right click on com.example.demo and click New -> Class 
	* Name it HomeController.java 
	* Edit it to look like this: 
```java
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.validation.Valid;

@Controller
public class HomeController {

    @Autowired
    JobRepository jobRepository;
    
    @RequestMapping("/")
    public String listJobs(Model model){
        model.addAttribute("jobs", jobRepository.findAll());
        return "list";
    }
    
    @GetMapping("/add")
    public String jobForm(Model model){
        model.addAttribute("job", new Job());
        return "jobform";
    }
    
    @PostMapping("/process")
    public String processForm(@Valid Job job, BindingResult result){
        if (result.hasErrors()){
            return "jobform";
        }
        jobRepository.save(job);
        return "redirect:/";
    }
}
```

6. Create a Template for the form
  	* Right click on templates and click New -> Html 
	* Name it jobform.html 
	* Edit it to look like this: 
```html
<!DOCTYPE html>
<html lang="en" xmlns:th="www.thymeleaf.org">
<head>
    <meta charset="UTF-8" />
    <title>Title</title>
</head>
<body>
    <form action="#" 
          th:action="@{/tvform}" 
          th:object="${tvshow}" 
          method="post">
        Id :<input type="number" th:field="*{id}" />
        <span th:if="${#fields.hasErrors('id')}" 
              th:errors="*{id}"></span><br />
        Name :<input type="text" th:field="*{name}" />
        <span th:if="${#fields.hasErrors('name')}" 
              th:errors="*{name}"></span><br />
        Type :<input type="text" th:field="*{type}" />
        <span th:if="${#fields.hasErrors('type')}" 
              th:errors="*{type}"></span><br />
        Description :<textarea rows="3" th:field="*{description}" />
        <span th:if="${#fields.hasErrors('description')}"
              th:errors="*{description}"></span>
        <br />
        <input type="submit" value="Submit" />
    </form>
</body>
</html>
```

6. Create a Template for the job listings
  	* Right click on templates and click New -> Html 
	* Name it list.html 
	* Edit it to look like this: 
```html
<!DOCTYPE html>
<html lang="en" xmlns:th="www.thymeleaf.org">
<head>
    <meta charset="UTF-8" />
    <title>Title</title>
</head>
<body>
<a href="/add">Add a Job</a><br />
<div th:each="job : ${jobs}">
    <h4 th:inline="text">[[${job.title}]] @ [[${job.employer}]]</h4>
    <p th:text="${job.description}"></p>
</div>
</body>
</html>
```

7. Run your application and open a browser, if you type in the URL http://localhost:8080/add you should see this: 
![Adding a job](https://github.com/ajhenley/unofficialguides/blob/master/IntroToSpringBoot/img/Lesson09a.png "Adding a job")

8. If you enter values and submit the form, it will show you a list of all the jobs added so far. So, you should see a page that looks like this:  
![List of Jobs](https://github.com/ajhenley/unofficialguides/blob/master/IntroToSpringBoot/img/Lesson09b.png "List of Jobs")


## What is Going On
