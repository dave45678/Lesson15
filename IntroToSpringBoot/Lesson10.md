# Lesson 10 - Complete data life cycle – input, update, list, detail, delete 
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
    public String listCourses(Model model){
        model.addAttribute("courses", courseRepository.findAll());
        return "list";
    }

    @GetMapping("/add")
    public String courseForm(Model model){
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
    public String showCourse(@PathVariable("id") long id, Model model){
        model.addAttribute("course", courseRepository.findOne(id));
        return "show";
    }

    @RequestMapping("/update/{id}")
    public String updateCourse(@PathVariable("id") long id, Model model){
        model.addAttribute("course", courseRepository.findOne(id));
        return "courseform";
    }

    @RequestMapping("/delete/{id}")
    public String delCourse(@PathVariable("id") long id){
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
          th:errors="*{title}"></span><br />
    Instructor :<input type="text" th:field="*{instructor}" />
    <span th:if="${#fields.hasErrors('instructor')}"
          th:errors="*{instructor}"></span><br />
    Description :<textarea rows="3" th:field="*{description}" />
    <span th:if="${#fields.hasErrors('description')}"
          th:errors="*{description}"></span><br />
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
            <a th:href="@{/update/{id}(id=${course.id})}">Update</a> -
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
![Adding a course](https://github.com/ajhenley/unofficialguides/blob/master/IntroToSpringBoot/img/Lesson10b.png "Adding a course")

10. If you enter values and submit the form, it will show you a list of all the jobs added so far. So, you should see a page that looks like this:  
![List of Courses](https://github.com/ajhenley/unofficialguides/blob/master/IntroToSpringBoot/img/Lesson10a.png "List of Courses")


## What is Going On

Congratulations on your first 'full' application! You can now add data to the database, as well as review, modify and delete it. 

### Model 
The @Entity annotation tells your application that a table should be created in your database that has fields named after the variables in the class. Depending on the database you are using, the data types may have slightly different names, but they will be the best types for the kind of data you are working with, so you don't have to think about how the data is stored and retrieved. Remember your getters and setters! They are used to tell the database which values go where. 

The annotations for validation should be familiar - these are used to determine whether the information input by the user is what is expected by the applicaition. If so, the data can be stored. If not, the view will indicate to the user where the problems are (for details, see the 'View' section), so they can be corrected. 

#### CrudRepository 
This acts as a pipeline to your database, automagically storing, modifying and retrieving data. Through the methods that CrudRepository makes available to you, you can instantly save, find one or all, and delete records by using very simple methods. 

[CrudRepository Methods](https://docs.spring.io/spring-data/commons/docs/current/api/org/springframework/data/repository/CrudRepository.html)

### The Controller 
This is where the action happens. Routes are mapped out for each action - Creating, Reading, Updating and Deleting data (CRUD). 

#### What does @Autowired do? 
When you create an instance of an object, you use the format ObjectClass someObject = new ObjectClass(); 
This creates an instance of the object, and you can use it within the method where it is called. 
For CrudRepository, that would mean that you had to instantiate the object within each method, but that would be a pain. 

@Autowired tells the compiler to instantiate the repository object when the application runs, so you don’t have to type out that line so many times! 

#### The routes 

##### Default Route (“/”)
When the user visits this route, the user will see a list of all the course entries that have been made. 
This is because the model contains the result of the .findAll() method, which pulls all the data for a selected model from the database. This data is made available to the view as a variable named ("courses"). 

#### Add route ("/add")
When a user visits this route, a new instance of the Courses class will be created and passed to the view. This will hold all values that the user enters into the form and return them to the controller at the route specified on the form by the POST method. 

#### Process route ("/process")
This route validates the course for errors, saves it to the database (using the CourseRepository object created by the @Autowired annotation), and redirects the user to the default route. 

#### Update route ("/update/{id}")
When a user wants to modify a record, that user can retrieve the details of that record by opening up http://localhost/8080/update, and adding the ID of the user whose record is being modified. The {id} parameter in this case is a primary key that exists in the database, because there should be only one record that matches this criterion. 

The .findOne() method is used to pull up that record, and it is passed to the view as an object named "course". 


#### Delete 
The delete route follows the same pattern, but instead of showing the record, it is immediately deleted from the database. When the user is re-directed to the default route, this will show in the list that is displayed, as that record will not be shown in the list. 

### The View 

This is an introduction to parameterised thymeleaf URLs. Sometimes you want to pass additional information to a URL so that you can perform operations on data. This option allows you to add paraemters to a route, so that the values that are passed can be used in your controller. You determine what these values are, and how they are processed. 

For more information about how to use parameters in URLs with Thymeleaf, see this page: 
[Parameters in URLS with Thymeleaf](http://www.thymeleaf.org/doc/articles/standardurlsyntax.html#adding-parameters)

#### courseform.html
This is the form that allows users to add new courses. It is tied to the course model (th:object="${course}"), and has validation that uses the default error messaging for the fields that have been annotated in the model (e.g. title and instructor). 
 
#### list.html
This form uses a thymeleaf loop (th:each) to show the details of each course that is passed in the courses object (a collection of course items) from the default route.

It also includes links for updating, showing details of, and deleting listed courses using __URL PARAMETERS__ - so you have the potential to acces all your CRUD (Create Read Update Delete) operations in one form. The user will be re-directed to different routes when he/she clicks each link. Each one will allow the user to carry out the selected CRUD operation. 

It also allows users to add a new course by clicking the appopriate link towards the top of the page.

Note that there is no thymeleaf action on this form - because the __anchor tag__ used has a thymeleaf attribute for the relevant route in your application. There is therefore no need to post the data with a button - you call a particular route instead.  

#### show.html  
This shows information for a single course, and has an option to delete the course, using its id as a __PARAMETER__ in the route to delete the item. 





