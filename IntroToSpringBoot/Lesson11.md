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
}
```

3. Create a Template 
  	* Right click on templates and click New -> Html 
	* Name it index.html 
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
  * Go to http://getbootstrap.com/getting-started and copy the Bootstrap CDN links
  * Paste that code right above the '</head>' tag

4. Run your application and open a browser, if you type in the URL http://localhost:8080 you should see this: 
![](https://github.com/ajhenley/unofficialguides/blob/master/IntroToSpringBoot/img/Lesson11.png)


## What is Going On

Congratulations! You have created your first styled HTML page. This is a page that includes the Bootstrap libary, which is a number of CSS and JavaScript files that you can use to style your pages. To find out more about how to style your pages, go to the [Twitter Boostsrap website](http://getbootstrap.com/components). 

### The Controller
Here, the default route maps to index.html. The Thymeleaf dependency tells your application that any views from the page will be rendered in HTML, and so the application looks in the templates folder by default, and assumes that the file extension is .html. This is why you do not need to add '.html' to the file name when you display the page. 

Your applicaiton will display the text of the HTML file in your browser, which will interpret the HTML tags and render (display) them appropriately. 

It is particularly important to add the  <meta name="viewport" content="width=device-width, initial-scale=1" /> line to make sure that your website is RESPONSIVE, and styles the page according to the dimensions of the device you are using to browse the website. 

### The View 
The HTML page displays a page that looks a bit better than the others we have seen so far. This is because of Bootstrap. 

The CDN (Content Delivery Network) links make sure that the CSS classes are available to the page, so that your application can 'dress up' the HTML file according to the rules laid out. These files are online, and should be easy for your application to access if it is on a sever with access to the internet. 

The HTML file interprets these rules using the 'class=' attribute, which indicate what fonts, background styles and images, font size(s), and alignment, among other things, will be used on the page. 



