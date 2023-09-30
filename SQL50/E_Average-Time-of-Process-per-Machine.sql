# Write your MySQL query statement below
WITH act_start AS(
    SELECT
        *
    FROM
        Activity a1
    WHERE
        a1.activity_type = 'start'
), act_end AS(
    SELECT
        *
    FROM
        Activity a2
    WHERE
        a2.activity_type = 'end'
)
SELECT
    act_start.machine_id,
    ROUND(AVG(act_end.timestamp - act_start.timestamp), 3) AS 'processing_time'
FROM
    act_start
    INNER JOIN act_end
        ON(
            act_start.machine_id = act_end.machine_id
            AND
            act_start.process_id = act_end.process_id
        )
GROUP BY
    act_start.machine_id