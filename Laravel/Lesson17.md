# Lesson 17 - Deploying Your Application to Heroku 
## The Walkthrough 

1.  Start with any application  with a database from any previous lesson 

2.  Create a Heroku Account
    If you don't already have one, go to Heroku.com and create an account

3.  Download the Heroku CLI 
    * Find the right download for your platform and install it:
    * https://devcenter.heroku.com/articles/heroku-cli

4. If you have not already initialized your application with a git repository, do so now:

    * Open a Terminal

    * Type:

``` shell 
git init
```
    
5. Log in to the Heroku CLI


```ShellSession
$ heroku login
Enter your Heroku credentials.
Email: java@example.com
Password:
Could not find an existing public key.
Would you like to generate one? [Yn]
Generating new SSH public key.
Uploading ssh public key /Users/java/.ssh/id_rsa.pub
```

6. Provision a new Heroku App:
	* Navigate to the directory your application is in
	* Run the following:
```ShellSession
$ heroku create [friendly-app-name]
Creating friendly-app-name in organization heroku... done, stack is cedar-14
http://friendly-app-name.herokuapp.com/ | git@heroku.com:friendly-app-name.git
Git remote heroku added
```

7. Connect to a database
	* Create the hobby database for your application
	* Run the following:
```ShellSession
$ heroku addons:create heroku-postgresql:hobby-dev
Creating heroku-postgresql:hobby-dev on ajspringboot24... free
Database has been created and is available
 ! This database is empty. If upgrading, you can transfer
 ! data from another database with pg:copy
Created postgresql-sinuous-90403 as HEROKU_POSTGRESQL_BRONZE_URL
Use heroku addons:docs heroku-postgresql to view documentation
```


8. Add a heroku database to your database configuration in config/database.php, and change the default database to 'heroku'

```php 

'default' => 'heroku',

...

'heroku' => [
    'driver'   => 'pgsql',
    'host'     => parse_url(getenv("DATABASE_URL"))["host"],
    'database' => substr(parse_url(getenv("DATABASE_URL"))["path"], 1),
    'username' => parse_url(getenv("DATABASE_URL"))["user"],
    'password' => parse_url(getenv("DATABASE_URL"))["pass"],
    'charset'  => 'utf8',
    'prefix'   => '',
    'schema'   => 'public',
],```

9. Create a Procfile that tells heroku where to look for the app: 
```shell 
echo web: vendor/bin/heroku-php-apache2 public/ > Procfile
```

10. Generate an appication key and set it up on heroku: 

``` shell 
php artisan key:generate --show 
```

The key will show below and will look like this: 
```base64:MTs0+UZ0tHljmRcFP1RpZ06aYpc1N1L3rqAx1FT+yqk=
```

11. Set the application key on heroku:  
``` heroku config:set APP_KEY=APP_KEY_GOES_HERE
```

12. Deploy your code
	* Run the following:
```ShellSession
$ git push heroku master
```
	
13. Open your application	

``` shell
$ heroku open
```	

### Pushing  new changes to Heroku
	* Update the code in your local repository and push to heroku

``` shell
$ git add .
$ git commit -m "Database Changes for Heroku"
$ git push heroku master
```

	* Run your application and open a browser
``` shell
heroku open 
```
