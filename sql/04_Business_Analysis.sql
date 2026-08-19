-- ==========================================================
-- 04_Business_Analysis.sql
-- Purpose: Business Analysis using SQL
-- ==========================================================

-- 1. Revenue Analysis
-- Business Question:
-- Which product categories generate the highest revenue?

SELECT
    category,
    ROUND(SUM(sales),2) AS total_sales
FROM superstore
GROUP BY category
ORDER BY total_sales DESC;

-- Business Question:
-- Which sub-categories generate the highest revenue?

SELECT
    sub_category,
    ROUND(SUM(sales),2) AS total_sales
FROM superstore
GROUP BY sub_category
ORDER BY total_sales DESC;

-- Business Question:
-- Which regions generate the highest revenue?

SELECT
    region,
    ROUND(SUM(sales),2) AS total_sales
FROM superstore
GROUP BY region
ORDER BY total_sales DESC;

-- Business Question:
-- Which customer segment contributes the most revenue?

SELECT
    segment,
    ROUND(SUM(sales),2) AS total_sales
FROM superstore
GROUP BY segment
ORDER BY total_sales DESC;


-- 2. Profitability Analysis
-- Business Question:
-- Which product categories generate the highest profit?

SELECT
    category,
    ROUND(SUM(profit),2) AS total_profit
FROM superstore
GROUP BY category
ORDER BY total_profit DESC;

-- Which product sub-categories generate the highest profit?

SELECT
    sub_category,
    ROUND(SUM(profit),2) AS total_profit
FROM superstore
GROUP BY sub_category
ORDER BY total_profit DESC;

-- Business Question:
-- Which sub-categories are unprofitable?

SELECT
    sub_category,
    ROUND(SUM(profit),2) AS total_profit
FROM superstore
GROUP BY sub_category
HAVING SUM(profit) < 0
ORDER BY total_profit;


-- Which products generate the highest total profit?

SELECT
    product_name,
    ROUND(SUM(profit),2) AS total_profit
FROM superstore
GROUP BY product_name
ORDER BY total_profit DESC
LIMIT 10;

-- Business Question:
-- Which product categories achieve the highest average profit margin?

SELECT
    category,
    ROUND(AVG(profit_margin),2) AS avg_profit_margin
FROM superstore
GROUP BY category
ORDER BY avg_profit_margin DESC;

-- 3. Discount Analysis
-- Business Question:
-- How does discount level affect profit?

SELECT
    discount_level,
    COUNT(*) AS total_orders,
    ROUND(AVG(profit),2) AS avg_profit,
    ROUND(SUM(profit),2) AS total_profit
FROM superstore
GROUP BY discount_level
ORDER BY avg_profit DESC;

-- Business Question:
-- How does profitability change across different discount ranges?

SELECT

    CASE
        WHEN discount = 0 THEN 'No Discount'
        WHEN discount <= 0.20 THEN 'Low Discount'
        WHEN discount <= 0.50 THEN 'Medium Discount'
        ELSE 'High Discount'
    END AS discount_group,

    COUNT(*) AS orders,

    ROUND(AVG(profit),2) AS average_profit,

    ROUND(SUM(profit),2) AS total_profit

FROM superstore

GROUP BY discount_group

ORDER BY average_profit DESC;

-- 4. Customer Analysis
-- Business Question:
-- Which customer segments are the most profitable?

SELECT
    segment,
    ROUND(SUM(profit),2) AS total_profit
FROM superstore
GROUP BY segment
ORDER BY total_profit DESC;

-- Business Question:
-- Who are the company's highest-value customers?

SELECT
    customer_name,
    ROUND(SUM(sales),2) AS total_sales,
    DENSE_RANK() OVER (
        ORDER BY SUM(sales) DESC
    ) AS customer_rank
FROM superstore
GROUP BY customer_name
ORDER BY customer_rank
LIMIT 10;

-- 5. Time Analysis
-- Business Question:
-- How do sales vary throughout the year?

SELECT
    month_number,
    order_month,
    ROUND(SUM(sales),2) AS monthly_sales
FROM superstore
GROUP BY month_number, order_month
ORDER BY month_number;

-- Business Question:
-- Which quarter generates the highest sales?

SELECT
    quarter,
    ROUND(SUM(sales),2) AS total_sales
FROM superstore
GROUP BY quarter
ORDER BY quarter;

-- Business Question:
-- Which day generates the highest sales?

SELECT
    day_of_week,
    ROUND(SUM(sales),2) AS total_sales
FROM superstore
GROUP BY day_of_week
ORDER BY total_sales DESC;

-- 6. Shipping Analysis
-- Business Question:
-- Which shipping mode is used most frequently?

SELECT
    ship_mode,
    COUNT(*) AS total_orders
FROM superstore
GROUP BY ship_mode
ORDER BY total_orders DESC;

