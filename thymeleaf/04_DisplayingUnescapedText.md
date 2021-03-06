# Displaying Unescaped Text

In this exercise, you will see how to use thymeleaf to display a controller variable containing html on your template.

## What you should do

### 1. Create a new spring boot application and a class called HomeController.java, that looks like this:
```java
@Controller
public class HomeContrller
{
    @RequestMapping("/escaped")
    public String showEscaped(Model model){
        model.addAttribute("body", "<h2>This is my <u>headline</u>!</h2>");
        return "escaped";
    }

    @RequestMapping("/unescaped")
    public String showUnescaped(Model model){
        model.addAttribute("body", "<h2>This is my <u>headline</u>!</h2>");
        return "unescaped";
    }
}
```

### 2. Create a template by right-clicking the template folder and name it escaped.html. It should look like this:
```html
<!DOCTYPE html>
<html xmlns:th="www.thymeleaf.org">
  <head>
    <title>Using Thymeleaf</title>
  </head>
  <body>
    <span th:text="${body}">It's not working</span>
  </body>
</html>
```

If it is done properly, when you run your application, you will be able to navigate to localhost:8080/escaped and see this:

This is because the template will render automatically html escape your text to help protect against injection attcaks. If we want
to actually render any tags that might be inside your variable, we need to use the th:utext attribute instead of the th:text. 

### 3. Create a template by right-clicking the template folder and name it unescaped.html. It should look like this:
```html
<!DOCTYPE html>
<html xmlns:th="www.thymeleaf.org">
  <head>
    <title>Using Thymeleaf</title>
  </head>
  <body>
    <span th:utext="${body}">It's not working</span>
  </body>
</html>
```

Now, if it is done properly, when you run your application, you will be able to navigate to localhost:8080/unescaped and see this:

This is because utext does not escape your text.
