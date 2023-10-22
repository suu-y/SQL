# Write your MySQL query statement below
WITH RECURSIVE cte AS (
    SELECT
        turn,
        person_id,
        person_name,
        weight,
        weight AS sum_rec
    FROM
        Queue
    WHERE
        turn = 1
    UNION ALL
    SELECT
        t.turn,
        t.person_id,
        t.person_name,
        t.weight,
        t.weight + c.sum_rec AS sum_rec
    FROM
        Queue t
    INNER JOIN
        cte c
        ON t.turn = c.turn + 1
)
SELECT
    person_name AS person_name
FROM
    cte
WHERE
    sum_rec <= 1000
ORDER BY
    sum_rec DESC
LIMIT
    1
