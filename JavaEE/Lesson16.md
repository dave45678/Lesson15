DROP DATABASE IF EXISTS tomcat_realm;
CREATE DATABASE tomcat_realm;
USE tomcat_realm;
CREATE TABLE tomcat_users (
	user_name varchar(20) NOT NULL PRIMARY KEY,
	password varchar(32) NOT NULL
);
CREATE TABLE tomcat_roles (
	role_name varchar(20) NOT NULL PRIMARY KEY
);
CREATE TABLE tomcat_users_roles (
	user_name varchar(20) NOT NULL,
	role_name varchar(20) NOT NULL,
	PRIMARY KEY (user_name, role_name),
	CONSTRAINT tomcat_users_roles_foreign_key_1 FOREIGN KEY (user_name) REFERENCES tomcat_users (user_name),
	CONSTRAINT tomcat_users_roles_foreign_key_2 FOREIGN KEY (role_name) REFERENCES tomcat_roles (role_name)
);
INSERT INTO tomcat_users (user_name, password) VALUES ('dave', 'password');
INSERT INTO tomcat_roles (role_name) VALUES ('admin');
INSERT INTO tomcat_users_roles (user_name, role_name) VALUES ('dave', 'admin');
COMMIT;

USE mysql;
CREATE USER 'tomcat_access'@'localhost' IDENTIFIED BY 'password';
GRANT SELECT ON tomcat_realm.* TO tomcat_access@localhost;




<!-- enter lesson number and title below separated by hyphen-->
# Lesson
## Learning Objectives
*
*

## The Walkthrough

1. Create a Controller
	* Right click on com.example.demo and click New -> Class
	* Name it HomeController.java
	* Edit it to look like this:

```java
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class HomeController {

    @RequestMapping("/")
    public String homePage(){
        return "index";
    }
}
```

2. Create a Template
  * Right click on templates and click New -> Html
	* Name it index.html
	* Edit it to look like this:
```html
<!DOCTYPE html>
<html lang="en" xmlns:th="www.thymeleaf.org">
<head>
    <meta charset="UTF-8" />
    <title>Title</title>
</head>
<body>
    <h2>Hello World!</h2>
</body>
</html>
```

Run your application and open a browser, if you type in the URL http://localhost:8080 you should see this:
![Running your first Spring Boot Application](img/Lesson01.png "Running your first Spring Boot Application")

## What is Going On



## Questions


[Github Repository](https://github.com/ajhenley/SpringBoot_01)
