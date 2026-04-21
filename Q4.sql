-- Question 4: Quarterly Revenue Trends
SELECT 
    EXTRACT(YEAR FROM order_date) AS year,
    EXTRACT(QUARTER FROM order_date) AS quarter,
    SUM(total_amount) AS total_revenue,
    AVG(total_amount) AS avg_order_value,
    COUNT(order_id) AS total_orders
FROM orders
WHERE order_status = 'Delivered'
GROUP BY 
    EXTRACT(YEAR FROM order_date),
    EXTRACT(QUARTER FROM order_date)
ORDER BY year, quarter;


-- I analyzed quarterly revenue, average order value, and order volume for 2023 and 2024.

-- Revenue shows strong upward growth across quarters, with a significant increase in 2024.

-- The highest growth occurred in Q2, where revenue increased substantially compared to Q2 2023.

-- This indicates accelerated platform growth and increased transaction volume in 2024.
