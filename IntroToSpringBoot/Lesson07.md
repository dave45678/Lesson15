# Lesson 7 - Validating Form Data 
## The Walkthrough 

1. Create a Spring Boot Application 
	* Name it SpringBoot_07 
	* Add the dependencies for the web and for thymeleaf 
	* Hit next until you finish the wizard, and then wait until it's done.    

2. Create a Class 
	* Right click on com.example.demo and click New -> Class 
	* Name it Tvshow.java 
	* Edit it to look like this: 

	```java
	import javax.validation.constraints.Min;
	import javax.validation.constraints.NotNull;
	import javax.validation.constraints.Size;
	
	public class Tvshow {
	    @NotNull
	    @Min(1)
	    private long id;
	
	    @NotNull
	    @Size(min=3, max=20)
	    private String name;
	
	    @NotNull
	    @Size(min=3, max=10)
	    private String type;
	
	    @NotNull
	    @Size(min=10, max=30)
	    private String description;
	}
	```

3. Autogenerate getters and setters
	* Right-click on the word Tvshow and select generate -> Getters and Setters
	* Select all the fields list and click OK

4. Create a Controller 
	* Right click on com.example.demo and click New -> Class 
	* Name it HomeController.java 
	* Edit it to look like this: 
	
	```java
	import org.springframework.stereotype.Controller;
	import org.springframework.ui.Model;
	import org.springframework.validation.BindingResult;
	import org.springframework.web.bind.annotation.GetMapping;
	import org.springframework.web.bind.annotation.PostMapping;
	
	import javax.validation.Valid;
	
	@Controller
	public class HomeController {
	    @GetMapping("/tvform")
	    public String loadTvForm(Model model){
	        model.addAttribute("tvshow", new Tvshow());
	        return "tvform";
	    }
	
	    @PostMapping("/tvform")
	    public String processTvForm(@Valid Tvshow tvshow, BindingResult result){
	        if (result.hasErrors()){
	            return "tvform";
	        }
	        return "tvshowconfirm";
	    }
	}
	```

5. Create a Template for the form
	* Right click on templates and click New -> Html 
	* Name it tvform.html 
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

6. Create a Template for the confirmation 
	* Right click on templates and click New -> Html 
	* Name it tvshowconfirm.html
	* Edit it to look like this: 
	
	```html
	<!DOCTYPE html>
	<html lang="en" xmlns:th="www.thymeleaf.org">
	<head>
	    <meta charset="UTF-8" />
	    <title>Title</title>
	</head>
	<body>
	<p th:inline="text">
	    The tv show's name was [[${tvshow.name}]].<br />
	    It is a [[${tvshow.type}]].<br />
	    It could be best described as
	    [[${tvshow.description}]].
	</p>
	</body>
	</html>
	
	```

7. Run your application and open a browser, if you type in the URL http://localhost:8080/tvform you should see this: 
![Creating a form](https://github.com/ajhenley/unofficialguides/blob/master/IntroToSpringBoot/img/Lesson07a.png "Creating a form")

8. If you enter values that violate your constraints and try to submit the form, it will show you an error. But once you enter valid values and click submit, you should see a page that looks like this:  
![Processing the form](https://github.com/ajhenley/unofficialguides/blob/master/IntroToSpringBoot/img/Lesson07b.png "Processing the form")


## What is Going On
A bean for TvShow is being created, and it includes constraint annotations. These constrains restrict the values that can be assigned to the variables. Remember the getters and setters!

### Constraints and validation
@NotNull and @Min(1) ensure that the user enters a value into this field.
You can also indicate that the input is valid for a range of a number of characters - e.g. there should be a minimum of 3 characters and a maximum of 30 for the name of the TV show. 

### The Controller
There are two routes mapped out in this controller - one each for get and post requests to “/tvform”. The get request creates an empty object to be passed to tvform.html, so that a user can enter information about TV shows. 
The post request validates the input received according to the annotations in the bean. If values entered are invalid, tvform.html will be displayed with the default error messages for the errors encountered. If the values entered are valid, tvshowconfirm.html will be shown. 

### The View
tvform.html 
As in the previous example, the entries made by the user are being put into an object that is created in the controller and passed to the html form. This object is referred to as “tvshow” in tvform.html. Once the user clicks the “Submit” button, the information is posted to the route indicated by the th:action form attribute. 
The input fields are also being validated based on the annotations in the bean. 
th:if=“${#fields.hasErrors(‘id’)}” gets the return values from BindingResult, and displays the default error message for the appropriate field if there are errors.
 
[Github Repository](https://github.com/ajhenley/SpringBoot_07)
