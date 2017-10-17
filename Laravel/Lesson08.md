<!-- enter lesson number and title below separated by hyphen-->
# Lesson-08 

## Learning Objectives
- Add Twitter bootstrap to a blade view 
- Add sub-views to blade templates 

## The Walkthrough
1. Create a folder called layouts to store your blade templates.

2. Create folders inside resources/assets for your web resources - css, images, javascript, etc.

3. Get Twitter Bootstrap: 

* Download the file by using this link: 
  ![https://github.com/twbs/bootstrap/releases/download/v3.3.7/bootstrap-3.3.7-dist.zip]
* Unzip the folder 

* Copy the folders from the unzipped file into the public folder 


4. Create a base layout: 

* Create a folder called layouts in resources/views/layouts
* Create a file called base.blade.php in rosources/views/layouts
* Edit base.blade.php to look like this: 

``` php 
    <!DOCTYPE html>
    <html>
        <head>
            <link rel="stylesheet" href="{!! asset('css/bootstrap.min.css') !!}">
            <title>Application Name - @yield('title')</title>
        </head>
        <body>
                @section('navlinks')
                    <nav class="navbar navbar-default">
                        <ui class="nav nav-pills">
                            <li><a href="/">Welcome</a></li>
                            <li ><a href="/2">Two</a></li>
                            <li><a href="/3">Three</a></li>
                        </ui>
                    </nav>
                @show
                @section('thecontainer')
                    <div class="container">
                        <p>This is content from the parent section. It should display before the text.</p>
                        @yield('content')
                        <p>This is content from the parent section. It should display after the text. 
                    </div>
                @show

                @section('highlighted')
                <div class="alert alert-success">
                    @yield('hltext')
                </div>
                @show
        </body>
    </html>

```

5. Create a file (Page Two) that uses the base layout: 

* Create a file called two.blade.php in the resources/views folder 
* Edit it to look like this: 

``` php 

@extends('layouts.base')


@section('title','Page Two')

@section('navlinks')
	@parent
@endsection 

@section('highlighted')
@endsection 


```

6. Create another file (Page Three) that uses the base layout 

* Create a file called three.blade.php in the resources/views folder 
* Edit it to look like this: 

``` php 

@extends('layouts.base')


@section('title','Page Three')

@section('navlinks')
	@parent
@endsection 

@section('content')
	<p> This is the content section for page three. It uses the styles from the base layout.
	The content yields everything from its parent section as well. 
@endsection 

@section('hltext')
 This is higihlighted text
@endsection


```


6. Create a route to page two: 

* Open web.php in the routes folder 
* Edit it to look like this: 

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

Route::get('/', function () {
    return view('welcome');
});

Route::get('/2',function(){
	return view('two');
});

Route::get('/3',function(){
	return view('three');
});


``` 

7. Open a browser window and navigate to ![http://localhost:8000] 

* You should see this: 
![Welcomepage](https://github.com/ajhenley/unofficialguides/blob/master/Laravel/img/bladetemplateindex.png "Creating blade template subviews")

* When you click on page 2 you should see this: 
![Page Two](https://github.com/ajhenley/unofficialguides/blob/master/Laravel/img/bladetemplateindex.png "Blade Page 2")

* When you click on page 3 you should see this:
![Page Three](https://github.com/ajhenley/unofficialguides/blob/master/Laravel/img/bladetemplateindex.png "Blade Page Three")


## What is Going On
