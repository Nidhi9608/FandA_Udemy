-- Salaries of San Francisco Employee Project
-- Project Title: Salaries of San Francisco Employee(312882 data)
-- Database: salaries_employees

-- Project Structure
-- 1. Database Setup
-- Database Creation:
-- Table Creation: A table named 'salaries' is created to store Salaries of San Francisco Employee data.

-- Project Overview
-- 1. Top 10 Highest Paid Employees
-- 2. Average BasePay by Job Title
-- 3. Total Overtime Pay by Year
-- 4. Count of Employees per Year
-- 5. Top 10 Job Titles with Highest Average TotalPay
-- 6. Employees with Zero BasePay but Positive Pay
-- 7. Job Titles with Highest Number of Employees
-- 8. Average TotalPayBenefits by Year
-- 9. TotalPay vs TotalPayBenefits Gap
-- 10. Null or Missing Data Check

CREATE TABLE salaries(
EmployeeName VARCHAR(50),
JobTitle VARCHAR(50),
BasePay FLOAT,
OvertimePay FLOAT,
OtherPay FLOAT,
Benefits FLOAT,
TotalPay FLOAT,
TotalPayBenefits FLOAT,
Year YEAR
);
SHOW GLOBAL VARIABLES LIKE 'local_infile';

SET GLOBAL local_infile = 1;

LOAD DATA INFILE 
"R:\\Git\\Salaries For San Francisco Employee\\Total_null.csv"
INTO TABLE salaries
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES;

-- 1. Top 10 Highest Paid Employees
SELECT EmployeeName, JobTitle, TotalPayBenefits
FROM salaries
ORDER BY TotalPayBenefits DESC
LIMIT 10;

-- 2. Average BasePay by Job Title
SELECT JobTitle, ROUND(AVG(BasePay), 2) AS AvgBasePay
FROM salaries
GROUP BY JobTitle
ORDER BY AvgBasePay DESC;

-- 3. Total Overtime Pay by Year
SELECT Year, SUM(OvertimePay) AS TotalOvertime
FROM salaries
GROUP BY Year
ORDER BY Year;

-- 4. Count of Employees per Year
SELECT Year, COUNT(*) AS EmployeeCount
FROM salaries
GROUP BY Year
ORDER BY Year;

-- 5. Top 10 Job Titles with Highest Average TotalPay
SELECT JobTitle, ROUND(AVG(TotalPay), 2) AS AvgTotalPay
FROM salaries
GROUP BY JobTitle
ORDER BY AvgTotalPay DESC
LIMIT 10;

-- 6. Employees with Zero BasePay but Positive Pay
SELECT EmployeeName, JobTitle, BasePay, TotalPay
FROM salaries
WHERE BasePay = 0 AND TotalPay > 0;

-- 7. Job Titles with Highest Number of Employees
SELECT JobTitle, COUNT(*) AS EmployeeCount
FROM salaries
GROUP BY JobTitle
ORDER BY EmployeeCount DESC
LIMIT 10;

-- 8. Average TotalPayBenefits by Year
SELECT Year, ROUND(AVG(TotalPayBenefits), 2) AS AvgTotalPayBenefits
FROM salaries
GROUP BY Year
ORDER BY Year;

-- 9. TotalPay vs TotalPayBenefits Gap
SELECT EmployeeName, JobTitle, TotalPay, TotalPayBenefits,
       (TotalPayBenefits - TotalPay) AS BenefitsGap
FROM salaries
ORDER BY BenefitsGap DESC
LIMIT 10;

-- 10. Null or Missing Data Check
SELECT *
FROM salaries
WHERE BasePay IS NULL OR TotalPay IS NULL OR TotalPayBenefits IS NULL;


