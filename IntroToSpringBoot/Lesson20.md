# Lesson 20 - Security - Using Database based Authentication 
## The Walkthrough 

1. Start with the code from the previous lesson

2. Add the dependencies for jpa and h2
    * Open the pom.xml file
    * Add the following xml right before the line that reads:  &lt;/dependencies>
```xml
		<dependency>
			<groupId>org.springframework.boot</groupId>
			<artifactId>spring-boot-starter-data-jpa</artifactId>
		</dependency>
		<dependency>
			<groupId>org.springframework.boot</groupId>
			<artifactId>spring-boot-devtools</artifactId>
			<scope>runtime</scope>
		</dependency>
		<dependency>
			<groupId>com.h2database</groupId>
			<artifactId>h2</artifactId>
			<scope>runtime</scope>
		</dependency>
```

3. Import your maven dependencies:
    * Either click the Import Changes link in the lower right hand corner, or
    * Right-click your project and click Maven -> Re-Import
    * Wait for the background tasks to complete
    
4. Create the User Class
    * Right click on com.example.demo and click New -> Class
    * Name it User.java
    * Edit it to look like this:    
```java
@Entity
public class User {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private long id;

    @Column(name = "email", nullable = false)
    private String email;

    @Column(name = "password")
    private String password;

    @Column(name = "first_name")
    private String firstName;

    @Column(name = "last_name")
    private String lastName;

    @Column(name = "enabled")
    private boolean enabled;

    @Column(name = "username")
    private String username;

    @ManyToMany(fetch = FetchType.EAGER)
    @JoinTable(joinColumns = @JoinColumn(name = "user_id"),inverseJoinColumns = @JoinColumn(name = "role_id"))
    private Collection<Role> roles;
}
```

5. Autogenerate getters and setters
    * Right click on the word User
    * Click Generate -> Getters and Setters

6. Create the Role Class
    * Right click on com.example.demo and click New -> Class
    * Name it Role.java
    * Edit it to look like this:    
```java
@Entity
public class Role {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private long id;

    @Column(unique=true)
    private String role;

    @ManyToMany(mappedBy = "roles",fetch = FetchType.LAZY)
    private Collection<User> users;
}
```

7. Autogenerate getters and setters
    * Right click on the word Role
    * Click Generate -> Getters and Setters

8. Create a User Repository
    * Right click on com.example.demo and click New -> Class
    * Name it UserRepository.java
    * Edit it to look like this:
```java    
import org.springframework.data.repository.CrudRepository;

public interface UserRepository extends CrudRepository<User, Long>{
    User findByUsername(String username);
} 
```

9. Create a Role Repository
    * Right click on com.example.demo and click New -> Class
    * Name it RoleRepository.java
    * Edit it to look like this:
```java    
import org.springframework.data.repository.CrudRepository;

public interface RoleRepository extends CrudRepository<Role, Long>{
} 
```

10. Edit the SecurityConfiguration Class 
	  * Edit the HttpSecurity configure method to look like this: 
```java
    @Autowired
    private SSUserDetailsService userDetailsService;

    @Autowired
    private UserRepository userRepository;

    @Override
    public UserDetailsService userDetailsServiceBean() throws Exception {
        return new SSUserDetailsService(userRepository);
    }

    @Override
    protected void configure(HttpSecurity http) throws Exception {
        http
                .authorizeRequests()
                .antMatchers("/").permitAll()
                .anyRequest().authenticated()
                .and()
                .formLogin().loginPage("/login").permitAll()
                .and()
                .logout()
                .logoutRequestMatcher(new AntPathRequestMatcher("/logout"))
                .logoutSuccessUrl("/login").permitAll().permitAll()
                .and()
                .httpBasic();

        http
                .csrf().disable();
        http
                .headers().frameOptions().disable();
    }

    @Override
    protected void configure(AuthenticationManagerBuilder auth) throws Exception {
        auth
                .userDetailsService(userDetailsServiceBean());
    }
```

