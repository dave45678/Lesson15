# Lesson 12 - Uploading Images to Spring Boot with Cloudinary
## The Walkthrough

1. Create a Spring Boot Application
    * Name it SpringBoot_12
    * Add the dependencies for web, thymeleaf, jpa and h2
    * Hit next until you finish the wizard, and then wait until it's done.

2. Sign up for a Cloudinary account (www.cloudinary.com) if you do not already have one 

3. Manually add Cloudinary dependencies
      * Open the pom.xml file and add this to the dependencies section
      
      ```xml
      <dependency>
			<groupId>com.cloudinary</groupId>
			<artifactId>cloudinary-taglib</artifactId>
			<version>1.2.1</version>
		</dependency>
		<dependency>
			<groupId>com.cloudinary</groupId>
			<artifactId>cloudinary-http44</artifactId>
			<version>1.2.1</version>
		</dependency>
      ```

4. Create a Class
    * Right-click on com.example.demo and click New -> Class
    * Name it Actor.java
    * Edit it to look like this:

```java
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

@Entity
public class Actor {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private long id;

    private String name;

    private String realname;

    private String headshot;
}
```

5. Autogenerate getters and setters
    * Right-click on the word Actor and select generate -> Getters and Setters
    * Select all the fields list and click OK
    
6. Create a Repository
    * Right click on com.example.demo and click New -> Class
    * Name it ActorRepository.java
    * Edit it to look like this:

```java
import org.springframework.data.repository.CrudRepository;

public interface ActorRepository extends CrudRepository<Actor, Long> {
}
```

7. Create a Cloudinary Class
    * Right-click on com.example.demo and click New -> Class
    * Name it CloudinaryConfig.java
    * Edit it to look like this:

```java
import com.cloudinary.Cloudinary;
import com.cloudinary.Singleton;
import com.cloudinary.Transformation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;
import java.io.IOException;
import java.util.Map;

@Component
public class CloudinaryConfig {
    private Cloudinary cloudinary;
    @Autowired
    public CloudinaryConfig(@Value("${cloudinary.apikey}") String key,
                            @Value("${cloudinary.apisecret}") String secret,
                            @Value("${cloudinary.cloudname}") String cloud){
        cloudinary = Singleton.getCloudinary();
        cloudinary.config.cloudName=cloud;
        cloudinary.config.apiSecret=secret;
        cloudinary.config.apiKey=key;
    }

    public Map upload(Object file, Map options){
        try{
            return cloudinary.uploader().upload(file, options);
        } catch (IOException e) {
            e.printStackTrace();
            return null;
        }
    }

    public String createUrl(String name, int width, int height, String action){
        return cloudinary.url()
                .transformation(new Transformation().width(width).height(height)
		.border("2px_solid_black").crop(action))
                .imageTag(name);
    }
}
```

8. Edit the Configuration
    * Open the application.properties file
    * Edit it to look like this:

```
# ===============================
# = Cloudinary configurations
# ===============================
cloudinary.cloudname=<<your cloud name>>
cloudinary.apisecret=<<your api secret>>
cloudinary.apikey=<<your api key>>

spring.h2.console.path=/h2-console
spring.h2.console.enabled=true
```

9. Create a Controller
    * Right-click on com.example.demo and click New -> Class
    * Name it HomeController.java
    * Edit it to look like this:
```java
import com.cloudinary.utils.ObjectUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.Map;

@Controller
public class HomeController {
    @Autowired
    ActorRepository actorRepository;

    @Autowired
    CloudinaryConfig cloudc;

    @RequestMapping("/")
    public String listActors(Model model){
        model.addAttribute("actors", actorRepository.findAll());
        return "list";
    }

    @GetMapping("/add")
    public String newActor(Model model){
        model.addAttribute("actor", new Actor());
        return "form";
    }

    @PostMapping("/add")
    public String processActor(@ModelAttribute Actor actor, 
    	@RequestParam("file")MultipartFile file){
        if (file.isEmpty()){
            return "redirect:/add";
        }
        try {
            Map uploadResult =  cloudc.upload(file.getBytes(), 
	    	ObjectUtils.asMap("resourcetype", "auto"));
            actor.setHeadshot(uploadResult.get("url").toString());
            actorRepository.save(actor);
        } catch (IOException e){
            e.printStackTrace();
            return "redirect:/add";
        }
        return "redirect:/";
    }
}
```

10. Create a Template for the actor listings
    * Right click on templates and click New -> Html
    * Name it list.html
    * Edit it to look like this:

