WITH sum_of_each_day AS (
    SELECT
        visited_on,
        SUM(amount) AS amount_a_day,
        RANK() OVER (ORDER BY visited_on) AS rnk 
    FROM
        Customer
    GROUP BY
        visited_on
    ORDER BY
        visited_on DESC
), week_amount AS(
    SELECT
        rnk,
        visited_on,
        SUM(amount_a_day) OVER (ORDER BY visited_on DESC ROWS BETWEEN CURRENT ROW AND 6 FOLLOWING) AS sum_week_amount,
        AVG(amount_a_day) OVER (ORDER BY visited_on DESC ROWS BETWEEN CURRENT ROW AND 6 FOLLOWING) AS average_week_amount
    FROM
        sum_of_each_day
    /*
    WHERE
        -- 起点の日から1週間後までのデータがある場合のみ集計
        rnk > 6
    */
    ORDER BY
        visited_on
)
/*
week_aountテーブル内でWHEREをかけると、WHEREがSELECTより先に実行されるため
Window関数のROWSが想定通り（1週間ごとに集計）に効かない
*/
SELECT
    visited_on,
    sum_week_amount AS amount,
    ROUND(average_week_amount, 2) as average_amount
FROM
    week_amount
WHERE
    rnk > 6