SELECT cuisine, AVG(rating) AS avg_rating
FROM restaurants
GROUP BY cuisine;