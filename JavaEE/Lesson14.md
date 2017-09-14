<!-- enter lesson number and title below separated by hyphen-->
# Lesson 14 - JPA database relationships - one to many

## Learning Objectives
* create a dynamic web application with a servlet and output page
* connect to the mySQL database using JPA
* retrieve the data as an ArrayList in the servlet
* use JSTL to loop through and display all the records

## The Walkthrough

0. If you haven't created the director and movie tables then run the following script in MySQL:

```sql
drop table if exists director;
create table director (directorId int auto_increment, `name` varchar(255) not null, genre varchar(255) not null, primary key (directorId));
insert into director (`name`, genre) values ('Stephen Bullock','Sci Fi');
select * from director;

drop table if exists movie;
create table movie (movieId int auto_increment, title varchar(255) not null,`year` int, description varchar(255) not null,directorId int, primary key(movieId));
insert into movie (title, `year`,description,directorId) values ("Emoji Movie", 2017, "About Emoji Movie ...",1);
insert into movie (title, `year`,description,directorId) values ("DeathStar Ewoks", 2011, "About DeathStar Ewoks ...",1);
select * from movie;

select  * from movie
inner join director
on movie.directorId = director.directorId;
```

1. Create a Java Dynamic Web Application
	* Name it Lesson14
	* Hit next until you finish the wizard, and then wait until it's done.    

2. Create a Servlet
	* Edit it to look like this:

```java
import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.Director;
import model.Movie;
import model.DbDirector;

@WebServlet("/ApplicationServlet")
public class ApplicationServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;


	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		ArrayList<Director> directors = (ArrayList<Director>)DbDirector.getAllDirectors();

		request.setAttribute("director",directors);
		request.getRequestDispatcher("/output.jsp").forward(request, response);
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}

}
```

3. Copy your JAR files to the ```WEB-INF\lib``` folder of your project. Any other location may not be found by your program.
  * eclipselink.jar
	* javax.persistence_2.1.0.v201304241213.jar
	* mysql-connector-java-5.1.42-bin.jar

4. Create a JSP page called output.jsp
  * Right-click on the web content directory and select the option to add a new JSP file. Call it output.jsp.

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
<h1>Lesson 14 - Using Database Relationships - one to many</h1>
<h3>One director directs many movies</h3>

<h2>List of directors and movies</h2>
<c:forEach var="director" items="${directors}">
    <h3><c:out value="${director.name}"></c:out></h3>   
    <c:forEach var="movie" items="${director.movies}">
    <li><c:out value="${movie.title}"></c:out></li>
    </c:forEach>
</c:forEach>
</body>
</html>

```

5. Add the tag library directives at the top of your JSP
Open your output.jsp file and add the following code below the @Page directive

```html
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
		* URL: ```jdbc:mysql://localhost:3306/unofficialGuides```
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
	<persistence-unit name="Lesson14" transaction-type="RESOURCE_LOCAL">
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
			.createEntityManagerFactory("Lesson14");

	public static EntityManagerFactory getEmFactory() {
		return emf;
	}

}
```
9. Next we generate the classes (entities) which map to the tables in the database. With JPA our program will interact only with the entities and JPL will interact with the database. That way we can change the database without changing our code.
* Right-click on the project name and select *New JPA Entities from Tables*
* On the dialog box select your connection
* Your schema should be 'unofficalGuides'
* Check the table(s) you want to include. In this case select only the director and movie tables.
* Click Next
* Eclipse will determine the relationships based on the table structure. You can review these and click next.
* Your Director class file will look as shown below. You can find it under Java source code folder in the model package. You should be careful about modifying this class as it will be overwritten if you modify the database and recreate the class.

```java
package model;

import java.io.Serializable;
import javax.persistence.*;
import java.util.List;

@Entity
@Table(name="director")
@NamedQuery(name="Director.findAll", query="SELECT d FROM Director d")
public class Director implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	private int directorId;

	private String genre;

	private String name;

	//bi-directional many-to-one association to Movie
	@OneToMany(mappedBy="director")
	private List<Movie> movies;

	public Director() {
	}

	public int getDirectorId() {
		return this.directorId;
	}

	public void setDirectorId(int directorId) {
		this.directorId = directorId;
	}

	public String getGenre() {
		return this.genre;
	}

	public void setGenre(String genre) {
		this.genre = genre;
	}

	public String getName() {
		return this.name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public List<Movie> getMovies() {
		return this.movies;
	}

	public void setMovies(List<Movie> movies) {
		this.movies = movies;
	}

	public Movie addMovy(Movie movy) {
		getMovies().add(movy);
		movy.setDirector(this);

		return movy;
	}

	public Movie removeMovy(Movie movy) {
		getMovies().remove(movy);
		movy.setDirector(null);

		return movy;
	}

}
```

10. You're ready to pull data from the director table.
In your servlet add the following code inside the doGet() method:

```java
// add the following code to doGet()
ArrayList<Director> directors = (ArrayList<Director>)DbDirector.getAllDirectors();

request.setAttribute("director",directors);
request.getRequestDispatcher("/output.jsp").forward(request, response);
}
```

11. Right-click on your servlet and select Run. You should see a list of directors and movies.



## What is Going On
When you right-click on the servlet and click run the doGet() method will execute. This will cause JPA to connect to the database and retrieve the directors. Each director object contains a variable of type list containing their movies. When the servlet redirects to the output.jsp page then the directors and movies will be displayed as JSTL loops through the object and its data, including the movie list.



## Questions
