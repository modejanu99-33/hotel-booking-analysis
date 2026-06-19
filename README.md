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

---

# Exploratory Data Analysis

*Work in progress.*

---

# Hypothesis Testing

*Work in progress.*

---

# Conclusions

*Work in progress.*
