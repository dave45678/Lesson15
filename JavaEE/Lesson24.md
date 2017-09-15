<!-- enter lesson number and title below separated by hyphen-->
# Lesson 24 - Custom Error Pages
## Learning Objectives
* Develop and implement custom error page for most common errors
* Develop and implement custom error page for Java errors

## The Walkthrough

1. Create a Java Dynamic Web Application
	* Name it Lesson02
	* Hit next until you finish the wizard, and then wait until it's done.    

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

3. Create a new JSP Page
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


Run your application and open a browser, if you type in the URL http://localhost:8080 you should see this:
![Running your first Spring Boot Application](img/Lesson01.png "Running your first Spring Boot Application")

## What is Going On



## Questions


[Github Repository](https://github.com/ajhenley/SpringBoot_01)
