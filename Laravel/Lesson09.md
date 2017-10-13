<!-- enter lesson number and title below separated by hyphen-->
# Lesson-09 Complete data life cycle – form, list, detail, delete

## Learning Objectives


## The Walkthrough

1. Create a Laravel Application named Laravel08

2. Create a database called coursedb 

3. Use Lesson 04 to set up your database configuration in your project. 

4. Create a course model and a migration to create the courses table. 

``` php artisan make:model Course -m 
``` 

You should now have the following files in your project: 

* **create_courses_table.php** in the /database/migrations folder 
* **Course.php** in the app folder 

5. Create a CourseController 
``` php artisan make:controller CourseController --resource --model=Course 
```

6. Create the fields that will be used in the courses table: 
* Edit the create_courses.php file in \database\migrations to look like this: 

``` php  

<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateCoursesTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('courses', function (Blueprint $table) {
            $table->increments('id');
            $table->char('title');
            $table->char('instructor');
            $table->char('description');
            $table->integer('credit');
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
        Schema::dropIfExists('courses');
    }
}

```

7. Open the CourseController.php file, located in \app\Http\Controllers

Edit the index function to look like this: 

``` php
public function index()
   {
       return view('courses.index',['courses'=>Course::all()]);
   }


```


8. Create a route to get a list of courses and pass that list to a view: 

* Open the web.php file, and include the following route: 

``` php 

Route::resource('courses',CourseController);

```

9.  Create function in CourseController that allows the user to input course details: 
* Open app\Http\Controllers\CourseController.php 
* Edit it to look like this:

``` php
public function create()
    {
        //
        return view('courses.create');
    }


```

10. Create a view to dsiplay the input form: 
Create a file called resources\views\courses\create.blade.php and edit it to look like this: 

``` html


<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset ="UTF8">
            <title>Course Input</title>
          <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous"/>

</head>
<body>
    <div class="container">
        <div class="col-md-10">
            <form action="/courses" method="post">

                @if ($errors->any())
                    <div class="alert alert-danger">
                        <ul>
                            @foreach ($errors->all() as $error)
                                <li>{{ $error }}</li>
                            @endforeach
                        </ul>
                    </div>
                @endif
                
                Title:<input class="form-control" type="text" name="title">
                Instructor:<input class="form-control" type="text" name="instructor">
                Description:<input class="form-control" type="textarea" name="description">
                Credit:<input class="form-control" type="number" name="credit">
                {{csrf_field()}}
                <br/>
                <input class="btn btn-success"type="submit" value="Submit"></a>
            </form>
        </div>
    </div>
</body>
</html>
```

11. Create a file called resources\views\courses\index.blade.php and edit it to look like this:

``` html
<!DOCTYPE html>

<html lang="en" xmlns:th="www.thymeleaf.org">
<head>
    <meta charset="UTF-8" />
    <title>List Coursess</title>

    <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous"/>
</head>
<body>
<div class="container">
    <table class="table table-striped">
      <thead>
        @if(count($courses))
         <h4><a class="pull-right" href="/courses/create">Add a course </a> </h4>
        @endif
          <tr>
            <th>Title</th>
            <th>Instructor</th>
            <th>Description</th>
            <th>Credit</th>
            </tr>
      </thead>
      <tbody
"
        @forelse($courses as $course)
          <tr>
            <td>{{$course->title}}</td>
            <td>{{$course->instructor}}</td>
            <td>{{$course->description}}</td>
            <td>{{$course->credit}}</td>
            <td><a class="btn btn-default" href="{{action('CourseController@edit',$course->id)}}" >Update</a></td>
            <td>
            <form method="post" action="{{action('CourseController@destroy', $course->id)}}">
            <input type="submit" class="btn btn-danger" value="Delete">
            {{csrf_field()}}
            {{ method_field('DELETE') }}
            </form>
            </td>
          </tr>
        @empty
          <h4> This is a list of courses. No courses are available right now, please <a href="/courses/create">Add one </a> </h4>
        @endforelse
      </tbody>
</table>
</div>
</body>
</html>

```

12. Modify the **store*** function in CourseController to make it save new entries: 

``` php 

 public function store(Request $request)
    {


         $rules = array('title'=>'required|min:4',
         'instructor'=>'required|min:3','description'=>'min:10');
         $request->validate($rules);
        $j = new Course;
        $j->instructor = $request->instructor;
        $j->title=$request->title;
        $j->description=$request->description;
        $j->credit=$request->credit;
        $j->save();

        //Get the number of records in the table and pass it to the view  

        return view('courses.index')->with(['courses'=>Course::all()]);

    }


```
13. Modify the **edit** function in CourseController to make it look like this: 
``` php 

  return view('courses.update')->with(['course'=>$course]);

``` 



13. Modify the **update** function in CourseController to make it look like this: 
``` php 
  public function update(Request $request, Course $course)
    {
        
        $course->title = $request->title; 
        $course->description = $request->description; 
        $course->employer = $request->employer; 
        $course->save();
        return view('courses.index')->with(['courses'=>Course::all()]);

    }

``` 

14. Create a file called resources\views\courses\update.blade.php and edit it to look like this: 

``` html 

<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset ="UTF8">
      <title>Course Update</title>
      <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous"/>

</head>
<body>
  <div class="container">
    <div class="col-md-10">
      <form method="post" action="{{action('CourseController@update',$course->id)}}">

        @if ($errors->any())
            <div class="alert alert-danger">
                <ul>
                    @foreach ($errors->all() as $error)
                        <li>{{ $error }}</li>
                    @endforeach
                </ul>
            </div>
        @endif

        Title:<input class="form-control" type="text" name="title" value="{{$course->title}}" >
        Employer:<input class="form-control" type="text" name="instructor" value="{{$course->instructor}}" >
        Description:<input class="form-control" type="textarea" name="description" value="{{$course->description}}" >
        Credit:<input class="form-control" type="number" name="credit" value="{{$course->credit}}" >

        {{csrf_field()}}
        <!-- This cannot be added in the form tag, so it is added here -->
        {{ method_field('PUT') }}
        <br/>
        <input class="btn btn-success"type="submit" value="Submit"></a>
      </form>
    </div>
  </div>
</body>
</html>
```

15. Modify the **delete* function in CourseController to make it look like this: 


``` php 
public function destroy(Course $course)
    {
         
        $course->delete();
        return redirect('course')->with(['course'=>Course::all()]);

    }
```

16. Open your browser and navigate to http://localhost:8000/courses 

You should see this: 


## What is Going On
