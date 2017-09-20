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
    First Name: <input type="text" name="firstname" />
    Last Name: <input type="text" name="lastname" />
    <input type="submit" value="Submit" />
    {{ csrf_field() }}
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
