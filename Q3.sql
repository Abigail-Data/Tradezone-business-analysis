--Question 3: Seller Fulfilment Efficiency

WITH delivery_times AS (
    SELECT 
        o.seller_id,
        (o.delivery_date - o.order_date) * 24 AS delivery_hours
    FROM orders o
    WHERE o.order_status = 'Delivered'
),
seller_ratings AS (
    SELECT 
        o.seller_id,
        AVG(r.rating) AS avg_rating
    FROM orders o
    JOIN reviews r 
      ON o.order_id = r.order_id
    WHERE o.order_status = 'Delivered'
    GROUP BY o.seller_id
)
SELECT 
    d.seller_id,
    COUNT(*) AS total_orders,
    ROUND(AVG(d.delivery_hours), 2) AS avg_delivery_hours,
    ROUND(sr.avg_rating, 2) AS avg_rating
FROM delivery_times d
LEFT JOIN seller_ratings sr 
  ON d.seller_id = sr.seller_id
GROUP BY d.seller_id, sr.avg_rating
HAVING COUNT(*) >= 20
ORDER BY avg_delivery_hours ASC
LIMIT 20;

-- This identified the top 20 fastest sellers based on average delivery time (in hours),
-- considering only sellers with at least 20 completed orders.

-- Results show variation between delivery speed and customer satisfaction,
-- indicating that faster delivery does not always guarantee higher ratings.