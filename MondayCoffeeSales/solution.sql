SELECT * FROM practice.customers;
-- Q.1 Coffee Consumers Count
-- How many people in each city are estimated to consume coffee, given that 25% of the population does?
select city_name,round(population*0.25)/1000000 as coffee_consumers,city_rank from city 
order by population desc;

-- Q.2
-- Total Revenue from Coffee Sales
-- What is the total revenue generated from coffee sales across all cities in the last quarter of 2023?
select extract(quarter from s.sale_date) as quarter,extract(year from s.sale_date) as year,ci.city_name,sum(s.total) as revenue 
from sales s join customers c on c.customer_id=s.customer_id
join city ci on ci.city_id=c.city_id 
where extract(year from s.sale_date)=2023
group by ci.city_name
order by revenue desc;

-- Q.3
-- Sales Count for Each Product
-- How many units of each coffee product have been sold?
select p.product_name,count(s.sale_id) as total_orders from products p  join sales s
on p.product_id=s.product_id
group by p.product_name
order by total_orders desc;

-- Q.4
-- Average Sales Amount per City
-- What is the average sales amount per customer in each city?
-- city and total sale
-- number of customers in each these city
select ci.city_name,sum(s.total) as total_revenue,count( distinct c.customer_id) as total_customers,
round(avg(s.total),2) as avg_sales_amount from sales s join customers c on s.customer_id=c.customer_id
join city ci on ci.city_id=c.city_id 
group by ci.city_name
order by total_revenue desc;

-- Q.5
-- City Population and Coffee Consumers (25%)
-- Provide a list of cities along with their populations and estimated coffee consumers.
-- return city_name, total current cx, estimated coffee consumers (25%)
select ci.city_name,count(distinct c.customer_id)as total_customers,round((ci.population*0.25)/1000000,2) as coffee_consumers from city ci
join customers c on c.city_id=ci.city_id
group by ci.city_name
order by coffee_consumers desc ;

-- -- Q6
-- Top Selling Products by City
-- What are the top 3 selling products in each city based on sales volume?
select * from (select ci.city_name,p.product_name,count(s.sale_id) as total_orders,
dense_rank() over(partition by ci.city_name order by count(s.sale_id) desc) as ranks
from sales s join products p on s.product_id=p.product_id join customers c on c.customer_id=s.customer_id
join city ci on ci.city_id=c.city_id 
group by ci.city_name,p.product_name) r
where ranks <=3 
order by city_name,ranks;

-- Q.7
-- Customer Segmentation by City
-- How many unique customers are there in each city who have purchased coffee products?
select ci.city_name,count(distinct c.customer_id) as unique_customers from customers c join city ci
on c.city_id=ci.city_id join sales s on s.customer_id=c.customer_id where s.product_id in (1,2,3,4,5,6,7,8,9,10,11,12,13,14)
group by ci.city_name;