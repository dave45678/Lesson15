<!-- enter lesson number and title below separated by hyphen-->
# Lesson-12: Using Database Relationships: One to One  

## Learning Objectives

## The Walkthrough

1. Create a new Laravel application named Lesson11 and configure a connection to the database 

2. Create a Director model 
``` shell 

php artisan make:model Director -m
```

3. Create a director resource 

``` shell 

php artisan make:controller DirectorController --resource --model=Director  
```
4. Create an Movie model 
``` shell 
php artisan make:model Movie -m 
``` 

5. Create an movie resource

``` shell 
php artisan make:controller MovieController --resource --model=Movie


8. Create route for associating directors with movies: 
* Edit web.php in the routes folder. Add the following code: 

``` shell 
	
	$director = new App\Director; 
	$director->name = "Steven Spielberg"; 


	$movie = new App\Movie; 
	$movie->title="";	
	$movie->description="";	
	$movie->year="";	
	$director->movies()->save($movie);

	$movie = new App\Movie; 
	$movie->title="";	
	$movie->description="";	
	$movie->year="";	
	$director->movies()->save($movie);

	$movie = new App\Movie; 
	$movie->title="";	
	$movie->description="";	
	$movie->year="";	
	$director->movies()->save($movie);

``` 

9. Examine the database 


## What is Going On
