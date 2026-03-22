CREATE TABLE dim_date (
    date_id DATE PRIMARY KEY,
    month INT,
    year INT
);

CREATE TABLE dim_store (
    store_id VARCHAR(20) PRIMARY KEY,
    store_name VARCHAR(100),
    city VARCHAR(50)
);

CREATE TABLE dim_product (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    product_name VARCHAR(100),
    category VARCHAR(50)
);

CREATE TABLE fact_sales (
    sale_id INT PRIMARY KEY AUTO_INCREMENT,
    date_id DATE,
    store_id VARCHAR(20),
    product_id INT,
    quantity INT,
    revenue DECIMAL(10,2),
    FOREIGN KEY (date_id) REFERENCES dim_date(date_id),
    FOREIGN KEY (store_id) REFERENCES dim_store(store_id),
    FOREIGN KEY (product_id) REFERENCES dim_product(product_id)
);

INSERT INTO dim_date VALUES
('2023-01-01',1,2023),
('2023-02-01',2,2023),
('2023-03-01',3,2023);

INSERT INTO dim_store VALUES
('S001','Mumbai Store','Mumbai'),
('S002','Delhi Store','Delhi'),
('S003','Bangalore Store','Bangalore');

INSERT INTO dim_product (product_name, category) VALUES
('Laptop','Electronics'),
('Shirt','Clothing'),
('Milk','Groceries');

INSERT INTO fact_sales (date_id,store_id,product_id,quantity,revenue) VALUES
('2023-01-01','S001',1,2,100000),
('2023-01-01','S002',2,5,5000),
('2023-02-01','S001',3,10,600),
('2023-02-01','S003',1,1,50000),
('2023-03-01','S002',2,3,3000),
('2023-03-01','S003',3,8,480),
('2023-01-01','S001',2,4,4000),
('2023-02-01','S002',1,2,100000),
('2023-03-01','S003',2,6,6000),
('2023-03-01','S001',3,7,420);