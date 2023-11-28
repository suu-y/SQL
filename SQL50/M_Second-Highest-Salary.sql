# Write your MySQL query statement below
WITH rank_t AS(
    SELECT
        salary,
        DENSE_RANK() OVER (ORDER BY salary DESC) AS rnk
    FROM
        Employee
)
SELECT
    CASE WHEN(COUNT(*) < 2) THEN null
        ELSE (
            SELECT DISTINCT
                salary
            FROM
                rank_t
            WHERE
                rnk = 2
        ) END AS SecondHighestSalary
FROM
    rank_t
