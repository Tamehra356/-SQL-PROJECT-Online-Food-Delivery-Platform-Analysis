EASY LEVEL

1. Which city has the most number of customers?
SELECT city, COUNT(*) AS total_customers
FROM customers
GROUP BY city
ORDER BY total_customers DESC
LIMIT 1;

2. What are the top 5 most ordered dishes?
SELECT d.name, COUNT(*) AS order_count
FROM order_items oi
JOIN dishes d ON oi.dish_id = d.dish_id
GROUP BY d.name
ORDER BY order_count DESC
LIMIT 5;

3. Who is the most frequent customer?
SELECT c.name, COUNT(*) AS order_count
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.name
ORDER BY order_count DESC
LIMIT 1;

 4. What are the top 3 restaurants by number of orders?
SELECT r.name, COUNT(*) AS total_orders
FROM orders o
JOIN restaurants r ON o.restaurant_id = r.restaurant_id
GROUP BY r.name
ORDER BY total_orders DESC
LIMIT 3;

 5. What is the average rating per cuisine?
SELECT cuisine, AVG(rating) AS avg_rating
FROM restaurants
GROUP BY cuisine;


 MODERATE LEVEL

1. Customers who ordered more than 2 times in the same week
SELECT customer_id, DATE_TRUNC('week', order_time) AS order_week, COUNT(*) AS order_count
FROM orders
GROUP BY customer_id, order_week
HAVING COUNT(*) > 2;

 2. Cities with the highest average order value
SELECT c.city, AVG(o.total_amount) AS avg_order_value
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
GROUP BY c.city
ORDER BY avg_order_value DESC;

 3. Dishes priced higher than the average price in their cuisine
SELECT *
FROM dishes d
WHERE d.price > (
    SELECT AVG(price) FROM dishes WHERE cuisine = d.cuisine
);

 4. Restaurant that serves the most expensive dish
SELECT r.name, d.name AS dish_name, d.price
FROM dishes d
JOIN restaurants r ON d.restaurant_id = r.restaurant_id
ORDER BY d.price DESC
LIMIT 1;

 5. Customers who only order vegetarian dishes
SELECT DISTINCT c.name
FROM customers c
WHERE NOT EXISTS (
    SELECT 1
    FROM orders o
    JOIN order_items oi ON o.order_id = oi.order_id
    JOIN dishes d ON oi.dish_id = d.dish_id
    WHERE o.customer_id = c.customer_id AND d.is_veg = FALSE
);


 ADVANCED LEVEL

 1. Most ordered cuisine per customer
SELECT customer_id, cuisine, order_count
FROM (
    SELECT c.customer_id, d.cuisine, COUNT(*) AS order_count,
           RANK() OVER (PARTITION BY c.customer_id ORDER BY COUNT(*) DESC) AS rnk
    FROM customers c
    JOIN orders o ON c.customer_id = o.customer_id
    JOIN order_items oi ON o.order_id = oi.order_id
    JOIN dishes d ON oi.dish_id = d.dish_id
    GROUP BY c.customer_id, d.cuisine
) ranked
WHERE rnk = 1;

 2. Restaurants with highest repeat customer rate
SELECT restaurant_id, COUNT(DISTINCT customer_id) AS repeat_customers
FROM (
    SELECT customer_id, restaurant_id, COUNT(*) AS cnt
    FROM orders
    GROUP BY customer_id, restaurant_id
    HAVING COUNT(*) > 1
) repeats
GROUP BY restaurant_id
ORDER BY repeat_customers DESC;

 3. Top 3 customers by spend in each city
SELECT city, customer_id, total_spent
FROM (
    SELECT c.city, o.customer_id, SUM(o.total_amount) AS total_spent,
           RANK() OVER (PARTITION BY c.city ORDER BY SUM(o.total_amount) DESC) AS rnk
    FROM orders o
    JOIN customers c ON o.customer_id = c.customer_id
    GROUP BY c.city, o.customer_id
) ranked
WHERE rnk <= 3;

 4. Peak ordering hours: weekday vs weekend
SELECT 
    CASE 
        WHEN EXTRACT(DOW FROM order_time) IN (0, 6) THEN 'Weekend'
        ELSE 'Weekday'
    END AS day_type,
    EXTRACT(HOUR FROM order_time) AS hour,
    COUNT(*) AS order_count
FROM orders
GROUP BY day_type, hour
ORDER BY day_type, hour;

 5. Average delivery time per restaurant
SELECT r.name, 
       AVG(EXTRACT(EPOCH FROM delivered_time - order_time)/60) AS avg_delivery_time_mins
FROM orders o
JOIN restaurants r ON o.restaurant_id = r.restaurant_id
GROUP BY r.name
ORDER BY avg_delivery_time_mins ASC;
