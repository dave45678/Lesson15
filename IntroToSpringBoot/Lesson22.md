# Lesson 22 - Automatically adding records to database when the Application Loads
## Walkthrough

1. Take an existing application like Lesson 21

2. Add a DataLoader Class
    * Right-click on  and click New -> Class
    * Name it DataLoader.java
    * Edit the contents to look like this:
```java
@Component
public class DataLoader implements CommandLineRunner{

    @Autowired
    UserRepository userRepository;

    @Autowired
    RoleRepository roleRepository;
    
    @Override
    public void run(String... strings) throws Exception {
        System.out.println("Loading data . . .");

        roleRepository.save(new Role("USER"));
        roleRepository.save(new Role("ADMIN"));

        Role adminRole = roleRepository.findByRole("ADMIN");
        Role userRole = roleRepository.findByRole("USER");

        User user = new User("bob@bob.com","bob","Bob","Bobberson", true, "bob");
        user.setRoles(Arrays.asList(userRole));
        userRepository.save(user);

        user = new User("jim@jim.com","jim","Jim","Jimmerson", true, "jim");
        user.setRoles(Arrays.asList(userRole));
        userRepository.save(user);

        user = new User("admin@secure.com","password","Admin","User", true, "admin");
        user.setRoles(Arrays.asList(adminRole));
        userRepository.save(user);

        user = new User("sam@every.com","password","Sam","Everyman", true, "everyman");
        user.setRoles(Arrays.asList(userRole, adminRole));
        userRepository.save(user);
    }
}

```

3. Assuming your dataloader implements CommandLineRunner, you can use this as a template for 
how you would implement this type of functionality in your own applications.
