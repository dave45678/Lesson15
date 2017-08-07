# Lesson 1 - Hello World with Template 
## The Walkthrough 

1. Create a Spring Boot Application 
	* Name it SpringBoot_01 
	* Add the dependencies for the web and for thymeleaf 
	* Hit next until you finish the wizard, and then wait until it's done.    

2. Create a Controller 
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
  * Right click on templates and click New -> Html 
	* Name it hometemplate.html 
	* Edit it to look like this: 
```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <title>Title</title>
</head>
<body>
    <h2>Hello World!</h2>
</body>
</html>
```

Run your application and open a browser, if you type in the URL http://localhost:8080 you should see this: 
![Running your first Spring Boot Application](https://github.com/ajhenley/unofficialguides/blob/master/IntroToSpringBoot/Lesson01.png "Running your first Spring Boot Application")

## What is Going On
Lines 1 and 2 of HomeController.java import the classes into your project that make the @Controller 
and @RequestMapping annotations work.  

The @Controller annotation tells the compiler that there is a list of routes in this file that the user 
of the application can browse to within the HomeController class. By using this annotation, we have made 
the HomeController like a phone directory or reference list for our application, where all the routes 
are mapped out.  

@RequestMapping indicates what route or end point the user will visit. The method underneath the 
@RequestMapping annotation is run each time that route is called.  
In this case, the default route is the only route that is mapped out.  

When a user browses to http://localhost:8080 (or the default route on the port that has been set 
for the application if 8080 is not in use), then the application will return a template (html file) 
called hometemplate.html from the templates folder. The extension is left out because the application 
assumes the extension, and appends it to the filename at runtime.  

### What’s a Route?  
Think of this as a part of your application that that can be mapped out so that when you type an address 
in the browser, the application can visit it.  

The default route is mapped out using (“/”). This means that when you visit http://localhost:8080 or 
http://localhost:8080/ when the application is running, the application will run the code in the method 
under the @RequestMapping annotation for the default route.  
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
A template is a blueprint for a dynamic page. This is a page that can change based on the user’s interaction with the application. A template is different from a static page because what you will see can change depending on the user who is logged in, and the data that the user requests. A template is what allows you to greet a user based on the time of day, or a name that he/she enters. A static page cannot do this, because it will always be the same.  

Templating engines (like Thymeleaf) are used to show data that is passed from the application, which may changed depending on the user’s interaction with the application. Thymeleaf templates have  expressions in it that accept contextual information at runtime -  when the application is running.
