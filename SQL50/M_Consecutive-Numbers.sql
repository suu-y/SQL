# Write your MySQL query statement below
WITH Sorted_t1 AS(
    SELECT
        id AS t1_id,
        num AS t1_num
    FROM
        Logs
    ORDER BY
        t1_num, t1_id
), Sorted_t2 AS(
    SELECT
        t1.t1_id,
        t1.t1_num,
        Logs.id AS t2_id,
        Logs.num AS t2_num
    FROM
        Sorted_t1 t1
        LEFT OUTER JOIN Logs
            ON(
                t1.t1_num = Logs.num
                AND
                t1.t1_id + 1 = Logs.id
            )
),  Sorted_t3 AS(
    SELECT
        t2.t1_id,
        t2.t1_num,
        t2.t2_id,
        t2.t2_num,
        Logs.id AS t3_id,
        Logs.num AS t3_num
    FROM
        Sorted_t2 t2
        LEFT OUTER JOIN Logs
            ON(
                t2.t2_num = Logs.num
                AND
                t2.t2_id + 1 = Logs.id
            )
)
SELECT DISTINCT
    t3_num AS ConsecutiveNums
FROM
    Sorted_t3
WHERE
    t3_num IS NOT NULL