SELECT * FROM ftn.amazon_sales;

INSERT INTO amazon_sales (
    invoice_id, branch, city, customer_type, gender, product_line, unit_price, quantity, vat, total, date, time,
    payment_method, cogs, gross_margin_percentage, gross_income, rating, time_of_day, day_name, month_name
) VALUES
('750-67-8428', 'A', 'Yangon', 'Member', 'Female', 'Health and beauty', 74.69, 7, 26.1415, 400.7165, '2025-01-05', '13:08:00', 'Ewallet', 374.575, 4.0, 26.1415, 9.1, 'Afternoon', 'Monday', 'January'),
('226-31-3081', 'C', 'Naypyitaw', 'Normal', 'Female', 'Electronic accessories', 15.28, 5, 3.82, 80.82, '2025-02-12', '10:29:00', 'Cash', 77.0, 4.76, 3.82, 8.2, 'Morning', 'Wednesday', 'February'),
('631-41-3108', 'A', 'Yangon', 'Member', 'Male', 'Home and lifestyle', 46.33, 4, 9.266, 194.726, '2025-03-23', '17:57:00', 'Credit card', 185.46, 4.76, 9.266, 7.4, 'Evening', 'Sunday', 'March'),
('123-19-1176', 'B', 'Mandalay', 'Normal', 'Female', 'Sports and travel', 58.22, 5, 14.555, 305.655, '2025-04-09', '11:40:00', 'Ewallet', 291.1, 4.76, 14.555, 9.0, 'Morning', 'Wednesday', 'April'),
('373-73-7910', 'C', 'Naypyitaw', 'Member', 'Male', 'Food and beverages', 19.25, 10, 9.625, 201.125, '2025-05-11', '14:35:00', 'Cash', 191.5, 4.76, 9.625, 6.7, 'Afternoon', 'Sunday', 'May'),
('699-14-3026', 'A', 'Yangon', 'Normal', 'Female', 'Fashion accessories', 95.25, 3, 14.2875, 157.0375, '2025-06-18', '16:15:00', 'Credit card', 142.75, 4.76, 14.2875, 8.5, 'Evening', 'Wednesday', 'June'),
('355-53-5943', 'B', 'Mandalay', 'Member', 'Male', 'Electronic accessories', 68.84, 6, 20.652, 361.692, '2025-07-01', '09:45:00', 'Ewallet', 341.04, 4.76, 20.652, 9.4, 'Morning', 'Tuesday', 'July'),
('582-48-3042', 'C', 'Naypyitaw', 'Normal', 'Female', 'Health and beauty', 33.50, 8, 13.40, 121.40, '2025-08-21', '12:50:00', 'Cash', 108.0, 4.76, 13.40, 6.8, 'Afternoon', 'Thursday', 'August'),
('489-30-1143', 'B', 'Mandalay', 'Member', 'Male', 'Home and lifestyle', 55.20, 2, 5.52, 116.92, '2025-09-14', '18:20:00', 'Credit card', 110.4, 4.76, 5.52, 7.9, 'Evening', 'Sunday', 'September'),
('871-46-2035', 'A', 'Yangon', 'Normal', 'Female', 'Food and beverages', 25.75, 4, 5.15, 108.15, '2025-10-02', '15:55:00', 'Ewallet', 103.0, 4.76, 5.15, 9.0, 'Afternoon', 'Thursday', 'October');

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