```html
<!DOCTYPE html>
<html lang="en" xmlns:th="www.thymeleaf.org">
<head>
    <meta charset="UTF-8" />
    <title>Title</title>
</head>
<body>
<a href="/add">Add an actor</a>
  <div th:each="actor : ${actors}">
      <div th:if="${actor.headshot} != null">
          <img th:src="${actor.headshot}" />
          <hr />
      </div>
      <h3 th:text="${actor.name}"></h3>
      <h4 th:text="${actor.realname}"></h4>
  </div>
</body>
</html>
```

11. Create a Template for the actor form
    * Right click on templates and click New -> Html
    * Name it form.html
    * Edit it to look like this:

```html
<!DOCTYPE html>
<html lang="en" xmlns:th="www.thymeleaf.org" 
	xmlns:sec="www.thymeleaf.org/extras/spring-security">
  <head>
      <meta charset="utf-8" />
      <meta http-equiv="X-UA-Compatible" content="IE=edge" />
      <meta name="viewport" content="width=device-width, initial-scale=1" />
      <title>Bootstrap 101 Template</title>
  </head>
  <body>
    <br /><br />
    <h1>Spring Boot file upload example</h1>
    <form method="POST" action="/add" th:object="${actor}" 
    	enctype="multipart/form-data">
        Name: <input type="text" th:field="*{name}" />
        Real Name: <input type="text" th:field="*{realname}" />
        <input type="file" name="file" /><br/><br/>
        <input type="submit" value="Submit" />
    </form>
  </body>
</html>
```

12. Run your application and open a browser, it you type in the URL http://localhost:8080 you should see this:

13. If you enter the values and upload an image, it will show you a list of all the actors added so far. So, you
should see a page that looks like this:


## What's Going On

Congratulations! If you've made it this far, you're ready to start using your first third party API. Cloudinary is an application that allows you to upload and transform images, so you can allow your users to filter images, re-shape them, add text, and have a lot of fun using the additional options that come for 'free' with this application. 

This is a sample of things you can do with Cloudinary (http://www.cloudinary.com/cookbook)
Have fun!


All you need to do is upload the image to the Cloudianry server, and apply as many styles as you would like to to transform the image. 

You will need to add the Cloudinary dependency so that you can create an instance of the Cloudinary class. This creates a way for your code to access all of the methods it needs to be able to 'talk to' the Cloudinary server. 

In this example, we're creating a database of headshots of actors, so we need to have their names, and a link to their headshots, which will be uploaded via our application and saved to the Cloudinary server. 

__REMEMBER YOUR GETTERS AND SETTERS!!__

You will need to create a class that interacts with the Cloudinary server, and makes all of the transformations available ot your application. This class (CloudinaryConfig) will use a number of classes that were imported when you added the dependency to the .pom file. 

In this class, you have the following: 


#What's Going ON

#The Model 
### Actor 
This is a simple entity that saves information about the actor. 

#The View

### list.html
This displays actors' names and pictures. The pictures are displayed using the image tag, but using a thymeleaf attribute, th:src, instead of a regular html attribute. 

### form.html 
This form allows a user to uplad files. 

```
<input type="file">
```
indicates that a file is expected, and 

```
 enctype="multipart/form-data"
```
indicates that additional data is going to be posted with the form (i.e. the picture). This means that the post variables for the form will include the file which is uploaded. The uploaded file can be processed, as you will see in the PostMapping method for the "add" route. 

#The Controller

### @RequestMapping("/")
This route lists all of the actors in the database and displays their images using list.html. 


@GetMapping("/add")
This route creates an empty object to allow users to add new actors. 
Users can input these details in form.html. 

@PostMapping("/add")
This is where the magic happens. Once a user clicks 'submit' on form.html, then the details are submitted to the controller. Here, the file (passed as a request parameter, as it is not part of the model) is uploaded to cloudinary. 

The resulting image is saved into a Map called uploadResult (to prepare it for Cloudinary). 

ObjectUtils.asMap("resourcetype","auto") indicates that Cloudinary should automatically try to detect what kind of file has been uploaded. 

Once the file has been successfully saved on the Cloudinary server, and a URL is available, it is saved to the actor object (using the setter for headshot), and the actor model is saved to the database, with the name entered by the user and the file uploaded.  The user is then returned to the default route and should see the list of actors and their headshots. 

## The Cloudinary Configuration Class
### private Cloudinary cloudinary 
This is an object that will be used to apply your image tranfomations, and generate a URL with those transformations so that you can use the image later.

### public CloudinaryConfig()
This constructor for the class you have created. It takes the values of the cloudinary settings you entered in your application.properties file, and assigns those to the variables that the Singleton class will use to connect to Cloudinary. 


### public Map upload (Object file, Map options)

This passes the file from the user's computer to Cloudinary, returning an object which contains all of the properties for the transformed image. 

### public String createUrl()
This creates a Cloudinary URL 'preset' trasnformations. In this case, the width, height and border can automatically be applied each time this method is called, and a URL to the transformed image will be returned. 


