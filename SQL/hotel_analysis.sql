-- =====================================================
-- Hotel Booking Demand Analysis
-- Description: Data cleaning, transformation and business analysis
-- Dataset: Hotel Booking Demand (119,390 rows)
-- =====================================================


-- =====================================================
-- 1. DATA CLEANING
-- =====================================================

-- Create cleaned table with correct data types and null handling
CREATE OR REPLACE TABLE hotel_bookings_cleaned AS
SELECT
  hotel,
  CAST(is_canceled AS INT) AS is_canceled,
  CAST(lead_time AS INT) AS lead_time,
  CAST(arrival_date_year AS INT) AS arrival_date_year,
  arrival_date_month,
  CAST(arrival_date_week_number AS INT) AS arrival_date_week_number,
  CAST(arrival_date_day_of_month AS INT) AS arrival_date_day_of_month,
  CAST(stays_in_weekend_nights AS INT) AS stays_in_weekend_nights,
  CAST(stays_in_week_nights AS INT) AS stays_in_week_nights,
  CAST(adults AS INT) AS adults,
  
  -- Clean children column (was string with 'NA' values)
  CASE 
    WHEN children = 'NA' OR children IS NULL OR children = '' THEN 0
    ELSE CAST(children AS INT)
  END AS children,
  
  CAST(babies AS INT) AS babies,
  meal,
  country,
  market_segment,
  distribution_channel,
  CAST(is_repeated_guest AS INT) AS is_repeated_guest,
  CAST(previous_cancellations AS INT) AS previous_cancellations,
  CAST(previous_bookings_not_canceled AS INT) AS previous_bookings_not_canceled,
  reserved_room_type,
  assigned_room_type,
  CAST(booking_changes AS INT) AS booking_changes,
  deposit_type,
  
  -- Clean agent and company (string 'NULL' values)
  CASE 
    WHEN agent = 'NULL' OR agent = '' OR agent IS NULL THEN NULL
    ELSE agent
  END AS agent,
  
  CASE 
    WHEN company = 'NULL' OR company = '' OR company IS NULL THEN NULL
    ELSE company
  END AS company,
  
  CAST(days_in_waiting_list AS INT) AS days_in_waiting_list,
  customer_type,
  CAST(adr AS DOUBLE) AS adr,
  CAST(required_car_parking_spaces AS INT) AS required_car_parking_spaces,
  CAST(total_of_special_requests AS INT) AS total_of_special_requests,
  reservation_status,
  reservation_status_date
FROM hotel_bookings_raw;


-- =====================================================
-- 2. CREATE VIEWS FOR POWER BI
-- =====================================================

-- Main view with calculated fields
CREATE OR REPLACE VIEW vw_hotel_bookings_main AS
SELECT
  hotel,
  is_canceled,
  lead_time,
  arrival_date_year,
  arrival_date_month,
  arrival_date_week_number,
  stays_in_weekend_nights + stays_in_week_nights AS total_nights,
  adults,
  children,
  babies,
  adults + children + babies AS total_guests,
  meal,
  country,
  market_segment,
  distribution_channel,
  is_repeated_guest,
  previous_cancellations,
  deposit_type,
  customer_type,
  adr,
  required_car_parking_spaces,
  total_of_special_requests,
  reservation_status,
  
  -- Calculated revenue (only confirmed bookings)
  CASE 
    WHEN is_canceled = 0 
    THEN adr * (stays_in_weekend_nights + stays_in_week_nights) 
    ELSE 0 
  END AS revenue,
  
  -- Lead time groups for analysis
  CASE 
    WHEN lead_time <= 7 THEN '0-7 days'
    WHEN lead_time <= 30 THEN '8-30 days'
    WHEN lead_time <= 90 THEN '31-90 days'
    WHEN lead_time <= 180 THEN '91-180 days'
    ELSE '180+ days'
  END AS lead_time_group
