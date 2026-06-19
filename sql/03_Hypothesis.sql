-- H1: City Hotel reservations are cancelled more frequently
-- than Resort Hotel reservations

SELECT
    hotel,
    COUNT(*) AS bookings,
    SUM(is_canceled) AS cancellations,
    ROUND(100.0 * AVG(is_canceled),2) AS cancellation_rate
FROM hotel_bookings
GROUP BY hotel;
-- H2: City Hotel reservations are cancelled more frequently
-- than Resort Hotel reservations
SELECT
    CASE
        WHEN lead_time <= 30 THEN '0-30 days'
        WHEN lead_time <= 90 THEN '31-90 days'
        WHEN lead_time <= 180 THEN '91-180 days'
        ELSE '180+ days'
    END AS lead_time_group,
    COUNT(*) AS bookings,
    ROUND(100.0 * AVG(is_canceled),2) AS cancellation_rate
FROM hotel_bookings
GROUP BY lead_time_group
ORDER BY lead_time_group;

SELECT
    is_canceled,
    COUNT(*) AS bookings,
    ROUND(AVG(lead_time),2) AS avg_lead_time,
    ROUND(STDDEV(lead_time),2) AS std_lead_time
FROM hotel_bookings
GROUP BY is_canceled;
