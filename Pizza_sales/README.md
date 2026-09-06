# 🍕 Pizza Sales Key Performance Indicators (KPIs) Analysis

An Exploratory Data Analysis (EDA) project on retail pizza chain sales transactions. This analysis calculates core operational KPIs such as Total Revenue, Average Order Value (AOV), total quantity sold, peak order days/hours, and menu item popularity to support menu engineering and store operations.

---

## 📌 Project Overview
This project evaluates retail food sales metrics across relational tables. It involves:

- Revenue KPI calculation (Total Revenue, Average Order Value, Total Pizzas Sold)
- Sales distribution analysis across pizza categories (*Classic*, *Veggie*, *Supreme*, *Chicken*) and sizes (*S*, *M*, *L*, *XL*)
- Order timing trends by day of the week and hour of the day
- Menu item ranking (Top 5 and Bottom 5 pizzas by revenue and volume)

---

## 🎯 Objectives
- Calculate total revenue, total orders placed, and average order value (AOV)
- Determine peak ordering days of the week and busiest hours of the day
- Evaluate sales performance across pizza categories and size configurations
- Identify best-selling and underperforming menu items for inventory optimization
- Provide data-driven operational recommendations for store staff scheduling and promotions

---

## 📁 Dataset & Files Included

### Relational Tables Included:
- **`orders`**: Order ID, Order Date, Order Time
- **`order_details`**: Order Detail ID, Order ID, Pizza ID, Quantity
- **`pizzas`**: Pizza ID, Pizza Type ID, Size (*S*, *M*, *L*, *XL*), Price ($)
- **`pizza_types`**: Pizza Type ID, Name, Category, Ingredients

---

## 🛠️ Tools & Technologies
- **Data Engine**: Relational Database Management System (SQL / MySQL)
- **Analysis Tools**: Database Query Engine & Analytical Reporting

---

## 🔍 Key Analysis Topics Covered

### 1. 💵 Financial & Operational KPIs
- Computing net sales revenue, total order volume, and average order spending per customer.

### 2. ⏰ Temporal Demand & Peak Hour Analysis
- Identifying peak order hours (e.g. lunch & dinner rush) and high-volume days of the week.

### 3. 🍕 Size & Category Revenue Breakdown
- Analyzing customer preferences across size tiers (Large vs. Medium) and category styles.

### 4. 🏆 Menu Item Performance Ranking
- Identifying the top 5 revenue-generating pizzas and bottom 5 underperforming items.

---

## 📊 Summary Output Metrics

| Operational Metric / Dimension | Summary Finding |
| :--- | :--- |
| **Busiest Day of the Week** | **Friday** records the highest total order volume |
| **Peak Hourly Window** | Lunch (12:00 PM – 1:30 PM) and Dinner (6:00 PM – 8:00 PM) |
| **Top Pizza Size by Revenue** | **Large (L)** size pizzas contribute **~44% of total revenue** |
| **Top Revenue Generating Pizza** | *Thai Chicken Pizza* generates the highest overall monetary value |

---

## 📌 Key Insights
- **Weekend Spikes**: Friday and Saturday evenings drive the highest transaction counts of the week.
- **Size Value Driver**: Large pizzas generate the vast majority of store sales due to higher unit pricing and group dining habits.
- **Menu Pareto Distribution**: A small core set of popular pizzas generates over 60% of total revenue.

---

## 🎓 Key Learnings
Through this project, I gained practical experience in:
- **Relational Data Joins**: Connecting transaction logs across multiple relational entities (`orders`, `order_details`, `pizzas`, `pizza_types`).
- **Retail Food KPI Calculation**: Formulating essential business metrics such as Average Order Value (AOV) and revenue per transaction.
- **Menu Engineering & Product Optimization**: Analyzing item-level profitability to support menu design and stock planning.

---

## ✅ Recommendations
- **Staffing Optimization**: Increase kitchen staff during peak Friday/Saturday dinner rush hours (6 PM – 8 PM).
- **Bundle Promotions**: Create combo meal deals featuring underperforming pizza items to boost overall inventory turnover.
- **Promote Large Size Upgrades**: Train order-taking staff to suggest size upgrades to Large (L) during checkout to boost AOV.

---

👤 **Author**: Rishita Choksi  
