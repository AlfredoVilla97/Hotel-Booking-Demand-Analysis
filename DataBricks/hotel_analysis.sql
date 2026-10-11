
-- 1. Data Cleaning
-- Create cleaned table with proper data types and null handling

CREATE OR REPLACE TABLE hotel_bookings_cleaned AS
SELECT
  ...
FROM hotel_bookings_raw;


-- 2. Create Views for Power BI
CREATE OR REPLACE VIEW vw_hotel_bookings_main AS ...
CREATE OR REPLACE VIEW vw_monthly_summary AS ...


-- 3. Analysis Queries

-- Query 1: Overall KPIs
SELECT ...

-- Query 2: Cancellations by Hotel
SELECT ...

-- Query 3: Cancellations by Month
...

-- Query 4: Lead Time vs Cancellation Rate
...

-- Query 5: Market Segment Analysis
...

-- Query 6: Top 10 Countries
...

-- Query 7: Monthly Revenue with Window Function
...

-- Query 8: Risk Segmentation
...
