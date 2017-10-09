use unofficialGuides;

show tables;

-- lesson 13
drop table if exists movie;
create table movie (movieId int auto_increment, title varchar(255) not null,`year` int, description varchar(255) not null,directorId int, primary key(movieId));
insert into movie (title, `year`,description,directorId) values ("Emoji Movie", 2017, "About Emoji Movie ...",1);
insert into movie (title, `year`,description,directorId) values ("DeathStar Ewoks", 2011, "About DeathStar Ewoks ...",1);
select * from movie;

drop table if exists actor;
create table actor (actorId int auto_increment, `name` varchar(255) not null, `realName` varchar(255) not null, primary key(actorId));
insert into actor (`name`,`realName`) values ("Sandra Bullock","Sandra Mae Bullowski");
select * from actor;

drop table if exists actor_movie;
-- create table movie_actor(movieId int, actorId int, foreign key (movieId) references movie(movieId),foreign key (actorId) references actor(actorId));
create table actor_movie(actorId int,movieId int);
insert into actor_movie values (1,1);
insert into actor_movie values (1,2);
select * from actor
inner join actor_movie
on actor.actorId = actor_movie.actorId
inner join movie
on actor_movie.movieId = movie.movieId;

-- Lesson 14
drop table if exists director;
create table director (directorId int auto_increment, `name` varchar(255) not null, genre varchar(255) not null, primary key (directorId));
insert into director (`name`, genre) values ('Stephen Bullock','Sci Fi');
select * from director;

drop table if exists movie;
create table movie (movieId int auto_increment, title varchar(255) not null,`year` int, description varchar(255) not null,directorId int, primary key(movieId));
insert into movie (title, `year`,description,directorId) values ("Emoji Movie", 2017, "About Emoji Movie ...",1);
insert into movie (title, `year`,description,directorId) values ("DeathStar Ewoks", 2011, "About DeathStar Ewoks ...",1);
select * from movie;

select  * from movie
inner join director
on movie.directorId = director.directorId;


drop table if exists laptop;
create table laptop (id int auto_increment not null, laptop_name varchar(50), laptop_os varchar(20),primary key(id));
insert into laptop (laptop_name,laptop_os) values ('WN1001HP','Windows 10');
insert into laptop (laptop_name,laptop_os) values ('LX1001DELL','RedHat Linux 7');
insert into laptop (laptop_name,laptop_os) values ('LX101DELL','Ubuntu Linux 17');
select * from laptop;
drop table if exists employee;
CREATE TABLE employee (id int auto_increment NOT NULL, employee_name varchar(255), laptop_id int,primary key(id));
insert into employee (employee_name,laptop_id)values('Henry Enright',1);
insert into employee (employee_name,laptop_id)values('Jacqueline Spivey',2);
insert into employee (employee_name,laptop_id)values('Kathleen Brewer',3);
select * from employee;
select * from employee inner join laptop on employee.laptop_id = laptop.id;




drop table if exists department;
CREATE TABLE department (id int auto_increment NOT NULL, department_name varchar(50),primary key(id));
insert into department (department_name) values ('Accounting');
insert into department (department_name) values ('Marketing');
insert into department (department_name) values ('Sales');

select * from department;

select * from customer;
-- http://www.oracle.com/technetwork/database/features/jdbc/jdbc-ucp-122-3110062.html
-- http://www.oracle.com/technetwork/database/enterprise-edition/jdbc-faq-090281.html#08_01
-- http://www.oracle.com/technetwork/database/application-development/index-099369.html
-- file:///home/student/Downloads/JavaEE_SDK/glassfish4/samples/docs/DeveloperREADME.html
-- https://en.wikipedia.org/wiki/Java_EE_version_history
