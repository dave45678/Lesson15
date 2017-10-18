<!-- enter lesson number and title below separated by hyphen-->
# Lesson 6 - Handling form values safely with JavaServer Pages Standard Tag Library (JSTL)
## Learning Objectives
* Create dynamic web application
* Add a servlet to the dynamic web application
* Add a JSP (Java Server Page)
* Create an HTML form on the JSP
* Capture the form values in the servlet
* Redirect to output page from the servlet
* Display form values on the output page
* Use the Java Standard Tag Library to safely display form values

## The Walkthrough

1. Create a Java Dynamic Web Application
	* Name it Lesson06
	* Hit next until you finish the wizard, and then wait until it's done.    

2. Create a Servlet
	* Right click on com.example.demo and click New -> Class
	* Name it ProcessServlet.java
	* Edit it to look like this:

```java
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import customTools.DbUser;

@WebServlet("/ProcessForm")
public class ProcessForm extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws	ServletException, IOException {
			doPost(request,response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
	    throws ServletException, IOException {
		String email = request.getParameter("email");
		String password = request.getParameter("password");
		String message = "";
    String nextPage = "/output.jsp";
		session.setAttribute("email",email);
		session.setAttribute("password",password);

		//Redirect to next page as indicated by the value of the nextURL variable
		getServletContext().getRequestDispatcher(nextURL).forward(request,response);
	}
}
```

3. Create the Login JSP
  * Create a new Java Server Page (JSP)
	* Name it login.jsp
	* Edit it to look like this:
```html
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html/>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Welcome to My Site</title>
</head>
<body>
<h1>Login Page</h1>

<form action="ProcessForm" method="post">
	Email:<input type="text" name="email"/><br/>
	Password:<input type="password" name="password"/><br/>
	<input type="submit" value="Log In">
</form>

</body>
</html>
```

4. Create the Output JSP
* Create a new Java Server Page (JSP)
* Name it output.jsp
* Edit it to look like this:
```html
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>   
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<title>Lesson 6</title>
</head>
<body>
<h1>You entered the following values:</h1>
<p>Email: <c:out value="${email}"></c:out></p>
<p>Password: <c:out value="${password}"></c:out></p>
</body>
</html>
```

Run your application and open a browser, if you type in the URL http://localhost:8080/login.jsp

## What is Going On

The JSTL out tag protects your site from text entered by the user that could possibly execute a script.

## Questions
* How does the JSTL out tag protect you from XSS attacks?
It escapes the HTML code input by the user and replaces it with safe character entities.
* What is a character entity?
HTML Code consists of certain characters such as less than (<) or greater than (>) signs that indicate the start or end of a tag.
* Try this:
Add the following code to your output.jsp page and run your application again:
```<script>alert('You have been hacked!');</script>">```

Now modify the code above to include JSTL out tags and run your application again:
```<c:out value="<script>alert('You have been hacked!');</script>"></c:out>```

* How much damage can one do with JavaScript?
* Could a user enter
