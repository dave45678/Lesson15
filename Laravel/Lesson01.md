<!-- enter lesson number and title below separated by hyphen-->
# Lesson
## Learning Objectives

You are going to create a "Hello World" application in Laravel.

## The Walkthrough

1. Create a new application by typing 'laravel new [application_name]'

In this case, you will type:

```
laravel new Lesson01
```

A new application will be created for you.

2. Generate your application key, by typing:

```
php artisan key:generate
```

3. Run your application:

```
php artisan serve
```

4. Run your application and open a browser, if you type in the URL http://localhost:8000 you should see this:


![Running your first Laravel Application](img/hello.png "Running your first Laravel application")


5. Modify the text. Locate the /resources/views folder, and open up welcome.blade.php

Edit the ***body*** of the message to contain only this:

```
<body>
    <h1>Hello World!</h1>
</body>
```

6. Run your application and open a browser, if you type in the URL http://localhost:8000 you should see this:


## What is Going On



## Questions


[Github Repository](https://github.com/ajhenley/SpringBoot_01)
