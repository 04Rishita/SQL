SELECT * FROM practice.orders; 

-- Find top 10 highest revenue generating products
select category,product_id,quantity*sales_price as revenue  from orders
group by product_id
order by revenue desc
limit 10;

-- find top 5 highest selling products in each region
select region,product_id, total_sales from(select region,product_id, sum(sales_price) as total_sales ,row_number() 
over(partition by region order by sales_price desc) as rnk
from orders group by region,product_id) as rnked
where rnk<=5;

-- find over growth comparison for 2022 and 2023 sales eg: 2022 vs 2023 jan
with cte as (
select year(order_date) as order_year,month(order_date) as order_month,sum(sales_price) as total_sales from 
orders group by year(order_date),month(order_date))
select order_month,
sum(case when order_year=2022 then total_sales else 0 end) as salesof_2022,
sum(case when order_year=2023 then total_sales else 0 end) as salesof_2023
from cte
group by order_month
order by order_month;

-- for each category which month has highest sales
with cte as(
select category,date_format(order_date,'%b-%Y') as order_month,sum(sales_price) as total_sales
from orders
group by category,month(order_date))
select * from (select * , row_number() over(partition by category order by total_sales desc) as rnk
from cte) rn
where rn=1;

-- find which subcategory  has highest growth by profit in 2023 compare to 2022
with cte as(
select sub_category,year(order_date) as order_year,sum(sales_price) as total_sales from orders
group by sub_category,year(order_date)),
cte2 as (select sub_category,
sum(case when order_year=2022 then total_sales else 0 end) as sales_2022,
sum(case when order_year=2023 then total_sales else 0 end) as sales_2023
from cte
group by sub_category
order by total_sales desc
)
select *,((sales_2023-sales_2022)*100/sales_2022) as sales_growth from cte2
order by sales_growth desc
limit 1;
 

