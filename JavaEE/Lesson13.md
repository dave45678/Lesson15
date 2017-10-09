<!-- enter lesson number and title below separated by hyphen-->
# Lesson 13 - JPA database relationships - many to many

## Learning Objectives
* create a dynamic web application with a servlet and output page
* connect to the mySQL database using JPA
* retrieve the data as an ArrayList in the servlet
* use JSTL to loop through and display all the records

## The Walkthrough

0. If you haven't created the movie and actor tables in MySQL then run the following scripts to do so now. You can run the script multiple times. It will first delete the tables if they exist and then create and populate them. After that the script will query the tables so you can see the  results in MySQL Workbench.

```sql
drop table if exists movie;
create table movie (movieId int auto_increment, title varchar(255) not null,`year` int, description varchar(255) not null,primary key(movieId));
insert into movie (title, `year`,description) values ("Emoji Movie", 2017, "About Emoji Movie ...");
insert into movie (title, `year`,description) values ("DeathStar Ewoks", 2011, "About DeathStar Ewoks ...");
select * from movie;

drop table if exists actor;
create table actor (actorId int auto_increment, `name` varchar(255) not null, `realName` varchar(255) not null, primary key(actorId));
insert into actor (`name`,`realName`) values ("Sandra Bullock","Sandra Mae Bullowski");
select * from actor;

drop table if exists movie_actor;
-- create table movie_actor(movieId int, actorId int, foreign key (movieId) references movie(movieId),foreign key (actorId) references actor(actorId));
create table movie_actor(movieId int, actorId int);
insert into movie_actor values (1,1);
insert into movie_actor values (2,1);
select * from actor
inner join movie_actor
on actor.actorId = movie_actor.actorId
inner join movie
on movie_actor.movieId = movie.movieId;
```

1. Create a Java Dynamic Web Application
	* Name it Lesson13
	* Hit next until you finish the wizard, and then wait until it's done.    

2. Create a Servlet
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

3. Copy your JAR files to the WEB-INF\lib folder of your project
  * eclipselink.jar
	* javax.persistence_2.1.0.v201304241213.jar
	* mysql-connector-java-5.1.42-bin.jar

	Place these files in the WEB-INF\lib folder. Any other location may not be found by your program.

4. Create a JSP page called output.jsp
Right-click on the web content directory and select the option to add a new JSP file. Call it output.jsp.

5. Add the tag library directives at the top of your JSP
Open your output.jsp file and add the following code below the @Page directive

```html
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
```
6. Connect to the database using JPA
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

7.  Look in the JPA Content container inside your project and double­click the persistence.xml file
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

8. Create a Java class called DbUtil and modify it to look like this:

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
9. Next we generate the classes (entities) which map to the tables in the database. With JPA our program will interact only with the entities and JPL will interact with the database. That way we can change the database without changing our code.
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
10. Create a new class named DbUtil. Place it in the customTools package.
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

11. You're ready to pull data from the customer table.
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
12. Create the following page to display your customer information. Call it output.jsp and place it in the Web Content directory.

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