-- Business Question:
-- What is the average shipping time for each shipping mode?

SELECT
    ship_mode,
    ROUND(AVG(shipping_days),2) AS avg_shipping_days
FROM superstore
GROUP BY ship_mode
ORDER BY avg_shipping_days;

-- 7. Regional Performance
-- Business Question:
-- How do sales, profit, and profit margin compare across regions?
SELECT
    region,
    ROUND(SUM(sales),2) AS total_sales,
    ROUND(SUM(profit),2) AS total_profit,
    ROUND(AVG(profit_margin),2) AS avg_profit_margin
FROM superstore
GROUP BY region
ORDER BY total_sales DESC;

-- 8. Executive KPI Summary
-- Business Question:
-- What are the company's overall performance indicators?
SELECT
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit,
    ROUND(AVG(discount), 2) AS average_discount,
    ROUND(AVG(profit_margin), 2) AS average_profit_margin,
    COUNT(*) AS total_orders,
    COUNT(DISTINCT customer_id) AS unique_customers
FROM superstore;

-- 9. Revenue Benchmark Analysis
-- Business Question:
-- Which categories generate above-average revenue?
WITH category_sales AS (
    SELECT
        category,
        SUM(sales) AS total_sales
    FROM superstore
    GROUP BY category
)
SELECT
    category,
    ROUND(total_sales, 2) AS total_sales
FROM category_sales
WHERE total_sales > (
    SELECT AVG(total_sales)
    FROM category_sales
)
ORDER BY total_sales DESC;

-- 10. Regional Sales Performance
-- Ranking  regions based on total sales

SELECT
    region,
    ROUND(SUM(sales), 2) AS total_sales,
    RANK() OVER (
        ORDER BY SUM(sales) DESC
    ) AS sales_rank
FROM superstore
GROUP BY region;

--11. Sub-Category Profit Ranking
SELECT
    sub_category,
    ROUND(SUM(profit), 2) AS total_profit,
    DENSE_RANK() OVER (
        ORDER BY SUM(profit) DESC
    ) AS profit_rank
FROM superstore
GROUP BY sub_category
ORDER BY profit_rank;

--12. Order Profitability Classification
SELECT
    CASE
        WHEN profit < 0 THEN 'Loss'
        WHEN profit < 100 THEN 'Low Profit'
        WHEN profit < 500 THEN 'Medium Profit'
        ELSE 'High Profit'
    END AS profit_category,
    COUNT(*) AS total_orders,
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit
FROM superstore
GROUP BY
    CASE
        WHEN profit < 0 THEN 'Loss'
        WHEN profit < 100 THEN 'Low Profit'
        WHEN profit < 500 THEN 'Medium Profit'
        ELSE 'High Profit'
    END
ORDER BY total_profit;

-- 13. Products Exceeding Average Sales
-- Business Question:
-- Which products generate sales above the overall average?
SELECT
    product_name,
    ROUND(SUM(sales), 2) AS total_sales
FROM superstore
GROUP BY product_name
HAVING SUM(sales) >
(
    SELECT AVG(product_sales)
    FROM
    (
        SELECT
            SUM(sales) AS product_sales
        FROM superstore
        GROUP BY product_name
    ) AS avg_sales
)
ORDER BY total_sales DESC;


-- 14. Products Outperforming Their Category
-- Business Question:
-- Which products outperform the average product within their category?

WITH product_sales AS (
    SELECT
        category,
        product_name,
        SUM(sales) AS total_sales
    FROM superstore
    GROUP BY
        category,
        product_name
),
category_averages AS (
    SELECT
        category,
        AVG(total_sales) AS average_product_sales
    FROM product_sales
    GROUP BY category
)
SELECT
    p.product_name,
    p.category,
    ROUND(p.total_sales, 2) AS total_sales
FROM product_sales p
JOIN category_averages c
    ON p.category = c.category
WHERE p.total_sales > c.average_product_sales
ORDER BY p.total_sales DESC;

-- 15. Cumulative Sales Trend
-- Business Question:
-- How do cumulative sales grow throughout the year?

SELECT
    month_number,
    order_month,
    ROUND(SUM(sales), 2) AS monthly_sales,
    ROUND(
        SUM(SUM(sales)) OVER (
            ORDER BY month_number
        ),
        2
    ) AS cumulative_sales
FROM superstore
GROUP BY
    month_number,
    order_month
ORDER BY month_number;

-- Final Executive Summary
-- Consolidated business KPIs

SELECT
    ROUND(SUM(sales),2) AS total_sales,
    ROUND(SUM(profit),2) AS total_profit,
    COUNT(DISTINCT customer_id) AS unique_customers,
    ROUND(AVG(discount),2) AS average_discount,
    ROUND(AVG(profit_margin),2) AS average_profit_margin
FROM superstore;