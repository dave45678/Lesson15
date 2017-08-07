# Lesson 6 - Handling Form Values -- the easy way 
## The Walkthrough 

1. Create a Spring Boot Application 
	* Name it SpringBoot_06 
	* Add the dependencies for the web and for thymeleaf 
	* Hit next until you finish the wizard, and then wait until it's done.    

2. Create a Class 
	* Right click on com.example.demo and click New -> Class 
	* Name it Song.java 
	* Edit it to look like this: 
```java
public class Song {
    private long id;
    private String name;
    private String artist;
    private String album;
    private int rating;
    private int year;
}
```

3. Create a Controller 
	* Right click on com.example.demo and click New -> Class 
	* Name it HomeController.java 
	* Edit it to look like this: 
```java
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class HomeController {
    @RequestMapping("/songform")
    public String loadFormPage(Model model){
        model.addAttribute("song', new Song());
        return "songform";
    }

    @RequestMapping("/songform")
    public String loadFromPage(@ModelAttribute Song song){
        return "confirmsong";
    }
}
```

3. Create a Template for the form
  	* Right click on templates and click New -> Html 
	* Name it songform.html 
	* Edit it to look like this: 
```html
<!DOCTYPE html>
<html lang="en" xmlns:th="www.thymeleaf.org">
<head>
    <meta charset="UTF-8" />
    <title>Title</title>
</head>
<body>
<form action="#" th:action="@{/songform}" th:object="${song}" method="post">
    Name: <input type="text" th:field="${name}" />
    Artist: <input type="text" name="${artist}" />
    Album: <input type="text" name="${album}" />
    Rating: <input type="number" name="${rating}" />
    Year: <input type="number" name="${year}" />
    <input type="submit" value="Submit" />
</form>
</body>
</html>
```

4. Create a Template for the confirmation
  	* Right click on templates and click New -> Html 
	* Name it confirmsong.html 
	* Edit it to look like this: 
```html
<!DOCTYPE html>
<html lang="en" xmlns:th="www.thymeleaf.org">
<head>
    <meta charset="UTF-8" />
    <title>Title</title>
</head>
<body>
    <p th:inline="text">The song name was [[${song.name}]].<br />
    The artist name is [[${song.artist}]].<br />
    The album name is [[${song.album}]].<br />
    The rating was [[${song.rating}]] and the year it came out on was [[${song.year}]].</p>
</body>
</html>
```

5. Run your application and open a browser, if you type in the URL http://localhost:8080/songform you should see this: 
![Creating a form](https://github.com/ajhenley/unofficialguides/blob/master/IntroToSpringBoot/img/Lesson06a.png "Creating a form")

6. Once you enter a value and click submit, you should see a page that looks like this:  
![Processing the form](https://github.com/ajhenley/unofficialguides/blob/master/IntroToSpringBoot/img/Lesson06b.png "Processing the form")


## What is Going On
### In the Controller

You are creating routes for both GET and POST requests to the songform endpoint 
(“/songform”). 
@GetMapping processes the GET requests, and @PostMapping processes post requests. 
They are shortcut annotations for 
@RequestMapping(value=“/songform“, method=RequestMethod.GET) and 
@RequestMapping(value=“/songform“, method=RequestMethod.POST) 
In the loadSongForm method, you are adding a new instance of the Song class to the model. This creates an ‘empty copy' of the Song class named “song”, which can be accessed by the songform html template. 
When the user submits information to the form, it is kept within the model, and can be drawn down into the processSongForm method using the @ModelAttribute annotation. 
This specifies that a model attribute of type Song which will be referred to as song in the method will be used. song is a Song object containing the values that were entered by the user into songform.html. 
“songvar” is now available to be used by confirmsong.html. 

### In the View (HTML Templates) 

**songform.html** 
A form is being created to accept values from the user. Since you are accepting values from the user, when he/she clicks the submit button (the HTML element with input type=“submit”), then the form values will be sent via a POST request to “/songform”. This will access the processSongForm method. 
**th:action** indicates what sould happen when the submit button is pressed. It uses a URL expression to indicate the route the user will be directed to in the controller. 

**th:object** indicates that the form’s values will be saved in the object called “song”, which was passed from the controller. 

**th:field** indicates that the value that is entered into an element corresponds to the value of the Song object referred to as song in the html template. When the form is posted, that value will be posted to the corresponding variable in the controller, and can also be accessed with getter methods if necessary. When the form is posted, the setters for song are called, so that the variable values can be assigned to the object. For example, song.setName() will be called to set the value of the name that the user entered into the input with attribute th:field=“*{name}”.
The input types show components that are best suited for capturing the selected type of information. For example, the number type will show a component that is best suited for increasing and decreasing integer values, while a text input will allow users to enter string values. 
*{} is a Thymeleaf selection expression that refers to a previously defined object, and indicates that all fields that are being referred to are from that object. In this case, the name, artist, album, rating and year fields all belong to the Song object called ‘song’ in the songform.html template. 

**confirmsong.html**
When the user entered values into songform.html, and the Song object was populated with the values, it was passed to the processSongForm method as part of a post request. The Song object was then passed to confirmsong.html, and is still accessible as “song”. This means that song's values can be accessed in confirmsong.html. 
The getter and setter methods you created are used to read and modify the values of the Song object. For example, [[${song.name}]] calls the value of song.getName(), and displays it in the html field. Make sure you create getters and setters for each field, otherwise you will not be able to set or access values for the objects you create. 

[Github Repository](https://github.com/ajhenley/SpringBoot_06)
