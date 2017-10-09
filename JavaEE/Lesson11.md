<!-- enter lesson number and title below separated by hyphen-->
# Lesson 11 - Hello World with Twitter Bootstrap
## Learning Objectives
* Create a dynamic web application
* Understand the Twitter Bootstrap CDN
* Add Twitter Bootstrap Jumbotron to the application

## The Walkthrough

1. Create a Servlet
	* Edit it to look like this:

```java
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/HomeServlet")
public class HomeServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String message = "Hello Twitter Bootstrap!";
		request.setAttribute("message",message);
		request.getRequestDispatcher("/index.jsp").forward(request, response);
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
```

3. Create a Template
  	* Right click on WebContent and select New -> Html
	* Name it index.html
	* Edit it to look like this:
```html
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Bootstrap 101 Template</title>
<!--add bootstrap CDN links just above the closing head tag -->
</head>
<body>
 <div class="container">
        <div class="jumbotron">
            <h1>${message}</h1>
            <p>...</p>
            <p><a class="btn btn-primary btn-lg" href="#" role="button">Learn more</a></p>
        </div>
    </div>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>

</body>
</html>
```
  * Go to http://getbootstrap.com/getting-started and copy the Bootstrap CDN links
  * Paste that code right above the  &lt;/head> tag
  * Note that this code is not HTML5 compliant. To make it compliant add the closing tags for the </link> element.

4. Run your application and open a browser, if you type in the URL http://localhost:8080.


## What is Going On

Congratulations! You have created your first styled HTML page. This is a page that includes the Bootstrap library. Bootstrap contains CSS and JavaScript files that you can use to style your pages. To find out more about how to style your pages, go to the [Twitter Boostsrap website](http://getbootstrap.com/components).

### Your JSP page
The JSP page displays a page that looks a bit better than the others we have seen so far. This is because of Bootstrap.

The CDN (Content Delivery Network) links make sure that the CSS classes are available to the page, so that your application can 'dress up' the JSP file according to the rules laid out. These files are online, and should be easy for your application to access if it is on a sever with access to the internet.

#### Attributes and classes are important
The JSP file interprets these rules using the ```'class='``` attribute, which indicate what fonts, background styles and images, font size(s), and alignment, among other things, will be used on the page.


## Questions
* Will this work on an HTML page? Try it and see.
