USE HotelBookingDB;
GO

/*=============================================================

                HOTEL BOOKING BUSINESS ANALYSIS

File: 04_business_analysis.sql

Description:
Business-oriented SQL analysis of the Hotel Booking dataset.

The objective is to identify opportunities to reduce
cancellations, minimize revenue loss, and improve booking
performance using data-driven insights.

=============================================================*/



/*=============================================================

Business Objective

Reduce cancellation losses by identifying the booking windows
that create the greatest financial risk.

-------------------------------------------------------------

Business Question

Which booking window should the hotel prioritise to reduce
cancellation losses?

=============================================================*/

SELECT
    CASE
        WHEN lead_time <= 7 THEN '0-7 days'
        WHEN lead_time <= 30 THEN '8-30 days'
        WHEN lead_time <= 90 THEN '31-90 days'
        WHEN lead_time <= 180 THEN '91-180 days'
        ELSE '180+ days'
    END AS booking_window,

    COUNT(*) AS total_bookings,

    SUM(
        CASE
            WHEN is_canceled = 1 THEN 1
            ELSE 0
        END
    ) AS canceled_bookings,

    ROUND(
        AVG(CAST(is_canceled AS FLOAT)) * 100,
        2
    ) AS cancellation_rate,

    ROUND(
        SUM(
            adr * (
                stays_in_weekend_nights +
                stays_in_week_nights
            )
        ),
        2
    ) AS potential_revenue,

    ROUND(
        SUM(
            CASE
                WHEN is_canceled = 1 THEN
                    adr * (
                        stays_in_weekend_nights +
                        stays_in_week_nights
                    )
                ELSE 0
            END
        ),
        2
    ) AS potential_revenue_lost

FROM hotel_bookings

GROUP BY
    CASE
        WHEN lead_time <= 7 THEN '0-7 days'
        WHEN lead_time <= 30 THEN '8-30 days'
        WHEN lead_time <= 90 THEN '31-90 days'
        WHEN lead_time <= 180 THEN '91-180 days'
        ELSE '180+ days'
    END

ORDER BY
    MIN(lead_time);


/*-------------------------------------------------------------

Business Insight

Reservations made 91–180 days before arrival generated the
highest potential revenue loss, while reservations made more
than 180 days in advance recorded the highest cancellation
rate.

Long lead-time bookings therefore represent the greatest
financial risk and should be the primary focus when developing
strategies to reduce cancellation losses.

-------------------------------------------------------------*/
/*-------------------------------------------------------------

Business Objective

Reduce cancellation-related revenue loss by identifying which
distribution channels generate the highest financial risk and
the greatest impact on hotel revenue.

-------------------------------------------------------------

Business Question

Which distribution channels should the hotel prioritise to
reduce cancellation losses and improve booking reliability?

=============================================================*/

SELECT
    distribution_channel,

    COUNT(*) AS total_bookings,

    SUM(
        CASE
            WHEN is_canceled = 1 THEN 1
            ELSE 0
        END
    ) AS canceled_bookings,

    ROUND(
        AVG(CAST(is_canceled AS FLOAT)) * 100,
        2
    ) AS cancellation_rate,

    ROUND(
        AVG(CAST(adr AS FLOAT)),
        2
    ) AS avg_adr,

    ROUND(
        AVG(CAST(lead_time AS FLOAT)),
        1
    ) AS avg_lead_time,

    ROUND(
        AVG(
            CAST(
                stays_in_weekend_nights +
                stays_in_week_nights AS FLOAT
            )
        ),
        2
    ) AS avg_length_of_stay,

    ROUND(
        SUM(
            adr * (
                stays_in_weekend_nights +
                stays_in_week_nights
            )
        ),
        2
    ) AS potential_revenue,

    ROUND(
        SUM(
            CASE
                WHEN is_canceled = 1 THEN
                    adr * (
                        stays_in_weekend_nights +
                        stays_in_week_nights
                    )
                ELSE 0
            END
        ),
        2
    ) AS potential_revenue_lost

FROM hotel_bookings

GROUP BY
    distribution_channel

ORDER BY
    potential_revenue_lost DESC;


/*-------------------------------------------------------------

Business Insight

TA/TO generated the highest potential revenue loss (€15.28M),
accounting for the majority of hotel bookings while also
recording the highest cancellation rate (41.22%) and the
longest average lead time (115.6 days).

In contrast, Direct bookings achieved a significantly lower
cancellation rate (17.65%) while maintaining a higher average
daily rate than TA/TO bookings.

These findings suggest that increasing the share of Direct
bookings through loyalty programmes, exclusive offers, or
direct booking incentives could substantially reduce
cancellation-related revenue loss while maintaining strong
room revenue.

-------------------------------------------------------------*/

