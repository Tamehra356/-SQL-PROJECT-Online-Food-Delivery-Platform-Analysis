CUSTOMERS TABLE
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    name VARCHAR(100),
    city VARCHAR(50),
    registration_date DATE
);

RESTAURANTS TABLE
CREATE TABLE restaurants (
    restaurant_id INT PRIMARY KEY,
    name VARCHAR(100),
    city VARCHAR(50),
    rating DECIMAL(2,1),
    cuisine VARCHAR(50)
);

 DISHES TABLE
CREATE TABLE dishes (
    dish_id INT PRIMARY KEY,
    name VARCHAR(100),
    price DECIMAL(5,2),
    cuisine VARCHAR(50),
    is_veg BOOLEAN,
    restaurant_id INT,
    FOREIGN KEY (restaurant_id) REFERENCES restaurants(restaurant_id)
);

 ORDERS TABLE
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    restaurant_id INT,
    total_amount DECIMAL(6,2),
    order_time TIMESTAMP,
    delivered_time TIMESTAMP,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (restaurant_id) REFERENCES restaurants(restaurant_id)
);

 ORDER_ITEMS TABLE
CREATE TABLE order_items (
    order_item_id SERIAL PRIMARY KEY,
    order_id INT,
    dish_id INT,
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (dish_id) REFERENCES dishes(dish_id)
);

 SAMPLE CUSTOMERS
INSERT INTO customers (customer_id, name, city, registration_date) VALUES
(1, 'Alice Johnson', 'New York', '2023-01-10'),
(2, 'Bob Smith', 'Los Angeles', '2023-02-15'),
(3, 'Carol White', 'Chicago', '2023-03-20'),
(4, 'David Brown', 'New York', '2023-04-01'),
(5, 'Eva Green', 'Houston', '2023-04-12');

SAMPLE RESTAURANTS
INSERT INTO restaurants (restaurant_id, name, city, rating, cuisine) VALUES
(1, 'Pizza Palace', 'New York', 4.5, 'Italian'),
(2, 'Spice Hub', 'Los Angeles', 4.0, 'Indian'),
(3, 'Sushi Zen', 'Chicago', 4.7, 'Japanese'),
(4, 'Burger Town', 'Houston', 3.9, 'American');

SAMPLE DISHES
INSERT INTO dishes (dish_id, name, price, cuisine, is_veg, restaurant_id) VALUES
(1, 'Margherita Pizza', 9.99, 'Italian', TRUE, 1),
(2, 'Paneer Tikka', 11.50, 'Indian', TRUE, 2),
(3, 'Chicken Sushi Roll', 14.75, 'Japanese', FALSE, 3),
(4, 'Veggie Burger', 8.25, 'American', TRUE, 4),
(5, 'Beef Burger', 10.00, 'American', FALSE, 4);

SAMPLE ORDERS
INSERT INTO orders (order_id, customer_id, restaurant_id, total_amount, order_time, delivered_time) VALUES
(101, 1, 1, 19.98, '2024-04-10 12:30:00', '2024-04-10 13:00:00'),
(102, 2, 2, 11.50, '2024-04-11 14:00:00', '2024-04-11 14:40:00'),
(103, 3, 3, 14.75, '2024-04-12 18:15:00', '2024-04-12 18:45:00'),
(104, 1, 4, 18.25, '2024-04-13 20:00:00', '2024-04-13 20:35:00'),
(105, 4, 1, 9.99, '2024-04-14 11:45:00', '2024-04-14 12:15:00');

SAMPLE ORDER ITEMS
INSERT INTO order_items (order_id, dish_id) VALUES
(101, 1), (101, 1),
(102, 2),
(103, 3),
(104, 4), (104, 5),
(105, 1);
