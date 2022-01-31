create database if not exists postdb;

use postdb;

create table if not exists author(
	id int auto_increment primary key,
    name varchar(100)
);

create table if not exists user(
	id int auto_increment primary key,
    name varchar(100)
);

create table if not exists post(
	id int auto_increment primary key,
    name varchar(100),
    authorid int,
    foreign key (authorid) references author(id),
    createdts datetime default current_timestamp
);

create table if not exists comment(
	id int auto_increment primary key,
    content varchar(1000),
    postid int,
    foreign key (postid) references post(id),
    createdts datetime default current_timestamp,
    userid int,
    foreign key (userid) references user(id)
);


insert into author(name) values('James Bond');
insert into author(name) values('JK Rowling');

insert into user(name) values('jb_bunny');
insert into user(name) values('sam_collin');
insert into user(name) values('sarah05');
insert into user(name) values('jamie_foxx');

insert into post(name, authorid) values('New Upcoming Movie', 2);
insert into post(name, authorid) values('Evening Break', 2);
insert into post(name, authorid) values('Sunday Blues', 2);
insert into post(name, authorid) values('Old Vintage House', 1);



insert into comment(content, postid, userid) values('Its name is No Time To Die!',1, 2);
insert into comment(content, postid, userid) values('Its gonna be epic!',1, 1);
insert into comment(content, postid, userid) values('Wow',1, 4);
insert into comment(content, postid, userid) values('Amazing movie',1, 3);
insert into comment(content, postid, userid) values('Cant wait to go to theaters',1, 2);
insert into comment(content, postid, userid) values('Bring popcorn',1, 1);
insert into comment(content, postid, userid) values('Its his last movie :(',1, 4);
insert into comment(content, postid, userid) values('I know',1, 3);
insert into comment(content, postid, userid) values('Whos gonna be the next bond',1, 1);
insert into comment(content, postid, userid) values('LOL',1, 4);
insert into comment(content, postid, userid) values('This is good',1, 3);

insert into comment(content, postid, userid) values('Love my evenings',2, 2);
insert into comment(content, postid, userid) values('Today is a good day',2, 1);
insert into comment(content, postid, userid) values('Tea time',2, 3);
insert into comment(content, postid, userid) values('I walk my dog on evening',2, 4);
insert into comment(content, postid, userid) values('Purple Sunset',2, 1);
insert into comment(content, postid, userid) values('Great',2, 3);
insert into comment(content, postid, userid) values('Outdoors',2, 2);
insert into comment(content, postid, userid) values('Over the moon',2, 4);

insert into comment(content, postid, userid) values('Sundays are the best',3, 2);
insert into comment(content, postid, userid) values('Sundays in italy are amazing',3, 4);
insert into comment(content, postid, userid) values('Its not sunday here :(',3, 3);
insert into comment(content, postid, userid) values('Lol :<))',3, 4);
insert into comment(content, postid, userid) values('Which part do you live in?',3, 1);
insert into comment(content, postid, userid) values('Orlando',3, 1);
insert into comment(content, postid, userid) values('Its cold there?',3, 3);
insert into comment(content, postid, userid) values('Pretty sure its cold there',3, 2);
insert into comment(content, postid, userid) values('-15 degree here',3, 2);
insert into comment(content, postid, userid) values('January is cold',3, 4);
insert into comment(content, postid, userid) values('LMAO',3, 1);
 
insert into comment(content, postid, userid) values('A house more vintage than vintage',4, 2);
insert into comment(content, postid, userid) values('Good one',4, 4);
insert into comment(content, postid, userid) values('My house is vintage',4, 3);
insert into comment(content, postid, userid) values('When was it made?',4, 4);
insert into comment(content, postid, userid) values('In 1800s ?',4, 1);
insert into comment(content, postid, userid) values('Thats too old too!',4, 1);
insert into comment(content, postid, userid) values('My great grandfather was in military so',4, 3);
insert into comment(content, postid, userid) values('Good man',4, 2);
insert into comment(content, postid, userid) values('They used to be cheaper back in the day',4, 2);
insert into comment(content, postid, userid) values('Inflation got us all good',4, 4);
insert into comment(content, postid, userid) values('yea ryt',4, 1);


select * from author;
select * from user;
select * from post;
select * from comment;

# Get list of Posts with latest 10 comments of each post authored by 'James Bond'
select p.id as postid, c.id as commentid, p.name as post, c.content as latest_comment from post p
inner join 
(select * from comment 
	where postid in (select id from post 
		where authorid = (select id from author where name='James Bond') 
	)
    
) c 
on p.id = c.postid
order by c.createdts desc;




        

with a as(
	select * from post
    where authorid = (select id from author where name='James Bond')
), b as (
	select postid, id as commentid, 
		row_number() over (partition by postid order by id desc) as rownum
	from comment
)
select * 
from a 
left join b
on b.postid = a.id
where b.rownum <= 10;