/*-------------------------------------------------------------

Business Question

Can special requests be used as an early indicator of
booking commitment?

-------------------------------------------------------------*/

SELECT
    total_of_special_requests,

    COUNT(*) AS total_bookings,

    SUM(
        CASE
            WHEN is_canceled = 1 THEN 1
            ELSE 0
        END
    ) AS canceled_bookings,

    ROUND(
        AVG(CAST(is_canceled AS FLOAT)) * 100,
        2
    ) AS cancellation_rate,

    ROUND(
        SUM(
            adr * (
                stays_in_weekend_nights +
                stays_in_week_nights
            )
        ),
        2
    ) AS potential_revenue

FROM hotel_bookings

GROUP BY
    total_of_special_requests

ORDER BY
    total_of_special_requests;

/*-------------------------------------------------------------

Business Insight

Reservations without special requests experienced the highest
cancellation rate (48%), while bookings with multiple special
requests showed substantially lower cancellation rates.

This suggests that special requests may serve as an early
indicator of guest commitment.

-------------------------------------------------------------*/

/*-------------------------------------------------------------

Business Question

Which market segments should be prioritised to minimise
revenue loss?

-------------------------------------------------------------*/

SELECT
    market_segment,

    COUNT(*) AS total_bookings,

    ROUND(
        SUM(
            adr * (
                stays_in_weekend_nights +
                stays_in_week_nights
            )
        ),
        2
    ) AS potential_revenue,

    ROUND(
        SUM(
            CASE
                WHEN is_canceled = 1 THEN
                    adr * (
                        stays_in_weekend_nights +
                        stays_in_week_nights
                    )
                ELSE 0
            END
        ),
        2
    ) AS potential_revenue_loss,

    ROUND(
        AVG(CAST(is_canceled AS FLOAT)) * 100,
        2
    ) AS cancellation_rate

FROM hotel_bookings

GROUP BY
    market_segment

ORDER BY
    potential_revenue_loss DESC;


/*-------------------------------------------------------------

Business Insight

Although the Groups segment recorded the highest cancellation
rate, the Online TA segment generated by far the greatest
potential revenue loss due to its significantly higher booking
volume.

These findings indicate that reducing cancellations within
the Online TA segment would likely have the greatest financial
impact.

-------------------------------------------------------------*/

/*-------------------------------------------------------------

Business Question

Do repeat guests generate enough business value to justify
greater investment in customer loyalty?

-------------------------------------------------------------*/

SELECT
    is_repeated_guest,

    COUNT(*) AS total_bookings,

    SUM(
        CASE
            WHEN is_canceled = 1 THEN 1
            ELSE 0
        END
    ) AS canceled_bookings,

    ROUND(
        AVG(CAST(is_canceled AS FLOAT)) * 100,
        2
    ) AS cancellation_rate,

    ROUND(
        AVG(adr),
        2
    ) AS average_adr,

    ROUND(
        AVG(
            stays_in_weekend_nights +
            stays_in_week_nights
        ),
        2
    ) AS average_length_of_stay

FROM hotel_bookings

GROUP BY
    is_repeated_guest;


/*-------------------------------------------------------------

Business Insight

Repeat guests recorded a substantially lower cancellation
rate (17.15% compared to 39.46% for first-time guests),
indicating more reliable bookings.

However, they also generated lower average booking value,
with lower ADR and shorter average stays.

Based on the available data, repeat guests improve booking
stability but do not necessarily generate higher booking
value. Additional business information, such as customer
lifetime value and loyalty programme costs, would be needed
to determine whether expanding loyalty initiatives would
provide a positive return on investment.

-------------------------------------------------------------*/

/*=============================================================

Business Objective

Identify high-risk booking profiles.

=============================================================*/


/*-------------------------------------------------------------

Business Question

Which combinations of booking window and market segment
result in the highest cancellation risk?

-------------------------------------------------------------*/

SELECT
    CASE
        WHEN lead_time <= 7 THEN '0-7 days'
        WHEN lead_time <= 30 THEN '8-30 days'
        WHEN lead_time <= 90 THEN '31-90 days'
        WHEN lead_time <= 180 THEN '91-180 days'
        ELSE '180+ days'
    END AS booking_window,

    market_segment,

    COUNT(*) AS total_bookings,

    SUM(
        CASE
            WHEN is_canceled = 1 THEN 1
            ELSE 0
        END
    ) AS canceled_bookings,

    ROUND(
        AVG(CAST(is_canceled AS FLOAT)) * 100,
        2
    ) AS cancellation_rate,

    ROUND(
        SUM(
            CASE
                WHEN is_canceled = 1
                THEN adr * (stays_in_weekend_nights + stays_in_week_nights)
                ELSE 0
            END
        ),
        2
    ) AS potential_revenue_loss

