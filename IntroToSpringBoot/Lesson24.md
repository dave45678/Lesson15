# Lesson 24 - Adding Twitter Bootstrap (or any other template) to Spring Boot 
## The Walkthrough 

1. Start with an application based on Lesson 17 (an application with at least basic security) 

2. Get Twitter Bootstrap
  * Download the file by using this link: 
  https://github.com/twbs/bootstrap/releases/download/v3.3.7/bootstrap-3.3.7-dist.zip
  * Unzip the file 
  * Copy the css, fonts and js folders into the static folder inside the resources folder
  
3. Create a Bootstrap Fragment Template
  * Right click on templates and click New -> Html 
	* Name it base.html 
	* Edit it to look like this: 
```html
<!DOCTYPE html>
<html lang="en" xmlns:th="www.thymeleaf.org">
<head th:fragment="headstuff">
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Bootstrap 101 Template</title>
    <link href="/css/bootstrap.min.css" rel="stylesheet" />
    <style>
        body { padding-bottom: 70px; }
    </style>
    <!--[if lt IE 9]>
    <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
    <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
</head>
<body>
<nav class="navbar navbar-default" th:fragment="navbar">
    <div class="container-fluid">
        <div class="navbar-header">
            <button type="button" class="navbar-toggle collapsed" 
                    data-toggle="collapse" 
                    data-target="#bs-example-navbar-collapse-1" 
                    aria-expanded="false">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand" href="#">LearningByCoding</a>
        </div>
        <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
            <ul class="nav navbar-nav">
                <li><a href="/">Home </a></li>
                <li><a href="/secure">Secure </a></li>
            </ul>
            <ul class="nav navbar-nav navbar-right">
                <li><a href="/login">Login</a></li>
            </ul>
        </div><!-- /.navbar-collapse -->
    </div><!-- /.container-fluid -->
</nav>

<h1>Hello, world!</h1>

<nav class="navbar navbar-default navbar-fixed-bottom" th:fragment="footer">
    <div class="container">
        <ul class="nav navbar-nav">
            <li><a href="/">Home </a></li>
            <li><a href="/secure">Secure </a></li>
            <li><a href="#">Copyright 2017 - Learning By Coding</a></li>
        </ul>
    </div>
</nav>

<th:block th:fragment="jslinks">
    <script
       src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js">
    </script>
    <script src="/js/bootstrap.js"></script>
</th:block>
</body>
</html>
```

4. Edit the index Template
  * Edit it to look like this: 
```html
<!DOCTYPE html>
<html lang="en" xmlns:th="www.thymeleaf.org">
    <head th:replace="base :: headstuff"></head>
    <body>
        <nav th:replace="base :: navbar"></nav>
        <div class="container">
            <div class="jumbotron">
                <h1>Hello, world!</h1>
                <p>...</p>
                <p><a class="btn btn-primary btn-lg"
                      href="/secure" role="button">Go to Secure</a>
                </p>
            </div>
        </div>
        <nav th:replace="base :: footer"></nav>
        <th:block th:replace="base :: jslinks"></th:block>
    </body>
</html>
```

5. Create a Template
  * Right click on templates and click New -> Html 
	* Name it secure.html 
	* Edit it to look like this: 
```html
<!DOCTYPE html>
<html lang="en" xmlns:th="www.thymeleaf.org">
<head th:replace="base :: headstuff"></head>
<body>
<nav th:replace="base :: navbar"></nav>
<div class="container">
    <div class="jumbotron">
        <h1>You have reached the Secure Page</h1>
        <p><a class="btn btn-primary btn-lg"
              href="/" role="button">Go to Home</a>
        </p>
    </div>
</div>
<nav th:replace="base :: footer"></nav>
<th:block th:replace="base :: jslinks"></th:block>
</body>
</html>
```

6. Edit the Controller 
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
    
    @RequestMapping("/secure")
    public String secure(){
        return "secure";
    }
}
```

7. Run your application and open a browser, if you type in the URL 
http://localhost:8080 you should see you home page styled with TwitterBootstrap.
