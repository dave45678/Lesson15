# Lesson 17 - Security - Basic Security 
## The Walkthrough 

1. Create a Spring Boot Application 
	* Name it SpringBoot_17 
	* Add the dependencies for security, web and thymeleaf 
	* Hit next until you finish the wizard, and then wait until it's done.    

2. Create a SecurityConfiguration Class 
	* Right click on com.example.demo and click New -> Class 
	* Name it SecurityConfiguration.java 
	* Edit it to look like this: 
```java
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;

@Configuration
@EnableWebSecurity
public class SecurityConfiguration extends WebSecurityConfigurerAdapter{

    @Override
    protected void configure(HttpSecurity http) throws Exception {
        http
                .authorizeRequests()
                .anyRequest().authenticated()
                .and()
                .formLogin()
                .and()
                .httpBasic();
    }

}
```

4. Create a Controller 
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
}
```
5. Create a Template 
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
<h2>It worked!</h2>
</body>
</html>
```

6. Run your application and open a browser, if you type in the URL http://localhost:8080 you should see this: 
![Default Login](https://github.com/ajhenley/unofficialguides/blob/master/IntroToSpringBoot/img/Lesson17a.png "Default Login")

7. If you try to login, it will show you an error. This is because you haven't added any security accounts. So, you will see this:  
![Login Error](https://github.com/ajhenley/unofficialguides/blob/master/IntroToSpringBoot/img/Lesson17b.png "Login Error")

8. Add Manual User Accounts
  * Edit your SecurityConfiguration.java and add the following method:
```java
    @Override
    protected void configure(AuthenticationManagerBuilder auth) throws Exception {

        auth.inMemoryAuthentication().
                withUser("user").password("password").roles("USER");
        // to add additional accounts, remove the semicolon at 
        // the end of the previous command and add an additional user like below:
        //           .and()
        //           .withUser("dave").password("begreat").roles("USER");
    }
```