FROM hotel_bookings

GROUP BY
    CASE
        WHEN lead_time <= 7 THEN '0-7 days'
        WHEN lead_time <= 30 THEN '8-30 days'
        WHEN lead_time <= 90 THEN '31-90 days'
        WHEN lead_time <= 180 THEN '91-180 days'
        ELSE '180+ days'
    END,
    market_segment

HAVING COUNT(*) >= 100

ORDER BY
    cancellation_rate DESC,
    potential_revenue_loss DESC;


/*-------------------------------------------------------------

Business Insight

Group bookings made more than 180 days before arrival
recorded the highest cancellation rate (71.55%), followed by
Group bookings made 91–180 days in advance (63.72%).

Long lead-time Online TA bookings also showed consistently
high cancellation rates and contributed substantially to the
highest potential revenue loss.

These findings suggest that cancellation risk is driven not
only by booking window or market segment individually, but by
their combination. Focusing on these high-risk booking
profiles could help reduce cancellations and minimise
potential revenue loss.

-------------------------------------------------------------*/

/*=============================================================

Business Objective

Identify characteristics that define high-risk booking profiles.

=============================================================*/


/*-------------------------------------------------------------

Business Question

What characteristics define the hotel's highest-risk booking
profile?

-------------------------------------------------------------*/

SELECT
    CASE
        WHEN lead_time <= 30 THEN '0-30 days'
        WHEN lead_time <= 180 THEN '31-180 days'
        ELSE '180+ days'
    END AS booking_window,

    CASE
        WHEN is_repeated_guest = 1 THEN 'Repeat Guest'
        ELSE 'First-time Guest'
    END AS customer_type,

    CASE
        WHEN total_of_special_requests = 0 THEN 'No Special Requests'
        ELSE 'At Least 1 Special Request'
    END AS special_requests,

    COUNT(*) AS total_bookings,

    SUM(
        CASE
            WHEN is_canceled = 1 THEN 1
            ELSE 0
        END
    ) AS canceled_bookings,

    ROUND(
        AVG(CAST(is_canceled AS FLOAT)) * 100,
        2
    ) AS cancellation_rate,

    ROUND(
        SUM(
            CASE
                WHEN is_canceled = 1
                THEN adr * (stays_in_weekend_nights + stays_in_week_nights)
                ELSE 0
            END
        ),
        2
    ) AS potential_revenue_loss

FROM hotel_bookings

GROUP BY

    CASE
        WHEN lead_time <= 30 THEN '0-30 days'
        WHEN lead_time <= 180 THEN '31-180 days'
        ELSE '180+ days'
    END,

    CASE
        WHEN is_repeated_guest = 1 THEN 'Repeat Guest'
        ELSE 'First-time Guest'
    END,

    CASE
        WHEN total_of_special_requests = 0 THEN 'No Special Requests'
        ELSE 'At Least 1 Special Request'
    END

HAVING COUNT(*) >= 100

ORDER BY
    cancellation_rate DESC,
    total_bookings DESC;

/*-------------------------------------------------------------

Business Insight

The highest-risk booking profile consisted of first-time
guests who booked more than 180 days before arrival without
submitting any special requests, resulting in a cancellation
rate of 69.39%.

Adding at least one special request substantially reduced
cancellation risk, even for bookings made well in advance.

These high-risk profiles were also associated with significant
potential revenue loss, highlighting the importance of
identifying them early.

-------------------------------------------------------------*/



/*=============================================================

Business Objective

Identify characteristics associated with reliable bookings.

=============================================================*/


/*-------------------------------------------------------------

Business Question

Are parking reservations associated with more reliable
bookings?

-------------------------------------------------------------*/

SELECT
    CASE
        WHEN required_car_parking_spaces > 0 THEN 'Parking Reserved'
        ELSE 'No Parking'
    END AS parking_status,

    COUNT(*) AS total_bookings,

    SUM(
        CASE
            WHEN is_canceled = 1 THEN 1
            ELSE 0
        END
    ) AS canceled_bookings,

    ROUND(
        AVG(CAST(is_canceled AS FLOAT)) * 100,
        2
    ) AS cancellation_rate,

    ROUND(
        AVG(adr),
        2
    ) AS average_adr

FROM hotel_bookings

GROUP BY
    CASE
        WHEN required_car_parking_spaces > 0 THEN 'Parking Reserved'
        ELSE 'No Parking'
    END

ORDER BY
    cancellation_rate;


