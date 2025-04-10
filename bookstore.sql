-- creating a database

CREATE DATABASE bookstoreDB;

-- using the database

USE bookstoreDB;

-- creating tables
-- table 1

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

-- table 2

CREATE TABLE book_author(
book_id INT,
author_id INT,
FOREIGN KEY (book_id) REFERENCES book(book_id),
FOREIGN KEY (author_id) REFERENCES author(author_id)
);

-- table 3

CREATE TABLE author(
author_id INT PRIMARY KEY,
author_name VARCHAR(255) NOT NULL,
bio TEXT
);

-- table 4

CREATE TABLE book_language(
language_id INT PRIMARY KEY,
languageName VARCHAR(255)
);

-- table 5

CREATE TABLE publisher(
publisher_id INT PRIMARY KEY,
publisherName VARCHAR(255)
);

-- table 6  

CREATE TABLE customer(
customer_id INT PRIMARY KEY,
customer_name VARCHAR (255) NOT NULL,
email VARCHAR(255),
phone VARCHAR(20)
);

-- table 7

CREATE TABLE customer_address(
customer_id INT,
address_id INT,
FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
FOREIGN KEY (address_id) REFERENCES  address(address_id)
);


-- table 8

CREATE TABLE address_status(
status_id INT PRIMARY KEY,
status_name VARCHAR(255) NOT NULL
);
