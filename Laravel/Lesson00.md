 <!-- enter lesson number and title below separated by hyphen-->

# Lesson 00 - Setting up

## Learning Objectives

- Set up your Laravel development environment on:
	- Linux (Ubuntu)
	- Windows, and 
	- Mac

## Things you will need to have on your machine
* Git
* Composer
* XAMPP Server 
* A text editor or IDE (PHP Storm, Sublime Text)
* Heroku CLI

## The Walkthrough 

1. Installing Git 
	
	* Open https://git-scm.com in your browser
  	* Download the installer for your machine 
  	* Run the installer application (accept the defaults for any questions)  

2. Installing Composer
	
	* Open https://getcomposer.org/download/ in your browser
	* Follow the instructions for your operating system 

3. Installing XAMPP Server
  	
  	* Open https://www.apachefriends.org/download.html in your browser. 
  	* You will need a minimum of PHP 7, so choose the appropriate installer 
  	* Download installer for your machine
  	* Run the installer application (accept the defaults for any questions)
  
4. Installing a text editor or IDE
	
	* If you wish to use PHP Storm:
  		* Open https://www.jetbrains.com/phpstorm/ in your browser
  		* Download the installer for your machine
  		* If you are a student in a college or university, go to https://www.jetbrains.com/student/ and using your campus email, register to get a one year free license
		* Run the installer application (accept the defaults for any questions)
	
	* If you wish to use Sublime Text:
		* Open https://www.sublimetext.com/ in your browser
		* Click the Download button and run the installer on your machine

5. Installing the Heroku CLI 
	
	* Open https://devcenter.heroku.com/articles/heroku-cli in your browser 
  	* Download the installer for your machine 
	* Run the installer application (accept the defaults for any questions)
  
6. Make sure to save the location of your Composer directory so you can add it to your 

PATH variables in Mac: 


PATH variables in Linux: 


PATH variables in Windows:
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
