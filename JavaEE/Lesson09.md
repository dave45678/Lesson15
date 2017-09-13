<!-- enter lesson number and title below separated by hyphen-->
# Lesson 9 - Looping through a table from the database using JPA
## Learning Objectives
* connect to the mySQL database using JPA
* display all the records in one page

## The Walkthrough

1. Create a Servlet
	* Right click on com.example.demo and click New -> Class
	* Name it HomeController.java
	* Edit it to look like this:

```java
package com.example.demo;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet("/ProcessForm")
public class ProcessForm extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		doGet(request, response);
	}

}
```

2. Copy your JAR files to the WEB-INF\lib folder of your project
  * eclipselink.jar
	* javax.persistence_2.1.0.v201304241213.jar
	* mysql-connector-java-5.1.42-bin.jar

	Place these files in the WEB-INF\lib folder. Any other location may not be found by your program.

3. Create a JSP page called output.jsp
Right-click on the web content directory and select the option to add a new JSP file. Call it output.jsp.

4. Add the tag library directives at the top of your JSP
Open your output.jsp file and add the following code below the @Page directive

```html
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
```
5. Connect to the database using JPA
There are a lot of steps to follow for JPA and you must follow them in order.
* Right-click on your project name and select Properties
* Select Project Facets
* Select JPA
* Click the link for further configuration
On the next screen:
* Change the platform to EclipseLink
* Select the option to Disable Library Configuration
* Click Add Connection and select MySQL
* Click next
On the next screen:
* Select the driver for MySQL
    * you may have to remove the suggested JAR and replace it with your own
* Populate the following properties (your actual values may vary):
    * Database: unofficialGuides
		* URL: jdbc:mysql://localhost:3306/unofficialGuides
		* User: root
		* Password: password
		* Check the box to save the password
 * When you click the Test Connection button you should get a message that says Ping Succeeded.
 * Click Finish once you get this message.
 * Click OK
 On the next screen: Click Apply & OK

6.  Look in the JPA Content container inside your project and double­click the persistence.xml file
* This is the dialog box for configuring your persistence.xml file
* If you click the General tab, you will see the raw xml of the persistence file. It doesn’t look like much yet but as we set our configuration more tags will be added.
* On the General tab, set the Persistence Provider to
```org.eclipse.persistence.jpa.PersistenceProvider```
* Uncheck the Exclude unlisted classes checkbox
* Click on the connection tab
    * change the Transaction Type to Resource Local
    * After that, click the Populate from connection link
    * A dialog will appear asking you to select your connection, click Ok after you have done this.
* Click on the source tab
    * the XML should now look approximately like this

```html
<?xml version="1.0" encoding="UTF-8"?>
<persistence version="2.1"
       xmlns="http://xmlns.jcp.org/xml/ns/persistence" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://xmlns.jcp.org/xml/ns/persistence http://xmlns.jcp.org/xml/ns/persistence/persistence_2_1.xsd">
	<persistence-unit name="Lesson09" transaction-type="RESOURCE_LOCAL">
		<provider>org.eclipse.persistence.jpa.PersistenceProvider</provider>
		<properties>
			<property name="javax.persistence.jdbc.url" value="jdbc:mysql://localhost:3306/unofficialGuides"/>
			<property name="javax.persistence.jdbc.user" value="root"/>
			<property name="javax.persistence.jdbc.password" value="password"/>
			<property name="javax.persistence.jdbc.driver"
			                              value="com.mysql.jdbc.Driver"/>
		</properties>
	</persistence-unit>
</persistence>

```

* Save the file changes (click the icon in Eclipse to save) and you are done

7. Create a Java class called DbUtil and modify it to look like this:

```java
package customTools;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.EntityTransaction;
import javax.persistence.Persistence;

public class DBUtil {
	private static final EntityManagerFactory emf = Persistence
			.createEntityManagerFactory("MyPersistenceProviderName");

	public static EntityManagerFactory getEmFactory() {
		return emf;
	}

}
```
8. Next we generate the classes (entities) which map to the tables in the database. With JPA our program will interact only with the entities and JPL will interact with the database. That way we can change the database without changing our code.
* Right-click on the project name and select *New JPA Entities from Tables*
* On the dialog box select your connection
* Your schema should be unofficalGuides
* Check the table(s) you want to include. In this case select only the customer table.
* Since you only have one table click Finish.
* Your Customer class file will look as shown below. You can find it under Java source code folder in the model package. You should be careful about modifying this class as it will be overwritten if you modify the database and recreate the class.

```java
package model;

import java.io.Serializable;
import javax.persistence.*;


/**
 * The persistent class for the customer database table.
 *
 */
@Entity
@Table(name="customer")
@NamedQuery(name="Customer.findAll", query="SELECT c FROM Customer c")
public class Customer implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	private int id;
	private String address;
	private String city;
	private String name;
	private String state;
	private String zipcode;

	public Customer() {
	}

	public int getId() {
		return this.id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getAddress() {
		return this.address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getCity() {
		return this.city;
	}

	public void setCity(String city) {
		this.city = city;
	}

	public String getName() {
		return this.name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getState() {
		return this.state;
	}

	public void setState(String state) {
		this.state = state;
	}

	public String getZipcode() {
		return this.zipcode;
	}

	public void setZipcode(String zipcode) {
		this.zipcode = zipcode;
	}
}
```
9. Create a new class named DbUtil. Place it in the customTools package.
Modify the class to make it look like this:

```java
package customTools;

import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

public class DbUtil {
	private static final EntityManagerFactory emf = Persistence
			.createEntityManagerFactory("Lesson09");

	public static EntityManagerFactory getEmFactory() {
		return emf;
	}

}
```

10. You're ready to pull data from the customer table.
In your servlet add the following cod inside the doGet() method:

```java
// add the following code to doGet()
String message = "";
	HttpSession session = request.getSession();

	EntityManager em = DbUtil.getEmFactory().createEntityManager();
	try {
		model.Customer cust = em.find(model.Customer.class, (long)2);
		message = cust.getName();
	} catch (Exception e){
		message = "something went wrong!";
	} finally {
		em.close();
	}
	session.setAttribute("message",message);
	request.getRequestDispatcher("/output.jsp").forward(request, response);
	```
11. Create the following page to display your customer information. Call it output.jsp and place it in the Web Content directory.

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
<h1>index page</h1>
<h1>${message}</h1>
</body>
</html>
```




## What is Going On



## Questions
