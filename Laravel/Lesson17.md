<!-- enter lesson number and title below separated by hyphen-->
# Lesson-18 Sending Email 
## Learning Objectives
- Use an existing e-mail server (Gmail)
- Send e-mail with templates

## The Walkthrough
1. Set up your configuration information so that your application can send e-mail form your account: 

* Change the settings in your .env file with your details. 

``` 
MAIL_DRIVER=smtp
MAIL_HOST=smtp.gmail.com
MAIL_PORT=587
MAIL_USERNAME=your.email@gmail.com
MAIL_PASSWORD=yourS3cureP@$$w0rd!
MAIL_ENCRYPTION=tls 
```
** Remember to remove these details or ignore this file if you are making your code public!**

2. Create a route in web.php to send e-mail: 

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

Route::get('sendmail',function(){
	$data = array(
		'name' =>"This Person"
		); 
	Mail::send('emailtemplate',$data,function($message){
		$message->from('person.from@gmail.com','First Email with Laravel');
		$message->to('hi@aoa4eva.me')->subject('Test email ');
	});

	return "Your e-mail has been sent";

});

```

3. Create a template called emailtemplate.blade.php. The content of this file will be sent to the recipient. 
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
	    <div class="col-md-6 col-md-offset-2">
	            <div class="col-md-12">
	            <a href="http://www.learningbycoding.com" class="pull-right">Learn by Coding!</a><br />
	            <H1>This is a sample e-mail from {{$name}}</H1>
	            <h4>This is text that will be sent in the email. You can format this e-mail however you want.</h4> 
	            You can also include pictures and icons! 
	            <div>
	            You should see an apple here... <img src="https://upload.wikimedia.org/wikipedia/commons/1/15/Red_Apple.jpg" height=30px>
	            </div>
	            </div>
	    </div>
	</body>
</html>
``` 

Note that you did not specify a 'from' element in the message. This is because gmail will use the detils of the e-mail address you set up. 

## What is Going On
