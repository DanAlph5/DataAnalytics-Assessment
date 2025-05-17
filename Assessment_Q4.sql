WITH
    CustomerTransactions AS (
        --  This CTE calculates the total number of transactions and total transaction value for each customer.
        SELECT
            owner_id,
            COUNT(*) AS total_transactions, -- Counts the total number of transactions
            SUM(confirmed_amount) AS total_transaction_value -- Sums the confirmed transaction amounts
        FROM
            savings_savingsaccount
        GROUP BY
            owner_id -- Groups the results by customer ID
    )
SELECT
    u.id AS customer_id, -- Selects the customer ID
    CASE
        WHEN u.name IS NOT NULL
        AND TRIM(u.name) <> '' THEN u.name
        ELSE CONCAT (
            COALESCE(u.first_name, ''),
            ' ',
            COALESCE(u.last_name, '')
        )
    END AS name, -- Selects the customer name, handling null or empty names
    TIMESTAMPDIFF (MONTH, u.date_joined, CURDATE ()) AS tenure_months, -- Calculates customer tenure in months
    COALESCE(ct.total_transactions, 0) AS total_transactions, -- Retrieves total transactions from CTE, defaults to 0 if null
    ROUND(
        (
            COALESCE(ct.total_transactions, 0) / NULLIF(
                TIMESTAMPDIFF (MONTH, u.date_joined, CURDATE ()),
                0
            )
        ) * 12 * (COALESCE(ct.total_transaction_value, 0) * 0.001),
        2
    ) AS estimated_clv -- Calculates the estimated CLV, handling potential division by zero
FROM
    users_customuser u
    LEFT JOIN CustomerTransactions ct ON u.id = ct.owner_id -- Joins with the CustomerTransactions CTE
ORDER BY
    estimated_clv DESC;

-- Orders the results by estimated CLV in descending order