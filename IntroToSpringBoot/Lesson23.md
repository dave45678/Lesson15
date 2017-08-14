# Lesson 23 - Custom Error Pages 
## The Walkthrough 

1. Create a Spring Boot Application 
	* Name it SpringBoot_16 
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

    @RequestMapping("/2")
    public String page2(){
        return "page2";
    }
}
```

3. Create an Base Template 
  	* Right click on templates and click New -> Html 
	* Name it base.html 
	* Edit it to look like this: 
```html
<!DOCTYPE html>
<html lang="en" xmlns:th="www.thymeleaf.org">
<head>
    <meta charset="UTF-8" />
    <title>Title</title>
</head>
<body>
    <div th:fragment="navlinks">
        <a href="/">index</a> - <a href="/2">Page 2</a> - <a href="/3">Page 3</a>
    </div>
    <div th:fragment="footer">copyright 2017</div>
</body>
</html>
```

4. Create an Index Template 
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
        <div th:replace="base :: navlinks"></div>
        <h2>Index Page</h2>
        <div th:replace="base :: footer"></div>
    </body>
</html>
```

5. Create a Page2 Template 
  	* Right click on templates and click New -> Html 
	* Name it page2.html 
	* Edit it to look like this: 
```html
<!DOCTYPE html>
<html lang="en" xmlns:th="www.thymeleaf.org">
    <head>
        <meta charset="UTF-8" />
        <title>Title</title>
    </head>
    <body>
        <div th:replace="base :: navlinks"></div>
        <h2>Page 2</h2>
        <div th:replace="base :: footer"></div>
    </body>
</html>
```

6. Create an Error Template 
  	* Right click on templates and click New -> Html 
	* Name it error.html 
	* Edit it to look like this: 
```html
<!DOCTYPE html>
<html lang="en" xmlns:th="www.thymeleaf.org">
    <head>
        <meta charset="UTF-8" />
        <title>Title</title>
    </head>
    <body>
        <div th:replace="base :: navlinks"></div>
        <h2>Error. Page not found</h2>
        <div th:replace="base :: footer"></div>
    </body>
</html>
```

7. 

Run your application and open a browser, if you type in the URL http://localhost:8080 you should see this: 
![](https://github.com/ajhenley/unofficialguides/blob/master/IntroToSpringBoot/img/Lesson16a.png )

And if you type in the URL http://localhost:8080/2 you should see this: 
![](https://github.com/ajhenley/unofficialguides/blob/master/IntroToSpringBoot/img/Lesson16b.png )

But if you type in the URL http://localhost:8080/3 you will get an error, since there is not route for that 
page. By having a template called error, you can have error pages that look like the rest of your application.

