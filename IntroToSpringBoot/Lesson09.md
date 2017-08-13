# Lesson 9 - Looping through list with Thymeleaf in Spring Boot 
## The Walkthrough 

1. Create a Spring Boot Application 
	* Name it SpringBoot_09 
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
      th:action="@{/process}"
      th:object="${job}"
      method="post">
    Title :<input type="text" th:field="*{title}" />
    <span th:if="${#fields.hasErrors('title')}"
          th:errors="*{title}"></span><br />
    Employer :<input type="text" th:field="*{employer}" />
    <span th:if="${#fields.hasErrors('employer')}"
          th:errors="*{employer}"></span><br />
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

You are using an in-memory database to store information about jobs. This information is captured from a user (or users) via an HTML form. The process  is the same as for any other database (MySQL, Postgres, SQL Server, etc.), and you benefit from The Java Persistence API's ability to 'talk to' many different databases using the same Spring Boot code. 

### The Model 

### The Job Class 
You are creating a class that will become a table in the H2 datbase. The annotations being used will determine how your application interacts with the database (e.g. automatically generating the Id which is used as the primary key for that table), and what kind of information the database stores in each field. 

### The Job Repository
This acts as your 'pipeline' to the database. The Job Repository has in-built methods that you can use to save, locate, and delete data. The Job Repository can return single or multiple instances of the jobs that are in the database, depending on the *__criteria__* used to locate fields. 

### The Controller

__@RequestMapping("/")__

When a user visits the default route (e.g. http://localhost:8080), the user will see a list of records that have been saved in the database. This is because the Job Repository is being used to retrieve all available records, and the result of this search is being passed to the view (in an Iterable object called 'jobs'). The view will display the individual elements of the 'jobs' object using a Thymeleaf loop. 

__@GetMapping("/add")__ 

When a user visits the default route (e.g. http://localhost:8080), a new and empty instance of the Job class will be created. This will be passed to the view (where it is referred to as 'jobs'), so that the user's input can be stored in fields within that model, and validated according to the rules set in the Job class.

 __@PostMapping("/process")__ 
 When a user presses the "submit" button, the view returns to the controller to execute the method under this route. This method checks the object that was passed to the view. That object is now populated with the user's input, which can be validated against the rules in the Job class. The @Valid annotation is used with the BindingResult object to check the object for validity according to the validation constraints. 
 
If the user has entered invalid data, the input form will be entered with prompts each invalid field input, for the user to enter valid values. Once the user enters valid information for all required inputs, the controller will return to the default route. 

__"redirect"__ is being used to call a route. Note that if you use __Model__ to create a model attribute, the job object that has been created and made available to the controller will disappear. In this case, ONLY use redirects for routes that support GET mapping. 

### The View 
Remember to include the thymeleaf XML namespace! This allows you to use thymeleaf tags in the HTML template. 

#### jobform.html 
This form serves two purposes. It accpets information from the user, and also informs the user about invalid data that was entered after the form has been submitted. 

When a new (and empty) object is passed to it, the form ignores the error messages, because the th:if statements evaluate to false. 

When an error occurs, the errors captured in the BindingResult object are passed back to the form, and checked for using 
``` java
${#fields.hasErrors('fieldname')
```
, where fieldname is the name of the field into which data was entered. If the th:if statement evaluates to true, then the span will display the default (or modified) error for that field: ``` th:errors="*{title}
```

#### Remember: 
The form action uses a thymeleaf statement, th:action. This maps to a named route in the controller. The method used is POST, since information will be submitted to the application. Since th:action is being used, the form action is not required. If you still wish to use it, assign "#" to the form action.  

#### list.html 
This is where the items that were entered show up in the application. The object that was passed to the view "jobs" is looped through. This object is like a list, or array list, and contains a number of objects. 

The th:each Thymeleaf statement is used to loop through the data. 

This can be confusing at first, but it is easier to understand if you think about it as an enhanced for loop. 

If you were looping through a similar object in the controller, you would do it this way: 

``` java
Iterable <Job> jobs = jobRepository.findAll();
for(Job job:jobs)
{
	System.out.println(job.getTitle()+" @ "+job.getEmployer());
	System.out.println(job.getDescription());
}

```

In Thymeleaf, you are changing this slightly. The controller has already passed *__jobs__* to Thyemleaf. 
So now, the view has to iterate through it using th:each. 

Look at the code below again, and think about how similar it is to the enhanced for loop above. 

``` java
<div th:each="job : ${jobs}">
    <h4 th:inline="text">[[${job.title}]] @ [[${job.employer}]]</h4>
    <p th:text="${job.description}"></p>
</div>
```

Note that the getters in Thymeleaf look like the variables declared in the Job class. They actually call the getters .getTitle(), .getEmployer(), and .getDescription() in the background to retrieve their values and display them in Thymeleaf. This is one of the most important reasons to add your getters and setters! If you don't, your appliation while trying to render the Thymeleaf view. 














