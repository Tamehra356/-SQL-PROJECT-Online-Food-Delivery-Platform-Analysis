SELECT c.name, COUNT(*) AS order_count
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.name
ORDER BY order_count DESC
LIMIT 1;