# Displaying External Text

In this exercise, you will see how to use thymeleaf to display a static block of text on your template.

## What you should do

1. Create a new spring boot application and add a file called message.properties, that looks like this:

```
hello.header=Welcome!
hello.content=Click here to advance to the next page
greeting.header=Hello on a second page!
greeting.content=Click here to go back
```

2. Create a template called message.html by right-clicking  on the template folder and make it look like this:

```html
<!DOCTYPE html>
<html>
  <head>
    <title>Using Thymeleaf</title>
  </head>
  <body>
    <span th:text="#{hello.header}">It's not working</span>
    <a href="#" th:text="${hello.content}">It's not working</a>
    <span th:text="${greeting.header}">It's not working</span>
    <button th:text="${greeting.content}">It's not working</span>
  </body>
</html>
```

If it is done properly, when you run your application, you will be able to navigate to localhost:8080/thymeleaf and see this:

This is because the template will render into this html:

```
<!DOCTYPE html>
<html>
  <head>
    <title>Using Thymeleaf</title>
  </head>
  <body>
    <span>It's not working</span>
    <a href="#" th:text="${hello.content}">It's not working</a>
    <span th:text="${greeting.header}">It's not working</span>
    <button th:text="${greeting.content}">It's not working</span>
  </body>
</html>

```
