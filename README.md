# Hotel Booking Demand Analysis

**Data Analysis Project using Databricks (SQL) + Power BI**

This project analyzes hotel booking demand data to uncover key business insights related to cancellations, revenue, seasonality, and customer behavior. The analysis was performed primarily with SQL in Databricks and visualized through an interactive Power BI dashboard.

---

## Project Overview

The dataset contains **119,390 hotel bookings** from two types of hotels (City Hotel and Resort Hotel). The main goal was to answer business questions such as:

- What is the overall cancellation rate?
- Which factors most influence cancellations? (Lead time, Deposit type, Market segment, etc.)
- How does revenue behave across months and hotel types?
- Which customer segments are the riskiest?

---

## Tools Used

- **Databricks** → Data cleaning, transformation and SQL analysis
- **SQL** → Main analysis language (CTEs, Window Functions, CASE statements)
- **Power BI** → Interactive dashboard with 3 pages
- **GitHub** → Project documentation and version control

---

## Key Insights

- **Overall Cancellation Rate:** 37.04%
- **City Hotel** has a significantly higher cancellation rate (41.73%) compared to **Resort Hotel** (27.76%)
- Bookings with **lead time > 180 days** have a **57%** cancellation rate
- **Groups** market segment shows the highest cancellation rate (**61%**)
- **Non-Refundable** deposits combined with previous cancellations reach **almost 100%** cancellation rate
- Revenue peaks during summer months (July – August)

---

## Dashboard Pages

### 1. Executive Overview
High-level KPIs, cancellations by hotel, top countries, and monthly revenue trend.

### 2. Cancellation Analysis
Deep dive into cancellation drivers: Lead Time, Market Segment, Deposit Type, and risk matrix.

### 3. Revenue & Seasonality
Revenue performance, ADR trends, market segment contribution, and seasonal patterns.

---

## Data Cleaning Process (Databricks)

- Handled string "NA" and "NULL" values
- Converted data types (especially `children` from string to integer)
- Created cleaned table: `hotel_bookings_cleaned`
- Created analysis-ready views for Power BI

---

## How to Use

1. Clone this repository
2. Open the Power BI file (`.pbix`) located in the `/powerbi` folder
3. (Optional) Review the SQL scripts in the `/databricks` folder

---

## Author

**Alfredo Villalobos**  
Aspiring Data Analyst | SQL • Power BI • Databricks


