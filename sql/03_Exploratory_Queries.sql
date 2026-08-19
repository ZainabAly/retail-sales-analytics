-- ==========================================
-- 03_Exploratory_Queries.sql
-- Purpose:Exploratory SQL Analysis
-- ==========================================

--1. Dataset Overview

--Total rows
SELECT COUNT(*) AS total_rows
FROM superstore;
--Date Range
SELECT
    MIN(order_date) AS first_order,
    MAX(order_date) AS last_order
FROM superstore;
--Distinct Categories
SELECT DISTINCT category
FROM superstore;
--Distinct Regions
SELECT DISTINCT region
FROM superstore;
--Distinct Segments
SELECT DISTINCT segment
FROM superstore;

--2. Aggregate Statistics
--Total Sales
SELECT ROUND(SUM(sales),2) AS total_sales
FROM superstore;
--Total Profit
SELECT ROUND(SUM(profit),2) AS total_profit
FROM superstore;
--Average Sales
SELECT ROUND(AVG(sales),2) AS average_sales
FROM superstore;
--Average Profit
SELECT ROUND(AVG(profit),2) AS average_profit
FROM superstore;
--Average Discount
SELECT ROUND(AVG(discount),2) AS average_discount
FROM superstore;

--3. Sales Analysis
--Sales by Category
SELECT
    category,
    ROUND(SUM(sales),2) AS total_sales
FROM superstore
GROUP BY category
ORDER BY total_sales DESC;
--Sales by Region
SELECT
    region,
    ROUND(SUM(sales),2) AS total_sales
FROM superstore
GROUP BY region
ORDER BY total_sales DESC;
--Sales by Segment
SELECT
    segment,
    ROUND(SUM(sales),2) AS total_sales
FROM superstore
GROUP BY segment
ORDER BY total_sales DESC;


--4. Profit Analysis
--Profit by Category
SELECT
    category,
    ROUND(SUM(profit),2) AS total_profit
FROM superstore
GROUP BY category
ORDER BY total_profit DESC;
--Profit by Region
SELECT
    region,
    ROUND(SUM(profit),2) AS total_profit
FROM superstore
GROUP BY region
ORDER BY total_profit DESC;


--5. Customer Analysis
--Orders by Segment
SELECT
    segment,
    COUNT(*) AS total_orders
FROM superstore
GROUP BY segment
ORDER BY total_orders DESC;
--Unique Customers
SELECT COUNT(DISTINCT customer_id) AS unique_customers
FROM superstore;


--6. Product Analysis
--Top 10 Products by Sales
SELECT
    product_name,
    ROUND(SUM(sales),2) AS total_sales
FROM superstore
GROUP BY product_name
ORDER BY total_sales DESC
LIMIT 10;
--Top 10 Products by Profit
SELECT
    product_name,
    ROUND(SUM(profit),2) AS total_profit
FROM superstore
GROUP BY product_name
ORDER BY total_profit DESC
LIMIT 10;


--7. Shipping Analysis
--Orders by Ship Mode
SELECT
    ship_mode,
    COUNT(*) AS total_orders
FROM superstore
GROUP BY ship_mode
ORDER BY total_orders DESC;
--Average Shipping Days
SELECT ROUND(AVG(shipping_days),2) AS average_shipping_days
FROM superstore;