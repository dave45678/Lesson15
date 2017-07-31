# Displaying Link URLs with Thymeleaf

In this exercise, you will see how to use thymeleaf to display a url in your template.

## What you should do

### 1. Create a new spring boot application and a class called HomeController.java, that looks like this:
```java
@Controller
public class HomeContrller
{
  @RequestMapping("/urls")
  public String showLinks(Model model){
    model.addAttribute("user", "ajhenley");
    model.addAttribute("id", 3);
    model.addAttribute("category","sapling");
    return "urls";
  }
}
```

### 2. Create a template by right-clicking the template folder and name it links.html. It should look like this:
```html
<!DOCTYPE html>
<html xmlns:th="www.thymeleaf.org">
    <head>
        <title>Using Thymeleaf</title>
    </head>
    <body>
        <a href="showproduct.html" th:href="@{/product/3}">Show Product</a><br />
        <a href="showproduct.html" th:href="@{/product/{productid}(productid=${id})}">
            Show Product</a><br />
        <a href="showproduct.html" 
        th:href="@{/product/{productid}/{category}(productid=${id},category=${category})}">
            Show Product</a>
    </body>
</html>
```

If it is done properly, when you run your application, you will be able to navigate to localhost:8080/thymeleaf 
and see this:

This is because the template will render into this html:

```html
<!DOCTYPE html>
<html>
  <head>
    <title>Using Thymeleaf</title>
  </head>
  <body>
        <a href="/product/3">Show Product</a><br />
        <a href="/product/3">Show Product</a><br />
        <a href="/product/3/sapling">Show Product</a>
  </body>
</html>
```
