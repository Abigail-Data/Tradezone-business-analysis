-- Question 2: Top 10 products by total revenue in 2024
SELECT 
    p.product_name,
    p.category,
    SUM(COALESCE(oi.line_total, 0)) AS total_revenue,
    COUNT(DISTINCT oi.order_id) AS total_orders
FROM order_items oi
JOIN orders o 
  ON oi.order_id = o.order_id
JOIN products p 
  ON oi.product_id = p.product_id
WHERE o.order_date BETWEEN '2024-01-01' AND '2024-12-31'
GROUP BY p.product_name, p.category
ORDER BY total_revenue DESC
LIMIT 10;

-- Question 2: Product Performance

-- This identified the top 10 products by total revenue in 2024.
-- Electronics products dominate the top-performing items, with laptops, accessories,
-- and home electronics generating the highest revenue.

-- The HP Pavilion 15 Laptop Intel i5 - v2 generated the highest revenue,
-- indicating strong demand for computing devices.

UPDATE products
SET category = INITCAP(category);

SELECT * FROM orders LIMIT 5;

--This calculates the delivery time
SELECT seller_id,
       order_date,
       delivery_date,
       (delivery_date - order_date) AS delivery_days
FROM orders
WHERE order_status = 'Delivered';

--This converts days to hours
SELECT seller_id,
       (delivery_date - order_date) * 24 AS delivery_hours
FROM orders
WHERE order_status = 'Delivered';

