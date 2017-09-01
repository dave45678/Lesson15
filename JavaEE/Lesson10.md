<!-- enter lesson number and title below separated by hyphen-->
# Lesson
## Learning Objectives
*
*

## The Walkthrough

1. Create a Controller
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

2. Create a Template
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

Run your application and open a browser, if you type in the URL http://localhost:8080 you should see this:
![Running your first Spring Boot Application](img/Lesson01.png "Running your first Spring Boot Application")

## What is Going On



## Questions


[Github Repository](https://github.com/ajhenley/SpringBoot_01)