FROM hotel_bookings_cleaned;


-- Monthly aggregated view
CREATE OR REPLACE VIEW vw_monthly_summary AS
SELECT
  arrival_date_year,
  arrival_date_month,
  hotel,
  COUNT(*) AS total_bookings,
  SUM(is_canceled) AS cancellations,
  ROUND(SUM(is_canceled) * 100.0 / COUNT(*), 2) AS cancellation_rate,
  ROUND(AVG(CASE WHEN is_canceled = 0 THEN adr END), 2) AS avg_adr,
  ROUND(SUM(CASE WHEN is_canceled = 0 
                 THEN adr * (stays_in_weekend_nights + stays_in_week_nights) 
                 ELSE 0 END), 2) AS revenue
FROM hotel_bookings_cleaned
GROUP BY arrival_date_year, arrival_date_month, hotel;


-- =====================================================
-- 3. BUSINESS ANALYSIS QUERIES
-- =====================================================

-- Query 1: Overall KPIs
SELECT
  COUNT(*) AS total_bookings,
  SUM(is_canceled) AS total_cancellations,
  ROUND(SUM(is_canceled) * 100.0 / COUNT(*), 2) AS cancellation_rate_pct,
  ROUND(AVG(adr), 2) AS avg_adr,
  ROUND(SUM(CASE WHEN is_canceled = 0 
                 THEN adr * (stays_in_weekend_nights + stays_in_week_nights) 
                 ELSE 0 END), 2) AS total_revenue
FROM hotel_bookings_cleaned;


-- Query 2: Cancellations by Hotel Type
SELECT
  hotel,
  COUNT(*) AS total_bookings,
  SUM(is_canceled) AS cancellations,
  ROUND(SUM(is_canceled) * 100.0 / COUNT(*), 2) AS cancellation_rate_pct,
  ROUND(AVG(adr), 2) AS avg_adr
FROM hotel_bookings_cleaned
GROUP BY hotel
ORDER BY cancellation_rate_pct DESC;


-- Query 3: Cancellations by Month
SELECT
  arrival_date_month,
  COUNT(*) AS total_bookings,
  SUM(is_canceled) AS cancellations,
  ROUND(SUM(is_canceled) * 100.0 / COUNT(*), 2) AS cancellation_rate_pct
FROM hotel_bookings_cleaned
GROUP BY arrival_date_month
ORDER BY 
  CASE arrival_date_month
    WHEN 'January' THEN 1 WHEN 'February' THEN 2 WHEN 'March' THEN 3
    WHEN 'April' THEN 4 WHEN 'May' THEN 5 WHEN 'June' THEN 6
    WHEN 'July' THEN 7 WHEN 'August' THEN 8 WHEN 'September' THEN 9
    WHEN 'October' THEN 10 WHEN 'November' THEN 11 WHEN 'December' THEN 12
  END;


-- Query 4: Lead Time vs Cancellation Rate
SELECT
  CASE 
    WHEN lead_time <= 7 THEN '0-7 days'
    WHEN lead_time <= 30 THEN '8-30 days'
    WHEN lead_time <= 90 THEN '31-90 days'
    WHEN lead_time <= 180 THEN '91-180 days'
    ELSE '180+ days'
  END AS lead_time_group,
  COUNT(*) AS total_bookings,
  SUM(is_canceled) AS cancellations,
  ROUND(SUM(is_canceled) * 100.0 / COUNT(*), 2) AS cancellation_rate_pct
FROM hotel_bookings_cleaned
GROUP BY 
  CASE 
    WHEN lead_time <= 7 THEN '0-7 days'
    WHEN lead_time <= 30 THEN '8-30 days'
    WHEN lead_time <= 90 THEN '31-90 days'
    WHEN lead_time <= 180 THEN '91-180 days'
    ELSE '180+ days'
  END
ORDER BY MIN(lead_time);


