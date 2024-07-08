/* Q1: Find how much amount spent by each customer on artists? Write a query to return customer name, artist name and total spent */

--Step 1: Creating the Common Table Expression (CTE)- to Identify the best-selling artist by calculating the total sales.
WITH best_selling_artist AS (
	SELECT artist.artist_id AS artist_id, artist.name AS artist_name, SUM(invoice_line.unit_price*invoice_line.quantity) AS total_sales
	--Calculates the total sales for each artist by summing the product of unit_price and quantity from the invoice_line table. This result is given the alias total_sales.
	FROM invoice_line
	JOIN track ON track.track_id = invoice_line.track_id
	JOIN album ON album.album_id = track.album_id
	JOIN artist ON artist.artist_id = album.artist_id
	GROUP BY 1  
	ORDER BY 3 DESC
	LIMIT 1
)
	--Step 2: Main Query
SELECT c.customer_id, c.first_name, c.last_name, bsa.artist_name, SUM(il.unit_price*il.quantity) AS amount_spent
	--Calculates the total amount spent by summing the product of unit_price and quantity from the invoice_line 
	--table and assigns this sum the alias amount_spent.
FROM invoice i
JOIN customer c ON c.customer_id = i.customer_id
JOIN invoice_line il ON il.invoice_id = i.invoice_id
JOIN track t ON t.track_id = il.track_id
JOIN album alb ON alb.album_id = t.album_id
JOIN best_selling_artist bsa ON bsa.artist_id = alb.artist_id
GROUP BY 1,2,3,4
	--1 refers to c.customer_id
    --2 refers to c.first_name
    --3 refers to c.last_name
    --4 refers to bsa.artist_name
ORDER BY 5 DESC;

/* Q2: We want to find out the most popular music Genre for each country. We determine the most popular genre as the genre 
with the highest amount of purchases. Write a query that returns each country along with the top Genre. For countries where 
the maximum number of purchases is shared return all Genres. */

WITH popular_genre AS 
(
    SELECT COUNT(invoice_line.quantity) AS purchases, customer.country, genre.name, genre.genre_id, 
	ROW_NUMBER() OVER(PARTITION BY customer.country ORDER BY COUNT(invoice_line.quantity) DESC) AS RowNo 
	--ROW_NUMBER(): Assigns a unique row number to each row within a partition of the result set.
	/*PARTITION BY customer.country: Divides the result set into partitions based on customer.country.
      ORDER BY COUNT(invoice_line.quantity) DESC: Orders each partition by the count of invoice_line.quantity in descending order.*/
    FROM invoice_line 
	JOIN invoice ON invoice.invoice_id = invoice_line.invoice_id
	JOIN customer ON customer.customer_id = invoice.customer_id
	JOIN track ON track.track_id = invoice_line.track_id
	JOIN genre ON genre.genre_id = track.genre_id
	GROUP BY 2,3,4
	--2 ASC: customer.country in ascending order.
	--1 DESC: purchases (count of invoice line quantities) in descending order.
	ORDER BY 2 ASC, 1 DESC
	--Filters the result set to include only the first row (most popular genre) for each country, as determined by the ROW_NUMBER() function.
)
SELECT * FROM popular_genre WHERE RowNo <= 1

/* Q3: Write a query that determines the customer that has spent the most on music for each country. 
Write a query that returns the country along with the top customer and how much they spent. 
For countries where the top amount spent is shared, provide all customers who spent this amount. */

WITH Customter_with_country AS (
		SELECT customer.customer_id,first_name,last_name,billing_country,SUM(total) AS total_spending,
	    ROW_NUMBER() OVER(PARTITION BY billing_country ORDER BY SUM(total) DESC) AS RowNo 
		FROM invoice
		JOIN customer ON customer.customer_id = invoice.customer_id
		GROUP BY 1,2,3,4
		ORDER BY 4 ASC,5 DESC)
SELECT * FROM Customter_with_country WHERE RowNo <= 1
