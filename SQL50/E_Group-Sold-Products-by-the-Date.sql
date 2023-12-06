# Write your MySQL query statement below
WITH unique_t AS(
    SELECT DISTINCT
        Activities.*
    FROM
        Activities
)
SELECT
    sell_date,
    COUNT(*) AS num_sold,
    GROUP_CONCAT(product ORDER BY product) AS products
FROM
    unique_t
GROUP BY
    sell_date