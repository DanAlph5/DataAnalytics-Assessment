SELECT
    pp.id AS plan_id, -- Selects the plan ID
    pp.owner_id, -- Selects the owner ID
    CASE
        WHEN pp.is_regular_savings = 1 THEN 'Savings'
        WHEN pp.is_a_fund = 1 THEN 'Investment'
        ELSE 'Unknown'
    END AS type, -- Determines the plan type (Savings or Investment)
    MAX(sa.transaction_date) AS last_transaction_date, -- Finds the latest transaction date for each plan
    DATEDIFF (CURDATE (), MAX(sa.transaction_date)) AS inactivity_days -- Calculates the number of days since the last transaction
FROM
    plans_plan pp
    LEFT JOIN savings_savingsaccount sa ON pp.id = sa.plan_id -- Joins plans_plan and savings_savingsaccount tables
    AND sa.confirmed_amount > 0 --  Only considers transactions with confirmed amounts greater than 0 (inflow)
WHERE
    (
        pp.is_regular_savings = 1
        OR pp.is_a_fund = 1
    ) -- Filters for savings or investment plans
    AND sa.transaction_date IS NOT NULL -- Excludes plans with no transactions
GROUP BY
    pp.id,
    pp.owner_id -- Groups the results by plan ID and owner ID
HAVING
    DATEDIFF (CURDATE (), last_transaction_date) > 365;

-- Filters for plans with no transactions in the last 365 days