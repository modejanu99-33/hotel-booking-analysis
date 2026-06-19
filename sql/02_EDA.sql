-- EXPLORATORY DATA ANALYSIS

-- Hotel Distribution

SELECT
    hotel,
    COUNT(*) AS bookings
FROM hotel_bookings
GROUP BY hotel
ORDER BY bookings DESC;

-- Overall Cancellation Rate

SELECT
    COUNT(*) AS bookings,
    SUM(is_canceled) AS cancellations,
    ROUND(100.0 * AVG(is_canceled),2) AS cancellation_rate
FROM hotel_bookings;

-- Customer Type Distribution

SELECT
    customer_type,
    COUNT(*) AS bookings
FROM hotel_bookings
GROUP BY customer_type
ORDER BY bookings DESC;

-- Top 10 Countries

SELECT
    country,
    COUNT(*) AS bookings
FROM hotel_bookings
WHERE country IS NOT NULL
GROUP BY country
ORDER BY bookings DESC
LIMIT 10;

-- Deposit Type Distribution

SELECT
    deposit_type,
    COUNT(*) AS bookings
FROM hotel_bookings
GROUP BY deposit_type
ORDER BY bookings DESC;

-- Repeat Guest Distribution

SELECT
    is_repeated_guest,
    COUNT(*) AS bookings
FROM hotel_bookings
GROUP BY is_repeated_guest;

-- Lead Time Overview

SELECT
    MIN(lead_time),
    ROUND(AVG(lead_time),2),
    MAX(lead_time)
FROM hotel_bookings;

-- Length of Stay Overview

SELECT
    MIN(stays_in_week_nights + stays_in_weekend_nights) AS min_nights,
    ROUND(
        AVG(stays_in_week_nights + stays_in_weekend_nights),
        2
    ) AS avg_nights,
    MAX(stays_in_week_nights + stays_in_weekend_nights) AS max_nights
FROM hotel_bookings;

-- Previous Cancellations Overview

SELECT
    previous_cancellations,
    COUNT(*) AS bookings
FROM hotel_bookings
GROUP BY previous_cancellations
ORDER BY previous_cancellations;

-- Parking Requirement Distribution

SELECT
    required_car_parking_spaces,
    COUNT(*) AS bookings
FROM hotel_bookings
GROUP BY required_car_parking_spaces
ORDER BY required_car_parking_spaces;
