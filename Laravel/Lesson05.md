# Lesson-05 Using databases with Laravel
## Learning Objectives

* Creating models and table migrations
* Linking forms and controllers to models
* Saving to the database

1. Create a new Laravel application

2. Create a database in mysql, by opening up the console, logging in and typing the following:

```
mysql
create database forge;
```

2. Create a Model called Person, with its associated migrations by typing this into your shell:

```
php artisan make:model Person -m
```

Note: YOU MUST RUN PHP ARTISAN FROM YOUR ROOT FOLDER FOR IT TO WORK PROPERLY

Create a new project:

laravel new Lesson03

Configure your database connection in config/database.php

To start with, make sure you have a database called forge with a user called forge who can can connect to MySQL without a password if you want to use the default database that laravel comes with.
Otherwise, create a database that you can connect to in MySQL
using  'create database DB_NAME', where DB_NAME is the name that your database will use.

Persist to a database:

1. Create a database called forge (you do not need to change database configuration)

2. php artisan make:model Customer

Look in /app for your file.
It should be called what you decided to name it.


3. Look in your .env file in the root directory of your project.
Change the MySQL settings to look like this:

DB_CONNECTION=mysql
DB_HOST=127.0.0.1
DB_PORT=3306
DB_DATABASE=forge
DB_USERNAME=root
DB_PASSWORD=

Make sure your password is whatever password you use for your MySQL configuration.

3. Now it's time to create the database structure.
'Tell Laravel' what your tables should look like.
To do this, use Migrations, so that you can run them again when you need to setup the database from scratch.

Go to the project's root folder, and type:
php artisan make:migration create_customers_table --create=customers

You should see the following text:
Created Migration: 2017_09_18_175912_create_customers_table

Go to the database file in the config folder in your project, and add fields to your tables as required.

For this example, make your file look like this:

Use the guidelines from http://laravel.com/docs/5.5/migrations#creating-tables to decide what fields to use, and their lengths.


There is an error 'baked' into laravel which will occur when you run ther users table migration.
To fix it, do the following:

As outlined in the Migrations guide to fix this all you have to do is edit your AppServiceProvider.php (app\Providers) file and inside the boot method set a default string length:

use Illuminate\Support\Facades\Schema;

public function boot()
{
    Schema::defaultStringLength(191);
}

4. php artisan migrate
This sets up your database with all of the tables that need to be created.
Check that your table has been created by going to your command line.
Type php artisan migrate:status.

Then go to your MySQL console.

Type:
use forge;

And then:
show tables;

You should see your customers table in the list.

Next, type:
describe customers;

You should see the name column that you created, with the size limit you specified.


Congratulations! You've created your tables.

Now let's create forms that can save into them in the next lesson.
