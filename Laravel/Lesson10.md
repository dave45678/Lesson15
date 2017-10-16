<!-- enter lesson number and title below separated by hyphen-->
# Lesson-10 Using Database Relationships: Many to Many 

## Learning Objectives
This lesson will take you through: 
- Creating two models - Actors and Movies - that have a many to many relationship 
- Creating relationships between Actors and Movies that are generated within the applicaiton
- Creating the table that will display details of the relationship 

## The Walkthrough

1. Create a new Laravel application named Lesson11 

2. Create a database called actorsandmovies

3. Use Lesson 04 to set up your database configuration in your new project.  

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

7. Create a table that keeps track of the relationship between actors and movies, named actor_movie: 
``` shell 
php artisan make:migration create_actor_movie  --create=actor_movie
```

8. Modify the table to include the actor and movie details by editing the create_actors migration to look like this: 

``php

<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class ActorMovie extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('actor_movie', function (Blueprint $table) {
            $table->increments('id');
            $table->integer('actor_id');
            $table->integer('movie_id');
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
        Schema::dropIfExists('actor_movie');
    }
}

```

6. Modify the model for Actor to define its relationship to Directors:
* Edit the Actor model to look like this:
``` php 
<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Actor extends Model
{
    //


    public function movies()
    {
        return $this->belongsToMany('App\Movie'); 
    }
}
```

7. Modify the model for Movie to define its relationship to Actors: 
* Edit the Movie Model to look like this: 
``` php 

<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Movie extends Model
{
    //

  public function actors()
  {
            return $this->hasMany('App\Actor'); 

  }

}

```


8. Create a landing page to display a list of movies and actors: 

Create a file called movieindex.blade.php in the resources\views folder and edit it to look like this: 
``` php
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
                        <th>Description</th>
                        <th>Year</th>
                        </tr>
            </thead>
            <tbody
"
                @forelse($movies as $movie)
                    <tr>
                        <td>{{$movie->title}}</td>
                        <td>{{$movie->description}}</td>
                        <td>{{$movie->year}}</td>
                        </form>
                        </td>
                    </tr>
                @empty
                    <h4> This is a list of movies. No movies are available right now. <a href="/load">You can load the data</a></h4>
                @endforelse
            </tbody>
</table>
<table class="table table-striped">
            <thead>
                @if(count($actors))
                 <h4><a class="pull-right" href="/actors/create">Add an actor </a> </h4>
                @endif
                    <tr>
                        <th>Name</th>
                        <th>Real Name</th>
                        <th>Movie Count</th>
                        </tr>
            </thead>
            <tbody>
                @forelse($actors as $actor)
                    <tr>
                        <td>{{$actor->name}}</td>
                        <td>{{$actor->realname}}</td>
                        @if($actor->movies->count())
                            <td>{{$actor->movies->count()}}</td>
                        @else
                            <td>No movies for this actor
                            <br> 
                            </td>
                        @endif
                        </td>
                    </tr>
                @empty
                    <h4> This is a list of actors. No actors are available right now, please <a href="/load">load data </a> </h4>
                @endforelse
        </tbody>
</table>

</div>
</body>
</html>
```

9. Edit the web.php file in the routes foler to look like this:

``` php 
<?php

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| contains the "web" middleware group. Now create something great!
|
*/

use App\Movie;
use App\Actor;

Route::get('/',function() {
    return view('movieindex')
   ->with('movies',App\Movie::all())
   ->with('actors',App\Actor::all());
});

Route::get('/load',function(){

       $actor = new App\Actor; 
       $actor->name="Sandra Bullock";
       $actor->realname="Sandra Mae Bullowski"; 
       $actor->save(); 

       $movie = new App\Movie; 
       $movie->title="Emoji Movie";
       $movie->year=2017; 
       $movie->description="About Emojis..."; 
       $actor->movies()->save($movie);

       $movie = new App\Movie; 
       $movie->title="Speed";
       $movie->year=1994; 
       $movie->description="About Speed";
       $actor->movies()->save($movie);

       $movie = new App\Movie; 
       $movie->title="Gravity";
       $movie->year=2013; 
       $movie->description="About Gravity..."; 

       $actor->movies()->save($movie);

        return view('movieindex')
       ->with('movies',App\Movie::all())
       ->with('actors',App\Actor::all());
});

Route::resource('actors','ActorController');
Route::resource('movies','MovieController');
```

10. Open up your browser and navigate to http://localhost:8000/ 

The application should look like this: 
![Actors and Movies](https://github.com/ajhenley/unofficialguides/blob/master/Laravel/img/listmoviesandactors.png "Creating a many to many relationship")

10. Examine the database 


## What is Going On
