-- =========================
-- DATA CLEANING SECTION
-- =========================
SELECT * 
FROM customers
WHERE customer_id IS NULL 
   OR state IS NULL;
   SELECT customer_id, COUNT(*)
   
FROM customers
GROUP BY customer_id
HAVING COUNT(*) > 1;
-- I checked for duplicate customer records and no duplicate found


SELECT seller_id, COUNT(*)
FROM sellers
GROUP BY seller_id
HAVING COUNT(*) > 1;
-- I checked for duplicate records in sellers table and no duplicate found

SELECT order_id, COUNT(*)
FROM orders
GROUP BY order_id
HAVING COUNT(*) > 1;
-- I checked for duplicate records in orders table and no duplicate found

UPDATE customers
SET state = INITCAP(state);
-- I standardized state and city names using INITCAP for consistency

SELECT order_date FROM orders LIMIT 5;
-- I checked order_date format in orders table
-- The dates are already in YYYY-MM-DD format, no changes needed

SELECT * FROM order_items LIMIT 5;

SELECT o.order_id,
       o.total_amount,
       SUM(oi.line_total) AS calculated_total
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY o.order_id
HAVING ABS(o.total_amount - SUM(oi.line_total)) > 10;
-- I validated order totals against line items
-- I found 124 orders where total_amount differs from calculated total by more than ₦10
-- These records were flagged but not removed for further investigation

SELECT *
FROM reviews
WHERE rating < 1 OR rating > 5;
-- I checked for review ratings validity
-- I Found invalid ratings (values outside 1–5 range, e.g., -1, 0, 7)
-- These records were flagged but not removed for further investigation

SELECT * FROM products LIMIT 5;

SELECT *
FROM products
WHERE unit_price < 0;
-- I Checked for negative product prices
-- And no negative unit_price values found

SELECT * FROM order_items LIMIT 5;

SELECT column_name
FROM information_schema.columns
WHERE table_name = 'order_items';
-- I checked for discount values in order_items table
-- No discount column exists in the dataset, so this validation was not applicable

SELECT * FROM customers LIMIT 5;
