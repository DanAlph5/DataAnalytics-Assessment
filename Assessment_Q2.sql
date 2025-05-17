WITH
    MonthlyTransactions AS (
        -- This CTE calculates the number of transactions per customer per month.
        SELECT
            owner_id,
            DATE_FORMAT (transaction_date, '%Y-%m') AS transaction_month, -- Extracts year and month from transaction_date
            COUNT(*) AS transaction_count -- Counts the number of transactions for each month
        FROM
            savings_savingsaccount
        GROUP BY
            owner_id,
            transaction_month -- Groups the results by customer and month
    ),
    AvgMonthlyTransactions AS (
        -- This CTE calculates the average number of transactions per month for each customer.
        SELECT
            owner_id,
            AVG(transaction_count) AS avg_transactions_per_month -- Calculates the average transaction count
        FROM
            MonthlyTransactions
        GROUP BY
            owner_id -- Groups the results by customer
    )
SELECT
    CASE
        WHEN amt.avg_transactions_per_month >= 10 THEN 'High Frequency'
        WHEN amt.avg_transactions_per_month >= 3
        AND amt.avg_transactions_per_month <= 9 THEN 'Medium Frequency'
        ELSE 'Low Frequency'
    END AS frequency_category, -- Categorizes customers based on average monthly transactions
    COUNT(DISTINCT u.id) AS customer_count, -- Counts the number of customers in each category
    AVG(amt.avg_transactions_per_month) AS avg_transactions_per_month -- Calculates the average transactions per month for each category
FROM
    AvgMonthlyTransactions amt
    JOIN users_customuser u ON amt.owner_id = u.id -- Joins with users_customuser to get customer information
GROUP BY
    frequency_category -- Groups the results by frequency category
ORDER BY
    CASE
        WHEN frequency_category = 'High Frequency' THEN 1
        WHEN frequency_category = 'Medium Frequency' THEN 2
        ELSE 3
    END;

-- Orders the results by frequency category (High, Medium, Low)