-- Question 8: Top Seller Bonus Qualification

SELECT 
    s.seller_id,
    COUNT(DISTINCT o.order_id) AS total_orders,
    ROUND(AVG(r.rating), 2) AS avg_rating,
    SUM(oi.line_total) AS total_revenue
FROM sellers s
JOIN orders o 
  ON s.seller_id = o.seller_id
JOIN order_items oi 
  ON o.order_id = oi.order_id
LEFT JOIN reviews r 
  ON o.order_id = r.order_id
WHERE 
    o.order_status = 'Delivered'
    AND o.order_date BETWEEN '2024-01-01' AND '2024-12-31'
GROUP BY s.seller_id
HAVING 
    COUNT(DISTINCT o.order_id) >= 10
    AND AVG(r.rating) >= 4.0
ORDER BY total_revenue DESC
LIMIT 10;

-- This query identifies the top 10 sellers in 2024 who qualify for performance bonuses.

-- Criteria:
-- - Sellers must have completed at least 10 orders
-- - Sellers must have an average rating of 4.0 or higher
-- - Only delivered orders in 2024 are considered

-- The query returns:
-- - Seller ID
-- - Total number of completed orders
-- - Average customer rating
-- - Total revenue generated

-- Results are sorted by total revenue in descending order
-- to highlight the highest-performing sellers.
