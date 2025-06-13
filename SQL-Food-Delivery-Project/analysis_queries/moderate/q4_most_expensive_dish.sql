SELECT r.name, d.name AS dish_name, d.price
FROM dishes d
JOIN restaurants r ON d.restaurant_id = r.restaurant_id
ORDER BY d.price DESC
LIMIT 1;