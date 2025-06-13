SELECT r.name, COUNT(*) AS total_orders
FROM orders o
JOIN restaurants r ON o.restaurant_id = r.restaurant_id
GROUP BY r.name
ORDER BY total_orders DESC
LIMIT 3;