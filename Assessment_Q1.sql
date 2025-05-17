WITH
    CustomerPlanCounts AS (
        SELECT
            owner_id,
            SUM(
                CASE
                    WHEN is_regular_savings = 1 THEN 1
                    ELSE 0
                END
            ) AS savings_count,
            SUM(
                CASE
                    WHEN is_a_fund = 1 THEN 1
                    ELSE 0
                END
            ) AS investment_count
        FROM
            plans_plan
        WHERE
            is_regular_savings = 1
            OR is_a_fund = 1
        GROUP BY
            owner_id
        HAVING
            SUM(
                CASE
                    WHEN is_regular_savings = 1 THEN 1
                    ELSE 0
                END
            ) >= 1
            AND SUM(
                CASE
                    WHEN is_a_fund = 1 THEN 1
                    ELSE 0
                END
            ) >= 1
    ),
    CustomerTotalDeposits AS (
        SELECT
            pp.owner_id,
            SUM(sa.confirmed_amount) AS total_deposits
        FROM
            plans_plan pp
            JOIN savings_savingsaccount sa ON pp.id = sa.plan_id
        GROUP BY
            pp.owner_id
    )
SELECT
    u.id AS owner_id,
    CASE
        WHEN u.name IS NOT NULL
        AND TRIM(u.name) <> '' THEN u.name
        ELSE CONCAT (
            COALESCE(u.first_name, ''),
            ' ',
            COALESCE(u.last_name, '')
        )
    END AS name,
    cpc.savings_count,
    cpc.investment_count,
    ctd.total_deposits
FROM
    users_customuser u
    JOIN CustomerPlanCounts cpc ON u.id = cpc.owner_id
    JOIN CustomerTotalDeposits ctd ON u.id = ctd.owner_id
ORDER BY
    ctd.total_deposits DESC;