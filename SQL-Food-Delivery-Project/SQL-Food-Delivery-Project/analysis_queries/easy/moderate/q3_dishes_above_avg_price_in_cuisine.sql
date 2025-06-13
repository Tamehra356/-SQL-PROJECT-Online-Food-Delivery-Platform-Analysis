SELECT *
FROM dishes d
WHERE d.price > (
    SELECT AVG(price)
    FROM dishes
    WHERE cuisine = d.cuisine
);