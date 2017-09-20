<!-- enter lesson number and title below separated by hyphen-->
# Lesson-01
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


![Running your first Laravel Application](https://github.com/ajhenley/unofficialguides/blob/master/Laravel/img/hello.png "Running your first Laravel Application")


5. Modify the text. Locate the /resources/views folder, and open up welcome.blade.php

Edit the **body** of the message to contain only this:

```
<body>
    <h1>Hello World!</h1>
</body>
```

6. Run your application and open a browser, if you type in the URL http://localhost:8000 you should see this:


## What is Going On
Your application is being 'scaffolded' when you type 'laravel new [application_name]'. That means that all of the basic classes that you will need to use are being added to your laravel project, and it is being set up for you. The 'bare-bones' application you download is like a template, and has most of the classes you will need to develop a functional application. You will use composer for dependency management, so if you want to use a class that is not available as part of the basic bundle, you will need to use composer to install it.

Your application uses a template engine called Blade to render php objects in HTML. By default, blade templates are stored in the ***resources/views*** folder, and are named **[Your_File_Name].blade.php**. This way, your application can recognise blade statements and variables. Blade renders into PHP. The blade template looks like HTML5, but it uses Blade's curly braces {{}} to render objects, and @ to render statements.
