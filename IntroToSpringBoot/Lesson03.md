# Lesson 3 - Hello World with External Variables 
## Learning Objectives
* Loading a value in the template from the messages.properties file

## The Walkthrough 

1. Create a Spring Boot Application 
	* Name it SpringBoot_03 
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
        return "hometemplate";
    }
}
```

3. Create a Template 
  	* Right click on templates and click New -> Html 
	* Name it hometemplate.html 
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
    <p th:text="#{static.message}"></p>
</body>
</html>
```

4. Create a messages.properties file 
  	* Right click on resources and click New -> File 
	* Name it messages.properties 
	* Edit it to look like this:
```
static.message=Hello World!
```

Run your application and open a browser, if you type in the URL http://localhost:8080 you should see this: 
![Running your 3rd Spring Boot Application](https://github.com/ajhenley/unofficialguides/blob/master/IntroToSpringBoot/img/Lesson03.png "Running your 2nd Spring Boot Application")

## What is Going On
The messages.properties file is where you will put all text that will be shown to users within your application. If you are translating text into other languages, you can create files for each language using the locale for that language, e.g. message_es.properties (for Spanish). This makes it easy to display text consistently across the application and also to create custom messages that can be used for validation errors. 
 
The "#{}" in the template indicates that a pre-defined message should be displayed. This is a Thymeleaf message expression.  

You are using this message expression to tell the template that text should be displayed within the paragraph tag, and that text should be the value that has been set for static.message in the message properties file (or the relevant locale file if the user chooses a different language).   

Again, there is also static text in the HTML file - this is the Hello World text within the level 2 heading tags. 

For more information about Thymeleaf expressions, see the “Thymeleaf Expression Sytnax” section of the link below:  
http://www.thymeleaf.org/doc/articles/standarddialect5minutes.html

## Question
If you have an entry in your messages.properties that looks like:  myval.name=Alton, which of the following would work on the template?  
	a &lt;div th:text="#{myval}">&lt;/div>  
	b &lt;div th:text="#myval.name">&lt;/div>   
	c &lt;div> th:text="#{myval}"&lt;/div>   
	d &lt;div th:text="#{myval.name}">&lt;/div>   

[Github Repository](https://github.com/ajhenley/SpringBoot_03)
