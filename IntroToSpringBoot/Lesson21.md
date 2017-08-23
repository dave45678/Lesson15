# Lesson 21 - Security - Adding User Registration 
## The Walkthrough 

1. Start with the code from the previous lesson

2. Edit the UserRepository
    * Add these lines to your repository
```java
    User findByUsername(String username);

    User findByEmail(String email);

    Long countByEmail(String email);

    Long countByUsername(String username);
```
    
3. Edit the RoleRepository
    * Add this line to your repository
```java
    Role findByRole(String role);
```    
    
4. Create a UserService Class
    * Right click on com.example.demo and click New -> Class
    * Name it UserService.java
    * Edit it to look like this:    
```java
@Service
public class UserService {
    @Autowired
    UserRepository userRepository;

    @Autowired
    RoleRepository roleRepository;

    @Autowired
    public UserService(UserRepository userRepository) {
        this.userRepository = userRepository;
    }
    public User findByEmail(String email) {
        return userRepository.findByEmail(email);
    }
    public Long countByEmail(String email) {
        return userRepository.countByEmail(email);
    }
    public User findByUsername(String username){
        return userRepository.findByUsername(username);
    }
    public void saveUser(User user) {
        user.setRoles(Arrays.asList(roleRepository.findByRole("USER")));
        user.setEnabled(true);
        userRepository.save(user);
    }
    public void saveAdmin(User user) {
        user.setRoles(Arrays.asList(roleRepository.findByRole("ADMIN")));
        user.setEnabled(true);
        userRepository.save(user);
    }
}
```

5. Edit the HomeController
    * Add the following:    
```java
    @Autowired
    private UserService userService;

    @RequestMapping(value="/register", method = RequestMethod.GET)
    public String showRegistrationPage(Model model){
        model.addAttribute("user", new User());
        return "registration";
    }

    @RequestMapping(value="/register", method = RequestMethod.POST)
    public String processRegistrationPage(
    	@Valid @ModelAttribute("user") User user, 
	BindingResult result, 
	Model model){

        model.addAttribute("user", user);

        if (result.hasErrors()) {
            return "registration";
        } else {
            userService.saveUser(user);
            model.addAttribute("message", "User Account Successfully Created");
        }
        return "index";
    }
```

6. Edit the SecurityConfiguration
    * Edit it to look like this:  
```java
@Configuration
@EnableWebSecurity
@EnableGlobalMethodSecurity(prePostEnabled = true)
public class SecurityConfiguration extends WebSecurityConfigurerAdapter {

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
                .antMatchers("/", "/h2-console/**", "/register").permitAll()
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
}
```

7. Create a Registration Template 
  	* Right click on templates and click New -> Html 
	  * Name it registration.html 
	  * Edit it to look like this: 
```html
<!DOCTYPE html>
<html 	xmlns="http://www.w3.org/1999/xhtml"
         xmlns:th="http://www.thymeleaf.org">
<head>
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Spring Security Example</title>
</head>
<body>
    <h4>New User Registration</h4>

    <form autocomplete="off" action="#" th:action="@{/register}"
          th:object="${user}" method="post">
            First Name <mark><strong>
	    <span th:if="${#fields.hasErrors('firstName')}" 
	    	th:errors="*{firstName}">First Name Error</span></strong></mark>
            <input type="text" id="firstName" placeholder="First Name" 
	    	th:field="*{firstName}" /><br />
            Last Name <mark><strong>
	    <span th:if="${#fields.hasErrors('lastName')}" 
	    	th:errors="*{lastName}">Last Name Error</span></strong></mark>
            <input type="text" id="lastName" placeholder="Last Name" 
	    	th:field="*{lastName}" /><br />
            Email <mark><strong>
	    <span th:if="${#fields.hasErrors('email')}" 
	    	th:errors="*{email}">Email Error</span></strong></mark>
            <input type="text" id="email" placeholder="Email" 
	    	th:field="*{email}" /><br />
            Username <mark><strong>
	    <span th:if="${#fields.hasErrors('username')}" 
	    	th:errors="*{username}">Username Error</span></strong></mark>
            <input type="text" id="username" placeholder="Username" 
	    	th:field="*{username}" /><br />
            Password <mark><strong>
	    <span th:if="${#fields.hasErrors('password')}" 
	    	th:errors="*{password}">Password Error</span></strong></mark>
            <input type="text" id="password" placeholder="Password" 
	    	th:field="*{password}" /><br />
        <button type="submit" class="btn btn-default">Submit</button>
    </form>

</body>
</html>
```

8. Run your application and open a browser, and you should see this:
![](https://github.com/ajhenley/unofficialguides/blob/master/IntroToSpringBoot/img/Lesson21a.png )

If you click on the secure page link, you should see this:
![](https://github.com/ajhenley/unofficialguides/blob/master/IntroToSpringBoot/img/Lesson21b.png )

But you won't be able to login because there are no accounts in the database. To add them, navigate to the URL http://localhost:8080/register/ and you will see this:
![](https://github.com/ajhenley/unofficialguides/blob/master/IntroToSpringBoot/img/Lesson21register.png )

Once you create an account, you will be able to login.
