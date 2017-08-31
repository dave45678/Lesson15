<!-- enter lesson number and title below separated by hyphen-->
# Lesson 6 - Handling form values with JSTL
## Learning Objectives
* Use the Java Standard Tag Library to display form values
*

## The Walkthrough

1. Create a Servlet
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

2. Create the Login JSP
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

3. Create the Output JSP
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

<!-- try this:
request.setAttribute("message", "<script>alert(\"You have been hacked!\");</script>");
-->


## Questions
