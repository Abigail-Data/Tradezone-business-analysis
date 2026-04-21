-- Question 5: Customer Spend Segmentation

WITH customer_spend AS (
    SELECT 
        c.customer_id,
        SUM(o.total_amount) AS total_spent
    FROM customers c
    JOIN orders o 
      ON c.customer_id = o.customer_id
    WHERE o.order_status = 'Delivered'
      AND o.order_date BETWEEN '2024-01-01' AND '2024-12-31'
    GROUP BY c.customer_id
),
segmented_customers AS (
    SELECT 
        customer_id,
        total_spent,
        CASE 
            WHEN total_spent >= 100000 THEN 'High Spenders'
            WHEN total_spent >= 50000 AND total_spent < 100000 THEN 'Medium Spenders'
            ELSE 'Low Spenders'
        END AS segment
    FROM customer_spend
)
SELECT 
    segment,
    COUNT(customer_id) AS customer_count,
    ROUND(AVG(total_spent), 2) AS avg_spend,
    ROUND(SUM(total_spent), 2) AS total_revenue
FROM segmented_customers
GROUP BY segment
ORDER BY total_revenue DESC;