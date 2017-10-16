<!-- enter lesson number and title below separated by hyphen-->
# Lesson-17 Custom Error Messages
## Learning Objectives
- Creating error pages that match your site 

## The Walkthrough

1. Create a template for the error message you want to display (e.g. 404.blade.php).
Save it in the /resources/views/errors folder.

2. Edit it to look like this: 
``` html
<!DOCTYPE html>
<html lang="en" xmlns:th="www.thymeleaf.org">
<head>
    <meta charset="UTF-8" />
    <title>List Courses</title>

    <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous"/>
</head>
<body>
</h3>
    <div class="col-md-12">
         <h1 class="text-danger text-center">Yaaaah...no. Couldn't find your page.</h1>
    </div>
</body>
</html>
```

3. Open your browser and navigate to http://localhost:8000/unavailablepage 
You should see the page you designed. 


## What is Going On
