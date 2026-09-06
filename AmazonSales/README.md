# 🛒 Amazon Sales Data Analysis Using SQL

## 📌 Project Overview

This project focuses on analyzing Amazon sales data using **SQL** to understand sales performance, customer behavior, product performance, revenue, payment methods, ratings, and branch-level trends.

The project contains **26 SQL queries** covering data exploration, aggregation, filtering, subqueries, CTEs, CASE statements, and time-based analysis.

## 🎯 Objectives

- Analyze sales and revenue performance.
- Compare sales across branches and cities.
- Identify top-performing product lines.
- Analyze customer and gender distribution.
- Understand payment method usage.
- Analyze customer ratings.
- Study sales by day and time of day.
- Generate useful business insights from sales data.

## 📂 Dataset

The dataset contains sales transaction information including:

- Invoice ID
- Branch and City
- Customer Type
- Gender
- Product Line
- Unit Price
- Quantity
- VAT
- Total Sales
- Date and Time
- Payment Method
- COGS
- Gross Income
- Customer Rating

Additional time-based fields such as **Time of Day, Day Name, and Month Name** are also used for analysis.

## 🛠️ SQL Concepts Used

- SELECT & DISTINCT
- WHERE
- COUNT, SUM, AVG, MAX
- GROUP BY & HAVING
- ORDER BY & LIMIT
- CASE statements
- Subqueries
- CTE (Common Table Expression)
- Date & Time functions
- Conditional analysis

## 🔍 Analysis Performed

### 💰 Sales & Revenue Analysis
Analyzed total sales, monthly revenue, product-line revenue, COGS, VAT, and city-wise revenue.

### 📦 Product Analysis
Compared product lines based on sales, revenue, VAT, and customer ratings.

### 👥 Customer Analysis
Analyzed customer types, gender distribution, and revenue contribution by customer type.

### 💳 Payment Analysis
Identified the most frequently used payment methods and analyzed their usage.

### ⭐ Rating Analysis
Calculated average ratings by product line, day, and time of day.

### 🏙️ Branch & City Analysis
Compared sales performance, revenue, VAT, and customer distribution across different branches and cities.

### ⏰ Time-Based Analysis
Analyzed sales and customer ratings across different days of the week and times of day.

## 📊 Key Insights

The analysis helps identify:

- Top-performing product categories.
- Highest-revenue cities and branches.
- Most frequently used payment methods.
- Customer types contributing the most revenue.
- Product lines with higher customer ratings.
- Peak sales periods based on day and time.
- Differences in customer and gender distribution across branches.

## 📁 Project Structure

```text
AmazonSales/
│
├── schema.sql
└── solution.sql

🚀 Key Learning

This project demonstrates how SQL can be used to analyze sales data and convert transactional data into meaningful business insights using aggregation, filtering, subqueries, CTEs, and time-based analysis.

👩‍💻 Author

Rishita Choksi

Skills: SQL | MySQL | Data Analysis | Business Analysis
