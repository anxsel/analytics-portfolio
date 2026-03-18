# Hotel Booking Survey Analysis

A portfolio case study focused on customer survey analysis for a hotel booking service.

The project demonstrates how raw survey data can be transformed into structured analytical outputs using **Python**, **pandas**, and **Jupyter Notebook**.  
The analysis focuses on customer satisfaction segmentation, factor importance, and quarterly changes in perception across key service dimensions.

---

## Project goal

This project focuses on analyzing customer survey data for a hotel booking service with the following objectives:

- classify satisfaction scores into promoter, passive, and detractor groups;
- analyze quarterly changes in factor importance (important and critically_important);
- analyze quarterly changes in the distribution of promoters, passives, detractors, and missing responses for each factor.

---

## Dataset

The dataset contains customer survey responses, including:

- response creation date;
- service usage duration;
- overall satisfaction score;
- ratings for individual service factors;
- importance ratings for the same factors.

---

## Evaluated factors

The survey included the following evaluation criteria:

- **Website / app usability** — ease of booking, searching, and payment.
- **Processing speed** — speed of responses from customer support.
- **Variety of offers** — breadth of accommodation options and additional services.
- **Service quality** — staff politeness, competence, and support availability.
- **Price-to-quality ratio** — perceived fairness of pricing relative to service quality, including hidden fees or commissions.
- **Reviews and ratings convenience** — ease of accessing and using reviews and ratings from other users.
- **Quality and relevance of hotel information** — completeness, accuracy, and timeliness of hotel and room information.
- **Payment security** — protection of payment data and reliability of refund guarantees.
- **Booking cancellation / modification convenience** — ease, speed, and clarity of cancellation or booking changes, including refund terms.
---

## Tools used

- Python
- pandas
- Jupyter Notebook

Optional additions if used in your notebook:

- numpy
- matplotlib
- seaborn / plotly

---

## What was done

In this project I:

- Preprocessed survey data and mapped ratings to NPS categories (promoter / passive / detractor)
- Calculated overall NPS and segment distribution
- Analyzed NPS by factors to identify main drivers of dissatisfaction
- Computed factor importance based on “important” responses
- Performed quarterly comparison (2023Q3 vs 2023Q4)
- Built visualizations (NPS distribution, importance, dynamics)
- Identified key gaps between user expectations and product performance

---

## Analytical decisions

### 1. NPS segmentation logic

For the 10-point satisfaction scale, the following thresholds were used:

- **9–10** — Promoters
- **7–8** — Passives
- **0–6** — Detractors

This approach is consistent with the standard NPS logic adapted to the available scale.

### 2. Definition of important factors

A factor was considered **important** if the response was:

- **Important**
- **Critically important**