/*-------------------------------------------------------------

Business Insight

Reservations that included a parking request recorded no
cancellations in this dataset, while bookings without parking
requests had a cancellation rate of 39.73%.

Guests requesting parking also generated a higher average
daily rate (ADR = 113.47 vs. 101.75), indicating that these
reservations were both more reliable and more valuable.

Although parking reservations represent a relatively small
share of total bookings, they appear to be a strong indicator
of reliable bookings within this dataset.

-------------------------------------------------------------*/

/*-------------------------------------------------------------

Business Question

Do booking modifications and special requests indicate
stronger booking commitment?

-------------------------------------------------------------*/

SELECT

    CASE
        WHEN booking_changes = 0 THEN 'No Booking Changes'
        ELSE 'Booking Modified'
    END AS booking_changes,

    CASE
        WHEN total_of_special_requests = 0 THEN 'No Special Requests'
        ELSE 'At Least 1 Special Request'
    END AS special_requests,

    COUNT(*) AS total_bookings,

    SUM(
        CASE
            WHEN is_canceled = 1 THEN 1
            ELSE 0
        END
    ) AS canceled_bookings,

    ROUND(
        AVG(CAST(is_canceled AS FLOAT)) * 100,
        2
    ) AS cancellation_rate

FROM hotel_bookings

GROUP BY

    CASE
        WHEN booking_changes = 0 THEN 'No Booking Changes'
        ELSE 'Booking Modified'
    END,

    CASE
        WHEN total_of_special_requests = 0 THEN 'No Special Requests'
        ELSE 'At Least 1 Special Request'
    END

ORDER BY
    cancellation_rate;


/*-------------------------------------------------------------

Business Insight

Bookings that were modified by guests recorded substantially
lower cancellation rates than bookings that remained
unchanged. Likewise, reservations with at least one special
request were consistently more reliable than those without
any special requests.

The highest cancellation rate (53.17%) was observed among
bookings with no modifications and no special requests,
whereas modified bookings with at least one special request
recorded a cancellation rate of only 15.03%.

These findings suggest that guest engagement throughout the
booking process is strongly associated with booking
commitment and lower cancellation risk.

-------------------------------------------------------------*/
/*-------------------------------------------------------------

Business Objective

Reduce cancellation-related revenue loss by identifying the
combination of booking characteristics associated with the
highest cancellation risk.

-------------------------------------------------------------

Business Question

What characteristics define the hotel's highest-risk booking
profile?

=============================================================*/

SELECT

    CASE
        WHEN lead_time <= 30 THEN '0-30 days'
        WHEN lead_time <= 180 THEN '31-180 days'
        ELSE '180+ days'
    END AS booking_window,

    CASE
        WHEN is_repeated_guest = 1 THEN 'Repeat Guest'
        ELSE 'First-time Guest'
    END AS guest_type,

    CASE
        WHEN total_of_special_requests = 0 THEN 'No Special Requests'
        ELSE 'At Least 1 Special Request'
    END AS special_requests,

    distribution_channel,

    deposit_type,

    COUNT(*) AS total_bookings,

    SUM(
        CASE
            WHEN is_canceled = 1 THEN 1
            ELSE 0
        END
    ) AS canceled_bookings,

    ROUND(
        AVG(CAST(is_canceled AS FLOAT)) * 100,
        2
    ) AS cancellation_rate,

    ROUND(
        SUM(
            CASE
                WHEN is_canceled = 1 THEN
                    adr * (
                        stays_in_weekend_nights +
                        stays_in_week_nights
                    )
                ELSE 0
            END
        ),
        2
    ) AS potential_revenue_loss

FROM hotel_bookings

GROUP BY

    CASE
        WHEN lead_time <= 30 THEN '0-30 days'
        WHEN lead_time <= 180 THEN '31-180 days'
        ELSE '180+ days'
    END,

    CASE
        WHEN is_repeated_guest = 1 THEN 'Repeat Guest'
        ELSE 'First-time Guest'
    END,

    CASE
        WHEN total_of_special_requests = 0 THEN 'No Special Requests'
        ELSE 'At Least 1 Special Request'
    END,

    distribution_channel,

    deposit_type

HAVING COUNT(*) >= 100

ORDER BY
    cancellation_rate DESC,
    potential_revenue_loss DESC,
    total_bookings DESC;
/*-------------------------------------------------------------

Business Insight

Bookings with a Non Refund deposit policy consistently recorded
near-total cancellation rates, confirming that deposit policy
is one of the strongest indicators of cancellation behaviour.

Among standard (No Deposit) reservations, first-time guests
booking 31–180 days before arrival through TA/TO channels
without any special requests generated the greatest financial
risk, producing more than €4.2 million in potential revenue
loss while maintaining a cancellation rate above 43%.

These findings indicate that combining multiple booking
characteristics provides a more effective way to identify
high-risk reservations than analysing individual factors
independently
-------------------------------------------------------------*/

