use ecommerce_analytics;

select count(*) as total_orders from orders;

select status,count(*) as total_orders from orders group by status order by total_orders desc;

select
 customer_id,
 count(order_id) as 
 total_orders
 from orders
 group by customer_id
 having count(order_id)>1
 order by total_orders desc;

select
	customer_id,
    count(order_id) as
total_orders
from orders
group by customer_id 
having count(order_id) >=5
order by total_orders Desc;

select o.customer_id,sum(oi.line_total) as total_revenue from orders o join order_items oi
on o.order_id = oi.order_id
group by o.customer_id
order by total_revenue desc
limit 10;

with customer_revenue as(select o.customer_id,sum(oi.line_total) as total_revenue from orders o join order_items
oi on o.order_id = oi.order_id
group by o.customer_id)

select * from customer_revenue order by total_revenue desc limit 10;

SELECT
    oi.product_id,
    SUM(oi.line_total) AS total_revenue,
    RANK() OVER (
        ORDER BY SUM(oi.line_total) DESC
    ) AS revenue_rank
FROM order_items oi
GROUP BY oi.product_id
ORDER BY revenue_rank
LIMIT 10;

WITH monthly_revenue AS (
    SELECT
        DATE_FORMAT(o.order_date, '%Y-%m') AS month,
        SUM(oi.line_total) AS revenue
    FROM orders o
    JOIN order_items oi
        ON o.order_id = oi.order_id
    GROUP BY DATE_FORMAT(o.order_date, '%Y-%m')
)

SELECT *
FROM monthly_revenue
ORDER BY month;

WITH monthly_revenue AS (
    SELECT
        DATE_FORMAT(o.order_date, '%Y-%m') AS month,
        SUM(oi.line_total) AS revenue
    FROM orders o
    JOIN order_items oi
        ON o.order_id = oi.order_id
    GROUP BY DATE_FORMAT(o.order_date, '%Y-%m')
)
SELECT *
FROM monthly_revenue
ORDER BY month;

SELECT
    o.customer_id,
    SUM(oi.line_total) AS total_revenue,
    DENSE_RANK() OVER (
        ORDER BY SUM(oi.line_total) DESC
    ) AS revenue_rank
FROM orders o
JOIN order_items oi
    ON o.order_id = oi.order_id
GROUP BY o.customer_id
ORDER BY revenue_rank
LIMIT 10;