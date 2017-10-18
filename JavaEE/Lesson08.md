<!-- enter lesson number and title below separated by hyphen-->
# Lesson 8 - Display Customer List with the JavaServer Pages Standard Tag Library (JSTL)

## Learning Objectives
* Create dynamic web application
* Add a servlet to the dynamic web application
* Add a JSP (Java Server Page)
* Create an HTML form on the JSP
* Capture the form values in the servlet
* Adding the form values to the Session
* Redirect to output page from the servlet
* Display form values on the output page
* Use the Java Standard Tag Library to safely display form values

## Overview
The JSTL (JSP Standard Tag Library provides tags to simplify common JSP tasks.

EL (Expression Language) makes it easy to use beans. EL has a compact syntax and allows you to access nested properties. EL can handle null values.

A primary feature of JSP is support for expression language (EL). This makes it easy to access data stored in JavaBeans.
EL allows you to access a bean using syntax such as ```${name}``` for for a private member variable that is accessible via a getter method, ```getName()```.

Before you can use JSTL tags in your page you need to import two jar files and include the taglib directive.
Both go in the ```WebContent/WEB-INF/lib``` folder of a dynamic web application.  
You'll find the jar files on your desktop in the JAR Files folder. Or you can search for them online.

### JAR (Java Archive) Files required for JSTL (Java Standard Tag Library)
* ```javax.servlet.jsp.jstl-api-1.2.1.jar```
* ```taglibs-standard-impl-1.2.5```

You will need to add a taglib directive to the top of your JSP page (usuallly just above the opening html tag)

```html
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
```

## The Walkthrough

1. Create a Java Dynamic Web Application
	* Name it Lesson08
	* Hit next until you finish the wizard, and then wait until it's done.    

2. Create a Servlet
	* Right click on com.example.demo and click New -> Class
	* Name it ProcessForm.java
	* Edit it to look like this:

```java
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.example.demo.Customer;

@WebServlet("/ProcessForm")
public class ProcessForm extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		List<Customer> customers = new ArrayList<Customer>();
		customers.add(new Customer("Kristina Simpson","94 Grant Street",
									"Chester","MO","46782"));
		customers.add(new Customer("Vanessa	Brown","4337 Prudence Street",
									"White River Junction","ND","48219"));
		customers.add(new Customer("Darryl Porter","608 Berkley Street",
									"Columbus","OH","64062"));
		customers.add(new Customer("Joseph Twiggs","1719 Boone Street",
									"Lawson","KY","95814"));

		request.setAttribute("customers", customers);

		getServletContext().getRequestDispatcher("/output.jsp").forward(request, response);

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}

}

```

3. Create a customer class

```java
package com.example.demo;

public class Customer {
	private String name;
	private String address;
	private String city;
	private String state;
	private String zip;

	public Customer(){

	}

	public Customer(String name, String address, String city, String state, String zip) {
		super();
		this.name = name;
		this.address = address;
		this.city = city;
		this.state = state;
		this.zip = zip;
	}


	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getCity() {
		return city;
	}
	public void setCity(String city) {
		this.city = city;
	}
	public String getState() {
		return state;
	}
	public void setState(String state) {
		this.state = state;
	}
	public String getZip() {
		return zip;
	}
	public void setZip(String zip) {
		this.zip = zip;
	}

}


4. Create a JSP. Make it look like this:
```html
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<h1>Customer List</h1>
<table class="table table-bordered">
    <thead>
        <tr><th>User</th><th>Post</th><th>Date</th></tr>
    </thead>
    <tbody>
    <c:forEach var="customer" items="${customers}">
        <tr><td><c:out value="${customer.name}"/></td>
        <td><c:out value="${customer.address}"/></td>
				<td><c:out value="${customer.city}"/></td>
				<td><c:out value="${customer.state}"/></td>
				<td><c:out value="${customer.zip}"/></td>
        </tr>
    </c:forEach>
    </tbody>
    </table>
</body>
</html>
```


Run your application and open a browser, if you type in the URL http://localhost:8080 you should see this:
![Running your first Spring Boot Application](img/Lesson01.png "Running your first Spring Boot Application")

## What is Going On
Note: If Eclipse gives 404 error then move the Servlet to the default package by removing the package statement entirely.


## Questions
