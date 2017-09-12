<!-- enter lesson number and title below separated by hyphen-->
# Lesson 2 - Hello World with Servlet and variable
## Learning Objectives
* Create dynamic web application
* Create Servlet
* Create JSP (Java Server Page)

## The Walkthrough

1. Create a Servlet
	* Right click on com.example.demo and click New -> Servlet
	* Name it HelloWorld.java
	* Edit it to look like this:

```java
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/HelloWorld")
public class ApplicationServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String message = "Hello, World!";

		request.setAttribute("message", message);

		//Redirect to output.jsp
		getServletContext().getRequestDispatcher("/output.jsp").forward(request,response);

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}
}

```

2. Create a new JSP Page
  * Right click on the WebContent folder and click New -> JSP
	* Name it output.jsp
	* The file will be placed in the WebContent folder
	* Edit it to look like this:

```html
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<h1>${message}</h1>
</body>
</html>
```

Run your application and open a browser, if you type in the URL http://localhost:8080 you should the message, Hello, World!

## What is Going On
We notice two methods in this class: <code>doGet()</code> and <code>doPost()</code>. The first one anwsers by HTTP to the reception of a GET request. The second to the reception of a POST request. As we want that in the both cases the servlet processes the request, <code>doPost()</code> forwards to <code>doGet()</code>. When we browse to the servlet url then the doGet() method is called. DoPost would only be called by a web form. We'll work with that later.

####Call the servlet from the browser
http://localhost:8080/Lesson02/HelloWorld

####Result in the browser:
<pre>
Hello, World!
</pre>

####Mapping the Servlet to the URL
You can use the @WebServlet annotation to map a servlet to a URL pattern. Simply code the URL pattern in parenthesis following the annotation, ```@WebServlet("/ApplicationServlet")```.

####Decomposition of the URL
Calling the servlet's URL from the browser will request the servlet. You can also call the servlet from a link or a form on a web page.

**The URL parts of the URL**:
Protocol: http or https
Domain: somedomain.com
Port (optional): the port which the servlet listens to
Root Entry Directory: the directory in which the servlet class file resides
Servlet Name: from the annotation mapping
[Protocol://][Domain]:[PORT]/[RootEntryDirectory]/[ServletName]

[Github Repository](https://github.com/ajhenley/SpringBoot_01)
