 <!-- enter lesson number and title below separated by hyphen-->

# Lesson 00 - Setting up

## Learning Objectives

- Setting up your Laravel development environment on Linux (Ubuntu), Windows, and Mac
- 


## Install Laravel



### Linux (Ubuntu) Installation 

1. Download XAMPP server for Linux and install it (https://www.apachefriends.org/download.html)

2. Download and install Composer (https://getcomposer.org/download)

3. Download and install Git - it will be needed to complete the Laravel installation (https://git-scm.com/download/linux)



### Mac Installation 
1. Download XAMPP server for Linux and install it (https://www.apachefriends.org/download.html)

2. Download and install Composer (https://getcomposer.org/download)

3. Download and install Git - it will be needed to complete the Laravel installation (https://git-scm.com/download/mac)

4. Make sure you are using PHP 7 (change the version in Wamp Server before continuing. You can check this in the terminal line by typing: 

``` shell
php -version
```

5. Make sure you have the following extensions installed:

    * PHP >= 7.0.0
    * OpenSSL PHP Extension
    * PDO PHP Extension
    * Mbstring PHP Extension
    * Tokenizer PHP Extension
    * XML PHP Extension


6. Create a new application to test the setup  by typing 

``` shell 
laravel new newappliation 
```

7. Generate your application key, otherwise you will see "Whoops, something went wrong". To do this, type the text bellow in your command prompt:

```
php artisan key:generate
```

8. Copy the file called .env.example to .env

9. Run your application by typing the line below in the command line:

```
php artisan serve
```
 Congratulations! You now officially have your first Laravel application up and running! Open up a browser and type in the text below to see it:

```
 http://localhost:8000
 ```

 Note: **YOU MUST RUN PHP ARTISAN FROM YOUR APPLICATION'S ROOT FOLDER FOR IT TO WORK PROPERLY**




### Windows Installation in 10 easy steps

1. Download WampServer and install it (http://www.wampserver.com/en/)

2. Download and install Composer (https://getcomposer.org/download/)

3. Download and install Git - it will be needed to complete the Laravel installation (https://git-scm.com/download/win)

4. Make sure you are using PHP 7 (change the version in Wamp Server before continuing. You can check this in the command line by typing: 
``` shell
php -version
``` 

5. Make sure you have the following extensions installed:

    * PHP >= 7.0.0
    * OpenSSL PHP Extension
    * PDO PHP Extension
    * Mbstring PHP Extension
    * Tokenizer PHP Extension
    * XML PHP Extension

6. Make sure to save the location of your Composer directory so you can add it to your PATH variables in Windows:
```
    C:/Users/[Your_User_Name]/AppData/Roaming/Composer
```

7. Create a new application to test the setup  by typing 

``` shell 
laravel new newappliation 
```

8. Generate your application key, otherwise you will see "Whoops, something went wrong". To do this, type the text bellow in your command prompt:

```
php artisan key:generate
```

9. Copy the file called .env.example to .env

10. Run your application by typing the line below in the command line:

```
php artisan serve
```
 Congratulations! You now officially have your first Laravel application up and running! Open up a browser and type in the text below to see it:

```
 http://localhost:8000
 ```

 Note: **YOU MUST RUN PHP ARTISAN FROM YOUR APPLICATION'S ROOT FOLDER FOR IT TO WORK PROPERLY**

## What's Going On

Laravel is a framework for PHP - which means that 'scaffolds' or builds a number of features for you using commands, instead of making you type them out on your own.

Commands include creating an application, setting up and seeding (putting data into) databases, and setting up relationships between fields in tables.

In order to get your Laravel installation working, you need to have a number of helper applications installed.

This guide takes you through the process of setting up your machine for various platforms, so that you are ready to build your application as quickly as possible.

You are downloading a WAMP server. It is a machine on **W**indows with **A**pache, **M**ySQPL and **P**HP.

This is your local version of a web server that allows you to see the pages that you develop in a browser.

When you run your laravel application, you should be able to see it in your browser, the same way you would if you put it on a server in the cloud, so that other people could use your website.

Your website is not publicly accessible on localhost - you can only access it from your machine.
