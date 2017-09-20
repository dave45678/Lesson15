<!-- enter lesson number and title below separated by hyphen-->
# Lesson-03
## Learning Objectives
* Capturing form values in the Controller

In this lesson you will learn how to receive input from the user (from forms), and pass that information to other views.

1. Create a Laravel application
    * Name it Laravel03
    * Generate your key

2. Create a Blade template
    * Create a new file called hometemplate.blade.php in the ***resources/views*** folder
    * Edit it to look like this:

    ```html
    <!DOCTYPE html>
    <html lang="{{app()->getLocale()}}">
    <head>
        <meta charset="UTF-8" />
        <title>Title</title>
    </head>
    <body>
    <form action="/processform" method="post">
        First Name: <input type="text" name="firstname" />
        <input type="submit" value="Submit" />
        {{ csrf_field() }}
    </form>
    </body>
    </html>
    ```

  3. Create a template for the confirmation
    * Create a new file called confirm.blade.php in the ***resources/views*** folder
    * Edit it to look like this:

``` html
    <!DOCTYPE html>
    <html lang="{{app()->getLocale()}}">
    <head>
        <meta charset="UTF-8" />
        <title>Title</title>
    </head>
    <body>
        <p>Hello, {{$nameval}}!</p>

    </body>
    </html>
```

4. Add the Request class to web.php:
Open the web.php file in the /routes folder, and add this line in the first line outside the comment (line 14)
```
use Illuminate\Http\Request;
```

5. Create a route for displaying the input form:
    * Edit the function for the default route in web.php to look like this:

``` php
Route::get('/', function () {
    return view('hometemplate');
});
```

6. Create a route for displaying the input form:

``` php
Route::post('/processform', function (Request $request) {
    return view('confirm')->with('nameval',$request->firstname);
});
```

7. Run your application and open a browser, if you type in the URL http://localhost:8000/loadform you should see this:
![Creating a form](https://github.com/ajhenley/unofficialguides/blob/master/IntroToSpringBoot/img/Lesson04a.png "Creating a form")

8. Once you enter a value and click submit, you should see a page that looks like this:  
![Processing the form](https://github.com/ajhenley/unofficialguides/blob/master/IntroToSpringBoot/img/Lesson04b.png "Processing the form")
