# Write your MySQL query statement below
WITH Member_cnt AS(
    SELECT
        COUNT(*) AS num_of_mem
    FROM
        Users
)
SELECT
    contest_id,
    ROUND((COUNT(*) / Member_cnt.num_of_mem) * 100, 2) AS percentage 
FROM
    Register
    CROSS JOIN Member_cnt
GROUP BY
    contest_id
ORDER BY
    percentage DESC,
    contest_id