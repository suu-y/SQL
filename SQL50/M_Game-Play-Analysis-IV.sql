-- まだ解けていない
# Write your MySQL query statement below
WITH user_freq AS (
    SELECT DISTINCT
        a1.player_id AS pid,
        MIN(a1.event_date) AS first_login
    FROM
        Activity a1
        INNER JOIN Activity a2
            ON a1.player_id = a2.player_id
    WHERE
        DATEDIFF(a2.event_date, a1.event_date) = 1
    GROUP BY
        a1.player_id
)
SELECT
    *,
    ROUND(
    COUNT(DISTINCT CASE WHEN first_login IS NOT NULL THEN a3.player_id END) /
    COUNT(DISTINCT a3.player_id), 2
    ) AS fraction
FROM
    Activity a3
    LEFT OUTER JOIN
        user_freq
        ON (
            a3.player_id = user_freq.pid
            AND
            a3.event_date = user_freq.first_login
        )