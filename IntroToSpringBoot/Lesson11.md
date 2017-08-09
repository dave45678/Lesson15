# Lesson 11 - Hello World with Twitter Bootstrap 
## The Walkthrough 

1. Create a Spring Boot Application 
	* Name it SpringBoot_11 
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
    public String index(){
        return "index";
    }
    
    @RequestMapping("/page2")
    public String page2(){
        return "page2";
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
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Bootstrap 101 Template</title>

</head>
<body>
    <div class="container">
        <div class="jumbotron">
            <h1>Hello, world!</h1>
            <p>...</p>
            <p><a class="btn btn-primary btn-lg" href="#" role="button">Learn more</a></p>
        </div>
    </div>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>

</body>
</html>
```
  * Go to http://getbootstrap.com/gettingh-started and copy the Bootstrap CDN links
  * Paste that code right above the </head> tag

4. Run your application and open a browser, if you type in the URL http://localhost:8080 you should see this: 
![](https://github.com/ajhenley/unofficialguides/blob/master/IntroToSpringBoot/img/Lesson11.png)

## What is Going On
