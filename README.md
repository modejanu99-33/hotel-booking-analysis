# Hotel Booking Analysis

## Project Overview

This project analyzes hotel booking data using PostgreSQL and statistical analysis techniques.

The dataset contains booking information from both City Hotels and Resort Hotels. The goal of this project is to identify booking patterns, investigate reservation cancellation behavior, detect anomalies, and uncover factors associated with higher cancellation rates.

---

## Objectives

- Explore the structure and quality of the dataset.
- Analyze booking patterns across hotel types, countries, and customer segments.
- Investigate reservation cancellation behavior.
- Identify factors associated with higher cancellation rates.
- Test hypotheses related to booking cancellations.
- Provide data-driven insights and recommendations.

---

## Dataset

The dataset contains:

- 119,390 hotel bookings
- 32 variables
- Reservations from both City Hotels and Resort Hotels

---

## Tools Used

- SQL
- Statistical Analysis

---

# Data Understanding

## Dataset Overview

The dataset consists of 119,390 hotel reservations and 32 variables describing customer characteristics, booking details, hotel information, and reservation outcomes.

<details>
<summary>View SQL Query</summary>

```sql
SELECT COUNT(*) AS total_bookings
FROM hotel_bookings;
```

</details>

---


## Reservations Without Guests

A data quality check revealed 180 bookings where the number of adults, children, and babies was equal to zero.

Such observations are unlikely in real-world hotel reservations and were flagged as anomalies.

<details>
<summary>View SQL Query</summary>

```sql
SELECT COUNT(*)
FROM hotel_bookings
WHERE adults = 0
AND COALESCE(children,0) = 0
AND COALESCE(babies,0) = 0;
```

</details>

---

## Missing Values Investigation

Missing values were identified in four variables.

| Variable | Missing Values |
|----------|---------------:|
| company | 112593 |
| agent | 16340 |
| country | 488 |
| children | 4 |

The `company` variable contains missing values in more than 94% of all observations and was excluded from further analysis.

The `agent` variable also contains a substantial number of missing values. Missing values in `country` and `children` represent only a small fraction of the dataset and are unlikely to significantly affect the analysis.

<details>
<summary>View SQL Query</summary>

```sql
SELECT
    COUNT(*) FILTER (WHERE company IS NULL) AS missing_company,
    COUNT(*) FILTER (WHERE agent IS NULL) AS missing_agent,
    COUNT(*) FILTER (WHERE country IS NULL) AS missing_country,
    COUNT(*) FILTER (WHERE children IS NULL) AS missing_children
FROM hotel_bookings;
```

</details>

---

## Lead Time Analysis

The maximum lead time observed in the dataset was 737 days, indicating that some reservations were made approximately two years before arrival.

<details>
<summary>View SQL Query</summary>

```sql
SELECT MAX(lead_time)
FROM hotel_bookings;
```

</details>

---

## ADR Outlier Detection

ADR (Average Daily Rate) was analyzed to identify extreme values.

Key findings:

- Average ADR = 101.83
- 99th percentile ADR = 252
- Maximum ADR = 5400

The maximum ADR value is substantially larger than the typical booking rates observed in the dataset and was flagged as a potential outlier.

<details>
<summary>View SQL Queries</summary>

```sql
SELECT
    AVG(adr) AS avg_adr,
    MAX(adr) AS max_adr
FROM hotel_bookings;

SELECT
    PERCENTILE_CONT(0.99)
    WITHIN GROUP (ORDER BY adr)
FROM hotel_bookings;
```

</details>

# Exploratory Data Analysis

## Hotel Distribution

The dataset contains reservations from two hotel types.

| Hotel | Bookings |
|---------|---------:|
| City Hotel | 79,330 |
| Resort Hotel | 40,060 |

City Hotels account for approximately two-thirds of all reservations in the dataset.

<details>
<summary>View SQL Query</summary>

```sql
SELECT
    hotel,
    COUNT(*) AS bookings
FROM hotel_bookings
GROUP BY hotel
ORDER BY bookings DESC;
```

</details>

---

## Overall Cancellation Rate

A total of 44,224 reservations were cancelled.

| Metric | Value |
|---------|---------:|
| Total Bookings | 119,390 |
| Cancelled Bookings | 44,224 |
| Cancellation Rate | 37.04% |

More than one-third of all reservations were cancelled.

<details>
<summary>View SQL Query</summary>

```sql
SELECT
    COUNT(*) AS bookings,
    SUM(is_canceled) AS cancellations,
    ROUND(100.0 * AVG(is_canceled),2) AS cancellation_rate
FROM hotel_bookings;
```

</details>

---

## Customer Type Distribution

Transient customers dominate the dataset.

| Customer Type | Bookings |
|---------|---------:|
| Transient | 89,613 |
| Transient-Party | 25,124 |
| Contract | 4,076 |
| Group | 577 |

Approximately 75% of all bookings belong to transient customers.

---

## Top Booking Countries

The majority of reservations originate from European countries.

| Country | Bookings |
|---------|---------:|
| PRT | 48,590 |
| GBR | 12,129 |
| FRA | 10,415 |
| ESP | 8,568 |
| DEU | 7,287 |

Portugal represents the largest share of reservations by a substantial margin.

---

## Deposit Type Distribution

Most reservations were made without a deposit.

| Deposit Type | Bookings |
|---------|---------:|
| No Deposit | 104,641 |
| Non Refund | 14,587 |
| Refundable | 162 |

---

## Repeat Guest Distribution

Only a small proportion of customers are repeat guests.

| Repeat Guest | Bookings |
|---------|---------:|
| No | 115,580 |
| Yes | 3,810 |

Repeat guests account for approximately 3.2% of all reservations.

---

## Lead Time Overview

| Metric | Days |
|---------|---------:|
| Minimum | 0 |
| Average | 104.01 |
| 95th Percentile | 320 |
| Maximum | 737 |

Reservations were typically made approximately 104 days before arrival.

While the maximum lead time reached 737 days, 95% of all reservations were made within 320 days of arrival. This indicates that extremely early bookings were rare and should be treated as outliers rather than representative customer behavior.

<details>
<summary>View SQL Queries</summary>

```sql
SELECT
    MIN(lead_time),
    ROUND(AVG(lead_time),2),
    MAX(lead_time)
FROM hotel_bookings;

SELECT
    PERCENTILE_CONT(0.99)
    WITHIN GROUP (ORDER BY lead_time)
FROM hotel_bookings;
```

</details>
## Length of Stay Overview

| Metric | Nights |
|---------|---------:|
| Minimum | 0 |
| Average | 3.43 |
| 99th Percentile | 14 |
| Maximum | 69 |

While the longest recorded stay lasted 69 nights, 99% of all reservations were 14 nights or shorter. This indicates that extremely long stays are rare outliers and do not represent typical customer behavior.

<details>
<summary>View SQL Queries</summary>

```sql
SELECT
    MIN(stays_in_week_nights + stays_in_weekend_nights) AS min_nights,
    ROUND(
        AVG(stays_in_week_nights + stays_in_weekend_nights),
        2
    ) AS avg_nights,
    MAX(stays_in_week_nights + stays_in_weekend_nights) AS max_nights
FROM hotel_bookings;

SELECT
    PERCENTILE_CONT(0.99)
    WITHIN GROUP (
        ORDER BY stays_in_week_nights + stays_in_weekend_nights
    ) AS stay_99th_percentile
FROM hotel_bookings;
```

</details>

# Hypothesis Testing

*Work in progress.*

# Conclusions

*Work in progress.*
