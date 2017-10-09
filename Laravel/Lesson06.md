# Lesson-06 Looping through items with Blade

## Learning Objectives
* How to loop through data in Blade
* How to use Controllers for model specific operations

## The Walkthrough

1. Create a new Laravel project.

2. Create a database called jobdb

3. Use Lesson 04 to set up your database connection.

4. Create a job model and a migration to create the jobs table.

```
php artisan make:model Job -m
```
5. Create a JobController
```
php artisan make:controller JobController --resource --model=Job
```
6. Create the fields that will be used in the jobs table
Update the migrations up function to look like this:

Then create the table with the migration command:
```
php artisan migrate
```

7. Create a method in the JobController to show all jobs

8. Create a route to get a list of courses and pass it to a view.

9. Create a view to display the list.

# What's going on:

## Creating a job and model:
These can be done at the same time by typing the text above.

## Creating a resourceful JobController
This is for job related actions. We are going to make a resource controller so that http verbs (GET, PUT, POST, DELETE) can automatically be called.
