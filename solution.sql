-- 1
  -- a.
	select first_name, last_name
	from actor;
  -- b.
	select (concat(first_name, " ", last_name)) as "Actor Name"
	from actor;

-- 2
  -- a.
	select actor_id, first_name, last_name
	from actor
	  where first_name like "%JOE%";
  -- b.
	select first_name, last_name
	from actor
	  where last_name like "%GEN%";
  -- c.
	select first_name, last_name
	from actor
	  where last_name like "%LI%"
	order by last_name, first_name;
  -- d.
	select country_id, country
	from country
	  where country in ("Afghanistan", "Bangladesh", "China");

-- 3
  -- a.
	alter table actor
	  add column description blob;
  -- b.
	alter table actor
	  drop column description;

-- 4
  -- a.
	select last_name, count(last_name) as frequency
	from actor;
  -- b.
	select last_name, count(last_name) as frequency_gt1
	from actor
	group by last_name
	  having frequency_gt1 > 1;
  -- c.
	update actor
	  set first_name = "HARPO"
		where first_name like "GROUCHO"
	  	  and last_name like "WILLIAMS";
  -- d.
	update actor
	  set first_name = "GROUCHO"
	    where first_name like "HARPO"
		  and last_name like "WILLIAMS";

-- 5a.
  show create table address;

-- 6
  -- a.
	select s.first_name
		  ,s.last_name
		  ,a.address
	from staff s
	  left join address a
		on a.address_id = s.address_id;
  -- b.
	select s.first_name
		  ,s.last_name
		  ,sum(p.amount) as sales_aug
	from staff s
	  left join payment p
		on s.staff_id = p.staff_id
		where payment_date like "2005-08-%"
	group by s.staff_id;
  -- c.
	select f.title
		   ,count(fa.film_id) as actor_count
	from film f
	  inner join film_actor fa
		on f.film_id = fa.film_id
	group by f.film_id;
  -- d.
	select f.title
		  ,count(i.film_id) num_available
	from inventory i
	  left join film f
		on f.film_id = i.film_id
	where f.title like "%HUNCHBACK IMP%";
  -- e.
	select distinct
			c.last_name
		   ,c.first_name
		   ,sum(p.amount) as spend_total
	from customer c
	  left join payment p
		on p.customer_id = c.customer_id
	group by p.customer_id
	order by c.last_name asc;

-- 7
  -- a.
	select f.title ,(
	  select l.name
	  from language l
	  where l.name = "English"
    ) as language
	from film f
	  where title like "K%"
	    or title like "Q%";
  -- b. TODO: refactor as subquery
	select a.first_name
   		  ,a.last_name
		  ,f.title
	from film_actor fa
	  left join actor a
		on a.actor_id = fa.actor_id
	  left join film f
		on f.film_id = fa.film_id
	where f.title = "Alone Trip";
  -- c.
	select cust.first_name
		  ,cust.last_name
		  ,coun.country
	from customer cust
	  left join address ad
	  	on cust.address_id = ad.address_id
	  left join city cit
	    on ad.city_id = cit.city_id
	  left join country coun
	    on cit.country_id = coun.country_id
		  where coun.country like "%canada%";
  -- d.
	select f.title
		  ,c.name
	from film f
	  left join film_category fc
	    on f.film_id = fc.film_id
	  left join category c
	    on fc.category_id = c.category_id
	      where c.name like "family";
  -- e.
    select f.title
		  ,count(r.rental_id) as times_rented
	from rental r
	  left join inventory i
	    on r.inventory_id = i.inventory_id
	  left join film f
	    on i.film_id = f.film_id
	group by f.title
	order by times_rented desc;
  -- f.
	select store, total_sales
	from sales_by_store;
  -- g.
	select s.store_id
		  ,cit.city
		  ,coun.country
	from store s
	  left join address a
	    on s.address_id = a.address_id
	  left join city cit
	    on a.city_id = cit.city_id
	  left join country coun
	    on cit.country_id = coun.country_id;
  -- h.
	select category
		  ,sum(total_sales) as gross_rev
	from sales_by_film_category
	group by category
	order by gross_rev desc
	limit 5;

-- 8
  -- a.
	create view top_5_genres as
	  select category
    	,sum(total_sales) as gross_rev
	  from sales_by_film_category
	  group by category
	  order by gross_rev desc
	  limit 5;
  -- b.
	select * from top_5_genres;
  -- c.
	drop view top_5_genres;
