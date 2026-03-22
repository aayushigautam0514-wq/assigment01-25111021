-- Q1:
SELECT customer_id, SUM(total_amount) AS total_value
FROM orders_flat
WHERE customer_city = 'Mumbai'
GROUP BY customer_name;

-- Q2:
SELECT product_id, SUM(quantity) AS total_sold
FROM orders
GROUP BY product_id
ORDER BY total_quantity_sold DESC
LIMIT 3;

-- Q3
SELECT 
    sales_rep_name,
    COUNT(DISTINCT customer_id) AS unique_customers
FROM orders_flat
GROUP BY sales_rep_name;

-- Q4
SELECT 
    order_id,
    SUM(unit_price * quantity) AS total_value
FROM orders_flat
GROUP BY order_id
HAVING total_value > 10000
ORDER BY total_value DESC;

-- Q5
SELECT DISTINCT product_name
FROM orders_flat
WHERE product_name NOT IN (
    SELECT DISTINCT product_name FROM orders_flat
);

