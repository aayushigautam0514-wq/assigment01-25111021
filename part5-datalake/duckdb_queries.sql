--Q1
SELECT
    c.customer_id,
    c.name                    AS customer_name,
    c.city,
    COUNT(o.order_id)         AS total_orders_placed
FROM read_csv_auto('datasets/customers.csv') AS c
LEFT JOIN read_json_auto('datasets/orders.json') AS o
    ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.name, c.city
ORDER BY total_orders_placed DESC;

--Q2
SELECT
    c.customer_id,
    c.name                        AS customer_name,
    c.city,
    SUM(o.total_amount)           AS total_order_value,
    COUNT(o.order_id)             AS number_of_orders
FROM read_csv_auto('datasets/customers.csv') AS c
JOIN read_json_auto('datasets/orders.json') AS o
    ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.name, c.city
ORDER BY total_order_value DESC
LIMIT 3;

--Q3
SELECT DISTINCT
    p.product_id,
    p.product_name,
    p.category,
    p.unit_price,
    c.name   AS customer_name,
    c.city   AS customer_city
FROM read_csv_auto('datasets/customers.csv')  AS c
JOIN read_json_auto('datasets/orders.json')   AS o  ON c.customer_id = o.customer_id
JOIN read_parquet('datasets/products.parquet') AS p  ON p.product_id  = o.product_id
WHERE c.city = 'Bangalore'
ORDER BY p.product_name;

--Q4
ELECT
    c.name          AS customer_name,
    c.city          AS customer_city,
    o.order_date,
    o.order_id,
    p.product_name,
    p.category,
    o.num_items     AS quantity,
    o.total_amount
FROM read_csv_auto('datasets/customers.csv')   AS c
JOIN read_json_auto('datasets/orders.json')    AS o  ON c.customer_id = o.customer_id
JOIN read_parquet('datasets/products.parquet') AS p  ON p.product_id  = o.product_id
ORDER BY o.order_date DESC
LIMIT 50;
