# Lesson 12 - Uploading Images to Spring Boot with Cloudinary
## The Walkthrough

1. Create a Spring Boot Application
    * Name it SpringBoot_12
    * Add the dependencies for web, thymeleaf, jpa and h2
    * Hit next until you finish the wizard, and then wait until it's done.

2. Create a Class
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

3. Autogenerate getters and setters
    * Right-click on the word Actor and select generate -> Getters and Setters
    * Select all the fields list and click OK
    
4. Create a Repository
    * Right click on com.example.demo and click New -> Class
    * Name it ActorRepository.java
    * Edit it to look like this:
```java
import org.springframework.data.repository.CrudRepository;

public interface ActorRepository extends CrudRepository<Actor, Long> {
}
```

5. Create a Cloudinary Class
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
                .transformation(new Transformation().width(width).height(height).border("2px_solid_black").crop(action))
                .imageTag(name);
    }
}
```

5. Edit the Configuration
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

6. Create a Controller
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
    public String processActor(@ModelAttribute Actor actor, @RequestParam("file")MultipartFile file){
        if (file.isEmpty()){
            return "redirect:/add";
        }
        try {
            Map uploadResult =  cloudc.upload(file.getBytes(), ObjectUtils.asMap("resourcetype", "auto"));
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

7. Create a Template for the actor listings
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

8. Create a Template for the actor form
    * Right click on templates and click New -> Html
    * Name it form.html
    * Edit it to look like this:
```html
<!DOCTYPE html>
<html lang="en" xmlns:th="www.thymeleaf.org " xmlns:sec="www.thymeleaf.org/extras/spring-security">
  <head>
      <meta charset="utf-8" />
      <meta http-equiv="X-UA-Compatible" content="IE=edge" />
      <meta name="viewport" content="width=device-width, initial-scale=1" />
      <title>Bootstrap 101 Template</title>
  </head>
  <body>
    <br /><br />
    <h1>Spring Boot file upload example</h1>
    <form method="POST" action="/add" th:object="${actor}" enctype="multipart/form-data">
        Name: <input type="text" th:field="*{name}" />
        Real Name: <input type="text" th:field="*{realname}" />
        <input type="file" name="file" /><br/><br/>
        <input type="submit" value="Submit" />
    </form>
  </body>
</html>
```

9. Run your application and open a browser, it you type in the URL http://localhost:8080 you should see this:

10. If you enter the values and upload an image, it will show you a list of all the actors added so far. So, you should see a page that looks like this:


## What's Going On

