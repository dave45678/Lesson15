<!-- enter lesson number and title below separated by hyphen-->
# Lesson-15 Seeding: Loading data into your application before it runs
## Learning Objectives

## The Walkthrough
1. Create a new Laravel project 

2. Create a seeder file - one that will allow you to feed values into your database: 
``` 
php artisan make:seeder UsersTableSeeder 
```

3. Use the faker class to create values for the seeder:
* Open UsersTableSeeder.php in the database/seeds folder.
* Edit it to look like this:

``` php 
<?php

namespace App\Providers;

use Illuminate\Support\ServiceProvider;
use Illuminate\Support\Facades\Schema;

class AppServiceProvider extends ServiceProvider
{
    /**
     * Bootstrap any application services.
     *
     * @return void
     */
    public function boot()
    {
         Schema::defaultStringLength(191);
    }

    /**
     * Register any application services.
     *
     * @return void
     */
    public function register()
    {
        //
    }
}

```

4. Set up your database connection so that the seeder is able store values into your table. Refer to Lesson04 if necessary.


5. Run your migrations to make sure that the users table exists: 
``` 
php artisan migrate
```


6. Run the seeder 
``` 
php artisan db:seed --class=UserssTableSeeder

```
7. Check your database 
```
	use faker; 
	select * from faker; 
```

## What's Going On 
You created a seeder class to provide values to your fields. When you call the seeder class, it populates the selected table.

You should see 50 records with realistic looking values. 

Congratulations! You have faked your users.

You can now use Lesson [] to see if they can log in using the e-mail addresses provided, and the password "password".