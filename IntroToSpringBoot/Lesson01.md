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
```java
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

Run your application and open a browser, if you type in the url localhost:8080 you should see this: 
![alt text]()
