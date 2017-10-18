<!-- enter lesson number and title below separated by hyphen-->
# Lesson 1 - Hello World with Servlet and no variable
## Learning Objectives
* Create dynamic web application
* Add a Servlet to the dynamic web application
* Add an HTML (Hypertext Markup Language) page to display text
* Enter text on the HTML page for the user to see

## The Walkthrough

1. Create a Java Dynamic Web Application
	* Name it Lesson01
	* Hit next until you finish the wizard, and then wait until it's done    

2. Create a Servlet
	* Right click on the src folder under JavaResources
	* Select New -> Servlet
	* Name it ProcessForm.java
	* Edit it to match the code shown below

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

3. Create an HTML Page
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
<!--todo screenshot maybe -->

## What is Going On
Hypertext Markup Language (HTML) is the standard markup language for creating web pages and web applications.

We notice two methods in this class: <code>doGet()</code> and <code>doPost()</code>. The first one anwsers by HTTP to the reception of a GET request. The second to the reception of a POST request. As we want that in the both cases the servlet processes the request, <code>doPost()</code> forwards to <code>doGet()</code>. When we browse to the servlet url then the doGet() method is called. DoPost would only be called by a web form. We'll work with that later.

The ```@WebServlet``` attribute. It contains the url for the serlvet
```@WebServlet("/ProcessForm")```
can be executed by right-click on the servlet and select Run As.
You servlet url will be ```http://localhost:8080/Lesson09/ProcessForm```

#### Call the servlet from the browser
http://localhost:8080/Lesson01/HelloWorld

#### Result in the browser:
<pre>
Hello, World!
</pre>

#### Mapping the Servlet to the URL
You can use the @WebServlet annotation to map a servlet to a URL pattern. Simply code the URL pattern in parenthesis following the annotation, ```@WebServlet("/HelloWorld")```.

#### Decomposition of the URL
Calling the servlet's URL from the browser will request the servlet. You can also call the servlet from a link or a form on a web page.

**The URL parts of the URL**:
Protocol: http or https
Domain: somedomain.com
Port (optional): the port which the servlet listens to
Root Entry Directory: the directory in which the servlet class file resides
Servlet Name: from the annotation mapping
```[Protocol://][Domain]:[PORT]/[RootEntryDirectory]/[ServletName]```
