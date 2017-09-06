<!-- enter lesson number and title below separated by hyphen-->
# Lesson 10 -  Complete data life cycle (form, list, detail, delete)
## Learning Objectives
*
*

## The Walkthrough

1. Create the database for the course
2. Create a Dynamic Web Application
3. Add JPA to your Dynamic Web application
4. Create entities representing the table in your database
1. Create a servlet
2. Create a JSP to display the list of courses
3. Create a JSP to display the details of a course
4. Create a JSP to add a course
5. Create a JSP to edit a course

### Create the database for the course

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
### Create a Dynamic Web Application

### Add JPA to your Dynamic Web application

### Create entities representing the table in your database

### Create a servlet

### Create a JSP with a course form


### Create a JSP to display the list of courses

### Create a JSP to display the details of a course

### Create a JSP to add a course
### Create a JSP to edit a course





Run your application and open a browser, if you type in the URL http://localhost:8080 you should see this:
![Running your first Spring Boot Application](img/Lesson01.png "Running your first Spring Boot Application")

## What is Going On



## Questions


[Github Repository](https://github.com/ajhenley/SpringBoot_01)
