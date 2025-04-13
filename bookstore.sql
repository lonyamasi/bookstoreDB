


-- Creating a database
CREATE DATABASE bookstoreDB;
USE bookstoreDB;

-- Creating tables

-- Country Table
CREATE TABLE country (
    country_id INT PRIMARY KEY,
    country_name VARCHAR(255) NOT NULL
    );



	
--customer table
CREATE TABLE customer(
	customer_id INT PRIMARY KEY,
	customer_name VARCHAR(255) NOT NULL,
	email VARCHAR(255),
	phone_no VARCHAR(255)
);


-- Order_Status Table
CREATE TABLE order_status (
    orderstatus_id INT PRIMARY KEY,
    status_name VARCHAR(255) NOT NULL
);



-- Shipping_Method Table
CREATE TABLE shipping_method (
    shipping_method_id INT PRIMARY KEY,
    method_name VARCHAR(255) NOT NULL
);

-- author table

CREATE TABLE author(
author_id INT PRIMARY KEY,
author_name VARCHAR(255) NOT NULL,
bio TEXT
);



-- book_language table

CREATE TABLE book_language(
language_id INT PRIMARY KEY,
languageName VARCHAR(255)
);

--publisher table

CREATE TABLE publisher(
publisher_id INT PRIMARY KEY,
publisherName VARCHAR(255)
);



--address status table

CREATE TABLE address_status(
status_id INT PRIMARY KEY,
status_name VARCHAR(255) NOT NULL
);



-- book table

CREATE TABLE book(
book_id INT PRIMARY KEY,
title VARCHAR(255) NOT NULL,
publisher_id INT, 
language_id  INT, 
publishedDate DATE,
price DECIMAL(10,2),
ISBN VARCHAR(20),
stock_quantity INT,
FOREIGN KEY (publisher_id) REFERENCES publisher(publisher_id),
FOREIGN KEY (language_id) REFERENCES book_language(language_id)
);


-- Address Table
CREATE TABLE address (
    address_id INT PRIMARY KEY,
    street VARCHAR(255) NOT NULL,
    city VARCHAR(255),
    state VARCHAR(255),
    country_id INT,
    postal_code VARCHAR(20),
    status_id INT,
    FOREIGN KEY (country_id) REFERENCES country(country_id),
    FOREIGN KEY (status_id) REFERENCES address_status(status_id)
    );



-- customer address table

CREATE TABLE customer_address(
customer_id INT,
address_id INT,
FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
FOREIGN KEY (address_id) REFERENCES  address(address_id)
);



-- Cust_Order Table

CREATE TABLE cust_order (
    order_id INT PRIMARY KEY,
    customer_id INT,
    shipping_method_id INT,
    orderstatus_id INT,
    order_date DATE,
    shipping_address INT,
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
    FOREIGN KEY (shipping_method_id) REFERENCES shipping_method(shipping_method_id),
    FOREIGN KEY (orderstatus_id) REFERENCES order_status(orderstatus_id),
    FOREIGN KEY (shipping_address) REFERENCES address(address_id)
);



-- Order_Line Table
CREATE TABLE order_Line (
    order_id INT,
    book_id INT,
    quantity INT NOT NULL,
    FOREIGN KEY (order_id) REFERENCES cust_order(order_id),
    FOREIGN KEY (book_id) REFERENCES book(book_id)
);




-- Order_History Table
CREATE TABLE order_history (
    history_id INT PRIMARY KEY,
    order_id INT,
    status_id INT,
    change_date DATE NOT NULL,
    FOREIGN KEY (order_id) REFERENCES cust_order(order_id),
    FOREIGN KEY (status_id) REFERENCES order_status(orderstatus_id)
);



--book author table

CREATE TABLE book_author(
book_id INT,
author_id INT,
FOREIGN KEY (book_id) REFERENCES book(book_id),
FOREIGN KEY (author_id) REFERENCES author(author_id)
);




