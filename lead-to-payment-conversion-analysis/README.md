# Lead-to-Payment Conversion Analysis

## Overview
This project is an end-to-end analytics case focused on conversion from incoming applications to first payment.

The business process includes four funnel stages:
- application received,
- first operator call,
- trial lesson,
- first payment.

The main goal of the analysis is to identify factors that may influence conversion and formulate business hypotheses to improve the conversion from application to first payment.

## Main metric
**C1 conversion** $= \frac{number of first payments}{number of incoming applications}$

## Dataset
The dataset contains lead-level and process-level information, including:
- order_id                   
- source                     
- application_datetime       
- gender                     
- first_call                 
- first_reach                
- operator_group_type        
- operator_group_name        
- trial_appointment_datetime 
- appointment_added_by_id    
- is_paid                    

## Project tasks
### 1. Jupyter Notebook analysis
- load and inspect the data,
- perform initial exploratory analysis,
- investigate key metrics and dependencies,
- formulate and check hypotheses related to payment conversion,
- prepare business recommendations.

### 2. Dashboard in DataLens
- build a dashboard reflecting key funnel relationships and findings,
- visualize conversion drivers and bottlenecks,
- provide a public dashboard link.

## Analytical focus
The analysis is centered around questions such as:
- which factors are associated with higher application-to-payment conversion,
- whether response speed affects downstream conversion,
- whether conversion differs by source or operator group,
- whether trial lesson scheduling patterns are linked to payment probability,
- where the main funnel losses occur.

## Skills demonstrated
- funnel analysis
- conversion analysis
- exploratory data analysis
- hypothesis generation
- business recommendation writing
- dashboard development