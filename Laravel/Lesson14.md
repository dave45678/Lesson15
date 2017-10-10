<!-- enter lesson number and title below separated by hyphen-->
# Lesson-14 Basic Security

## Learning Objectives
In this lesson, you will learn how to create an application that allows users to:

* Register, and

* Log in with details created during the registration process

## The Walkthrough

1. Make sure your MySQL server is running. This means that you should have WampServer, Laragon or whatever application runs your web and SQL servers running.


2. Create a new Laravel project. Don't forget to generate your application key if it does not already exist!

``` shell
laravel new Lesson14
```

3. Type:

``` shell
php artisan make:auth
```

4. You should see the following message:
![Authentiation feature added](img/createdauth.jpg)

5. Before you run your application, you have to set up a database connection, so that your users can be stored and authenticated against stored information.

To do this, see [Using databases with Laravel], and use the appropriate names for your project.

6. Run your laravel application by typing

``` shell
php artisan serve
```
and going to port 8000 on localhost in your browser.

You should see the following:

![Authentiation feature added](img/laravelauthed.jpg)


7. You can now use the register link (http://localhost:8000/register) to register users with your application!

8. Once you have registered, you can log in with the e-mail and password used.

***Note:***  The functionality to check e-mail addresses that have already been registered is included:

![Authentiation feature added](img/alreadyregistered.jpg)

## What is Going On
