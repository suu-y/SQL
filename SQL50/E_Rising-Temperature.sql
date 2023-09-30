# Write your MySQL query statement below
SELECT
    w1.id
FROM
    Weather w1
    LEFT OUTER JOIN Weather w2
        ON w1.recordDate = DATE_ADD(w2.recordDate, INTERVAL 1 DAY)
        -- w1のrecodeDateと、「+1日すれば同じになる」w2のrecodeDateを繋ぐ
WHERE
    w1.temperature > w2.temperature