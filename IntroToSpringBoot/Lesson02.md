# Lesson 2 - Hello World with Variables 
## Learning Objectives
* Passing a variable to the template from the controller
* Using the thymeleaf th:text attribute

## The Walkthrough 

1. Create a Spring Boot Application 
	* Name it SpringBoot_02 
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

@Controller
public class HomeController {

    @RequestMapping("/")
    public String homePage(Model model){
        model.addAttribute("myvar", "Say hello to the people.");
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
    <p th:text="${myvar}"></p>
</body>
</html>
```

Run your application and open a browser, if you type in the URL http://localhost:8080 you should see this: 
![Running your 2nd Spring Boot Application](https://github.com/ajhenley/unofficialguides/blob/master/IntroToSpringBoot/img/Lesson02.png "Running your 2nd Spring Boot Application")

## What is Going On
In the homePage method of the HomeController, we are passing data to the template.  

An object named model, of class Model, is being passed as an argument to the homePage method. This will create a container that can hold as many objects that you put in it for use by your template. Think of it as a container that is passed between the controller and the view so that they can share objects.  

The objects that the model holds are called attributes. This is why you add attributes to the model, using the model.addAttributes method. The arguments passed are the name you want the object to have (this is what your templates will call that object), and the actual object you want to make available.   

In the above example, a string of value “Say hello to the people” is being passed to the model, and it is named “myvar”. This is why “myvar" is being used in the template, and it displays the value that was assigned to it from the HomeController.  

The "${}" in the template indicates that a variable is expected, and its value should be displayed. This is a Thymeleaf variable expression.  

You are using this variable expression to tell the template that text should be displayed within the paragraph tag, and that the text should be the value of the object called myvar.  

There is also static text in the HTML file - this is the Hello World text within the level 2 heading tags. It doesn't change at runtime. The user will see both types of text when the hometemplate file is displayed.

## Questions
1. If you declared your controller method like this: public String myVals(Model model, then how do you send a value to the template?
	* model.add("val", "greeting")
	* model.addAttribute("val", "greeting")
	* model.attribute("val","greeting")
2. If you successfully send a variable called "myvar" to the template, which of the following would work on the template?
	* &lt;div th:text="${myvar}">&lt;/div>
	* &lt;div th:text="myvar">&lt;/div>
	* &lt;div> th:text="${myvar}"&lt;/div>
	* &lt;div "${myvar}">&lt;/div>

[Github Repository](https://github.com/ajhenley/SpringBoot_02)
