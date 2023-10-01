# Write your MySQL query statement below
WITH Action_cnt AS(
    SELECT
        user_id,
        SUM(CASE WHEN action = 'confirmed' THEN 1 ELSE 0 END) AS cnt_conf,
        SUM(CASE WHEN action = 'timeout' THEN 1 ELSE 0 END) AS cnt_tout
    FROM
        Confirmations
    GROUP BY
        user_id
)
SELECT DISTINCT
    Sups.user_id,
    ROUND(COALESCE((Action_cnt.cnt_conf / (Action_cnt.cnt_conf + Action_cnt.cnt_tout)), 0), 2) AS confirmation_rate
    -- こんなに関数が入れ子になってもいいの？
FROM
    Signups Sups
    LEFT OUTER JOIN Action_cnt
        ON Sups.user_id = Action_cnt.user_id
GROUP BY
    Sups.user_id
