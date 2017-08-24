# Lesson 19 - Security - Specific Permissions 
## The Walkthrough 

1. Start with the code from the previous lesson

2. Edit the SecurityConfiguration Class 
	  * Edit the HttpSecurity configure method to look like this: 
```java
    @Override
    protected void configure(HttpSecurity http) throws Exception {
        http
                .authorizeRequests()
			.antMatchers("/")
			.access("hasRole('ROLE_USER') or hasRole('ROLE_ADMIN')")
			.antMatchers("/admin").access("hasRole('ROLE_ADMIN')")
                .anyRequest().authenticated()
                .and()
                .formLogin().loginPage("/login").permitAll()
                .and()
                .httpBasic();
    }
```

    * Edit the AuthenticationManagerBuilder configure method to look like this:
```java
    @Override
    protected void configure(AuthenticationManagerBuilder auth) throws Exception {

        auth.inMemoryAuthentication().
                withUser("user").password("password").roles("USER")
                .and()
                .withUser("dave").password("begreat").roles("ADMIN");
    }
```

3. Edit the Controller 
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
    @RequestMapping("/admin")
    public String admin(){
        return "admin";
    }
}
```

4. Create a Template 
  	* Right click on templates and click New -> Html 
	* Name it admin.html 
	* Edit it to look like this: 
```html
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8" />
        <title>Title</title>
    </head>
    <body>
        <h2>Admin Page</h2>
    </body>
</html>
```

5. Run your application and open a browser, if you Login as user / password you should not be able to navigate to the Admin page. However, if you login as admin / password you should be able to see the Admin Page.
