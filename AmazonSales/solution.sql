
SELECT * FROM ftn.amazon_sales;

select count(*) as total_columns from amazon_sales;
select count(*) as total_rows from amazon_sales;
select count(*) as null_vales from amazon_sales where NULL;

-- Q.1 What is the count of distinct cities in the dataset?
select count(distinct(city)) as distinct_city_count from amazon_sales;

 -- Q.2 for each branch, what is corresponding city?
select distinct branch,city from amazon_sales;

-- Q.3 What is the count of distinct product lines in the dataset?
select count(distinct(product_line)) as distinct_products from amazon_sales; 

-- Q.4 Which payment method occurs most frequently?
select payment_method,count(*) as occurences from amazon_sales
group by payment_method
order by occurences desc;

-- Q.5 Which product line has the highest sales?
select product_line,sum(quantity) as highest_sales from amazon_sales 
group by product_line
order by highest_sales;

-- Q.6 How much revenue is generated each month?
select month_name,sum(total) as total_revenue from amazon_sales 
group by month_name
order by total_sales;

-- Q.7 Which product line generated highest revenue?
select product_line,sum(total) as total_revenue from amazon_sales
group by month_name
order by total_sales;

-- Q.8 In which month cost of goods sold reach its peak?
select month_name,sum(cogs) as total_cost from amazon_sales
group by month_name
order by total_cost desc;

-- Q.9 Which city has the highest revenue recorded?
select city,sum(total) as total_revenue from amazon_sales
group by city
order by total_revenue desc;

-- Q.10 Which product line incurred the highest value added tax?
select product_line,sum(vat) as highest_value from amazon_sales
group by product_line
order by highest_value desc;

-- Q.11 Which customer type occurs most frequently?
select customer_type,count(*) as count from amazon_sales
group by customer_type
order by count;

-- Q.12 For each product line, add a column indicating "Good" if its sales are above average, otherwise "Bad." 
select product_line,sum(total) as revenue,
case
when sum(total) > (select sum(total)/count(distinct(product_line)) from amazon_sales) then "Good"
else "Bad"
end performace
from amazon_sales
group by product_line;

-- Q.13 Which branch exceeded the average number of product sold? 
select branch,sum(quantity) as product_sold from amazon_sales
group by branch
having product_sold >(select avg(quantity) as avg_quanity) 
order by product_sold desc;

-- Q.14 Which product line is most frequently associated with each gender? 
with new as
(select gender,product_line,count(*) as count from amazon_sales group by gender,product_line),
max_count as(select max(count) from new group by gender)
select * from new where count in (select * from max_count) limit 2;

-- Q.15 What is the count of distinct customer types in the dataset?
select customer_type,count(distinct(customer_type)) as unique_cutomer_type from amazon_sales
group by customer_type;

-- Q.16 Calculate the average rating for each product line.
select avg(rating)as avg_rating,product_line from amazon_sales
group by product_line
order by avg_rating desc;

-- Q.17 Identify the customer type contributing the highest revenue.
select customer_type,sum(total) as revenue from amazon_sales
group by customer_type
order by revenue;

-- Q.18 Count the sales occurrences for each time of day on every weekday.
select day_name,time_of_day,count(*) as sales from amazon_sales
group by day_name,time_of_day
order by field(day_name,'Sunday','Monday','Tuesday','Wednesday','Thursday','Friday','Saturday'),
field('Afternoon','Morning','Evening');

-- Q.19 Determine city with highest VAT percentage.
select city,max(vat) as highest_percentage from amazon_sales
group by city
order by highest_percentage desc;

-- Q.20 Identify the customer type with the highest VAT payments.
select customer_type,max(vat) as vat_perecentage from amazon_sales;

-- Q.21 What is the count of distinct payment methods in the dataset?
select count(distinct(payment_method)) as unique_paymenttypes from amazon_sales;

-- Q.22 Examine distribution of gender within each branch.
select branch,gender,count(*) as count from amazon_sales
group by branch,gender
order by branch,gender;

-- Q.23 Determine predominant gender among customer.
select gender,count(*) as count from amazon_sales
group by gender
order by count;

-- Q.24 Identify the day of the week with the highest average ratings.
select day_name,avg(rating) as avg_rating from amazon_sales
group by day_name
order by avg_rating desc
limit 1;

-- Q.25 Identify the time of day when customer provide most ratings.
select time_of_day,count(rating) as counts from amazon_sales
group by time_of_day
order by counts desc
limit 1;
-- Q.26 Determine the time of day with the highest customer ratings for each branch.
select time_of_day,max(rating) as maximum_rtaing , branch from amazon_sales a
where rating= (select max(rating) from amazon_sales b where b.branch=a.branch)
group by time_of_day,branch
order by branch,time_of_day;
