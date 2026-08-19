-- ==========================================================
-- 05_Views.sql
-- Purpose: Create reusable analytical views
-- ==========================================================

-- Category Performance

DROP VIEW IF EXISTS category_performance;

CREATE VIEW category_performance AS

SELECT
    category,
    ROUND(SUM(sales),2) AS total_sales,
    ROUND(SUM(profit),2) AS total_profit,
    ROUND(AVG(profit_margin),2) AS avg_profit_margin,
    COUNT(*) AS total_orders
FROM superstore
GROUP BY category;

SELECT *
FROM category_performance;

-- Regional Performance

DROP VIEW IF EXISTS regional_performance;

CREATE VIEW regional_performance AS

SELECT
    region,
    ROUND(SUM(sales),2) AS total_sales,
    ROUND(SUM(profit),2) AS total_profit,
    ROUND(AVG(profit_margin),2) AS avg_profit_margin,
    COUNT(*) AS total_orders
FROM superstore
GROUP BY region;

SELECT *
FROM regional_performance;

-- Monthly Sales

DROP VIEW IF EXISTS monthly_sales;

CREATE VIEW monthly_sales AS

SELECT
    month_number,
    order_month,
    ROUND(SUM(sales),2) AS monthly_sales,
    ROUND(SUM(profit),2) AS monthly_profit
FROM superstore
GROUP BY
    month_number,
    order_month;

SELECT *
FROM monthly_sales
ORDER BY month_number;

-- Customer Performance

DROP VIEW IF EXISTS customer_performance;

CREATE VIEW customer_performance AS

SELECT
    customer_id,
    customer_name,
    segment,
    ROUND(SUM(sales),2) AS total_sales,
    ROUND(SUM(profit),2) AS total_profit,
    COUNT(order_id) AS total_orders
FROM superstore
GROUP BY
    customer_id,
    customer_name,
    segment;

SELECT *
FROM customer_performance
ORDER BY total_sales DESC
LIMIT 10;

-- Product Performance

DROP VIEW IF EXISTS product_performance;

CREATE VIEW product_performance AS

SELECT
    product_id,
    product_name,
    category,
    sub_category,
    ROUND(SUM(sales),2) AS total_sales,
    ROUND(SUM(profit),2) AS total_profit,
    COUNT(*) AS total_orders
FROM superstore
GROUP BY
    product_id,
    product_name,
    category,
    sub_category;

SELECT *
FROM product_performance
ORDER BY total_profit DESC
LIMIT 10;

-- Shipping Performance

DROP VIEW IF EXISTS shipping_performance;

CREATE VIEW shipping_performance AS

SELECT
    ship_mode,
    ROUND(AVG(shipping_days),2) AS avg_shipping_days,
    COUNT(*) AS total_orders,
    ROUND(SUM(sales),2) AS total_sales
FROM superstore
GROUP BY ship_mode;

SELECT *
FROM shipping_performance;

-- Discount Analysis

DROP VIEW IF EXISTS discount_analysis;

CREATE VIEW discount_analysis AS

SELECT
    discount_level,
    COUNT(*) AS total_orders,
    ROUND(AVG(discount),2) AS avg_discount,
    ROUND(AVG(profit),2) AS avg_profit,
    ROUND(SUM(profit),2) AS total_profit
FROM superstore
GROUP BY discount_level;

SELECT *
FROM discount_analysis;

-- Executive KPI Summary

DROP VIEW IF EXISTS executive_kpis;

CREATE VIEW executive_kpis AS

SELECT
    ROUND(SUM(sales),2) AS total_sales,
    ROUND(SUM(profit),2) AS total_profit,
    ROUND(AVG(discount),2) AS average_discount,
    ROUND(AVG(profit_margin),2) AS average_profit_margin,
    COUNT(*) AS total_orders,
    COUNT(DISTINCT customer_id) AS unique_customers
FROM superstore;

SELECT *
FROM executive_kpis;

