<!-- enter lesson number and title below separated by hyphen-->
# Lesson-10 Using Database Relationships: Many to Many 

## Learning Objectives
This lesson will take you through: 
- Creating two models - Actors and Movies - that have a many to many relationship 
- Creating the table that will record details of the relationship 
- Creating a function to establish the many to many relationship between data that is being entered into the application. 
- Creating a form to show that the relationship has successfully been created

## The Walkthrough

1. Create a new Laravel application named Lesson11 

2. Create a database called actorsandmovies

3.Use Lesson 04 to set up your database configuration in your new project.  

4. Create a Movie model and a migration to create the movies table

``` shell 
php artisan make:model Movie -m 
``` 

You should now have the following files in your project: 

* **create_movies_table.php** in the /database/migrations folder 

* **Movie.php** in the app folder 

5. Create a Movie resource controller 

``` shell
php artisan make:controller MovieController --resource --model=Movie 
```

6. Create the fields that will be used in the movies table: 

* Edit the create_movies_table.php file in \database\migrations to look like this:

``` php 

<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateMoviesTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('movies', function (Blueprint $table) {
            $table->increments('id');
            $table->char('title');
            $table->integer('year');
            $table->char('description');
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('movies');
    }
}


```


4. Create an Actor model 

``` shell 
php artisan make:model Actor -m 
``` 

5. Create an Actor resource controller
``` shell 
php artisan make:controller ActorController --resource --model=Actor 
```

6. Create fields that will be used in the actors table: 

* Edit your create_actors_table in the database\migrations folder to look like this: 

```php 

<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateActorsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('actors', function (Blueprint $table) {
            $table->increments('id');
            $table->char('name');
            $table->char('realname');
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('actors');
    }
}


```

6. Create a landing page to display a list of movies and actors. 
Create a file called movieindex.blade.php in the resources\views folder and edit it to look like this: 
``` html 
<!DOCTYPE html>

<html lang="en" xmlns:th="www.thymeleaf.org">
<head>
    <meta charset="UTF-8" />
    <title>List Movies</title>

    <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous"/>
</head>
<body>
<div class="container">
		<table class="table table-striped">
			<thead>
				@if(count($movies))
				 <h4><a class="pull-right" href="/movies/create">Add a movie </a> </h4>
				@endif
					<tr>
						<th>Title</th>
						<th>Employer</th>
						<th>Description</th>
						</tr>
			</thead>
			<tbody
"
				@forelse($movies as $movie)
					<tr>
						<td>{{$movie->title}}</td>
						<td>{{$movie->employer}}</td>
						<td>{{$movie->description}}</td>
						<td><a class="btn btn-default" href="{{action('MovieController@edit', $movie['id'])}}" >Update</a></td>
						<td>
						<form method="post" action="{{action('MovieController@destroy', $movie->id)}}">
						<input type="submit" class="btn btn-danger" value="Delete">
						{{csrf_field()}}
						{{ method_field('DELETE') }}
						</form>
						</td>
					</tr>
				@empty
					<h4> This is a list of movies. No movies are available right now, please <a href="/movies/create">Add one </a> </h4>
				@endforelse
			</tbody>
</table>
</div>
</body>
</html>

```


7. Add routes for the controllers you have created to the web.php file in the routes folder, so that it can identify each route, and its assiociated action. 

``` php 
Route::resource('movies','MovieController');

Route::resource('actors','ActorController');

``` 

7. Modify your MovieController: 

* Edit the index function to show the welcome page 

* Edit the create function to show the create page

* Edit thestore function to save the information entered and go back to the main list page. 


6. Create an input form for Movies 
Create a file called newmovie.blade.php in the resources\views folder and edit it to look like this: 



7. Create an input form for Actors
Create a file called newactor.blade.php in the resources\views folder and edit it to look like this: 


8. Generate a table to keep track of the relationships between models: 

``` shell

php artisan make:migration movie_actors --create=actor_movie

```
8. Create a form called addtomovies.blade for placing actors in movies
Edit it to look like this: 
``` html 
<!DOCTYPE html>

<html lang="en" xmlns:th="www.thymeleaf.org">
<head>
    <meta charset="UTF-8" />
    <title>List Movies</title>

    <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous"/>
</head>
<body>
<form method="post" action="{{action('ActorController@addmovie',$movie->id)}}">
@if(count($movies))
	<div class="container">
		<select>
			@foreach($movies as $movie)
				<option value={{$movie->id}}>{{$movie->title}}</option>
			@endforeach

		</select>
@else
	<h4>No movies are available. <a href="/movies/create"> Add one</a></h4>
@endif 
<input class="btn btn-default" type="submit" value="Add!">
</div>
</form>
</body>
</html>
```


Create movies and actors. 
Use the 'Add one' link to place an actor in a movie. 


Browse to http://localhost:8000

The application should look like this: 
![Actors and Movies](https://github.com/ajhenley/unofficialguides/blob/master/Laravel/img/listmoviesandactors.png "Creating a many to many relationship")

9. Examine the database 


## What is Going On
