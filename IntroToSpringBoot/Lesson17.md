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
##What's Going On

Congratulations! You're ready to add basic security to your Spring Boot web application. This will help to ensure that people are who they say they are (because they use the appropriate passwords to sign in), and that they can access information within your application because they are authorized to have access to it, since they are assigned __ROLES__. 

In this example, you will use Spring Boot's default security options, with a little customisation. You will set your own username and password for accessing the application using in-memory authentication. This means your username and password details will not be stored in a database, but you will be able to use them every time that appication runs. 

When users are created (either as in-memory users or in a database), they have at least one, but possibly many roles assigned to them. These roles can restrict appication access even further. 

### The new addition - SecurityConfiguration.java

This is a file that sets up the applicaition to restrict access. By default, if access is not specified, it is denied. You have to specifically permit access to each page, directory or group of pages in your application. 


**__@Configuration__** and **__@EnableWebSecurity__**
This indicates to the compiler that the file is a configuration file and Spring Security is enabled for the application. 

The class you create (SecurityConfiguration) extends the WebSecurityConfigurerAdapter, which has all of the methods needed to include security in your application. 

**__.authorizeRequests()__**
This tells your application which requests should be authorized. In this example, you are telling the application that any request that is authenticated should be permitted. Right now, this means that if a user enters a correct user/password combination, he/she will be directed to the default route. 

**__.and()__** 
Adds additional authentication rules. Use this to combine rules. 

**__.formLogin()__** 
This indicates that the application should show a login form. Spring Boot's default login form will be shown, and this will inclue messages for incorrect attempts. 

**__.httpBasic()__** 
This means that the user can avoid a login prompt by putting his/her login details in the request. This can be used for testing, but should be removed before the application goes live. 

**__configure()__**
This overrides the default configure method, configures users who can access the application. By default, Spring Boot will provide a new random password assigned to the user "user" when it starts up, if you do not include this method. 

Once you include this method, you will be able to log in with the users configured here. At this point, the configuration is for a single in-memory user. Multiple users can be configured here, as you will see when you remove the comments in the additonal code. 

This is also the method in which you can configure how users are granted access to the application if their details are stored in a database. 



