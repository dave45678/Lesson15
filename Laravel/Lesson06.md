# Lesson-06 Looping through items with Blade

## Learning Objectives
* How to loop through data in Blade
* How to use Controllers for model specific operations

## The Walkthrough

1. Create a new Laravel project caled Lesson06.

2. Create a database called jobdb

3. Use Lesson 04 to set up your database configuration in your new project.

4. Create a job model and a migration to create the jobs table.
(ALWAYS make sure you have your database running in the background!)

```
php artisan make:model Job -m
```
You should now have the following files in your project:
** create_jobs_table.php ** in the /database/migrations folder
** Job.php ** in the app folder  

5. Create a JobController
```
php artisan make:controller JobController --resource --model=Job
```
6. Create the fields that will be used in the jobs table:

* Edit the create_jobs_table.php file in \daabase\migrations to look like this:
```
<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateJobsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('jobs', function (Blueprint $table) {
            $table->increments('id');
            $table->char('title');
            $table->char('employer');
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
        Schema::dropIfExists('jobs');
    }
}

```

Then create the table with the migration command:
```
php artisan migrate
```


7. Open the JobController.php file, which will be found in app\Http\Controllers

Make sure you have an index function in the JobControlller file that looks like this:

``` php
public function index()
   {
       //
       return view('jobs.index',['jobs'=>Job::all()]);
   }
```

8. Create a route to get a list of jobs and pass that list to a view:
* Open the web.php file, and include the following route:
Route::resource('jobs','JobController');

9. Create a route in the controller that shows the form that saves new job entries:
* Open app\Http\Controllers\JobController.php
* Edit it to look like this:
``` php
public function create()
    {
        //
        return view(jobs.create);
    }
```

9. Create a view to display the input form:
Open up resources\views\jobs\create.blade.php, and edit it to look like this:




# What's going on:

#### Creating a job and model:
These can be done at the same time by typing the text above.

#### Creating a resourceful JobController
This is for job related actions. We are going to make a resource controller so that http verbs (GET, PUT, POST, DELETE) can automatically be called.
