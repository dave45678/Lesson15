# Lesson 18 - Security - Adding Custom Login page 
## The Walkthrough 

1. Start with the code from the previous lesson

2. Edit the SecurityConfiguration Class 
	* Edit the configure method to look like this: 
	
```java
    @Override
    protected void configure(HttpSecurity http) throws Exception {
        http
                .authorizeRequests()
                .anyRequest().authenticated()
                .and()
                .formLogin().loginPage("/login").permitAll()
                .and()
                .httpBasic();
    }
```

3. Edit the Controller 
	* Right click on com.example.demo and click New -> Class 
	* Name it HomeController.java 
	* Edit it to look like this: 

```java
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class HomeController {
    @RequestMapping("/")
    public String index(){
        return "index";
    }
    @RequestMapping("/login")
    public String login(){
        return "login";
    }
}
```

4. Create a Template 
  	* Right click on templates and click New -> Html 
	* Name it login.html 
	* Edit it to look like this: 

```html
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" xmlns:th="http://www.thymeleaf.org"
      xmlns:sec="http://www.thymeleaf.org/thymeleaf-extras-springsecurity3">
    <head>
        <title>Spring Security Example </title>
    </head>
    <body>
        <div th:if="${param.error}">
            Invalid username and password.
        </div>
        <div th:if="${param.logout}">
            You have been logged out.
        </div>
        <form th:action="@{/login}" method="post">
            <div><label> User Name : <input type="text" name="username"/> </label></div>
            <div><label> Password: <input type="password" name="password"/> </label></div>
            <div><input type="submit" value="Sign In"/></div>
        </form>
    </body>
</html>
```

5. Run your application and open a browser, if you type in the URL http://localhost:8080 you should see this: 
![Custom Login](https://github.com/ajhenley/unofficialguides/blob/master/IntroToSpringBoot/img/Lesson18a.png "Custom Login")

6. If you successfully login(using the accounts created in the SecurityConfiguration file), you will see this:  
![Login Success](https://github.com/ajhenley/unofficialguides/blob/master/IntroToSpringBoot/img/Lesson18b.png "Login Success")

# What's Going On

You have used Spring Boot's default security page to log in (Lesson 17), but if you're building a real world application, you'll want to customise the login form. Once you've got basic security set up, adding a login form is a simple process. First, you have to create the login form. Since this page will receive user input and pass it on to Spring Security, it will need to have fields that Spring Security can use for authentication - specifically, 'username' and 'password'. It will also have to POST the form details to the login route. 

### Security Configuration Class

The modification you make to this page is as follows: 
.formLogin().loginPage("/login").permitAll()
This means that you are expecting a login form, which will display when you visit the route /login, and everyone can see it, even if they are not authenticated. 

This is therefore the page that people will see if they have not logged in yet, before they are directed to the page that they can see after logging in. 

### Login form
This form is displayed when users visit a page that requires authentication. This passes the information on to Spring Security, and if the user name and password are correct, the user is allowed to see the page. If the user enters incorrect details, he/she will see a message indicating that the login details were incorrect. The code below displays an error message if the login details are incorrect. 

```
 <div th:if="${param.error}">
            Invalid username and password.
</div>   
```

