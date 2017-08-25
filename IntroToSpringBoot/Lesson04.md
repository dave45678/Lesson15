# Lesson 4 - Handling Form Values -- the hard way 
## Learning Objectives
* Capturing form values in the controller
* Using the thymeleaf th:action attribute
* Using the thymeleaf th:object attribute
* Using the thymeleaf th:field attribute

## The Walkthrough 

1. Create a Spring Boot Application 
	* Name it SpringBoot_04 
	* Add the dependencies for the web and for thymeleaf 
	* Hit next until you finish the wizard, and then wait until it's done.    

2. Create a Controller 
	* Right click on com.example.demo and click New -> Class 
	* Name it HomeController.java 
	* Edit it to look like this: 
```java
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class HomeController {
    @RequestMapping("/loadform")
    public String loadFormPage(){
        return "formtemplate";
    }

    @RequestMapping("/processform")
    public String loadFromPage(@RequestParam("login") String login,
                               Model model){
        model.addAttribute("loginval", login);
        return "confirm";
    }
}
```

3. Create a Template for the form
  	* Right click on templates and click New -> Html 
	* Name it formtemplate.html 
	* Edit it to look like this: 
```html
<!DOCTYPE html>
<html lang="en" xmlns:th="www.thymeleaf.org">
<head>
    <meta charset="UTF-8" />
    <title>Title</title>
</head>
<body>
<form action="#" th:action="@{/processform}" method="post">
    Login: <input type="text" name="login" />
    <input type="submit" value="Submit" />
</form>
</body>
</html>
```

4. Create a Template for the confirmation
  	* Right click on templates and click New -> Html 
	* Name it confirm.html 
	* Edit it to look like this: 
```html
<!DOCTYPE html>
<html lang="en" xmlns:th="www.thymeleaf.org">
<head>
    <meta charset="UTF-8" />
    <title>Title</title>
</head>
<body>
    <p th:inline="text">The login used was [[${loginval}]].</p>
</body>
</html>
```

5. Run your application and open a browser, if you type in the URL http://localhost:8080/loadform you should see this: 
![Creating a form](https://github.com/ajhenley/unofficialguides/blob/master/IntroToSpringBoot/img/Lesson04a.png "Creating a form")

6. Once you enter a value and click submit, you should see a page that looks like this:  
![Processing the form](https://github.com/ajhenley/unofficialguides/blob/master/IntroToSpringBoot/img/Lesson04b.png "Processing the form")


## What is Going On
The “/loadform” route displays the template formtemplate to the user.  

The “/processform” route processes both get and post requests in the same way, so if you type http://localhost:8080/processform?login=Randomusername, you should see the same value as if you enter Randomusername in the login box displayed when you visit the ”loadform” route.  

**@RequestParam** means that the loadFromPage method expects a parameter (either in the URL as a GET request, or posted to the form via a POST request) that is called login, and passes the value of that parameter to the model as “loginval”. The html templates can now access the value of the login string as “loginval”.  

**th:inline** indicates that the value of text to be displayed is shown within the tag. To make sure the values of your Thymeleaf expresssions are evaluated, enclose your expressions in double square parentheses - [[]]. 

## Questions
1. Which of the following tells thymeleaf what variable to use for all the fields in the form?
	* th:object
	* th:action
	* th:text
	* th:field
	
2. Which of the following tells thymeleaf what variable attribute (variable.attribute) to map to a particular input control?
	* th:object
	* th:action
	* th:text
	* th:field
	
3. Which of the following tells thymeleaf what route to use to submit the form to?
	* th:object
	* th:action
	* th:text
	* th:field	

4. Webpages are usually loaded using which HTML verb?
	* GET
	* PUT
	* POST
	* DELETE

5. Web forms are usually submitted using which HTML verb?
	* GET
	* PUT
	* POST
	* DELETE
	
	
	
[Github Repository](https://github.com/ajhenley/SpringBoot_04)
