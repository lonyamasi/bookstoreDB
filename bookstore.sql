-- Creating a database
CREATE DATABASE bookstoreDB;
USE bookstoreDB;

-- Creating tables

-- Address Table
CREATE TABLE Address (
    address_id INT PRIMARY KEY,
    street VARCHAR(255) NOT NULL,
    city VARCHAR(255),
    state VARCHAR(255),
    country_id INT,
    postal_code VARCHAR(20),
    status_id INT,
    FOREIGN KEY (country_id) REFERENCES Country(country_id),
    FOREIGN KEY (status_id) REFERENCES Address_Status(status_id)
    );

-- Country Table
CREATE TABLE Country (
    country_id INT PRIMARY KEY,
    country_name VARCHAR(255) NOT NULL
    );

-- Cust_Order Table
CREATE TABLE Cust_Order (
    order_id INT PRIMARY KEY,
    customer_id INT,
    shipping_method_id INT,
    orderstatus_id INT,
    order_date DATE,
    shipping_address INT,
    FOREIGN KEY (customer_id) REFERENCES Customer(customer_id),
    FOREIGN KEY (shipping_method_id) REFERENCES Shipping_Method(shipping_method_id),
    FOREIGN KEY (orderstatus_id) REFERENCES Order_Status(orderstatus_id),
    FOREIGN KEY (shipping_address) REFERENCES Address(address_id)
);

-- Order_Line Table
CREATE TABLE Order_Line (
    order_id INT,
    book_id INT,
    quantity INT NOT NULL,
    FOREIGN KEY (order_id) REFERENCES Cust_Order(order_id),
    FOREIGN KEY (book_id) REFERENCES Book(book_id)
);

-- Shipping_Method Table
CREATE TABLE Shipping_Method (
    shipping_method_id INT PRIMARY KEY,
    method_name VARCHAR(255) NOT NULL
);

-- Order_History Table
CREATE TABLE Order_History (
    history_id INT PRIMARY KEY,
    order_id INT,
    status_id INT,
    change_date DATE NOT NULL,
    FOREIGN KEY (order_id) REFERENCES Cust_Order(order_id),
    FOREIGN KEY (status_id) REFERENCES Order_Status(orderstatus_id)
);

-- Order_Status Table
CREATE TABLE Order_Status (
    orderstatus_id INT PRIMARY KEY,
    status_name VARCHAR(255) NOT NULL
);