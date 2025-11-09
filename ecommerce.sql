CREATE DATABASE ecommerce;
USE ecommerce;

-- Customers table
CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    city VARCHAR(50),
    country VARCHAR(50)
);

-- Products table
CREATE TABLE Products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(50),
    price DECIMAL(10,2)
);

-- Orders table
CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

-- Payments table
CREATE TABLE Payments (
    payment_id INT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    total_amount DECIMAL(10,2),
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);



-- Insert into Customers
INSERT INTO Customers (customer_id, customer_name, city, country)
VALUES
(1, 'Aarav Mehta', 'Mumbai', 'India'),
(2, 'Sneha Reddy', 'Hyderabad', 'India'),
(3, 'John Smith', 'New York', 'USA'),
(4, 'Emma Brown', 'London', 'UK'),
(5, 'Ravi Kumar', 'Chennai', 'India'),
(6, 'Sophia Taylor', 'Sydney', 'Australia'),
(7, 'Liam Johnson', 'Toronto', 'Canada'),
(8, 'Priya Singh', 'Delhi', 'India');

-- Insert into Products
INSERT INTO Products (product_id, product_name, category, price)
VALUES
(101, 'Laptop', 'Electronics', 65000.00),
(102, 'Smartphone', 'Electronics', 25000.00),
(103, 'Headphones', 'Accessories', 3000.00),
(104, 'Office Chair', 'Furniture', 8000.00),
(105, 'Keyboard', 'Accessories', 1500.00),
(106, 'LED Monitor', 'Electronics', 12000.00),
(107, 'Running Shoes', 'Fashion', 4500.00),
(108, 'Wrist Watch', 'Fashion', 5000.00);

-- Insert into Orders
INSERT INTO Orders (order_id, customer_id, order_date)
VALUES
(201, 1, '2025-01-15'),
(202, 2, '2025-02-10'),
(203, 3, '2025-03-05'),
(204, 1, '2025-03-20'),
(205, 4, '2025-04-02'),
(206, 5, '2025-04-15'),
(207, 6, '2025-05-05'),
(208, 2, '2025-06-01'),
(209, 7, '2025-07-18'),
(210, 8, '2025-08-12');

-- Insert into Payments
INSERT INTO Payments (payment_id, order_id, product_id, quantity, total_amount)
VALUES
(301, 201, 101, 1, 65000.00),
(302, 201, 103, 2, 6000.00),
(303, 202, 102, 1, 25000.00),
(304, 202, 105, 2, 3000.00),
(305, 203, 106, 1, 12000.00),
(306, 204, 107, 2, 9000.00),
(307, 205, 104, 1, 8000.00),
(308, 205, 108, 1, 5000.00),
(309, 206, 103, 3, 9000.00),
(310, 207, 102, 2, 50000.00),
(311, 208, 101, 1, 65000.00),
(312, 209, 108, 1, 5000.00),
(313, 210, 104, 2, 16000.00),
(314, 210, 107, 1, 4500.00);


SELECT 
    c.customer_name,
    SUM(p.total_amount) AS total_spent
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id
JOIN Payments p ON o.order_id = p.order_id
GROUP BY c.customer_name
ORDER BY total_spent DESC
LIMIT 5;


SELECT 
    pr.product_name,
    SUM(p.quantity) AS total_sold
FROM Products pr
JOIN Payments p ON pr.product_id = p.product_id
GROUP BY pr.product_name
ORDER BY total_sold DESC
LIMIT 5;


SELECT 
    DATE_FORMAT(o.order_date, '%Y-%m') AS month,
    SUM(p.total_amount) AS total_sales
FROM Orders o
JOIN Payments p ON o.order_id = p.order_id
GROUP BY month
ORDER BY month;