# Write your MySQL query statement below
WITH freq_user AS(
    SELECT
        player_id,
        -- 真偽値を返す
        DATEDIFF(event_date, MIN(event_date) OVER(PARTITION BY player_id)) = 1
            AS consecutive
    FROM
        Activity
)
SELECT
    ROUND(SUM(consecutive) / COUNT(DISTINCT player_id), 2) AS fraction
FROM
    freq_user