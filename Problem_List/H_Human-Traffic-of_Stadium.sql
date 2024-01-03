# Write your MySQL query statement below
WITH consecutive_people AS (
    SELECT
        *,
        IF(LAG(people, 1) OVER (ORDER BY id) >= 100, 1, 0) AS prev_1_people,
        IF(LAG(people, 2) OVER (ORDER BY id) >= 100, 1, 0)  AS prev_2_people,
        IF(LEAD(people, 1) OVER (ORDER BY id) >= 100, 1, 0)  AS next_1_people,
        IF(LEAD(people, 2) OVER (ORDER BY id) >= 100, 1, 0)  AS next_2_people
    FROM
        Stadium
)
SELECT
    id, visit_date, people
FROM
    consecutive_people
WHERE
    people >= 100
    AND(
        (prev_1_people AND prev_2_people)
        OR
        (prev_1_people AND next_1_people)
        OR
        (next_1_people AND next_2_people)
    )
