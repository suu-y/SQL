# Write your MySQL query statement below
WITH Single_num AS(
    SELECT
        num, COUNT(*) AS cnt
    FROM
        MyNumbers
    GROUP BY
        num
)
SELECT
    MAX(num) AS num
FROM
    Single_num
WHERE
    cnt = 1
