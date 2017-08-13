# Lesson 15 - Using Database Relationships with Spring Boot - OneToOne 
## The Walkthrough 

1. Create a Spring Boot Application 
	* Name it SpringBoot_15 
	* Add the dependencies for the web, jpa, h2 and thymeleaf 
	* Hit next until you finish the wizard, and then wait until it's done.    

2. Create a Class
	* Right click on com.example.demo and click New -> Class
	* Name it Employee.java
	* Edit it to look like this:
```java
@Entity
public class Employee {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private int id;
    private String name;
    private String ssn;

    @OneToOne(cascade = CascadeType.ALL)
    @JoinColumn(name = "laptop_id")
    private Laptop laptop;
}
```

3. Autogenerate getters and setters
	* Right-click on the word Employee and select generate -> Getters and Setters
	* Select all the fields listed and click OK

4. Create a Class
	* Right click on com.example.demo and click New -> Class
	* Name it Laptop.java
	* Edit it to look like this:
```java
@Entity
public class Laptop {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private int id;
    private String brand;
    private String model;

    @OneToOne(mappedBy = "laptop")
    private Employee employee;
}
```

5. Autogenerate getters and setters
	* Right-click on the word Laptop and select generate -> Getters and Setters
	* Select all the fields listed and click OK

6. Create a Repository
	* Right click on com.example.demo and click New -> Class
	* Name it EmployeeRepository.java
	* Edit it to look like this:
```java
import org.springframework.data.repository.CrudRepository;

public interface EmployeeRepository extends CrudRepository<Employee, Long>{
}
```

7. Create a Repository
	* Right click on com.example.demo and click New -> Class
	* Name it LaptopRepository.java
	* Edit it to look like this:
```java
import org.springframework.data.repository.CrudRepository;

public interface LaptopRepository extends CrudRepository<Laptop, Long>{
}
```

8. Create a Controller 
	* Right click on com.example.demo and click New -> Class 
	* Name it HomeController.java 
	* Edit it to look like this: 
``` java
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import java.util.HashSet;
import java.util.Set;

@Controller
public class HomeController {

    @Autowired
    EmployeeRepository employeeRepository;

    @RequestMapping("/")
    public String index(Model model){
        // First let's create an employee
        Employee employee = new Employee();
        employee.setName("Stephen Bullock");
        employee.setSsn("555-12-1234");

        // Now let's create a laptop
        Laptop laptop = new Laptop();
        laptop.setBrand("Dell");
        laptop.setModel("Latitude XL");


        // Add the laptop to the employee
        employee.setLaptop(laptop);

        // Save the employee to the database
        employeeRepository.save(employee);

        // Grab all the employees from the database and send them to
        // the template
        model.addAttribute("employees", employeeRepository.findAll());
        return "index";
    }
}
```

9. Create a Template 
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
<div th:each="employee : ${employees}">
    <h2 th:text="${employee.name}"></h2>
    <h6 th:inline="text">identified by [[${employee.ssn}]]</h6>
    <ul>
        <th:block th:object="${employee.laptop}" >
            <li th:inline="text">Has been assigned a <b>[[*{brand}]]</b> [[*{model}]].</li>
        </th:block>
    </ul>
</div>
</body>
</html>
```

10. Run your application and open a browser, if you type in the URL http://localhost:8080 you should see something like this: 
![Relationships](https://github.com/ajhenley/unofficialguides/blob/master/IntroToSpringBoot/img/Lesson15.png)

