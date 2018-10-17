use sakila;

-- add actor.actor_name
alter table actor
	add actor_name varchar(50) not null;

select * from actor;

-- this don't work in mysql apparently
with f as (
	select actor_id, first_name
	from actor
) l as (
	select actor_id, last_name
	from actor
) update actor
	set actor_name = concat(first_name, " ", last_name)
	where f.actor_id = l.actor_id;

-- fill actor.actor_name
update actor
	set actor_name = concat(first_name, " ", last_name)
	where actor_id = actor_id;

select actor_name from actor;

-- filtering examples
select actor_name 
from actor
	where actor_name like "%GEN%";

select first_name, last_name 
from actor
	where last_name like "%LI%"
	order by last_name, first_name;

select * 
from country
	where country in ("Afghanistan", "Bangladesh", "China");

-- add actor.middle_name
alter table actor
	add middle_name varchar(20) after first_name;
	
-- alter actor.middle_name to blob dtype
alter table actor
	modify column middle_name blob;

-- drop actor.middle_name
alter table actor
	drop column middle_name;

-- actor.last_name count
select last_name, count(*) as lname_count
from actor
	group by last_name;
	
-- actor.last_name count > 1
select last_name, count(*) as lname_count
from actor
	group by last_name
	having lname_count > 1;

-- update actor.first_name = "GROUCHO"
select first_name, last_name
from actor
	where first_name like "%GROUCHO%"
	where last_name like "%WILLIAM%";

update actor
	set first_name = "HARPO" 
	where first_name like "%GROUCHO%"
	and last_name like "%WILL%";
