# EdTech Analytics Case: Course Renewal and Student Segmentation

## Overview
This project is an end-to-end analytics case for an EdTech product.  
The project includes SQL data extraction, Python-based preprocessing and validation, student wave segmentation, and a BI dashboard for tracking course renewals and identifying students for retention actions.

The goal was to:
- extract and prepare student-course data with SQL,
- validate and preprocess the dataset in Python,
- segment students into enrollment waves,
- build a dashboard for monitoring course renewals and identifying students for retention actions.

## Context
This project focuses on annual school courses related to Russian standardized exams:
- **EGE (ЕГЭ)** — Unified State Exam
- **OGE (ОГЭ)** — Basic State Exam

## Business goal
The dashboard should help answer two main questions:
1. Which courses have the best and worst renewal performance?
2. Which active students did not renew a selected course month and may require follow-up?

## Tasks completed
### 1. SQL data extraction
Prepared an SQL script to extract annual-course students (EGE / OGE) with the required fields:
- course ID and title,
- subject and subject type,
- course type,
- course start date,
- student ID, last name, city,
- active / not expelled flag,
- course open date,
- number of full months opened,
- number of submitted homework assignments.

The SQL part was implemented based on:
- the provided database schema (`db_schema.jpg`),
- the helper Python script (`script_db.py`) used to simulate querying the database.

## Data quality notes
Some text fields in the source data contain Russian-language values and mixed scripts (Cyrillic and Latin). This specifically applies to:

- `users.last_name`
- `courses.name`
- `lessons.topic`
- `cities.name`

These values were kept unchanged in their original form, since they are part of the source data and are not critical for the calculation logic.

### 2. Python data preprocessing
Validated and processed the dataset:
- checked duplicates,
- checked missing values,
- verified data types,
- searched for anomalies,
- performed preprocessing where needed,
- created student wave segmentation.

Wave logic:
- wave 0 — joined before or on course start date,
- wave 1 — joined within 1 week after start,
- wave 2 — joined within 1–2 weeks,
- wave 3 — joined within 2–3 weeks,
- wave 4 — joined within 3–4 weeks,
- wave 5 — joined after 4 weeks.

### 3. Dashboard
Built a dashboard to:
- compare courses by renewal count and renewal rate for a selected month,
- provide detailed student-level information for a selected course, including:
  - student’s course,
  - student’s wave within the course,
  - number of submitted homework assignments on the course,
  - city,
  - activity / expulsion status,
  - renewal status for the selected month,
- filter students who:
  - are not expelled,
  - belong to selected courses,
  - belong to selected waves,
  - are from selected cities,
  - did not renew in a selected month,
  - have homework submissions below a selected threshold.

## Deliverables
The final solution included:
- an SQL script in `.sql` format with explanatory comments,
- a Jupyter Notebook in `.ipynb` format with preprocessing, validation, and wave segmentation,
- a public Yandex DataLens dashboard,
- calculation logic for dashboard metrics with comments.
