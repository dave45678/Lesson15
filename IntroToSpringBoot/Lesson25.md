# Lesson 25 - Deploying Your Application to Heroku 
## The Walkthrough 

1. Start with any application you from any previous lesson 

2. Create a Heroku Account
    * If you don't already have one, go to Heroku.com and create an account

3. Download the Heroku CLI 
    * Find the right download for your platform and install it:
      * Mac: https://devcenter.heroku.com/toolbelt-downloads/osx
      * Win32: https://devcenter.heroku.com/toolbelt-downloads/windows32
      * Win64: https://devcenter.heroku.com/toolbelt-downloads/windows64
      * Debian/Ubuntu: https://devcenter.heroku.com/toolbelt-downloads/debian
    
4. Login in to the Heroku CLI
    * Open a Terminal
```shell
$ heroku login
Enter your Heroku credentials.
Email: java@example.com
Password:
Could not find an existing public key.
Would you like to generate one? [Yn]
Generating new SSH public key.
Uploading ssh public key /Users/java/.ssh/id_rsa.pub
```
    
6. Provision a new Heroku App
	* Navigate to the directory your application is in
	* Run the following:
```text
$ <b>heroku create</b>
Creating nameless-lake-8055 in organization heroku... done, stack is cedar-14
http://nameless-lake-8055.herokuapp.com/ | git@heroku.com:nameless-lake-8055.git
Git remote heroku added
```
	
7. Deploy your code
	* Run the following:
```text
$ <b>heroku create</b>
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
	
8. Open your application	
```text
$ <b>heroku open</b>
```	

### Connecting to a database

9. Create the hobby database for your application
	* Run the following:
```text
$ <b>heroku addons:create heroku-postgresql:hobby-dev</b>
Creating heroku-postgresql:hobby-dev on ajspringboot24... free
Database has been created and is available
 ! This database is empty. If upgrading, you can transfer
 ! data from another database with pg:copy
Created postgresql-sinuous-90403 as HEROKU_POSTGRESQL_BRONZE_URL
Use heroku addons:docs heroku-postgresql to view documentation
```

10. Use Postgresql
	* If you aren't already using postgres in your application add this to your dependencies:
```xml
<dependency>
  <groupId>org.postgresql</groupId>
  <artifactId>postgresql</artifactId>
  <version>9.4-1201-jdbc4</version>
</dependency>
```

	* Add this to your application.properties (and comment out your local database properties)
```text
spring.datasource.url=${JDBC_DATABASE_URL}
spring.datasource.username=${JDBC_DATABASE_USERNAME}
spring.datasource.password=${JDBC_DATABASE_PASSWORD}
spring.jpa.show-sql=false
spring.jpa.generate-ddl=true
spring.jpa.hibernate.ddl-auto=update
```

11. Push these new changes to Heroku
```text
$ git add .
$ git commit -m "Database Changes for Heroku"
$ git push heroku master
```

8. Run your application and open a browser
