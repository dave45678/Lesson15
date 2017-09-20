# Lesson-04 Using databases with Laravel
## Learning Objectives

* Setting up the database connection
* Creating models and table migrations

1. Create a new Laravel application. Don't forget to generate your application key if it does not already exist!

2. Create a database that you can connect to in MySQL
using  'create database DB_NAME', where DB_NAME is the name that your database will use. In our case, we will create a database called forge:

```
mysql
create database forge;
```

3. Look in your .env file in the root directory of your project.
Change the MySQL settings to look like this:
```
DB_CONNECTION=mysql
DB_HOST=127.0.0.1
DB_PORT=3306
DB_DATABASE=forge
DB_USERNAME=
DB_PASSWORD=
```
Your username and password should be the credentials you use to log in to MySQL.

4. Look in  **config/database.php**
Update the MySQL details with the appropriate values for
DB_DATABASE, DB_USERNAME, and DB_PASSWORD
Make sure your password is whatever password you use for your MySQL configuration.

6. Create a Model called Person, with its associated migrations by typing this into your shell:

```
php artisan make:model Person -m
```

You should see the following text:
Created Migration: 2017_09_18_175912_create_people_table

Look in the **/app** directory for your file.
It should be called what you decided to name it.

Go to the database file in the config folder in your project, and add fields to your tables as required.

For this example, make your file look like this:

```php
<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Person extends Model
{
    //
}

```
Use the guidelines from http://laravel.com/docs/5.5/migrations#creating-tables to decide what fields to use, and their lengths.

There is an error 'baked' into Laravel which will occur when you run the users table migration.

To fix it, do the following:

As outlined in the Migrations guide to fix this all you have to do is edit your AppServiceProvider.php (app\Providers) file and inside the boot method set a default string length:
```
php
use Illuminate\Support\Facades\Schema;

public function boot()
{
    Schema::defaultStringLength(150);
}
```


4. Update your migrations to reflect the columns you want to see in your tables.
To do this:
* Go to the migrations folder.
* Open up create_people_table.php, and edit it to look like this:

![Edit migration](https://github.com/ajhenley/unofficialguides/blob/master/Laravel/img/create_person_migration.png "Running your first Laravel Migration")

5. Run your migration statements to update your table structures by typing:
```
php artisan migrate
```

This sets up your database with all of the tables that need to be created.
You should see a result that is similar to the image below:

![Migration result](https://github.com/ajhenley/unofficialguides/blob/master/Laravel/img/create_migration.png "Running your first Laravel Migration")

Type php artisan migrate:status.

You should see the following text:

![Migration ran](https://github.com/ajhenley/unofficialguides/blob/master/Laravel/img/migrationran.png "Checking your first Laravel Migration")

Check that your table has been created. Go to your MySQL console.

Type:
```
mysql
use forge;
```

And then:
```
mysql
show tables;
```

You should see your people table in the list.

Next, type:
```
mysql
describe persons;
```
You should see the columns that you created, with the size limits you specified.

Congratulations! You've created your tables.

Now let's create forms that can save into them in the next lesson.
