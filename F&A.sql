-- Financial and Accounting Courses-Udemy Project
-- Project Overview
-- Project Title: Financial and Accounting Courses-Udemy
-- Database: f&a_udemy

-- This project is designed to demonstrate my SQL skills
-- The project involves setting up database.

-- Project Structure
-- 1. Database Setup
-- Database Creation:
-- Table Creation: A table named 'courses' is created to store Udemy,s Financial and Accounting courses data.
-- The table structure includes columns for id, title, url, is_paid, num_subscribers, avg_rating, avg_rating_recent, rating, num_reviews, is_wishlisted, num_published_lectures, num_published_practice_tests, created, published_time, discount_price_amount, discount_price_currency, discount_price_price_string, price_detail_amount, price_detail_currency, price_detail_price_string.

-- Project Objective
-- A. Ovrall KPTs
--   1. Key Performing Indexes
-- B. Course Performance
--   2. Top 10 most subscribed courses
--   3. Total revenue estimate(if price is fixed)
--   4. Average reviews per level
-- C. Subject-wise Trends
--   5. Subject-wise subscribers
-- D. Popularity and User Engagement
--   6. Most reviewed courses
--   7. Most wishlisted courses
--   8. Most subscribed paid courses
-- E. Pricing and Revenue Insights
--   9. Top 10 most expensive courses(Actual Price)
--   10. Price Discount Analysis
--   11. Courses with 100% discount
--   12. Price vs. Subscribers correlation prepare
-- F. Ratings and Reviews
--   13. Top rated courses
--   14. Courses with High Ratings but Low Overall
-- G. Time-based Insights
--   15. Courses published per year
--   16. Average Discounted Price Over Time
--   17. Recently published Top performers

CREATE TABLE courses(
id INT PRIMARY KEY, 
title VARCHAR(200), 
url VARCHAR(200), 
is_paid VARCHAR(10), 
num_subscribers INT, 
avg_rating FLOAT, 
avg_rating_recent FLOAT, 
rating FLOAT, 
num_reviews INT, 
is_wishlisted VARCHAR(20), 
num_published_lectures INT, 
num_published_practice_tests INT, 
created DATETIME,
published_time DATETIME, 
discount_price_amount INT, 
discount_price_currency VARCHAR(5), 
discount_price_price_string VARCHAR(20), 
price_detail_amount INT, 
price_detail_currency VARCHAR(10), 
price_detail_price_string VARCHAR(20)
);

SHOW GLOBAL VARIABLES LIKE 'local_infile';

SET GLOBAL local_infile = 1;

LOAD DATA INFILE 
'R:\\Git\\Financial and Accounting Courses - Udemy\\udemy_output_All_Finance__Accounting_UDEMY_null.csv'
INTO TABLE courses
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES;

SELECT * FROM courses;

-- A. Ovrall KPTs
--   1. Key Performing Indexes
-- Total number of courses
SELECT COUNT(*) AS total_courses FROM courses;

-- Total subscribers
SELECT SUM(num_subscribers) AS total_subscribers FROM courses;

-- Total reviews
SELECT SUM(num_reviews) AS total_reviews FROM courses;

-- Average rating
SELECT AVG(avg_rating) AS avg_rating FROM courses;

-- B. Course Performance
--   2. Top 10 most subscribed courses
SELECT title, num_subscribers
FROM courses
ORDER BY num_subscribers DESC
LIMIT 10;

--   3. Total revenue estimate(if price is fixed)
SELECT SUM(price * num_subscribers) AS estimated_revenue
FROM courses;

--   4. Average reviews per rating
SELECT avg_rating, AVG(num_reviews) AS avg_reviews
FROM courses
GROUP BY avg_rating;

-- C. Subject-wise Trends
--   5. Subject-wise subscribers
SELECT DISTINCT(id) as d_id, title, num_subscribers
FROM courses
GROUP BY d_id;

-- D. Popularity and User Engagement
--   6. Most reviewed courses
SELECT title, num_reviews
FROM courses
ORDER BY num_reviews DESC
LIMIT 10;

--   7. Most wishlisted courses
SELECT title, is_wishlisted
FROM courses
WHERE is_wishlisted = 'true'
ORDER BY num_subscribers DESC
LIMIT 10;

--   8. Most subscribed paid courses
SELECT title, num_subscribers
FROM courses
WHERE is_paid = 'True'
ORDER BY num_subscribers DESC
LIMIT 10;

-- E. Pricing and Revenue Insights
--   9. Top 10 most expensive courses(Actual Price)
SELECT title, price_detail_amount
FROM courses
WHERE is_paid = 'True'
ORDER BY price_detail_amount DESC
LIMIT 10;

--   10. Price Discount Analysis
SELECT title, price_detail_amount, discount_price_amount,
       (price_detail_amount - discount_price_amount) AS discount_value
FROM courses
WHERE is_paid = 'True'
ORDER BY discount_value DESC
LIMIT 10;

--   11. Courses with 100% discount
SELECT title
FROM courses
WHERE is_paid = 'True' AND discount_price_amount = 0;

--   12. Price vs. Subscribers correlation 
SELECT price_detail_amount, num_subscribers
FROM courses;

-- F. Ratings and Reviews
--   13. Top rated courses
SELECT title, avg_rating, num_reviews
FROM courses
WHERE num_reviews > 1000
ORDER BY avg_rating DESC
LIMIT 10;

--   14. Courses with High Ratings but Low Overall
SELECT title, avg_rating, avg_rating_recent
FROM courses
WHERE avg_rating_recent > avg_rating
ORDER BY (avg_rating_recent - avg_rating) DESC
LIMIT 10;

-- G. Time-based Insights
--   15. Courses published per year
SELECT YEAR(published_time) AS year, COUNT(*) AS course_count
FROM courses
GROUP BY YEAR(published_time)
ORDER BY year;

--   16. Average Discounted Price Over Time
SELECT YEAR(published_time) AS year, 
       AVG(discount_price_amount) AS avg_discount_price
FROM courses
WHERE is_paid = 'True'
GROUP BY YEAR(published_time)
ORDER BY year;

--   17. Recently published Top performers
SELECT title, published_time, avg_rating_recent
FROM courses
ORDER BY published_time DESC
LIMIT 10;

