# Lesson-05 Forms and Validation

## Learning Objectives
* Linking form input to models
* Validate form input


1. Create a new Laravel application.

2. We will use the database connection from Lesson04, so make sure you have that set up.

3. We will also use the Person model that we created before to validate fields.

4. Create a template to accept input - first name and last name.

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
.
    {{$message or ''}}
	@if($errors->has('firstname'))
	<span>You must enter a first name</span>
	@endif

    First Name: <input type="text" name="firstname" />

	@if($errors->has('lastname'))
	<span>You must enter a last name</span>
 	@endif

    Last Name: <input type="text" name="lastname" />

    <input type="submit" value="Submit" />

    {{csrf_field()}}
</form>
</body>
</html>
```

5. Create a template for the confirmation
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
        <p> First Name: {{$pers->firstname}}!</p>
        <p> First Name: {{$pers->lastname}}!</p>

    </body>
    </html>
```

6. Modify the Person model so that you can automatically populate items from the form: 
```php
<?php

	namespace App;


use Illuminate\Database\Eloquent\Model;

	class Person extends Model
	{
	    // This allow us to use the model's ->all() function to populate fields. 

//It fills the fields indicated if the request variables used for input have the same name

		protected $fillable= array('firstname','lastname');
	}

```

7. Modify web.php to look like this: 

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

use Illuminate\Http\Request;
use App\Person;

Route::get('/', function () {
    return view('hometemplate');
});

Route::post('/processform',function(Request $request){
	 $rules = array('firstname'=>'required','lastname'=>'required');
	  
	  $request->validate($rules);
	  $persval = new Person($request->all());
	  $persval->save();
});

```

9. Run your application. Enter information into the form leaving out one or both required fields to see the validation messages. 

10. Enter information in both fields. 

11. Check the database to see the information entered. 
