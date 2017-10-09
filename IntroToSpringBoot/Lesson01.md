# Lesson 1 - Hello World with Template 
## Learning Objectives
* Creating a Spring Boot Application
* Creating a Controller
* Creating a Thymeleaf Template

## The Walkthrough 

1. Create a Spring Boot Application 
	* Go to the menu and click File -> New Project
	* On the left-hand side click on Spring Initializr and click Next on the lower right
	* Go to the Name field and set the name to SpringBoot_01 and click Next on the lower right
	* Select the dependencies web and thymeleaf
		* On the left column click on Web and then click the checkbox next to Web in the middle column
		* On the left column click on Template Engines and then click the checkbox next to Thymeleaf in the middle column
		* Click the Next button in the lower right hand corner
	* Change the project name field to SpringBoot_01 and click Finish
	* The wizard may take some time to finish, but if you are asked if you want to Add as Maven Project  then click the provided link
	* You know it is finished when there is a leaf with a power button in the upper right hand corner of your screen.
	
2. Create a Controller 
	* Click on the triangle next to your application’s folder in the left hand menu, this expands that folder
	* Expand the src folder
	* Expand the main folder
	* Expand the java folder
	* You should now be here:
	
	* Right click on com.example.demo and click New -> Class 
	* Name it HomeController.java 
	* Edit it to look like this: 
```java
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class HomeController {

    @RequestMapping("/")
    public String homePage(){
        return "index";
    }
}
```

3. Create a Template 
	* Expand the resources folder inside of the main folder
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
    <h2>Hello World!</h2>
</body>
</html>
```

4. Run your application 
	* To run the application click the run button in the upper right hand corner:

5. View your Application
	* Open Google Chrome and type in the URL http://localhost:8080 and hit enter. You should see this

![Running your first Spring Boot Application](https://github.com/ajhenley/unofficialguides/blob/master/IntroToSpringBoot/img/Lesson01.png "Running your first Spring Boot Application")

## What is Going On
Lines 1 and 2 of HomeController.java import the classes into your project that make the @Controller 
and @RequestMapping annotations work.  

The @Controller annotation tells the compiler that there is a list of paths in this file that the user 
can browse to within the HomeController class. By using this annotation, we have made 
the HomeController like a phone directory or reference list for our application, where all the routes 
are mapped out.  

@RequestMapping indicates what path or end point the user will visit. The method following the 
@RequestMapping annotation is run each time that the path is used.  
In this case, the default path is the only path that is specified out.  

When a user browses to http://localhost:8080 (or the default path on the port that has been set 
for the application if 8080 is not in use), then the application will return a template (html file) 
called hometemplate.html from the templates folder. The extension is left out because the application 
assumes the extension, and appends it to the filename at runtime.  

### What’s a Path?  
A path is a set of directions from the base URL that your application can respond to. If your site is served up at 
http://localhost:8080, then telling a user to go to http://localhost:8080/add means that the path is "/add".  
Telling a user to load http://localhost:8080/ means that the path is "/".

The default path is indicated by using (“/”). This means that when you visit http://localhost:8080 or 
http://localhost:8080/ when the application is running, the application will run the code in the method 
following the @RequestMapping annotation for the default path.  
@RequestMapping maps out both GET and POST requests. 

The easiest way to think about GET and POST requests is that you use GET requests in your application 
when the user is getting information from the server. It results in a response that he user can see - 
e.g. browsing to a page. A user can type parameters in the URL to provide additional information, 
e.g. his/her name, and those will provide extra information to the application that it can use to 
show the user more information based on those parameters. Since the parameters in the URL are visible 
to the user, make sure that you use GET requests for parameters that are not sensitive 
(e.g. NO PASSWORDS!!) 

You will use POST requests for all routes that are posting or sending information to the server. If a 
user enters details in a form, use a POST request so that when the user clicks the “Submit” button, the 
details will be sent to the server and will be hidden from view (i.e. they will not be in the URL).  
For more about GET and POST requests, see these articles:  
* http://www.diffen.com/difference/GET-vs-POST-HTTP-Requests 
* https://www.w3schools.com/tags/ref_httpmethods.asp 

By default, @RequestMapping maps to a GET request. 

### What’s a template?  
A template is a blueprint for a dynamic page. A template is different from a static page because what you will see can change depending on the user who is logged in, and the data that the user requests. A template is what allows you to greet a user based on the time of day, or a name that he/she enters. A static page cannot do this, because it will always be the same.  

Templating engines (like Thymeleaf) are used to show data that is passed from the application, which may change depending on the user’s interaction with the application. 

## Questions
1. What is a template?
	* a blueprint
	* a static page
	* a controller
	* a variable
2. What's a route?
	* a way to get home
	* a page request path
	* a url
	* a way to interpret a variable
3. What is the difference between GET and POST?
	* one is an action and other isn't
	* post is for sending data through email
	* get is for asking for things
	* get loads forms and post submits them
	
[Github Repository](https://github.com/ajhenley/SpringBoot_01)
