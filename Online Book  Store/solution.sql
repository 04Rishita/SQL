CREATE TABLE Books (
    Book_ID SERIAL PRIMARY KEY,
    Title VARCHAR(100),
    Author VARCHAR(100),
    Genre VARCHAR(50),
    Published_Year INT,
    Price NUMERIC(10, 2),
    Stock INT
);
CREATE TABLE Customers (
    Customer_ID SERIAL PRIMARY KEY,
    Name VARCHAR(100),
    Email VARCHAR(100),
    Phone VARCHAR(15),
    City VARCHAR(50),
    Country VARCHAR(150)
);
CREATE TABLE Orders (
    Order_ID SERIAL PRIMARY KEY,
    Customer_ID INT REFERENCES Customers(Customer_ID),
    Book_ID INT REFERENCES Books(Book_ID),
    Order_Date DATE,
    Quantity INT,
    Total_Amount NUMERIC(10, 2)
);
select * from books;
select * from Customers;
select * from orders;

-- 1) Retrieve all books in the "Fiction" genre:
select * from books where Genre='Fiction';

-- 2) Find books published after the year 1950:
select * from books where Published_Year > 1950;

-- 3) List all customers from the Canada:
select * from customers where Country='Canada';

-- 4) Show orders placed in November 2023:
select * from orders where Order_Date between '2023-11-01' and '2023-11-30';

-- 5) Retrieve the total stock of books available:
 select sum(stock) as total_books from books;
 
 -- 6) Find the details of the most expensive book:
select * from books order by price desc
limit 1;

-- 7) Show all customers who ordered more than 1 quantity of a book:
select * from orders where Quantity > 1;

-- 8) Retrieve all orders where the total amount exceeds $20:
select * from orders where Total_Amount > 20;

-- 9) List all genres available in the Books table:
select distinct Genre from books;

-- 10) Find the book with the lowest stock:
select Title,min(stock) as lowest_stock_book from books;

-- 11) Calculate the total revenue generated from all orders:
select sum(total_amount) as total_revenue from orders ;

-- 12) Retrieve the total number of books sold for each genre:
select b.Genre,sum(o.Quantity) as total_number_books from orders o join books b 
on o.Book_ID = b.Book_ID 
group by b.Genre;

-- 13) Find the average price of books in the "Fantasy" genre:
select avg(price) as average_price from books where Genre='Fantasy';

-- 14) List customers who have placed at least 2 orders:
select c.Name,c.Customer_ID,count(o.Order_ID) from customers c 
join orders o on o.Customer_ID=c.Customer_ID
having count(o.Order_ID) > 2;

-- 15) Find the most frequently ordered book:
select o.book_id,b.title,count(o.order_id) as counts
from orders o join books b on o.Book_ID=b.Book_ID
group by o.book_id,b.title
order by counts desc
limit 1;

-- 16) Show the top 3 most expensive books of 'Fantasy' Genre :
select * from books where Genre='Fantasy'
order by price desc
limit 3;

-- 17) Retrieve the total quantity of books sold by each author:
select b.Author,sum(o.Quantity) as total_quantity from orders o join books b 
on o.Book_ID=b.Book_ID 
group by b.Author
order by total_quantity;

-- 18) List the cities where customers who spent over $30 are located:
select distinct c.City ,o.total_amount from orders o join customers c 
on c.Customer_ID=o.Customer_ID 
where o.total_amount > 30;

-- 19) Find the customer who spent the most on orders:
select c.customer_ID,c.name,sum(o.total_amount)as total_spent from orders o join customers c
on c.Customer_ID=o.Customer_ID 
group by c.customer_ID,c.name
order by total_spent;

-- 20) Calculate the stock remaining after fulfilling all orders:
select b.book_id,b.title,b.stock,coalesce(sum(o.quantity),0) as order_quantity,
b.stock- coalesce(sum(o.quantity),0) as remaining_quantity from books b 
LEFT JOIN orders o ON b.book_id=o.book_id
GROUP BY b.book_id ORDER BY b.book_id;