-- Query 5: Market Segment Analysis
SELECT
  market_segment,
  COUNT(*) AS total_bookings,
  SUM(is_canceled) AS cancellations,
  ROUND(SUM(is_canceled) * 100.0 / COUNT(*), 2) AS cancellation_rate_pct,
  ROUND(AVG(adr), 2) AS avg_adr
FROM hotel_bookings_cleaned
GROUP BY market_segment
ORDER BY total_bookings DESC;


-- Query 6: Top 10 Countries by Bookings
SELECT
  country,
  COUNT(*) AS total_bookings,
  SUM(is_canceled) AS cancellations,
  ROUND(SUM(is_canceled) * 100.0 / COUNT(*), 2) AS cancellation_rate_pct,
  ROUND(AVG(adr), 2) AS avg_adr
FROM hotel_bookings_cleaned
GROUP BY country
ORDER BY total_bookings DESC
LIMIT 10;


-- Query 7: Monthly Revenue Analysis with Window Function
WITH monthly_stats AS (
  SELECT
    arrival_date_year,
    arrival_date_month,
    hotel,
    COUNT(*) AS total_bookings,
    SUM(is_canceled) AS cancellations,
    ROUND(SUM(is_canceled) * 100.0 / COUNT(*), 2) AS cancellation_rate,
    ROUND(AVG(CASE WHEN is_canceled = 0 THEN adr END), 2) AS avg_adr_confirmed,
    ROUND(SUM(CASE WHEN is_canceled = 0 
                   THEN adr * (stays_in_weekend_nights + stays_in_week_nights) 
                   ELSE 0 END), 2) AS revenue
  FROM hotel_bookings_cleaned
  GROUP BY arrival_date_year, arrival_date_month, hotel
)
SELECT
  arrival_date_year,
  arrival_date_month,
  hotel,
  total_bookings,
  cancellations,
  cancellation_rate,
  avg_adr_confirmed,
  revenue,
  ROUND(revenue / SUM(revenue) OVER (PARTITION BY arrival_date_year), 4) AS revenue_share_of_year
FROM monthly_stats
ORDER BY 
  arrival_date_year,
  CASE arrival_date_month
    WHEN 'January' THEN 1 WHEN 'February' THEN 2 WHEN 'March' THEN 3
    WHEN 'April' THEN 4 WHEN 'May' THEN 5 WHEN 'June' THEN 6
    WHEN 'July' THEN 7 WHEN 'August' THEN 8 WHEN 'September' THEN 9
    WHEN 'October' THEN 10 WHEN 'November' THEN 11 WHEN 'December' THEN 12
  END,
  hotel;


-- Query 8: High-Risk Booking Segmentation
WITH risk_flags AS (
  SELECT
    *,
    CASE 
      WHEN lead_time > 180 THEN 'Very High Lead Time'
      WHEN lead_time > 90 THEN 'High Lead Time'
      ELSE 'Normal Lead Time'
    END AS lead_time_risk,
    
    CASE 
      WHEN deposit_type = 'No Deposit' THEN 'No Deposit'
      WHEN deposit_type = 'Non Refund' THEN 'Non Refundable'
      ELSE 'Refundable'
    END AS deposit_risk,
    
    CASE 
      WHEN previous_cancellations >= 1 THEN 'Has Previous Cancellations'
      ELSE 'No Previous Cancellations'
    END AS history_risk
  FROM hotel_bookings_cleaned
)
SELECT
  lead_time_risk,
  deposit_risk,
  history_risk,
  COUNT(*) AS total_bookings,
  SUM(is_canceled) AS cancellations,
  ROUND(SUM(is_canceled) * 100.0 / COUNT(*), 2) AS cancellation_rate_pct,
  ROUND(AVG(adr), 2) AS avg_adr
FROM risk_flags
GROUP BY lead_time_risk, deposit_risk, history_risk
ORDER BY cancellation_rate_pct DESC;
