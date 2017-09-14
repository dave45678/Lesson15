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


CREATE TABLE department (id NOT NULL);
CREATE TABLE employee (id NOT NULL, dept_id NOT NULL, FOREIGN KEY (dept_id) REFERENCES department(id));

-- http://www.oracle.com/technetwork/database/features/jdbc/jdbc-ucp-122-3110062.html
-- http://www.oracle.com/technetwork/database/enterprise-edition/jdbc-faq-090281.html#08_01
-- http://www.oracle.com/technetwork/database/application-development/index-099369.html
-- file:///home/student/Downloads/JavaEE_SDK/glassfish4/samples/docs/DeveloperREADME.html
-- https://en.wikipedia.org/wiki/Java_EE_version_history
