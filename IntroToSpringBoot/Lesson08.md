# Lesson 8 - Using databases with Spring Boot 
## The Walkthrough 

1. Create a Spring Boot Application 
	* Name it SpringBoot_08 
	* Add the dependencies for the web, devtools, jpa, h2 and thymeleaf. 
	* Hit next until you finish the wizard, and then wait until it's done.    

2. Create a Class 
	* Right click on com.example.demo and click New -> Class 
	* Name it Person.java 
	* Edit it to look like this: 
```java
package com.example.demo;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

@Entity
public class Person {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private long id;

    private String firstName;
    private String lastName;
}
```

3. Autogenerate getters and setters
  * Right-click on the word Person and select generate -> Getters and Setters
  * Select all the fields list and click OK

4. Configure H2 
	* Open application.properties 
	* Edit it to look like this: 
```
spring.h2.console.enabled=true
spring.h2.console.path=/h2-console

spring.jpa.hibernate.ddl-auto=create
```

5. Run your application and open a browser, if you type in the URL http://localhost:8080/h2-console you should see this: 
![H2 Login](https://github.com/ajhenley/unofficialguides/blob/master/IntroToSpringBoot/img/Lesson08a.png "H2 Login")

6. Fix the JDBC URL (if you need to...)
	* Change the JDBC URL to jdbc:h2:mem:testdb (if it isn't that already)
	* Click connect and you should see this:
![H2 Console](https://github.com/ajhenley/unofficialguides/blob/master/IntroToSpringBoot/img/Lesson08b.png "H2 Console")

## What's Going ON 
You are creating a Spring Boot application that uses an in-memory
database called H2 to store its data. If you create a Spring Boot application with the correct dependencies, you do not need to download additional software. 

Everything the application needs to run will be included when Maven downloads and includes the dependencies your application needs to work with. 


### The Controller 
Start by creating a class that uses the @Entity annotation to create a table in your database. The database in which the table will be located is determined by the application properties. 

The fields in the Person class determine what data types will be used to store the data in the database, and also what kind of constraints will be used to ensure only valid data is stored.

The constraints are denoted by annotations. A list of annotations that can be used is available here:

[Java Documentation](https://docs.oracle.com/javaee/7/api/javax/validation/constraints/package-summary.html)

[Hibernate Documentation] (http://docs.jboss.org/hibernate/stable/validator/reference/en-US/html_single/#validator-defineconstraints-spec)

The annotations being used on the Person class are as follows: 
@Id - this indicates that the field is the unique identifier that will be used for each row in the database. 
@GeneratedValue - this indicates that the identifier will be generated, and strategy=GenrationType.AUTO means a unique number will automatically be assigned to each row. 

Remember the getters and setters! They are used to save and retrieve data to and from the database. 

### Application Properties 
spring.h2.console.enabled=true permits access to the database outside the application (using the h2 console). 
spring.h2.console.path=/h2-console allows you to browse to the database to view the data in it by typing http://localhost:8080/h2-console. If your server port is not 8080, you will have to modify the path accordingly. 
spring.jpa.hibernate.ddl-auto=create 
This allows the application to create database tables. In this mode, every time you run the application, it will create tables to store the data if they do not already exist. If the tables already exist, all data will be cleared, and any data you enter will last until you restart the application. 
