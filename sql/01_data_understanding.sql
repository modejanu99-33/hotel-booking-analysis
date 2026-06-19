-- DATA UNDERSTANDING

-- Dataset Overview

SELECT COUNT(*) AS total_bookings
FROM hotel_bookings;

-- Hotel Distribution

SELECT
    hotel,
    COUNT(*) AS bookings
FROM hotel_bookings
GROUP BY hotel;

-- Data Quality Check

SELECT COUNT(*) AS bookings_without_guests
FROM hotel_bookings
WHERE adults = 0
AND COALESCE(children,0) = 0
AND COALESCE(babies,0) = 0;

-- Missing Values Summary

SELECT
    COUNT(*) FILTER (WHERE company IS NULL) AS missing_company,
    COUNT(*) FILTER (WHERE agent IS NULL) AS missing_agent,
    COUNT(*) FILTER (WHERE country IS NULL) AS missing_country,
    COUNT(*) FILTER (WHERE children IS NULL) AS missing_children
FROM hotel_bookings;

-- Outlier Detection

SELECT MAX(lead_time) AS max_lead_time
FROM hotel_bookings;

SELECT
    AVG(adr) AS avg_adr,
    MAX(adr) AS max_adr
FROM hotel_bookings;

SELECT
    PERCENTILE_CONT(0.99)
    WITHIN GROUP (ORDER BY adr) AS adr_99th_percentile
FROM hotel_bookings;
