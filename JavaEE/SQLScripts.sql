-- a collection of MySQL scripts used for unofficialGuides

-- select * into customer from  select FullName,StreetAddress,City,State,ZipCode from customers limit 10;
create database unofficialGuides;
use unofficialGuides;
DROP TABLE `customer`;

use unofficialGuides;

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
select * from customer;


use unofficialGuides;

create table course (
id mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
instructor varchar(255) DEFAULT NULL,
title varchar(255) DEFAULT NULL,
credit integer,
PRIMARY KEY (`id`)
);

create table movie (
id mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
title
year long
description
)





select  * from course;

INSERT INTO `unofficialGuides`.`course` (`instructor`, `title`, `credit`) VALUES ('Mary Tyler Moore', 'Freshman English', '3');
INSERT INTO `unofficialGuides`.`course` (`instructor`, `title`, `credit`) VALUES ('Neil Tyson', 'Physics', '3');
