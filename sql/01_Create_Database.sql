-- ==========================================
-- 01_Create_Database.sql
-- Purpose: Create the Superstore table
-- Database: retail_sales
-- ==========================================
-- Drop table if it already exists
DROP TABLE IF EXISTS superstore;

-- Create main table
CREATE TABLE superstore (

    -- Primary Key
    row_id INT PRIMARY KEY,

    -- Order Information
    order_id VARCHAR(20),
    order_date DATE,
    ship_date DATE,
    ship_mode VARCHAR(30),

    -- Customer Information
    customer_id VARCHAR(20),
    customer_name VARCHAR(100),
    segment VARCHAR(30),

    -- Location
    country VARCHAR(50),
    city VARCHAR(50),
    state VARCHAR(50),
    postal_code INT,
    region VARCHAR(30),

    -- Product Information
    product_id VARCHAR(20),
    category VARCHAR(30),
    sub_category VARCHAR(50),
    product_name VARCHAR(255),

    -- Sales Metrics
    sales DECIMAL(10,2),
    quantity INT,
    discount DECIMAL(4,2),
    profit DECIMAL(10,2),

    -- Feature Engineered Columns
    order_year INT,
    order_month VARCHAR(20),
    month_number INT,
    quarter INT,
    day_of_week VARCHAR(20),
    shipping_days INT,
    profit_margin DECIMAL(10,2),
    discount_level VARCHAR(20),
    sales_category VARCHAR(20),
    order_size VARCHAR(20)
);

-- Verify table creation
SELECT *
FROM superstore
LIMIT 5;