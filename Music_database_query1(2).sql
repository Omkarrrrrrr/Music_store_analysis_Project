--q1) Who is the senior most employee based on job title?
select * from employee
order by levels desc
limit 1

--q2) Which countries have most invoices?
select * from invoice

select count(*) as c
from invoice
group by billing_country
order by c desc

--q3)what are top3 values of total invoice

select * from invoice
order by total desc
limit 3

--q4) Which city has the best customers? we would like to throw a promotional Music festival in the city we made most money
--    write a query that returns one city that has the highest sum of invoice totals
--    return both the city name and sum of all invoice totals

select sum(total) as invoice_total, billing_city
from invoice
group by billing_city
order by invoice_total desc

--q5) Who is the best customer? the customer who has spent the most money will be declared the best coustomer.
-- write a query that return the person who has spent the most money.

select customer.customer_id, customer.first_name, customer.last_name, sum(invoice.total) as total
from customer
join invoice on customer.customer_id = invoice.customer_id
group by customer.customer_id
order by total desc
limit 1

