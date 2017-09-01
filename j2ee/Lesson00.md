<!-- enter lesson number and title below separated by hyphen-->
# Lesson 00 - Set up your database
## Learning Objectives
* Open and log in to MySQL
* Create a database
* Create a table
* Insert data into the table
* Select data from the table

## The Walkthrough

1. Open MySQL
	* Click on the icon
	* log in as user: root and password: password
	* click on the link for File | New Query Tab
  * copy the following sql script to the new query tab
  * run the following statements

```sql
create database unofficialGuides;
use unofficialGuides;

-- DROP TABLE `customer`;

 CREATE TABLE customer (
  id mediumint(8) unsigned NOT NULL auto_increment,
  name varchar(255) default NULL,
  address varchar(255) default NULL,
  city varchar(255),
  state varchar(50) default NULL,
  zipcode varchar(10) default NULL,
  PRIMARY KEY (id)
) AUTO_INCREMENT=1;

INSERT INTO customer (id,name,address,city,state,zipcode) VALUES (1,"Lionel","742-1014 At Road","Covington","KY","71640"),(2,"Zephania","8324 Risus. St.","College","AK","99949"),(3,"Alma","Ap #207-5625 Nunc Ave","Essex","VT","26389"),(4,"Bernard","Ap #508-183 Id Ave","Wilmington","DE","70192"),(5,"Ian","Ap #482-8521 Aliquam Rd.","Lewiston","ME","52459"),(6,"Alyssa","536-8700 Imperdiet Street","Spokane","WA","95441"),(7,"Leandra","Ap #489-1473 Magnis St.","Phoenix","AZ","86105"),(8,"Brady","115 Vel Road","Oklahoma City","OK","46486"),(9,"Deborah","P.O. Box 365, 5462 Vehicula St.","Rutland","VT","32879"),(10,"Sylvester","3227 In Ave","Topeka","KS","87561");
INSERT INTO customer (id,name,address,city,state,zipcode) VALUES (11,"Edan","P.O. Box 971, 519 Neque. Rd.","Boston","MA","53932"),(12,"Amos","Ap #199-4791 Integer St.","Fresno","CA","90447"),(13,"Arden","Ap #596-1640 Posuere, Street","Hillsboro","OR","13368"),(14,"Cadman","251-1009 Pede Street","San Antonio","TX","95361"),(15,"Maisie","Ap #541-370 Vivamus Rd.","Helena","MT","58108"),(16,"Gay","P.O. Box 319, 8570 Ligula Road","Sandy","UT","96867"),(17,"Ignacia","3841 Adipiscing Avenue","Fort Smith","AR","71891"),(18,"Prescott","Ap #457-7314 Ultrices St.","Montpelier","VT","37223"),(19,"Vaughan","3787 Duis Av.","Sandy","UT","33454"),(20,"Karleigh","6918 Eu, Rd.","Bear","DE","71521");
INSERT INTO customer (id,name,address,city,state,zipcode) VALUES (21,"Lars","P.O. Box 112, 4205 Risus. Rd.","Hartford","CT","32770"),(22,"Kenyon","158-6262 Elit Rd.","Lawton","OK","79290"),(23,"Oleg","625 Ut Street","Baltimore","MD","14306"),(24,"Lacota","P.O. Box 623, 343 Vestibulum Rd.","Clarksville","TN","71296"),(25,"Susan","6274 Cum St.","Orlando","FL","60756"),(26,"Clarke","Ap #333-507 Metus St.","Bear","DE","31156"),(27,"McKenzie","945-9350 Aliquet. St.","Salt Lake City","UT","34310"),(28,"Karleigh","P.O. Box 876, 5018 Vehicula Street","Springdale","AR","72260"),(29,"Ross","P.O. Box 475, 2636 Aliquam Avenue","Grand Rapids","MI","20339"),(30,"Portia","P.O. Box 875, 7438 Vel St.","South Bend","IN","17578");
```

## What is Going On
You have just created a database in MySQL. You will be connecting to it from Java and JPA. To do so you will need to copy the following JAR files to your project.
 * eclipselink.jar
 * javax.persistence_2.1.0.v201304241213.jar
 * mysql-connector-java-5.1.42-bin.jar

Place these files in the WEB-INF\lib folder. Any other location may not be found by your program.

To connect from Java you will need the following connection information:

```java
jdbc:mysql://localhost/DATABASE?user=USER&password=PASSWORD
```

Note that the words in uppercase should be replaced with your database name, user name and password. Other values may also change depending on your system set up.

## Questions
* Where can I download the JAR files?
* What is my local database connection information?
