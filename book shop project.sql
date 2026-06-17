--1 Retrieve all books in the "Fiction" genre
Select * from books
Where genre = 'Fiction'

--2 Find books published after the year 1950
Select * from books
Where published_year>1950

--3 List all customers from the Canada
Select * from customers
Where country='Canada'

--4 Show orders placed in November 2023
Select * from orders
Where order_date >= date '2023-11-01' 
    and order_date< date '2023-11-30'

--5 Retrieve the total stock of books available
Select sum(stock) as total_stock
From books

--6 Find the details of the most expensive book
Select * from books
Order by price desc
Fetch first row only

--7 Show all customers who ordered more than 1 quantity of a book
Select * from orders
Where quantity>1

--8 Retrieve all orders where the total amount exceeds $20
Select * from orders
Where total_amount>20

--9 List all genres available in the Books table
Select distinct genre
From books

--10 Find the book with the lowest stock
Select * from books
Order by stock asc
Fetch first row only

--11 Calculate the total revenue generated from all orders
Select sum(total_amount) as total_revenue
From orders

--12 Retrieve the total number of books sold for each genre
Select b.genre,sum(o.quantity) as total_books_sold
From orders o
Join books b
On o.book_id=b.book_id
Group by b.genre

--13 Find the average price of books in the "Fantasy" genre
Select avg(price)
From books
Where genre='Fantasy'

--14 List customers who have placed at least 2 orders
SELECT customer_id,count(order_id) as order_count
From orders
Group by customer_id
having count(order_id)>=2

--15 Find the most frequently ordered book
Select book_id, count(order_id) as order_count
From orders
Group by book_id
Order by order_count desc

--16 Show the top 3 most expensive books of 'Fantasy' Genre
Select * from books
Where genre='Fantasy'
Order by price desc
Fetch first row only

--17 Retrieve the total quantity of books sold by each author
Select b.author, sum(o.quantity) as total_books_sold
From orders o
Join
    Books b
	On o.book_id=b.book_id
Group by b.author

--18 List the cities where customers who spent over $30 are located
Select distinct c.city, o.total_amount
From orders o
Join customers c
On o.customer_id=c.customer_id
Where o.total_amount>30

--19 Find the customer who spent the most on orders
Select c.customer_id,c.name,sum(o.total_amount)as total_spent
From orders o
Join customers c
On o.customer_id=c.customer_id
Group by c.customer_id,c.name
Order by total_spent desc
Fetch first row only

--21. calculate the stock remaining after fulfilling all orders
select b.book_id,b.title,b.stock, coalesce(sum(o.quantity),0) as fil_quantity,
    b.stock-coalesce(sum(o.quantity),0) as remaining_quantity
from books b
join orders o on b.book_id=o.book_id
group by b.book_id,b.title,b.stock

--22. 9 Write a query to display the customers name,the book’s title and 
        --the date of the order for every record in the orders table

select c.name, b.title, o.order_date
from customers c
join orders o on c.customer_id=o.customer_id
join books b on b.book_id=o.book_id 

--23. 11 Identify any customer who have never placed an order. 
        --By using left join and check for null values

select c.name,o.order_id
from customers c
left join
    orders o on o.customer_id=c.customer_id
    where order_id is null

/*24. generate a list of orders showing the order_id, the customers name, 
the customers country and the total amount spent, ordered by the highest amount spent */
select o.order_id,c.name,c.country,sum(o.total_amount) as amount_spent
from customers c
join 
    orders o
            on c.customer_id=o.customer_id
    group by o.order_id,c.name,c.country
    order by amount_spent desc

--25. write a query to find all books that have a price higher than 
--the over all average book price “subquries”
select title,PRICE
from books
where price >
(select avg(price) as avg_book_price
from books)

--26. retrieve the names and emails of customers who have bought at 
--least one ‘biography’ book

select distinct c.name, c.email, b.genre
from customers c
join 
    orders o on o.customer_id=c.customer_id
join
    books b on o.book_id=b.book_id
where genre = 'Biography'

--27. find the book_id and title of the most expensive book that has a stock level of fewer than 10 copies
SELECT book_id,TITLE,stock,price
from books
where stock<10
order by price desc
fetch first row only
--28. 16 for each country find the customer who has placed the highest single order amount, display the country, customer name, and that order amount
select country,name,total_amount
from
(select c.country, c.name, o.total_amount,
        row_number() over (partition by c.country
        order by o.total_amount desc) as mytable
    from customers c
    join orders o
    on c.customer_id=o.customer_id)
where mytable = 1

--29.rank the books within each genre based on their price (highest to lowest) using a window function like “dense_rank”
select genre,title,PRICE,
dense_rank() over (partition by genre order by price desc) as price_rank
from books

--30.write a query to display the monthly total sales revenue for the year 2024 (grouped by month from January to December)
SELECT 
    to_char(order_date,'month') as sale_month,
   sum(total_amount) as monthly_sales
   from orders
   where extract(year from order_date)=2024
   GROUP BY to_char(order_date,'month'),extract(month from order_date)
   order by extract(month from order_date) 

--31.calculate a running total of the total_amount for all orders, ordered chronologically by order_date
select order_id,total_amount,
        sum(total_amount) over (order by order_id asc) as running_total
        from orders

--32. find the “VIP customer” who have placed more than 3 individual orders. Display their name,city and total order count.  
select c.name,c.city,
        count(o.order_id) as VIP_orders
        from customers c
        join orders o
        on c.customer_id=o.customer_id
        group by c.name,c.city
        having count(o.order_id)> 3
        order by count(o.order_id) desc


