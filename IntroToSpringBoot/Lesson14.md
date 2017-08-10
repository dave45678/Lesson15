# Lesson 14 - Running in Debug Mode 
## The Walkthrough 

1. Create a Spring Boot Application 
	* Name it SpringBoot_14 
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

import java.util.Random;

@Controller
public class HomeController {

    @RequestMapping("/")
    public String index(Model model){
        Random rnd = new Random();
        int i = rnd.nextInt();
        model.addAttribute("rnd", i);
        return "randomnum";
    }
}
```

3. Create a Template 
  	* Right click on templates and click New -> Html 
	* Name it randomnum.html 
	* Edit it to look like this: 
```html
<!DOCTYPE html>
<html lang="en" xmlns:th="www.thymeleaf.org">
<head>
    <meta charset="utf-8" />
    <title>Bootstrap 101 Template</title>

</head>
<body>
  <h2>Random Number</h2>
  <h1 th:text="${rnd}"></h1>
</body>
</html>
```

4. Run your application and open a browser, if you type in the URL http://localhost:8080 you should see something like this: 
![](https://github.com/ajhenley/unofficialguides/blob/master/IntroToSpringBoot/img/Lesson14a.png)

5. Now run your application in debug mode. You can do this one of two ways, either:
    * Go to the run menu and select Debug <program name> from the menu, or
    * Using the run section on the command bar, select the button that looks like a bug:
![](https://github.com/ajhenley/unofficialguides/blob/master/IntroToSpringBoot/img/Lesson14b.png)
    
6. Create a breakpoint
    * Open your HomeController.java
    * Click on left of line 15, next to the line number and red dot should appear like this:
    ![](https://github.com/ajhenley/unofficialguides/blob/master/IntroToSpringBoot/img/Lesson14c.png)

7. With your application still running in debug mode, navigate to the url http://localhost:8080, you should see something like this:
![](https://github.com/ajhenley/unofficialguides/blob/master/IntroToSpringBoot/img/Lesson14d.png)

8. If you look at Intellij, it should now look like this:
![](https://github.com/ajhenley/unofficialguides/blob/master/IntroToSpringBoot/img/Lesson14e.png)

9. Click on the step-over button ![](https://github.com/ajhenley/unofficialguides/blob/master/IntroToSpringBoot/img/Lesson14f.png)
 and look at the value of i. You are examining the value of a variable while the program is running. 
 
 10. Click the run-until button ![](https://github.com/ajhenley/unofficialguides/blob/master/IntroToSpringBoot/img/Lesson14g.png)
 to continue.


## What is Going On
