Persistence refers to the ability to store objects in a database and use those objects with transactional integrity. In a J2EE application, data is typically stored and persisted in the data tier, in a relational database.

Entity beans are enterprise beans that contain persistent data and that can be saved in various persistent data stores. The entity beans represent data from a database; each entity bean carries its own identity. Entity beans can be deployed using application-managed persistence or container-managed persistence.

Converting a Java project to a JPA project

Use this procedure to convert an existing Java project to a JPA project.

From the Navigator or Project explorer, right-click the Java project and then select Configure > Convert to JPA Project.
The Project Facets page of the Modify Faceted Project wizard appears. Just click finish. We need to modify the settings in the persistence.xml file but you don't have to complete it through the optional wizard.



Customizing your Errors

When you are developing an application, you probably won't want to implement custom error pages. The Tomcat error pages are exactly what you need with all the information you could want in one place.

Once you are ready to deploy your application, the default error pages lack ... polish, and can be a sign of an unprofessional application.

There are two kinds of errors that you are going to want your application to be able to handle: html errors and java exceptions.

The main html errors you need to handle are the 404 error (page not found) and the 500 error (server error).

As for java exceptions, we can build a general page that handles all java exceptions.
Step 1

The easiest way to handle custom errors is to add entries to the web.xml file. By default the web.xml file is not available, so to add it you need to:

    Right-click your dynamic web project
    Select  Java EE Tools -> Generate Deployment Descriptor Stub
    Double-click the web.xml file in WebContent/WEB-INF

Step 2

Add an extra line before </web-app> and insert the following

<error-page>
    <error-code>404</error-code>
    <location>/error_404.jsp</location>
</error-page>

Then create a corresponding .jsp page with the proper message.
Step 3

If you run your application and try to navigate to a page that doesn't exist, you should now get your new custom error page.
Java Exceptions

To create your own attractive page for handling ALL java exceptions add the following to your web.xml file:

<error-page>
   <location>/error_java.jsp</location>
</error-page>

Then put something like the following in your error_java.jsp :

<h1>Java Error</h1>
<p>Sorry, Java has thrown an exception.</p>
<p>To continue, click the back button.</p>

<h2>Details</h2>
<p>Type: ${pageContext.exception["class"]}</p>
<p>Message: ${pageContext.exception.message}</p>

As an added touch, you can route your exceptions to a servlet, leave the last 3 lines out of the output message and instead post that detailed information to a log or email it to an admin. That way there is a simple easy-to-understand message for the user and complete information for the developers for debugging purposes.

 
