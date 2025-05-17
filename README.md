# SQL Query Solutions for Business Analysis

This document outlines the SQL query solutions developed to address the business questions provided, along with the challenges encountered during the process and potential business decisions based on the findings.

## Business Questions Addressed

The following business questions were addressed through SQL queries:

1.  **High-Value Customers with Multiple Products:** Identifying customers who have both a savings and an investment plan.
2.  **Transaction Frequency Analysis:** Categorizing customers based on their average monthly transaction frequency.
3.  **Account Inactivity Alert:** Identifying active accounts with no inflow transactions for over one year.
4.  **Customer Lifetime Value (CLV) Estimation:** Estimating the CLV of each customer based on account tenure and transaction volume.

## Challenges Encountered

Several technical challenges were faced during the analysis few of which include:

* **Dump File Issues:** The provided dump file did not function as expected on a Windows environment. Upon successful loading into a MySQL database, only the `plans_plan` and `savings_savingsaccount` tables were visible. This necessitated commenting the constraint.
* **Missing `users_customuser` Table Constraints:** The `users_customuser` table initially threw an error related to a `tier_ID` constraint referencing a `user_tier` table, which was absent in the loaded database. To resolve this, the `tier_ID` constraint on the `users_customuser` table was commented.
* **Missing `withdrawals_withdrawalintent` Table:** The `withdrawals_withdrawalintent` table, wasn't present and was also commented to avoid error.
* **Time Zone Issues:** An error related to time zone settings was encountered during the database setup or data loading process. This issue was temporarily resolved by commenting out the problematic configuration because this will only be needed when inputting data into the database and not necessary for analysis.

## Potential Business Decisions Based on Findings

The insights gained from the SQL query results can inform several key business decisions:

**1. High-Value Customers with Multiple Products:**

* **Cross-Selling Opportunities:** The business can identify these high-value customers for targeted cross-selling campaigns, promoting additional products or services that align with their existing portfolio (e.g., offering premium investment advisory services to customers with both savings and investment accounts).
* **Loyalty Programs:** Implement tailored loyalty programs or exclusive benefits to retain and further engage these valuable customers.
* **Personalized Communication:** Develop personalized communication strategies to nurture these relationships and understand their evolving financial needs.

**2. Transaction Frequency Analysis:**

* **Customer Segmentation:** The categorization of customers into "High Frequency," "Medium Frequency," and "Low Frequency" segments allows for targeted marketing and communication strategies tailored to each group's engagement level.
* **Product Adoption Insights:** Analyze if certain product types or customer demographics are more associated with specific transaction frequencies, providing insights into product adoption and usage patterns.
* **Engagement Campaigns:** Develop campaigns to encourage higher transaction frequency among "Low Frequency" customers, potentially through incentives or highlighting the benefits of more frequent engagement.

**3. Account Inactivity Alert:**

* **Customer Retention Efforts:** Identify and proactively reach out to customers with inactive accounts to understand the reasons for inactivity and implement strategies to re-engage them (e.g., personalized offers, reminders of account benefits, surveys to gather feedback).
* **Risk Assessment:** Analyze the characteristics of inactive accounts to identify potential risks, such as account closures or customer attrition.
* **Resource Optimization:** Determine if resources are being allocated to maintain a large number of truly dormant accounts and explore potential optimization strategies.

**4. Customer Lifetime Value (CLV) Estimation:**

* **Customer Prioritization:** Focus marketing and sales efforts on customers with the highest estimated CLV to maximize long-term profitability.
* **Targeted Acquisition:** Refine customer acquisition strategies to attract individuals with characteristics similar to high-CLV customers.
* **Retention Strategies:** Implement targeted retention programs for high-CLV customers to minimize churn and maximize their lifetime value.
* **Personalized Service:** Provide enhanced and personalized services to high-CLV customers to foster stronger relationships and increase their loyalty.

By leveraging the insights derived from these SQL queries, the Cowrywise can make data-driven decisions to improve customer engagement, optimize resource allocation, and ultimately drive growth and profitability.