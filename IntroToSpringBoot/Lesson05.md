# Lesson 5 - Creating a Java Bean
## The Walkthrough

1. Create a Spring Boot Application
	* Name it SpringBoot_05
	* Add the dependencies for the web and for thymeleaf
	* Hit next until you finish the wizard, and then wait until it's done.    

2. Create a Class
	* Right click on com.example.demo and click New -> Class
	* Name it Song.java
	* Edit it to look like this:
```java
public class Song {
    private long id;
    private String name;
    private String artist;
    private String album;
    private int rating;
    private int year;
}
```

3. Autogenerate getters and setters
  	* Right click on the word Song in the class declaration and select generate -> Getters and Setters
	* Select all the fields listed and click ok


## What is Going On
You will use beans all the time in Java. To create one, you will need to create an ordinary class, add private member variables, and add public getter and setter methods to it. This class is going to be a blueprint for all of the objects created for that class. Every time you instantiate an object of the class (i.e. create a copy of the class you can actually use), you will use getters and setters to modify and access the values of the variables within the class.


## Questions
1. Member variables of a Java Bean should be public?
	* True
	* False
	* Both
	* Neither

2. Getter and Setter methods of a Java Bean should be 	public?
	* True
	* False
	* Both
	* Neither

[Github Repository](https://github.com/ajhenley/SpringBoot_05)
