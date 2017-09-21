# Lesson-06 Looping through items with Blade

## Learning Objectives
* How to loop through data in Blade
* How to use Controllers for model specific operations

## The Walkthrough

1. Create a new Laravel project.

2. Set up your database. 

2. Create a job model and a migration to create the jobs table.

```
php artisan make:model Job -m
```
3. Create a JobController
```
php artisan make:controller JobController --resource --model=Job
```
4. Create the fields that will be used in the jobs table
Update the migrations up function to look like this:

Then create the table with the migration command:
```
php artisan migrate
```

5. Create a method in the JobController to show all jobs
3. Create a route to get a list of courses and pass it to a view.

4. Create a view to display the list.


#What's going on:

Creating a job and model:
These can be done at the same time by typing the text above.

Creating a resourceful JobController
This is for job related actions. We are going to make a resource controller so that http verbs (GET, PUT, POST, DELETE) can automatically be called.
