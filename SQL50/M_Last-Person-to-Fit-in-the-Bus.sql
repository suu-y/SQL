# Write your MySQL query statement below
WITH orderd_t AS(
    SELECT
        turn, person_id, person_name, weight,
        weight + lag(weight, 1) over (ORDER BY turn) AS sum_rec
    FROM
        Queue
    ORDER BY
        turn
), calc_t AS(
    SELECT
        turn, person_id, person_name, weight, sum_rec,
        sum_rec 
        + (lag(sum_rec, 1) over (ORDER BY turn))
        - (lag(weight, 1) over (ORDER BY turn)) AS total
    FROM
        orderd_t
)
SELECT
    *
FROM
    calc_t
