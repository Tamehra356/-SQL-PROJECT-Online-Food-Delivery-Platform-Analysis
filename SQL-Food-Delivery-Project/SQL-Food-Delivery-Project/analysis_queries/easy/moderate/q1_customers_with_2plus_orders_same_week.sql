SELECT customer_id, DATE_TRUNC('week', order_time) AS order_week, COUNT(*) AS order_count
FROM orders
GROUP BY customer_id, order_week
HAVING COUNT(*) > 2;