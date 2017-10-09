# Lesson 10 - Complete data life cycle – input, update, list, detail, delete
## The Walkthrough


1. Create a Java Dynamic Web Application
	* Name it Lesson10
	* Hit next until you finish the wizard, and then wait until it's done.    

2. Add the Java Archive Files (JARs) to your project
   * JAR files contain code developed by third parties
	 * JAR files contain classes which add functionality to your application
	 * JAR files must be in your program's class path.
	 >Place JAR files in the folder ```WebContent\WEB-INF\lib``` so your program will >locate the classes in the JAR files

	 * We will be working with the following JAR files for accessing the data with JPA:
	    * eclipselink.jar
			* javax.persistence_2.1.0.v201304241213.jar
			* mysql-connector-java-5.1.42-bin.jar			
		* We will be working with the following JAR files for using JSTL (Java Standard Tag Library)
			* taglibs-standard-impl-1.2.5.jar
			* javax.servlet.jsp.jstl-api-1.2.1.jar


> In computer programming, a third-party software component is a reusable software component developed to be either freely distributed or sold by an entity other than the original vendor of the development platform. (Source: Wikipedia, https://en.wikipedia.org/wiki/Third-party_software_component)

2. Add the persistence.xml file
 * Create a folder under the Java src folder called META-INF
 * In the META-INF folder, add a new file called persistence.xml
 * Copy the XML code as shown below.

 ```java
 <?xml version="1.0" encoding="UTF-8"?>
 <persistence xmlns="http://xmlns.jcp.org/xml/ns/persistence"
  xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" version="2.1"
  xsi:schemaLocation=
	"http://xmlns.jcp.org/xml/ns/persistence  http://xmlns.jcp.org/xml/ns/persistence/persistence_2_1.xsd">

  <persistence-unit name="PERSISTENCE_UNIT_NAME" transaction-type="TRANSACTION_TYPE">
     <provider>PERSISTENCE_PROVIDER</provider>
     <exclude-unlisted-classes>false</exclude-unlisted-classes>
     <properties>
         <property name="javax.persistence.jdbc.url" value="DATABASE_URL"/>
         <property name="javax.persistence.jdbc.user" value="DATABASE_USER"/>
         <property name="javax.persistence.jdbc.password" value="DATABASE_PASSWORD"/>
         <property name="javax.persistence.jdbc.driver" value="DATABASE_DRIVER"/>
     </properties>
   </persistence-unit>
 </persistence>
 ```


 3. Update the persistence.xml values with those for your project
 * The values are case-sensitive.
 * Replace the capitalized words with their respective values as shown in the list below
 * Remember: XML attribute values should be in quotes

PERSISTENCE_UNIT_NAME = "Lesson10"
TRANSACTION_TYPE = "RESOURCE_LOCAL"
PERSISTENCE_PROVIDER = "org.eclipse.persistence.jpa.PersistenceProvider"
DATABASE_URL = "jdbc:mysql://localhost:3306/Lesson10"
DATABASE_USER = "root"
DATABASE_PASSWORD = "password"
DATABASE_DRIVER = "com.mysql.jdbc.Driver"

4. Create the entities which are Java classes that represent your database tables
* Right-click on your project and select `New`
* Select `JPA Entities from Tables`
* Select your connection, schema (database name) and tables
* If your tables have relationships then you will be defining those relationships on the screens that follow.

5. Create a new class called `DbUtil`
* Copy the following code into the DbUtil class
* Replace the PERSISTENCE_UNIT_NAME with the value shown in Step 3

```java
package model;

import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

public class DbUtil {

	private static final EntityManagerFactory factory =
		Persistence.createEntityManagerFactory(PERSISTENCE_UNIT_NAME);

	public static EntityManagerFactory getEmFactory() {
		return factory;
	}
}
```

6. Create a helper class for your course entity.
* Name the file `DbCourse`

```java
package model;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.EntityTransaction;
import javax.persistence.Query;
import model.Course;

public class DbCourse {

	public static Course getCourse(long courseId)
	{
		EntityManager em = DbUtil.getEmFactory().createEntityManager();
		Course course = em.find(Course.class, courseId);
		return course;		
	}

	public static List<Course> getAllCourses (){
		EntityManager em = DbUtil.getEmFactory().createEntityManager();
		String qString = "select c from Course c";

		ArrayList<Course> courses = new ArrayList<Course>();
		try{
			Query query = em.createQuery(qString);
			List<Course> results = query.getResultList();
			//courses = (ArrayList<Course>) results;
			for (Course item : results) {
				courses.add(item);
			}

		}catch (Exception e){
			e.printStackTrace();
		}
		finally{
				em.close();
			}
		return courses;
	}

	public static void insert(Course course) {
		EntityManager em = DbUtil.getEmFactory().createEntityManager();
		EntityTransaction trans = em.getTransaction();
		trans.begin();
		try {
			em.persist(course);
			trans.commit();
		} catch (Exception e) {
			e.printStackTrace();
			trans.rollback();
		} finally {
			em.close();
		}
	}

	public static void update(Course course) {
		EntityManager em = DbUtil.getEmFactory().createEntityManager();
		EntityTransaction trans = em.getTransaction();
		trans.begin();
		try {
			em.merge(course);
			trans.commit();
		} catch (Exception e) {
			System.out.println(e);
			trans.rollback();
		} finally {
			em.close();
		}
	}


}
```
7. Right-click on your Java src folder and select the menu item to to Create a Servlet for adding a new course. The servlet should be called `AddCourse`

```java
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/AddCourse")
public class AddCourse extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session = request.getSession();

		String message = "";
		session.setAttribute("message",message );
		request.getRequestDispatcher("/list.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {


	}

}
```
8. Right-click on your Java src folder and select the menu item to to Create a Servlet for listing all courses. The servlet should be called `ListCourse`

```java

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.Course;
import model.DbCourse;

@WebServlet("/ListCourses")
public class ListCourses extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session = request.getSession();


		ArrayList<Course> courses = (ArrayList<Course>) DbCourse.getAllCourses();
		request.setAttribute("courses",courses );
		request.getRequestDispatcher("/list.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {


	}

}
```
9. Right-click on your Java src folder and select the menu item to to Create a Servlet for editing a course. The servlet should be called `EdittCourse`

```java
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/EditCourse")
public class EditCourse extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session = request.getSession();

		String message = "";
		session.setAttribute("message",message );
		request.getRequestDispatcher("/list.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
	}
}
```

10. Right-click on your Java src folder and select the menu item to to Create a Servlet for editing a course. The servlet should be called `ShowCourse`

```java
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.Course;
import model.DbCourse;

@WebServlet("/ShowCourse")
public class ShowCourse extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		HttpSession session = request.getSession();
		Long courseId = Long.parseLong(request.getParameter("courseid"));

		Course course = DbCourse.getCourse(courseId);
		session.setAttribute("course",course);
		request.getRequestDispatcher("/show.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
	}
}
```

### In the next few steps you will be adding some JSP files to your project.
>JSP files must be placed in the WebContent folder. Files in the /WEB-INF folder or below will not be displayed and will generate an HTTP 404 Error.

11. Right-click on the `WebContent` folder and add a JSP file called `courseform.jsp`

```html
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Add a course</title>
</head>
<body>
<form action="addcourse" method="post">
      <input type="hidden" value="${id}" />
    Title :<input name="title" type="text" value="${title}" /><br />
    Instructor :<input name="instructor" type="text" value="${instructor}" /><br />
    Description :<textarea name="description" rows="3">${description}</textarea><br />
    Credits :<input name="credit" type="text" value="${credit}" /><br />
             <input type="submit" value="Submit" />
</form>
</body>
</html>
```

12. Right-click on the `WebContent` folder and add a JSP file called `list.jsp`

```html
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

<a href="/add">Add a Course</a><br />
<table>
    <tr>
        <th>Title</th>
        <th>Instructor</th>
        <th>Credits</th>
        <td>Actions</td>
    </tr>
    <c:forEach var="course" items="${courses}">
    <tr>
        <td> <c:out value="${course.title}"></c:out></td>
        <td> <c:out value="${course.instructor}"></c:out></td>
        <td> <c:out value="${course.credit}"></c:out></td>
        <td>
            <a href="/update?id=<c:out value="${course.id}"></c:out>">Update</a> -
            <a href="/detail?id=<c:out value="${course.id}"></c:out>">Details</a> -
            <a href="/delete?id=<c:out value="${course.id}"></c:out>">Delete</a>
        </td>
    </tr>
    </c:forEach>
</table>

</body>
</html>

```

13. Right-click on the `WebContent` folder and add a JSP file called `show.jsp`

```html
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<h1>Course Details</h1>
<a href="/ListCourses">Show All Courses</a><br />
<p/>

 <c:set var="course" value="${course}"/>
 Title: <c:out value="${course.title}"></c:out><br/>
 Instructor: <c:out value="${course.instructor}"></c:out><br/>
 Credits: <c:out value="${course.credit}"></c:out><p/>
 <a href="/update?id=<c:out value="${course.id}"></c:out>">Update</a> -
 <a href="/show?id=<c:out value="${course.id}"></c:out>">Details</a>

</body>
</html>

```

14. Open MySQL. Your username is `root` and the password is `password`. Run the following SQL Scripts to create the database tables. You may have to switch to the database you set up for this tutorial. To do this in MySQL run the following command:

 ```sql
use mydatabase;
 ```

```sql
use unofficialGuides;

create table course (
id mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
instructor varchar(255) DEFAULT NULL,
title varchar(255) DEFAULT NULL,
credit integer,
PRIMARY KEY (`id`)
);


select  * from course;

INSERT INTO `unofficialGuides`.`course` (`instructor`, `title`, `credit`) VALUES ('Mary Tyler Moore', 'Freshman English', '3');
INSERT INTO `unofficialGuides`.`course` (`instructor`, `title`, `credit`) VALUES ('Neil Tyson', 'Physics', '3');


```


15. Run your application (right-click on the servlet and select `Run as`) and open a browser, if you type in the URL http://localhost:8080/add you should see the form for adding a course.
<!-- todo add image with page to add a course -->

16. If you enter values and submit the form, it will show you a list of all the courses added so far. So, you should see a page that displays the list of courses.

<!-- todo add image with page to show the list of courses -->

17. If you click on a particular course you should see the details for that course.

<!-- todo add image of page to show details for a course, including delete button -->

18. If you click on the delete button next to a course then the course should delete and return you to the course listing.

## What is Going On

Congratulations on your first 'full' application! You can now add data to the database, as well as review, modify and delete it.
