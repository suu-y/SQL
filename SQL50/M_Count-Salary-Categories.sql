# Write your MySQL query statement below
WITH category_t AS (
    SELECT 'Low Salary' AS category
        UNION ALL
    SELECT 'Average Salary'
        UNION ALL
    SELECT 'High Salary'
), count_t AS(
    SELECT
        CASE
            WHEN income < 20000 THEN 'Low Salary'
            WHEN income BETWEEN 20000 AND 50000 THEN 'Average Salary'
            WHEN income > 50000 THEN 'High Salary'
        END AS category,
        COUNT(*) as cnt
    FROM
        Accounts
    GROUP BY
        category
)
SELECT
    category_t.category,
    IFNULL(count_t.cnt, 0) AS accounts_count
FROM
    category_t
    LEFT OUTER JOIN count_t
        ON category_t.category = count_t.category

