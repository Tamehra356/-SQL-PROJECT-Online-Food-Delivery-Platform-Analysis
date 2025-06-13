SELECT DISTINCT c.name
FROM customers c
WHERE NOT EXISTS (
    SELECT 1
    FROM orders o
    JOIN order_items oi ON o.order_id = oi.order_id
    JOIN dishes d ON oi.dish_id = d.dish_id
    WHERE o.customer_id = c.customer_id AND d.is_veg = FALSE
);