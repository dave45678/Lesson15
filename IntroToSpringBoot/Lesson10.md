# Lesson 10 - Complete data life cycle – form, list, detail, delete 
## The Walkthrough 

1. Create a Spring Boot Application 
	* Name it SpringBoot_10 
	* Add the dependencies for web, thymeleaf, jpa and h2 
	* Hit next until you finish the wizard, and then wait until it's done.    

2. Create a Class 
	* Right click on com.example.demo and click New -> Class 
	* Name it Course.java 
	* Edit it to look like this: 
```java
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.validation.constraints.Min;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

@Entity
public class Course {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private long id;

    @NotNull
    @Size(min=4)
    private String title;

    @NotNull
    @Size(min=3)
    private String instructor;

    @NotNull
    @Size(min=10)
    private String description;

    @NotNull
    @Min(3)
    private int credit;

}
```

3. Autogenerate getters and setters
  * Right-click on the word Course and select generate -> Getters and Setters
  * Select all the fields list and click OK

4. Create a Repository 
	* Right click on com.example.demo and click New -> Class 
	* Name it CourseRepository.java 
	* Edit it to look like this: 
```java
import org.springframework.data.repository.CrudRepository;

public interface CourseRepository extends CrudRepository<Course, Long>{
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
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.validation.Valid;

@Controller
public class HomeController {

    @Autowired
    CourseRepository courseRepository;

    @RequestMapping("/")
    public String listJobs(Model model){
        model.addAttribute("courses", courseRepository.findAll());
        return "list";
    }

    @GetMapping("/add")
    public String jobForm(Model model){
        model.addAttribute("course", new Course());
        return "courseform";
    }

    @PostMapping("/process")
    public String processForm(@Valid Course course, BindingResult result){
        if (result.hasErrors()){
            return "courseform";
        }
        courseRepository.save(course);
        return "redirect:/";
    }

    @RequestMapping("/detail/{id}")
    public String showJob(@PathVariable("id") long id, Model model){
        model.addAttribute("course", courseRepository.findOne(id));
        return "show";
    }

    @RequestMapping("/update/{id}")
    public String updateCourse(@PathVariable("id") long id, Model model){
        model.addAttribute("course", courseRepository.findOne(id));
        return "courseform";
    }

    @RequestMapping("/delete/{id}")
    public String delJob(@PathVariable("id") long id){
        courseRepository.delete(id);
        return "redirect:/";
    }
}
```

6. Create a Template for the form
  	* Right click on templates and click New -> Html 
	* Name it courseform.html 
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
      th:action="@{/process}"
      th:object="${course}"
      method="post">
      <input type="hidden" th:field="*{id}" />
    Title :<input type="text" th:field="*{title}" />
    <span th:if="${#fields.hasErrors('title')}"
          th:errors="*{name}"></span><br />
    Instructor :<input type="text" th:field="*{instructor}" />
    <span th:if="${#fields.hasErrors('instructor')}"
          th:errors="*{instructor}"></span><br />
    Description :<textarea rows="3" th:field="*{description}" />
    <span th:if="${#fields.hasErrors('description')}"
          th:errors="*{description}"></span>
    Credits :<input type="text" th:field="*{credit}" />
    <span th:if="${#fields.hasErrors('credit')}"
          th:errors="*{credit}"></span><br />
    <br />
    <input type="submit" value="Submit" />
</form>
</body>
</html>
```

6. Create a Template for the course listings
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
<a href="/add">Add a Course</a><br />
<table>
    <tr>
        <th>Title</th>
        <th>Instructor</th>
        <th>Credits</th>
        <td>Actions</td>
    </tr>
    <tr th:each="course : ${courses}">
        <td th:text="${course.title}"></td>
        <td th:text="${course.instructor}"></td>
        <td th:text="${course.credit}"></td>
        <td>
            <a th:href="@{/detail/{id}(id=${course.id})}">Details</a> -
            <a th:href="@{/delete/{id}(id=${course.id})}">Delete</a>
        </td>
    </tr>
</table>
</body>
</html>
```

7. Create a template for course detail
  	* Right click on templates and click New -> Html 
	* Name it show.html 
	* Edit it to look like this: 
```html
<!DOCTYPE html>
<html lang="en" xmlns:th="www.thymeleaf.org">
<head>
    <meta charset="UTF-8" />
    <title>Title</title>
</head>
<body>

<a href="/">Show All Courses</a><br />
Title :<span th:text="${course.title}" ></span><br />
Instructor :<span th:text="${course.instructor}" ></span><br />
Description :<p th:text="${course.description}" ></p>
Credits :<span th:text="${course.credit}" ></span><br />
<a th:href="@{/delete/{id}(id=${course.id})}">Delete this course</a>
</body>
</html>
```

8. Configure H2 to use the console
    * Configure H2
    * Open application.properties
    * Edit it to look like this:
```
spring.h2.console.enabled=true
spring.h2.console.path=/h2-console

spring.jpa.hibernate.ddl-auto=create
```

9. Run your application and open a browser, if you type in the URL http://localhost:8080/add you should see this: 
![Adding a job](https://github.com/ajhenley/unofficialguides/blob/master/IntroToSpringBoot/img/Lesson09a.png "Adding a job")

10. If you enter values and submit the form, it will show you a list of all the jobs added so far. So, you should see a page that looks like this:  
![List of Jobs](https://github.com/ajhenley/unofficialguides/blob/master/IntroToSpringBoot/img/Lesson09b.png "List of Jobs")


## What is Going On
