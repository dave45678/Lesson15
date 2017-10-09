use unofficialGuides;

-- lesson 13
drop table if exists movie;
create table movie (movieId int auto_increment, title varchar(255) not null,`year` int, description varchar(255) not null,primary key(movieId));
insert into movie (title, `year`,description) values ("Emoji Movie", 2017, "About Emoji Movie ..."); 
insert into movie (title, `year`,description) values ("DeathStar Ewoks", 2011, "About DeathStar Ewoks ..."); 
select * from movie;

drop table if exists actor;
create table actor (actorId int auto_increment, `name` varchar(255) not null, `realName` varchar(255) not null, primary key(actorId));
insert into actor (`name`,`realName`) values ("Sandra Bullock","Sandra Mae Bullowski");
select * from actor;

drop table if exists movie_actor;
-- create table movie_actor(movieId int, actorId int, foreign key (movieId) references movie(movieId),foreign key (actorId) references actor(actorId));
create table movie_actor(movieId int, actorId int);
insert into movie_actor values (1,1);
insert into movie_actor values (2,1);
select * from actor
inner join movie_actor 
on actor.actorId = movie_actor.actorId
inner join movie
on movie_actor.movieId = movie.movieId;


