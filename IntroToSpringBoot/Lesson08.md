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
	
