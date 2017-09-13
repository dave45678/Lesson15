# Lesson 20.5 - Storing user details when Authenticating 
## The Walkthrough 

1. Start with the application from the last lesson 
	* Name it SpringBoot_01 
	* Add the dependencies for the web and for thymeleaf 
	* Hit next until you finish the wizard, and then wait until it's done.    

2. Extend the Security User Object 
	* Right click on com.example.demo and click New -> Class 
	* Name it CustomUserDetails.java 
	* Edit it to look like this: 
```java
public class CustomUserDetails extends  org.springframework.security.core.userdetails.User{

    private User user;

    public CustomUserDetails(User user, Collection<? extends GrantedAuthority> authorities){
        super(user.getUsername(), user.getPassword(), authorities);
        this.user = user;
    }

    public CustomUserDetails(User user, String password, Collection<? extends GrantedAuthority> authorities){
        super(user.getUsername(), password, authorities);
        this.user = user;
    }

    public CustomUserDetails(User user, boolean enabled, boolean accountNonExpired, 
                             boolean credentialsNonExpired, boolean accountNonLocked, 
                             Collection<? extends GrantedAuthority> authorities) {
        super(user.getUsername(), user.getPassword(), enabled, accountNonExpired, 
                credentialsNonExpired, accountNonLocked, authorities);
        this.user = user;
    }

    public User getUser() {
        return user;
    }
}
```

3. Edit the SSUserDetailsService to use CustomerUserDetails 
  	* find the line that looks like this: 
```html
  return new org.springframework.security.core.userdetails.User( 
        user.getUsername(), user.getPassword(), getAuthorities(user)); 
```

  	* Replace it with this: 
```html
  return new CustomUserDetails(user, getAuthorities(user));  
```


4. Edit the HomeController to access the data 
  	* edit the secure method to look like this: 
```html
    public String secure(Principal principal, Model model){
        User myuser = ((CustomUserDetails) ((UsernamePasswordAuthenticationToken) principal)
		.getPrincipal()).getUser();
        model.addAttribute("myuser", myuser);
        return "secure";
    }
```

5. Edit the secure.html template to access the object
  	* Edit it to look like this: 
```html
<!DOCTYPE html>
<html lang="en" xmlns:th="www.thymeleaf.org">
    <head>
        <meta charset="UTF-8" />
        <title>Title</title>
    </head>
    <body>
        <h3>Secure Page</h3>
        <a href="/logout">logout</a>
        <h4>email</h4>
        <p th:text="${myuser.email}"></p><br/>
        <h4>last name</h4>
        <p th:text="${myuser.lastName}"></p>
    </body>
</html>
```

