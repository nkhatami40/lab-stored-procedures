#1- In the previous lab we wrote a query to find first name, last name, and emails of all the customers who rented Action movies. Convert the query into a simple stored procedure.
  #query
  USE sakila;
  select first_name, last_name, email
  from customer
  join rental on customer.customer_id = rental.customer_id
  join inventory on rental.inventory_id = inventory.inventory_id
  join film on film.film_id = inventory.film_id
  join film_category on film_category.film_id = film.film_id
  join category on category.category_id = film_category.category_id
  where category.name = "Action"
  group by first_name, last_name, email;
  
  #Creating a stored procedure using the query:
  DELIMITER //
create procedure rented_category11() 
begin
 select first_name, last_name, email
  from customer
  join rental on customer.customer_id = rental.customer_id
  join inventory on rental.inventory_id = inventory.inventory_id
  join film on film.film_id = inventory.film_id
  join film_category on film_category.film_id = film.film_id
  join category on category.category_id = film_category.category_id
  where category.name = "Action"
  group by first_name, last_name, email;
end //
DELIMITER ;

#Calling the procedure:
call rented_category11();


#Now keep working on the previous stored procedure to make it more dynamic. Update the stored procedure in a such manner that it can take a string argument for the category name and return the results for all customers that rented movie of that category/genre. 
#For eg., it could be action, animation, children, classics, etc.

 DELIMITER //
create procedure rented_category3(in categoryname varchar(10)) 
begin
 select first_name, last_name, email
  from customer
  join rental on customer.customer_id = rental.customer_id
  join inventory on rental.inventory_id = inventory.inventory_id
  join film on film.film_id = inventory.film_id
  join film_category on film_category.film_id = film.film_id
  join category on category.category_id = film_category.category_id
  where category.name = categoryname
  group by first_name, last_name, email;
end //
DELIMITER ;

#Calling the procedure:
call rented_category3('classics');


#Write a query to check the number of movies released in each movie category. Convert the query in to a stored procedure to filter only those categories that have movies released greater than a certain number. 
#Pass that number as an argument in the stored procedure.

#Query:
SELECT COUNT(film_id) as 'number_of_movies', category.name
FROM category
join film_category
using(category_id)
join film using(film_id)
GROUP BY category.name
HAVING COUNT(film_id) > 60
;

#Create a procedure:
DELIMITER //
create procedure filter_category(in number_limit int) 
begin
 SELECT COUNT(film_id) as 'number_of_movies', category.name
FROM category
join film_category
using(category_id)
join film using(film_id)
GROUP BY category.name
HAVING COUNT(film_id) > number_limit
;
end //
DELIMITER ;

call filter_category(60);
