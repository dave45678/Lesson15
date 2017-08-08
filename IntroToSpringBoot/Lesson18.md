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
![Login Error](https://github.com/ajhenley/unofficialguides/blob/master/IntroToSpringBoot/img/Lesson18b.png "Login Error")

