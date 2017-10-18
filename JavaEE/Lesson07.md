<!-- enter lesson number and title below separated by hyphen-->
# Lesson 7 - Validating form data

## Learning Objectives
* Create dynamic web application
* Add a servlet to the dynamic web application
* Add a JSP (Java Server Page)
* Create an HTML form on the JSP
* Validate the values received by the servlet
* Redirect user back to form if invalid data is entered
* Use the Java Standard Tag Library to display form values

## The Walkthrough

1. Create a Java Dynamic Web Application
	* Name it Lesson07
	* Hit next until you finish the wizard, and then wait until it's done.    

2. Create a Servlet
	* Right click on com.example.demo and click New -> Class
	* Name it ProcessServlet.java
	* Edit it to look like this:

```java
import java.io.IOException;

import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/ProcessForm")
public class ApplicationServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws	ServletException, IOException {

		String nextPage = "/login.jsp";
		getServletContext().getRequestDispatcher(nextPage).forward(request,response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		HttpSession session = request.getSession();

		String email = request.getParameter("email");
		String password = request.getParameter("password");

		String message = "";
		String nextPage = "/login.jsp";

		//check for null values then check for empty (blank) values... check null first!
		if(email!=null && !email.isEmpty() && isValidEmailAddress(email)){
			//email contains data.... check the password
			if(password!=null && !password.isEmpty()){
				//check the database for the valid email and password
				//we'll learn about databases later, right now, just
				//check the values to illustrate the concept
				if(email.equalsIgnoreCase("duke@java.com") && password.equals("java123"))
				{
					message = "Thank you, you are valid";  
					session.setAttribute("message", message);
					session.setAttribute("email",email);
					session.setAttribute("password",password);
					nextPage = "/output.jsp";
				}else{
					message += "Email or Password is invalid. Try again!<br/>";
					session.invalidate();
					nextPage = "/login.jsp";
				}
			}else{
				message += "Null or blank values are not permitted!<br/>";
			}
		}else{
			message += "Null or blank values are not permitted!<br/>";
		}

		//Redirect to next page as indicated by the value of the nextPage variable
		getServletContext().getRequestDispatcher(nextPage).forward(request,response);
	}
	public static boolean isValidEmailAddress(String email) {
		   boolean result = true;
		   try {
		      InternetAddress emailAddr = new InternetAddress(email);
		      emailAddr.validate();
		   } catch (AddressException ex) {
		      result = false;
		   }
		   return result;
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
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<h1>Login Page</h1>

<form action="ProcessForm" method="post">
    Email:<input type="text" name="email"/><br/>
    Password:<input type="password" name="password"/><br/>
    <input type="submit" value="Log In">
</form>
<p>to login use duke@java.com and java123</p>
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
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Welcome to the site</title>
</head>
<body>
<h1><c:out value="${message}"></c:out></h1>
<h2>You entered the following values:</h2>
<p>Email: <c:out value="${email}"></c:out></p>
<p>Password: <c:out value="${password}"></c:out></p>
</body>
</html>

```

Run your application and open a browser, if you type in the URL http://localhost:8080/login.jsp

## What is Going On
JavaMail is a Java API build into Java EE used to send and receive email. Java Mail is distributed via GitHub:
```https://javaee.github.io/javamail/#Download_JavaMail_Release```



## Questions
