# Lesson 26 - Deploying Your Application to Heroku 

https://springframework.guru/unit-testing-junit-part-2/

## The Walkthrough 

### 1.  Start with any application you from any previous lesson 

### 2.  Create a Heroku Account
    If you don't already have one, go to Heroku.com and create an account

### 3.  Download the Heroku CLI 
    * Find the right download for your platform and install it:
      * Mac: https://devcenter.heroku.com/toolbelt-downloads/osx
      * Win32: https://devcenter.heroku.com/toolbelt-downloads/windows32
      * Win64: https://devcenter.heroku.com/toolbelt-downloads/windows64
      * Debian/Ubuntu: https://devcenter.heroku.com/toolbelt-downloads/debian
    
### 4. Log in to the Heroku CLI

Open a Terminal

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

### 5. Provision a new Heroku App:
1. Navigate to the directory your application is in

2. Run the following:

```ShellSession
$ heroku create
Creating nameless-lake-8055 in organization heroku... done, stack is cedar-14
http://nameless-lake-8055.herokuapp.com/ | git@heroku.com:nameless-lake-8055.git
Git remote heroku added
```

### 6. Connect to a database

1. Create the hobby database for your application
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

2. Use Postgresql
	* If you aren't already using postgres in your application add this to your dependencies:

 ```xml
<dependency>
  <groupId>org.postgresql</groupId>
  <artifactId>postgresql</artifactId>
  <version>9.4-1201-jdbc4</version>
</dependency>
```

3. Add postgres settings to your properties
	* Add this to your application.properties (and comment out your local database properties)

```
spring.datasource.url=${JDBC_DATABASE_URL}
spring.datasource.username=${JDBC_DATABASE_USERNAME}
spring.datasource.password=${JDBC_DATABASE_PASSWORD}
spring.jpa.show-sql=false
spring.jpa.generate-ddl=true
spring.jpa.hibernate.ddl-auto=update
```

	
### 7. Deploy your code
1. Run the following:
	
```ShellSession
$ git push heroku master
Initializing repository, done.
Counting objects: 110, done.
Delta compression using up to 4 threads.
Compressing objects: 100% (87/87), done.
Writing objects: 100% (110/110), 212.71 KiB | 0 bytes/s, done.
Total 110 (delta 30), reused 0 (delta 0)

-----> Java app detected
-----> Installing OpenJDK 1.8... done
-----> Installing Maven 3.3.3... done
-----> Executing: mvn -B -DskipTests=true clean install
       [INFO] Scanning for projects......
       [INFO] --------------------------------------------------------
       [INFO] BUILD SUCCESS
       [INFO] --------------------------------------------------------
       [INFO] Total time: 11.417s
       [INFO] Finished at: Thu Sep 11 17:16:38 UTC 2014
       [INFO] Final Memory: 21M/649M
       [INFO] -------------------------------------------------------> 
       Discovering process types
       Procfile declares types -> web
```
	
2. Open your application	

```ShellSession
$ heroku open
```	

### 8. Push new changes to Heroku
1. Update the code in your local repository and push to heroku

```
$ git add .
$ git commit -m "Database Changes for Heroku"
$ git push heroku master
```

2. Run your application and open a browser


# What's Going On 
Now that you've created an entire application, you probably want to share it with people. Heroku is a free app hosting service that lets you put your appication in the cloud. You can create up to 5 free applications on Heroku, and as long as you are using a PostgreSQL database, your app(s) will be hosted at no cost to you. 

If you already have a GitHub repository for your application, deploying to Heroku is easy. All you need to do (once you have an account) is log in to the terminal, create an application, and a database that will be used to hold your application's data. 

#### CONFIGURING THE DATABASE (DON'T FORGET YOUR DEPENDENCY!)

When configuring your database settings, you will have to include a dependency to allow you to connect to a PostgreSQL database - the same way you did with MySQL. You can't connect without it!

You will also need to change the settings to make sure your datasource now points to your new repository in the application properties file. The url, username, and password will automatically be taken from your database when you create it with 

``` 
heroku addons:create heroku-postgresql:hobby-dev
```

Once everything is configured, you can push to your remote URL like you're used to doing, and open the app in a browser with 

```
heroku open
``` 

