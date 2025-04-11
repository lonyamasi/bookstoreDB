


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