11. Create the SSUserDetailsService
    * Right click on com.example.demo and click New -> Class
    * Name it RoleRepository.java
    * Edit it to look like this:
```java
@Transactional
@Service
public class SSUserDetailsService implements UserDetailsService {

    private UserRepository userRepository;

    public SSUserDetailsService(UserRepository userRepository){
        this.userRepository=userRepository;
    }

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        try {
            User user = userRepository.findByUsername(username);
            if (user == null) {
                System.out.println("user not found with the provided username " + user.toString());
                return null;
            }

            System.out.println(" user from username " + user.toString());
            return new org.springframework.security.core.userdetails.User(user.getUsername(), user.getPassword(), getAuthorities(user));
        } catch (Exception e){
            throw new UsernameNotFoundException("User not found");
        }
    }

    private Set<GrantedAuthority> getAuthorities(User user){
        Set<GrantedAuthority> authorities = new HashSet<GrantedAuthority>();
        for(Role role : user.getRoles()) {
            GrantedAuthority grantedAuthority = new SimpleGrantedAuthority(role.getRole());
            authorities.add(grantedAuthority);
        }
        System.out.println("user authorities are " + authorities.toString());
        return authorities;
    }
}
```

12. Create a Controller 
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

    @RequestMapping("/secure")
    public String secure(){
        return "secure";
    }
}
```

13. Create a Login Template 
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

14. Create a Index Template 
  	* Right click on templates and click New -> Html 
	  * Name it index.html 
	  * Edit it to look like this: 
```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <title>Title</title>
</head>
<body>
<h2>Insecure Page</h2>
<a href="/secure">Secure Page</a>
</body>
</html>
```

15. Create a Secure Template 
  	* Right click on templates and click New -> Html 
	  * Name it secure.html 
	  * Edit it to look like this: 
```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <title>Title</title>
</head>
<body>
<h3>Secure Page</h3>
<a href="/logout">logout</a>
</body>
</html>
```

16. Run your application and open a browser, and you should see this:
![](https://github.com/ajhenley/unofficialguides/blob/master/IntroToSpringBoot/img/Lesson21a.png )

If you click on the secure page link, you should see this:
![](https://github.com/ajhenley/unofficialguides/blob/master/IntroToSpringBoot/img/Lesson21b.png )

But you won't be able to login because there are no accounts in the database. To add them, navigate to the URL http://localhost:8080/h2-console/ and you will see this:
![](https://github.com/ajhenley/unofficialguides/blob/master/IntroToSpringBoot/img/Lesson21d.png )

If you click on the Connect button at the bottom, you should see this:
![](https://github.com/ajhenley/unofficialguides/blob/master/IntroToSpringBoot/img/Lesson21e.png )

And you can post this sql script in the window on the right:
```sql
INSERT INTO ROLE VALUES(1, 'USER');
INSERT INTO ROLE VALUES(2, 'ADMIN');
INSERT INTO USER_DATA VALUES (1, 'jim@jim.com', TRUE, 'Jim', 'Jimmerson', 'password', 'jim');
INSERT INTO USER_DATA VALUES (2, 'bob@bob.com', TRUE, 'Bob', 'Bobberson', 'password', 'bob');
INSERT INTO USER_DATA VALUES (3, 'admin@admin.com', TRUE, 'Admin', 'User', 'password', 'admin');
INSERT INTO USER_DATA_ROLES VALUES (1,1);
INSERT INTO USER_DATA_ROLES VALUES (2,1);
INSERT INTO USER_DATA_ROLES VALUES (3,1);
INSERT INTO USER_DATA_ROLES VALUES (3,2);
```

And click on the Run button at the top of the script and you should see something like this:
![](https://github.com/ajhenley/unofficialguides/blob/master/IntroToSpringBoot/img/Lesson21f.png )

You should now be able to go to the URL http://localhost:8080/login and login with the account jim and password password.
