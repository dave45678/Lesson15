<!-- enter lesson number and title below separated by hyphen-->
# Lesson 5 - Creating a Java Bean
## Learning Objectives
* Create dynamic web application
* Add a servlet to the dynamic web application
* Add a JSP (Java Server Page)
* Create a User Bean
* Populate the bean from a web form
* Add the bean to the session
* Display the values of the bean on a JSP

## The Walkthrough

1. Create a Java Dynamic Web Application
	* Name it Lesson05
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
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<a href="HomeServlet">Go to Home Page</a>
<h1>You entered the following values:</h1>
<p>Email: ${email}</p>
<p>Password: ${password}</p>
</body>
</html>
```
5. Create a Java Bean
* Create a new class
* Name it User
* Modify your User class to look like this:

```java
package com.example.demo;

public class User {
	private String userEmail;
	private String userPassword;

	public User(){

	}
	public User(String email, String password){
		setUserEmail(email);
		setUserPassword(password);
	}

	public String getUserEmail() {
		return userEmail;
	}
	public void setUserEmail(String userEmail) {
		this.userEmail = userEmail;
	}
	public String getUserPassword() {
		return userPassword;
	}
	public void setUserPassword(String userPassword) {
		this.userPassword = userPassword;
	}

}
```

Run your application and open a browser, if you type in the URL http://localhost:8080/login.jsp

## What is Going On



## Questions
