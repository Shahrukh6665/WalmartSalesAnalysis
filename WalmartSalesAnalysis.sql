-- Create database
CREATE DATABASE IF NOT EXISTS walmartSales;

USE walmartsales;

-- Create table
CREATE TABLE IF NOT EXISTS sales(
	invoice_id VARCHAR(30) NOT NULL PRIMARY KEY,
    branch VARCHAR(5) NOT NULL,
    city VARCHAR(30) NOT NULL,
    customer_type VARCHAR(30) NOT NULL,
    gender VARCHAR(30) NOT NULL,
    product_line VARCHAR(100) NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL,
    quantity INT NOT NULL,
    tax_pct FLOAT(6,4) NOT NULL,
    total DECIMAL(12, 4) NOT NULL,
    date DATETIME NOT NULL,
    time TIME NOT NULL,
    payment VARCHAR(15) NOT NULL,
    cogs DECIMAL(10,2) NOT NULL,
    gross_margin_pct FLOAT(11,9),
    gross_income DECIMAL(12, 4),
    rating FLOAT(2, 1)
);

-- Data cleaning --
SELECT * FROM sales;

-- Add the time_of_day column
SELECT
	time,
	(CASE
		WHEN `time` BETWEEN "00:00:00" AND "12:00:00" THEN "Morning"
        WHEN `time` BETWEEN "12:01:00" AND "16:00:00" THEN "Afternoon"
        ELSE "Evening"
    END) AS time_of_day
FROM sales;

ALTER TABLE sales ADD COLUMN time_of_day VARCHAR(20);

-- For this to work turn off safe mode for update --
-- Edit > Preferences > SQL Editor > scroll down and toggle safe mode --
-- Reconnect to MySQL: Query > Reconnect to server --

UPDATE sales
SET time_of_day = (
	CASE
		WHEN `time` BETWEEN "00:00:00" AND "12:00:00" THEN "Morning"
        WHEN `time` BETWEEN "12:01:00" AND "16:00:00" THEN "Afternoon"
        ELSE "Evening"
    END
);

-- Add day_name column -- 
SELECT 
	date,
    DAYNAME(date)
FROM sales;

ALTER TABLE sales ADD COLUMN day_name VARCHAR(10);

UPDATE sales
SET day_name = DAYNAME(date);

-- Add month_name column --
SELECT 
	date,
    MONTHNAME(date)
FROM sales;

ALTER TABLE sales ADD COLUMN month_name VARCHAR(10);

UPDATE sales 
SET month_name = MONTHNAME(date);

SELECT * FROM sales;

----------------------------------------------------------------------------------------------
--------------------------------------- Generic ----------------------------------------------
----------------------------------------------------------------------------------------------

-- How many unique cities does the data have? --
SELECT
	DISTINCT city
FROM sales;

-- In which city is each branch? --
SELECT
	DISTINCT city,
    branch
FROm sales;


----------------------------------------------------------------------------------------------
--------------------------------------- Product ----------------------------------------------
----------------------------------------------------------------------------------------------

-- How many unique product lines does the data have? --
SELECT
	DISTINCT product_line
FROM sales;

-- What is the most selling product line --
SELECT
	SUM(quantity) AS Qty,
    product_line
FROM sales
GROUP BY product_line
ORDER BY Qty DESC;

-- What is the total revenue by month --
SELECT
	month_name AS month,
    SUM(total) AS Total_revenue
FROM sales
GROUP BY month_name
ORDER BY Total_revenue;

-- What month had the largest COGS? --
SELECT
	month_name AS month,
    SUM(cogs) as COGS
FROM sales
GROUP BY month_name
ORDER BY COGS;

-- What product line had the largest revenue? --
SELECT
	product_line,
    SUM(total) AS Total_revenue
FROM sales
GROUP BY product_line
ORDER BY Total_revenue;

-- What is the city with the largest revenue? --
SELECT
	city,
    branch,
    SUM(total) AS Total_revenue
FROM sales
GROUP BY city, branch
ORDER BY Total_revenue;

-- What product line had the largest VAT? --
SELECT
	product_line,
    AVG(tax_pct) AS avg_tax
FROM sales
GROUP BY product_line
ORDER BY avg_tax DESC;

-- Fetch each product line and add column to those product --
-- line showing "Good", "Bad". Good if its greater than average sales --

SELECT
	AVG(quantity) AS avg_qty
FROM sales;

SELECT
	product_line,
    AVG(quantity) AS avg_qty,
    CASE
		WHEN AVG(quantity) >= 5.5 THEN "Good"
        ELSE "Bad"
	END AS remark
FROM sales
GROUP BY product_line
ORDER BY avg_qty;

-- Which branch sold more products than average product sold? --
SELECT 
	branch,
    SUM(quantity) AS Qty
FROM sales
GROUP BY branch
HAVING SUM(quantity) > (SELECT AVG(quantity) FROM sales);

-- What is the most common product line by gender --
SELECT
	gender,
    product_line,
    COUNT(gender) AS Gender
