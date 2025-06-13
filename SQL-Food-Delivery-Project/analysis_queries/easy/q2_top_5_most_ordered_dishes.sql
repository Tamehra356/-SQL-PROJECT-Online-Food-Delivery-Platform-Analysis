SELECT d.name, COUNT(*) AS order_count
FROM order_items oi
JOIN dishes d ON oi.dish_id = d.dish_id
GROUP BY d.name
ORDER BY order_count DESC
LIMIT 5;