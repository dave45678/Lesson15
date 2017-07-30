# Using Checkboxes with Thymeleaf and Spring Boot

In this exercise, you will see how to use checkboxes with a thymeleaf form.

## What you should do

### 1. Create a new spring boot application and add a class called HomeController.java, that looks like this:
```java
@Controller
public class HomeContrller
{
    @GetMapping("/form")
    public String loadForm(Model model){
        model.addAttribute("consultant", new Consultant());
        return "form2";
    }
}
```

### 2. Create a file called Consultant.java that looks like this:
```java
@Entity
public class Consultant {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private long id;

    private String fname;
    private String lname;
    private long hourlyrate;
    private boolean available;
    
    // Getters and Setters
```

### 3. Create a template by right-clicking the template folder and name it form.html. It should look like this:
```html
<!DOCTYPE html>
<html lang="en" xmlns:th="www.thymeleaf.org">
<head>
    <meta charset="UTF-8" />
    <title>Title</title>
</head>
<body>
<h2>New Consultant Form</h2>
    <form action="#" th:action="@{/form}" th:object="${consultant}" method="post">
        First Name: <input type="text" th:field="*{fname}" /><br />
        Last Name: <input type="text" th:field="*{lname}" /><br />
        Hourly Rate: <input type="number" th:field="*{hourlyrate}" /><br />
        <div>
            <label th:for="${#ids.next('available')}" >Available for Assignment</label>
            <input type="checkbox" th:field="*{available}" />
        </div>
    </form>
</body>
</form>
```

If it is done properly, when you run your application, you will be able to navigate to localhost:8080/form and see this:

This is because the template will render into this html:

```html
<!DOCTYPE html>

<html lang="en">
<head>
    <meta charset="UTF-8" />
    <title>Title</title>
</head>
<body>
  <h2>New Consultant Form</h2>
  <form action="/form" method="post">
    First Name: <input type="text" id="fname" name="fname" value="" /><br />
    Last Name: <input type="text" id="lname" name="lname" value="" /><br />
    Hourly Rate: <input type="number" id="hourlyrate" name="hourlyrate" value="0" /><br />
    <div>
        <label for="available1">Available for Assignment</label>
        <input type="checkbox" id="available1" name="available" value="true" /><input type="hidden" name="_available" value="on" />
    </div>
  </form>
</body>
</html>
```