--Creating Roles and assignments
-----CREATE ROLES  

CREATE ROLE bookstore_admin;
CREATE ROLE inventory_manager;
CREATE ROLE sales;
CREATE ROLE auditor;

--- inmysql
-- CREATE ROLE 'bookstore_admin', 'inventory_manager', 'sales_staff', 'auditor';

---------CREATE USERS 
CREATE USER lucy WITH PASSWORD '1234';
CREATE USER crystal WITH PASSWORD '1234';
CREATE USER lynda WITH PASSWORD '1234';
CREATE USER david WITH PASSWORD '1234';
CREATE USER zablon WITH PASSWORD '1234';

-- -- Create users in MySQL with host specification
-- CREATE USER 'lucy'@'localhost' IDENTIFIED BY '1234';
-- CREATE USER 'crystal'@'localhost' IDENTIFIED BY '1234';
-- CREATE USER 'lynda'@'localhost' IDENTIFIED BY '1234';
-- CREATE USER 'david'@'localhost' IDENTIFIED BY '1234';
-- CREATE USER 'zablon'@'localhost' IDENTIFIED BY '1234';




---- ACCESS PRIVILEDGES --USING POSTGRESQL SYNTAX
--- bookstore_admin
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO bookstore_admin;

 ------- In mysql
-- GRANT ALL PRIVILEGES ON bookstoreDB.* TO 'bookstore_admin'@'localhost';




---- inventory manager
-- Core inventory tables
GRANT SELECT, INSERT, UPDATE ON book TO inventory_manager;
GRANT SELECT, INSERT, UPDATE ON author TO inventory_manager;
GRANT SELECT, INSERT, UPDATE ON book_author TO inventory_manager;
GRANT SELECT, INSERT, UPDATE ON publisher TO inventory_manager;
GRANT SELECT, INSERT, UPDATE ON book_language TO inventory_manager;

-- Related reference tables
GRANT SELECT ON country TO inventory_manager;
GRANT SELECT ON shipping_method TO inventory_manager;
GRANT SELECT ON order_status TO inventory_manager;

-- Order visibility for restocking purposes
GRANT SELECT ON cust_order TO inventory_manager;
GRANT SELECT ON order_line TO inventory_manager;


-- sales staff
-- Customer management
GRANT SELECT, INSERT, UPDATE ON customer TO sales;
GRANT SELECT, INSERT, UPDATE ON address TO sales;
GRANT SELECT, INSERT, UPDATE ON customer_address TO sales;
GRANT SELECT ON address_status TO sales;
GRANT SELECT ON country TO sales;

-- Order processing
GRANT SELECT, INSERT, UPDATE ON cust_order TO sales;
GRANT SELECT, INSERT, UPDATE ON order_line TO sales;
GRANT SELECT ON order_status TO sales;
GRANT SELECT ON shipping_method TO sales;

-- Book catalog access
GRANT SELECT ON book TO sales;
GRANT SELECT ON author TO sales;
GRANT SELECT ON book_author TO sales;
GRANT SELECT ON publisher TO sales;
GRANT SELECT ON book_language TO sales;


---client auditor

GRANT SELECT ON ALL TABLES IN SCHEMA public TO auditor;
-- in mySQL
-- GRANT SELECT ON `bookstore`.* TO 'auditor'@'localhost';


-- Assign users to their roles
GRANT bookstore_admin TO lucy;
GRANT inventory_manager TO crystal;
GRANT sales TO david;
GRANT sales TO lynda;
GRANT auditor TO zablon;

-- Assign roles to users (MySQL 8.0+)
-- GRANT 'bookstore_admin' TO 'lucy'@'localhost';
-- GRANT 'inventory_manager' TO 'crystal'@'localhost';
-- GRANT 'sales' TO 'david'@'localhost';
-- GRANT 'sales' TO 'lynda'@'localhost';
-- GRANT 'auditor' TO 'zablon'@'localhost';






