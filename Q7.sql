-- Question 7: Review Ratings and Sales Performance

WITH product_ratings AS (
    SELECT 
        p.product_id,
        AVG(r.rating) AS avg_rating,
        SUM(oi.line_total) AS total_revenue,
        AVG(oi.unit_price) AS avg_unit_price
    FROM products p
    JOIN order_items oi 
      ON p.product_id = oi.product_id
    JOIN orders o 
      ON oi.order_id = o.order_id
    LEFT JOIN reviews r 
      ON o.order_id = r.order_id
    WHERE o.order_status = 'Delivered'
      AND o.order_date BETWEEN '2024-01-01' AND '2024-12-31'
    GROUP BY p.product_id
)

SELECT 
    CASE 
        WHEN avg_rating >= 4 THEN 'High Rated'
        WHEN avg_rating BETWEEN 3 AND 3.99 THEN 'Mid Rated'
        ELSE 'Low Rated'
    END AS rating_category,

    COUNT(*) AS product_count,
    SUM(total_revenue) AS total_revenue,
    AVG(avg_unit_price) AS avg_unit_price

FROM product_ratings
GROUP BY rating_category;

-- This query groups products into rating categories:
-- High Rated (≥ 4.0), Mid Rated (3.0 – 3.99), and Low Rated (< 3.0)

-- It calculates:
-- - Number of products in each category
-- - Total revenue generated
-- - Average unit price

-- This helps evaluate how product ratings influence sales performance
-- and whether higher-rated products generate more revenue.
