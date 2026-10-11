-- ============================================================
-- E-commerce Sales Analytics
-- Database setup, sample data, and analysis queries
-- MySQL
-- ============================================================

CREATE DATABASE IF NOT EXISTS ecommerce;
USE ecommerce;

-- Drop tables in child-to-parent order so this script can be rerun.
DROP TABLE IF EXISTS Orders;
DROP TABLE IF EXISTS Products;
DROP TABLE IF EXISTS Customers;

-- 1. Create tables
CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL,
    city VARCHAR(50)
);

CREATE TABLE Products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    category VARCHAR(50),
    price DECIMAL(10,2) NOT NULL
);

CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    customer_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    order_date DATE NOT NULL,
    CONSTRAINT fk_orders_customer
        FOREIGN KEY (customer_id) REFERENCES Customers(customer_id),
    CONSTRAINT fk_orders_product
        FOREIGN KEY (product_id) REFERENCES Products(product_id),
    CONSTRAINT chk_orders_quantity CHECK (quantity > 0)
);

-- 2. Insert sample customers
INSERT INTO Customers (customer_id, customer_name, city) VALUES
(1, 'Ravi', 'Chennai'),
(2, 'Priya', 'Bengaluru'),
(3, 'Arun', 'Hyderabad'),
(4, 'Sneha', 'Chennai'),
(5, 'Kiran', 'Mumbai'),
(6, 'Meena', 'Bengaluru');

-- 3. Insert sample products
INSERT INTO Products (product_id, product_name, category, price) VALUES
(101, 'Laptop', 'Electronics', 55000.00),
(102, 'Mouse', 'Accessories', 500.00),
(103, 'Keyboard', 'Accessories', 1200.00),
(104, 'Monitor', 'Electronics', 12000.00),
(105, 'Headphones', 'Accessories', 2500.00),
(106, 'Phone', 'Electronics', 25000.00);

-- 4. Insert sample orders
INSERT INTO Orders (order_id, customer_id, product_id, quantity, order_date) VALUES
(1001, 1, 101, 1, '2026-01-05'),
(1002, 2, 102, 2, '2026-01-12'),
(1003, 1, 104, 1, '2026-02-03'),
(1004, 3, 103, 2, '2026-02-15'),
(1005, 4, 106, 1, '2026-03-02'),
(1006, 2, 105, 2, '2026-03-18'),
(1007, 1, 102, 3, '2026-04-04'),
(1008, 5, 101, 1, '2026-04-20'),
(1009, 3, 104, 2, '2026-05-10'),
(1010, 6, 103, 3, '2026-05-22'),
(1011, 4, 105, 1, '2026-06-08'),
(1012, 2, 106, 1, '2026-06-25'),
(1013, 1, 103, 2, '2026-07-03'),
(1014, 5, 102, 4, '2026-07-15'),
(1015, 6, 104, 1, '2026-08-11');

-- ============================================================
-- 5. Overall KPIs: order count, units sold, and revenue
-- Expected: 15 orders, 27 units, 228400.00 revenue
-- ============================================================
SELECT
    COUNT(DISTINCT o.order_id) AS total_orders,
    SUM(o.quantity) AS total_units_sold,
    SUM(p.price * o.quantity) AS total_revenue
FROM Orders AS o
JOIN Products AS p
    ON o.product_id = p.product_id;

-- 6. Top 3 products by revenue
SELECT
    p.product_id,
    p.product_name,
    SUM(o.quantity) AS total_quantity_sold,
    SUM(p.price * o.quantity) AS total_revenue
FROM Products AS p
JOIN Orders AS o
    ON p.product_id = o.product_id
GROUP BY p.product_id, p.product_name
ORDER BY total_revenue DESC
LIMIT 3;

-- 7. Customer spending and order count
SELECT
    c.customer_id,
    c.customer_name,
    COUNT(DISTINCT o.order_id) AS total_orders,
    SUM(p.price * o.quantity) AS total_spent
FROM Customers AS c
JOIN Orders AS o
    ON c.customer_id = o.customer_id
JOIN Products AS p
    ON o.product_id = p.product_id
GROUP BY c.customer_id, c.customer_name
ORDER BY total_spent DESC;

-- 8. Revenue by city
SELECT
    c.city,
    SUM(p.price * o.quantity) AS total_revenue
FROM Customers AS c
JOIN Orders AS o
    ON c.customer_id = o.customer_id
JOIN Products AS p
    ON o.product_id = p.product_id
GROUP BY c.city
ORDER BY total_revenue DESC;

-- 9. Revenue and units sold by product category
SELECT
    p.category,
    SUM(o.quantity) AS total_quantity_sold,
    SUM(p.price * o.quantity) AS total_revenue
FROM Products AS p
JOIN Orders AS o
    ON p.product_id = o.product_id
GROUP BY p.category
ORDER BY total_revenue DESC;

-- 10. Monthly revenue
SELECT
    DATE_FORMAT(o.order_date, '%Y-%m') AS sales_month,
    SUM(p.price * o.quantity) AS monthly_revenue
FROM Orders AS o
JOIN Products AS p
    ON o.product_id = p.product_id
GROUP BY DATE_FORMAT(o.order_date, '%Y-%m')
ORDER BY sales_month;

-- 11. Customers who have never placed an order
SELECT
    c.customer_id,
    c.customer_name
FROM Customers AS c
LEFT JOIN Orders AS o
    ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL;

-- 12. Products that have never been ordered
SELECT
    p.product_id,
    p.product_name
FROM Products AS p
LEFT JOIN Orders AS o
    ON p.product_id = o.product_id
WHERE o.order_id IS NULL;

-- 13. Revenue per order (useful for further analysis)
SELECT
    o.order_id,
    o.order_date,
    c.customer_name,
    p.product_name,
    o.quantity,
    p.price,
    (p.price * o.quantity) AS order_line_revenue
FROM Orders AS o
JOIN Customers AS c
    ON o.customer_id = c.customer_id
JOIN Products AS p
    ON o.product_id = p.product_id
ORDER BY o.order_date, o.order_id;