FROM sales
GROUP BY gender, product_line
ORDER BY Gender DESC;

-- What is the average rating of each product line --
SELECT
	AVG(rating) AS avg_rating,
    product_line
FROM sales
GROUP BY product_line
ORDER BY avg_rating DESC;

-------------------------------------------------------------------------------------------
---------------------------------- Customer -----------------------------------------------
-------------------------------------------------------------------------------------------

-- How many unique customer types does the data have --
SELECT 
	DISTINCT customer_type
FROM sales;

-- How many unique payment types does the data have --
SELECT 
	DISTINCT payment
FROM sales;

-- What is the most common customer type? --
SELECT 
	customer_type,
    COUNT(*) AS Count
FROM sales
GROUP BY customer_type
ORDER BY Count DESC;

-- Which customer types buys the most? --
SELECT
	 customer_type,
     COUNT(*)
FROM sales
GROUP BY customer_type;

-- What is the gender of the most of the customers? --
SELECT 
	gender,
    COUNT(*) AS Gender
FROM sales
GROUP BY gender
ORDER BY Gender DESC;

-- What is the gender disstribution per branch? --
SELECT
	gender,
    COUNT(*) AS Gender
FROM sales
WHERE branch = 'C'
GROUP BY gender
ORDER BY Gender DESC;

SELECT
	gender,
    COUNT(*) AS Gender
FROM sales
WHERE branch = 'A'
GROUP BY gender
ORDER BY Gender DESC;

SELECT
	gender,
    COUNT(*) AS Gender
FROM sales
WHERE branch = 'B'
GROUP BY gender
ORDER BY Gender DESC;

-- Which time of the day do customers give most ratings --
SELECT
	time_of_day,
    AVG(rating) AS avg_rating
FROM sales
GROUP BY time_of_day
ORDER BY avg_rating DESC;

-- Which day do customers give most ratings --
SELECT
	day_name,
    AVG(rating) AS avg_rating
FROM sales
GROUP BY day_name
ORDER BY avg_rating DESC;

-- Which month do customers give most ratings --
SELECT
	month_name,
    AVG(rating) AS avg_rating
FROM sales
GROUP BY month_name
ORDER BY avg_rating DESC;

-- Which time of day do customers give most ratings per branch --
SELECT
	time_of_day,
    AVG(rating) AS avg_rating
FROM sales
WHERE branch = 'A'
GROUP BY time_of_day
ORDER BY avg_rating DESC;

SELECT
	time_of_day,
    AVG(rating) AS avg_rating
FROM sales
WHERE branch = 'B'
GROUP BY time_of_day
ORDER BY avg_rating DESC;

SELECT
	time_of_day,
    AVG(rating) AS avg_rating
FROM sales
WHERE branch = 'C'
GROUP BY time_of_day
ORDER BY avg_rating DESC;

-- Branch A and C are doing great in rating, Branch B needs to do 
-- little more to get better ratings. 

-- Which day of the week has best avg ratings --
SELECT
	day_name,
    AVG(rating) AS avg_rating
FROM sales
GROUP BY day_name
ORDER BY avg_rating DESC;

-- Mon, Fri and Tue ate the top best days with ratings

-- Which day of the week has the best average ratings per branch?
SELECT 
	day_name,
	COUNT(day_name) total_sales
FROM sales
WHERE branch = "C"
GROUP BY day_name
ORDER BY total_sales DESC;

SELECT 
	day_name,
	COUNT(day_name) total_sales
FROM sales
WHERE branch = "A"
GROUP BY day_name
ORDER BY total_sales DESC;

SELECT 
	day_name,
	COUNT(day_name) total_sales
FROM sales
WHERE branch = "B"
GROUP BY day_name
ORDER BY total_sales DESC;

--------------------------------------------------------------------------------------------
---------------------------------- Sales ---------------------------------------------------
--------------------------------------------------------------------------------------------

-- Number of sales made in each time of the day per weekday --
SELECT 
	time_of_day,
    day_name,
    COUNT(*) AS Total_sales
FROM sales
GROUP BY time_of_day
ORDER BY  Total_sales DESC;

-- Number of sales made in each time of the day per weekday 
SELECT
	time_of_day,
	COUNT(*) AS total_sales
FROM sales
WHERE day_name = "Sunday"
GROUP BY time_of_day 
ORDER BY total_sales DESC;

-- Evenings experience most sales, the stores are 
-- filled during the evening hours

-- Which of the customer types brings the most revenue?
SELECT
	customer_type,
	SUM(total) AS total_revenue
FROM sales
GROUP BY customer_type
ORDER BY total_revenue;

-- Which city has the largest tax/VAT percent?
SELECT
	city,
    ROUND(AVG(tax_pct), 2) AS avg_tax_pct
FROM sales
GROUP BY city 
ORDER BY avg_tax_pct DESC;

-- Which customer type pays the most in VAT?
SELECT
	customer_type,
	AVG(tax_pct) AS total_tax
FROM sales
GROUP BY customer_type
ORDER BY total_tax;