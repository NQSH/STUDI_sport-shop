DROP DATABASE IF EXISTS STUDI_sport_shop;
CREATE DATABASE STUDI_sport_shop;
USE STUDI_sport_shop;


CREATE TABLE categories (
	id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL
);

CREATE TABLE brands (
	id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL
);

CREATE TABLE products (
	id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    base_price DECIMAL(10,2) NOT NULL DEFAULT 0.00,
    is_active BOOL NOT NULL DEFAULT TRUE,
    category_id INT NOT NULL,
    brand_id INT NOT NULL,
    FOREIGN KEY (category_id) REFERENCES categories(id),
    FOREIGN KEY (brand_id) REFERENCES brands(id)
);

CREATE TABLE product_variants (
	id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    quantity INT NOT NULL DEFAULT 0,
    product_id INT NOT NULL,
    specific_price DECIMAL(10,2) DEFAULT NULL,
    FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE
);

CREATE TABLE attributes (
	id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL
);

CREATE TABLE attribute_values (
	id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    value VARCHAR(10) NOT NULL,
    attribute_id INT NOT NULL,
    FOREIGN KEY (attribute_id) REFERENCES attributes(id)
);

CREATE TABLE variant_attributes (
	product_variant_id INT NOT NULL,
    attribute_value_id INT NOT NULL,
    PRIMARY KEY(product_variant_id, attribute_value_id),
    FOREIGN KEY (product_variant_id) REFERENCES product_variants(id) ON DELETE CASCADE,
    FOREIGN KEY (attribute_value_id) REFERENCES attribute_values(id) ON DELETE CASCADE
);

CREATE TABLE users (
	id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    email VARCHAR(255) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL
);

CREATE TABLE clients (
	id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    firstname VARCHAR(100) NOT NULL,
    lastname VARCHAR(100) NOT NULL,
    phone_number VARCHAR(16) NOT NULL,
    user_id INT UNIQUE NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

CREATE TABLE addresses (
	id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    street VARCHAR(255) NOT NULL,
    additionnal_info VARCHAR(255),
    zipcode VARCHAR(20),
    city VARCHAR(100),
    type ENUM('SHIPPING','BILLING'),
    is_default BOOL DEFAULT TRUE,
    client_id INT NOT NULL,
    FOREIGN KEY (client_id) REFERENCES clients(id) ON DELETE CASCADE
);

CREATE TABLE orders (
	id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    status ENUM('PENDING', 'PAID', 'PROCESSING', 'SHIPPED', 'DELIVERED', 'CANCELED', 'REFOUNDED') NOT NULL DEFAULT 'PENDING',
    client_id INT NOT NULL,
    shipping_address_id INT NOT NULL,
    billing_address_id INT NOT NULL,
    FOREIGN KEY (client_id) REFERENCES clients(id),
    FOREIGN KEY (shipping_address_id) REFERENCES addresses(id),
    FOREIGN KEY (billing_address_id) REFERENCES addresses(id)    
);

CREATE TABLE order_details (
	id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    quantity INT NOT NULL DEFAULT 1,
    order_id INT NOT NULL,
    product_variant_id INT NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders(id) ON DELETE CASCADE,
    FOREIGN KEY (product_variant_id) REFERENCES product_variants(id) ON DELETE CASCADE
);

CREATE TABLE payment_types (
	id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
	name VARCHAR(20) UNIQUE NOT NULL
);

CREATE TABLE payments (
	id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    amount DECIMAL(10,2) NOT NULL,
    status ENUM('PENDING', 'COMPLETED', 'FAILED', 'REFOUNDED'),
    details JSON,
    order_id INT NOT NULL,
    payment_type_id INT NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders(id),
    FOREIGN KEY (payment_type_id) REFERENCES payment_types(id)
);

