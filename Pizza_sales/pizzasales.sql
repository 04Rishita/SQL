SELECT * FROM practice.order_details;

-- Retrive the total number of orders placed
SELECT 
    COUNT(order_id) AS total_orders
FROM
    orderss;

-- Calculate the total revenue generated from pizza sales.
SELECT 
    ROUND(SUM(order_details.quantity * pizzas.price),
            2) AS total_sales
FROM
    order_details
        JOIN
    pizzas ON order_details.pizza_id = pizzas.pizza_id;

-- Identify the highest-priced pizza.
SELECT 
    pizza_types.name, pizzas.price
FROM
    pizza_types
        JOIN
    pizzas ON pizzas.pizza_type_id = pizza_types.pizza_type_id
ORDER BY pizzas.price DESC
LIMIT 1;

-- Identify the most common pizza size ordered.
SELECT 
    pizzas.size,
    COUNT(order_details.order_details_id) AS common_size
FROM
    pizzas
        JOIN
    order_details ON pizzas.pizza_id = order_details.pizza_id
GROUP BY pizzas.size;

-- List the top 5 most ordered pizza types along with their quantities.
SELECT 
    pizza_types.name AS pizza_type,
    SUM(order_details.quantity) AS total_ordered
FROM
    order_details
        JOIN
    pizzas ON order_details.pizza_id = pizzas.pizza_id
        JOIN
    pizza_types ON pizzas.pizza_type_id = pizza_types.pizza_type_id
GROUP BY pizza_types.name
ORDER BY total_ordered DESC
LIMIT 5;

-- Join the necessary tables to find the total quantity of each pizza category ordered.
SELECT 
    pizza_types.category,
    SUM(order_details.quantity) AS total_quantity
FROM
    pizzas
        JOIN
    order_details ON order_details.pizza_id = pizzas.pizza_id
        JOIN
    pizza_types ON pizzas.pizza_type_id = pizza_types.pizza_type_id
GROUP BY pizza_types.category
ORDER BY total_quantity DESC;

-- Determine the distribution of orders by hour of the day.
SELECT 
    COUNT(order_id) AS counts,
    HOUR(order_time) AS hours,
    DAY(order_date) AS days
FROM
    orderss
GROUP BY HOUR(order_time) , DAY(order_date)
ORDER BY counts;

-- Join relevant tables to find the category-wise distribution of pizzas.
select count(pizza_type_id) as pizzas,category from pizza_types
group by category
order by pizzas;

-- Group the orders by date and calculate the average number of pizzas ordered per day.
SELECT 
    AVG(order_details.quantity) AS pizza_ordered_per_day
FROM
    (SELECT 
        orderss.order_date,
            SUM(order_details.quantity) AS total_pizzas
    FROM
        orderss
    JOIN order_details ON orderss.order_id = order_details.order_id
    GROUP BY orderss.order_date) AS order_quantity;

-- Determine the top 3 most ordered pizza types based on revenue.
SELECT 
    pizza_types.name,
    ROUND(SUM(order_details.quantity * pizzas.price),
            2) AS revenue
FROM
    order_details
        JOIN
    pizzas ON order_details.pizza_id = pizzas.pizza_id
        JOIN
    pizza_types ON pizza_types.pizza_type_id = pizzas.pizza_type_id
GROUP BY pizza_types.name
ORDER BY revenue DESC
LIMIT 3;

-- Calculate the percentage contribution of each pizza type to total revenue.
 SELECT 
    pizza_types.category,
    ROUND(SUM(order_details.quantity * pizzas.price),
            2) AS revenue
FROM
    pizza_types
        JOIN
    pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
        JOIN
    order_details ON order_details.pizza_id = pizzas.pizza_id
GROUP BY pizza_types.category
ORDER BY revenue;

-- Analyze the cumulative revenue generated over time.
select order_date,revenue,sum(revenue)over(order by order_date) 
as cum_revenue from 
(select orderss.order_date,
round(sum(order_details.quantity * pizzas.price),2)
as revenue
from order_details join pizzas 
on order_details.pizza_id=pizzas.pizza_id
join orderss on orderss.order_id=order_details.order_id
group by orderss.order_date) as sales;

-- Determine the top 3 most ordered pizza types based on revenue for each pizza category.
select category,name,
revenue from(
select pizza_types.category,pizza_types.name,
sum(order_details.quantity * pizzas.price)as revenue,
rank() over(partition by pizza_types.category 
order by sum(order_details.quantity * pizzas.price)desc) 
as rnks
from order_details join pizzas on 
order_details.pizza_id=pizzas.pizza_id 
join pizza_types on 
pizza_types.pizza_type_id=pizzas.pizza_type_id
group by pizza_types.category,pizza_types.name) 
as ranked
where rnks<=3;


