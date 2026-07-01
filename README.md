# 🏨 Hotel Booking Reliability & Cancellation Analysis

> **End-to-End Data Analytics Project using SQL, Python, Machine Learning and Power BI**

---

# 📖 Introduction

Hotel booking cancellations represent one of the biggest operational challenges in the hospitality industry. Unexpected cancellations reduce occupancy, impact revenue forecasting, complicate staff planning, and limit opportunities to resell available rooms.

This project investigates hotel booking behaviour using historical reservation data from **City Hotel** and **Resort Hotel**. The objective is to identify the factors associated with booking cancellations, evaluate customer reliability, and transform analytical findings into practical business recommendations.

To achieve this, the project combines **SQL**, **Python**, **Machine Learning**, and **Power BI** to perform exploratory data analysis, answer business questions, develop predictive models, and create an interactive executive dashboard.

A key contribution of this project is the development of the **Machine Learning Booking Reliability Index (ML-BRI)**, a scoring system that converts cancellation probabilities into an interpretable reliability score ranging from **0 to 100**, allowing hotels to identify both high-risk and highly reliable reservations.

'''
## 📑 Table of Contents

- 📖 Introduction
- 🎯 Project Objectives
- 🛠️ Technology Stack
- 🧹 Data Cleaning
- 📊 Exploratory Data Analysis
- 📈 Executive Dashboard
- ❓ Business Questions
- 🤖 Machine Learning
- ⭐ ML Booking Reliability Index
- 🔍 Sensitivity Analysis
- 💡 Business Recommendations


# 🛠️ Technology Stack

| Technology | Purpose |
|------------|----------|
| 🐍 Python | Data Cleaning, EDA & Machine Learning |
| 🗄️ SQL Server | Business Analysis |
| 📊 Power BI | Interactive Dashboard |
| 🐼 Pandas | Data Manipulation |
| 📈 Matplotlib | Data Visualisation |
| 🤖 Scikit-learn | Logistic Regression |
| 📓 Jupyter Notebook | Analysis Environment |

---

# 🧹 Data Cleaning

<img width="1466" height="980" alt="Data cleaning" src="https://github.com/user-attachments/assets/7c4e570f-5494-424e-b036-d7deed965066" />


# 📊 Exploratory Data Analysis (EDA)

Before investigating specific business questions, an exploratory data analysis (EDA) was conducted to understand the overall structure of the dataset and identify potential booking patterns.

The EDA explored booking behaviour, reservation outcomes, pricing, customer characteristics, and relationships between variables. These observations served as the foundation for the SQL analysis and Machine Learning models developed later in the project.

The most important findings are summarised below.

---
<img width="720" height="450" alt="EDA 1" src="https://github.com/user-attachments/assets/bdf219df-4924-4e4c-b064-f02925716163" />


### 🏨 Hotel Booking Distribution

City Hotels account for the majority of reservations in the dataset, representing approximately two-thirds of all bookings. This imbalance highlights the importance of analysing cancellation behaviour separately for different hotel types.

<img width="727" height="480" alt="EDA 2" src="https://github.com/user-attachments/assets/3f8bb576-17c0-45b8-b996-068b102a98f9" />

### 📉 Reservation Status

Most reservations resulted in successful check-outs; however, more than one-third of all bookings were cancelled. This confirms that booking cancellations represent a significant operational and financial challenge for hotels.

<img width="1007" height="477" alt="EDA 3" src="https://github.com/user-attachments/assets/3bba20e7-b547-49a7-8ff8-eac3abf7720c" />

### ⏳ Lead Time Distribution

Reservations range from same-day bookings to bookings made nearly two years in advance. The wide distribution suggests that booking lead time may play an important role in cancellation behaviour and deserves further investigation.

<img width="1372" height="987" alt="EDA 4" src="https://github.com/user-attachments/assets/54e175b3-c96a-4787-baba-787025286108" />

### 🔗 Correlation Matrix

Most numerical variables exhibit relatively weak linear correlations. Nevertheless, several behavioural features show meaningful relationships with booking cancellations, supporting their inclusion in the Machine Learning model.

---

The exploratory analysis provided an initial understanding of booking behaviour and highlighted several potential risk factors.

The following section investigates these observations through SQL-based business questions and interactive Power BI visualisations.


# 📈 Executive Dashboard
<img width="1427" height="800" alt="Ex  Dashboard" src="https://github.com/user-attachments/assets/1f2d23b6-890a-4cd5-8bf1-40759a815526" />


<details>
<summary><b>📖 Click to view dashboard insights</b></summary>

### Dashboard Highlights

- 📚 119K hotel bookings analysed
- ❌ 37.3% cancellation rate
- 💶 €42.71M potential revenue
- 📉 €16.72M potential revenue loss
- 💰 €102.5 average ADR

### Key Insights

- 🌐 Online TA generated the highest revenue loss.
- 🏨 City Hotels experienced significantly higher cancellation rates.
- 📅 Booking demand and cancellations peak during summer.
- 💼 Nearly 40% of potential revenue is affected by cancellations.

</details>

---

# ❓ Business Question 1

## Which booking window should the hotel prioritise to reduce cancellation losses?
<img width="657" height="392" alt="Booking window, cancl rate" src="https://github.com/user-attachments/assets/ea5bd450-cfa5-4d54-8920-93a08df157bc" />


<details>
<summary><b>📖 Click to view SQL findings</b></summary>

### 🔍 SQL Findings

The SQL analysis revealed a clear relationship between booking lead time and cancellation behaviour.

| Booking Window | Cancellation Rate |
|---------------|------------------:|
| 0–7 Days | **9.7%** |
| 8–30 Days | **28.0%** |
| 31–90 Days | **37.8%** |
| 91–180 Days | **44.8%** |
| 180+ Days | **57.1%** |

Cancellation rates increase consistently as the booking window becomes longer, with reservations made more than **180 days** before arrival representing the highest-risk group.

### 🎯 Why it matters

Guests who book far in advance have more time to change their travel plans, increasing the likelihood of cancellation.

Understanding this pattern allows hotels to identify high-risk reservations early and supports the development of targeted strategies to reduce future cancellation losses.

</details>

---

# ❓ Business Question 2

## Do special requests indicate stronger booking commitment?
<img width="682" height="397" alt="special req, canc" src="https://github.com/user-attachments/assets/462e0e8e-7337-4676-a1c1-5a57edd60124" />


<details>
<summary><b>📖 Click to view SQL findings</b></summary>

### 🔍 SQL Findings

The SQL analysis identified a strong inverse relationship between the number of special requests and booking cancellations.

| Special Requests | Cancellation Rate |
|-----------------:|------------------:|
| 0 | **48.0%** |
| 1 | **22.1%** |
| 2 | **22.2%** |
| 3 | **17.9%** |
| 4 | **10.6%** |
| 5 | **5.0%** |

Guests who made **no special requests** had the highest cancellation rate. As the number of special requests increased, cancellation rates decreased substantially.

### 🎯 Why it matters

Special requests appear to reflect genuine booking intent rather than casual reservations.

Guests who actively personalise their stay are more likely to complete their reservation, making special requests a valuable behavioural indicator of booking reliability.

</details>

---
# ❓ Business Question 3

## Are repeat guests more reliable than first-time guests?

<img width="1402" height="791" alt="repeat customer" src="https://github.com/user-attachments/assets/595fb581-c681-4a59-9fbb-d44193fe917d" />


<details>
<summary><b>📖 Click to view SQL findings</b></summary>

### 🔍 SQL Findings

Repeat guests account for only **2.95%** of all bookings but demonstrate substantially higher booking reliability than first-time guests.

| Customer Type | Cancellation Rate |
|--------------|------------------:|
| First-time Guest | **37.9%** |
| Repeat Guest | **15.7%** |

Although repeat guests generate a lower average daily rate (**€70.19** vs **€103.46**), they cancel reservations far less frequently.

### 🎯 Why it matters

Customer loyalty appears to reduce booking uncertainty.

While repeat guests contribute a smaller share of total bookings, their significantly lower cancellation rate makes them a valuable customer segment for improving occupancy stability and reducing cancellation-related losses.

> 🤖 **Machine Learning Validation:** Logistic Regression also identified **Repeat Guests** as one of the strongest predictors associated with lower cancellation risk.

</details>

---
