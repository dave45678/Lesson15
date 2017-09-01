<!-- enter lesson number and title below separated by hyphen-->
# Lesson 3 - Hello World with Servlet and external variables
## Learning Objectives
* Create dynamic web application
* Create Servlet
* Create JSP (Java Server Page)
* Create a Resource Bundle to store messages and properties

## The Walkthrough

1. Create a Servlet
	* Right click on com.example.demo and click New -> Servlet
	* Name it HelloWorld.java
	* Edit it to look like this:

```java
package com.example.demo;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet("/Lesson01")
public class Lesson01 extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

        //redirect to the JSP
		request.getRequestDispatcher("/output.jsp").forward(request, response);

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}
}

```

2. Create an HTML Page
  * Right click on templates and click New -> Html
	* Name it output.html
	* Edit it to look like this:

```html
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

Run your application and open a browser, if you type in the URL http://localhost:8080 you should see this:
![Running your first Java EE Application](img/Lesson01.png "Running your first Spring Boot Application")

## What is Going On
We notice two methods in this class: <code>doGet()</code> and <code>doPost()</code>. The first one anwsers by HTTP to the reception of a GET request. The second to the reception of a POST request. As we want that in the both cases the servlet processes the request, <code>doPost()</code> forwards to <code>doGet()</code>. When we browse to the servlet url then the doGet() method is called. DoPost would only be called by a web form. We'll work with that later.

####Call the servlet from the browser
http://localhost:999/Lesson01/HelloWorld

####Result in the browser:
<pre>
Hello, World!
</pre>

####Mapping the Servlet to the URL
You can use the @WebServlet annotation to map a servlet to a URL pattern. Simply code the URL pattern in parenthesis following the annotation, ```@WebServlet("/HelloWorld")```.

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
