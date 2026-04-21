-- =========================
-- QUESTION 1
-- Customer Acquisition & 30-Day Conversion
-- =========================

SELECT state, COUNT(*) AS total_customers
FROM customers
WHERE signup_date BETWEEN '2024-01-01' AND '2024-12-31'
GROUP BY state
ORDER BY total_customers DESC
LIMIT 5;

-- Question 1: Top 5 states by new customer sign-ups in 2024
-- Result shows Lagos, FCT, Rivers, Oyo, and Kano as the top states
SELECT c.customer_id,
       c.state,
       c.signup_date,
       o.order_date
FROM customers c
JOIN orders o 
  ON c.customer_id = o.customer_id
WHERE c.signup_date BETWEEN '2024-01-01' AND '2024-12-31'
  AND o.order_date <= c.signup_date + INTERVAL '30 days';

SELECT DISTINCT c.customer_id,
       c.state
FROM customers c
JOIN orders o 
  ON c.customer_id = o.customer_id
WHERE c.signup_date BETWEEN '2024-01-01' AND '2024-12-31'
  AND o.order_date <= c.signup_date + INTERVAL '30 days';

  WITH total_customers AS (
    SELECT state, COUNT(*) AS total
    FROM customers
    WHERE signup_date BETWEEN '2024-01-01' AND '2024-12-31'
    GROUP BY state
),
converted_customers AS (
    SELECT c.state, COUNT(DISTINCT c.customer_id) AS converted
    FROM customers c
    JOIN orders o 
      ON c.customer_id = o.customer_id
    WHERE c.signup_date BETWEEN '2024-01-01' AND '2024-12-31'
      AND o.order_date <= c.signup_date + INTERVAL '30 days'
    GROUP BY c.state
)
SELECT t.state,
       t.total,
       COALESCE(c.converted, 0) AS converted,
       ROUND((COALESCE(c.converted, 0) * 100.0 / t.total), 2) AS conversion_rate
FROM total_customers t
LEFT JOIN converted_customers c
  ON t.state = c.state
ORDER BY conversion_rate DESC
LIMIT 5;

-- Question 1: Customer Acquisition & 30-Day Conversion

-- Top 5 states by new customer sign-ups in 2024 were Lagos, FCT, Rivers, Oyo, and Kano.

-- Lagos recorded the highest conversion rate (49.32%), indicating strong early customer engagement.
-- Kano had the lowest conversion rate (31.03%), suggesting potential issues in onboarding or product-market fit.

-- This analysis highlights differences in customer behavior across regions and can guide targeted growth strategies.
