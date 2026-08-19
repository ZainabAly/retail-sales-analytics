-- ==========================================
-- 02_Data_Import.sql
-- Purpose: Verify data import
-- ==========================================

-- Count total rows
SELECT COUNT(*) AS total_rows
FROM superstore;

-- Preview the data
SELECT *
FROM superstore
LIMIT 10;