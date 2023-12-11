# Write your MySQL query statement below
WITH ordered_t AS(
    SELECT DISTINCT
        buyer_id,
        COUNT(*) OVER (PARTITION BY buyer_id) AS cnt
    FROM
        Orders
    WHERE
        order_date BETWEEN '2019-01-01' AND '2019-12-31'
)
SELECT
    Users.user_id AS buyer_id,
    Users.join_date,
    IFNULL(ordered_t.cnt, 0) AS orders_in_2019
FROM
    Users
    LEFT OUTER JOIN ordered_t
        ON Users.user_id = ordered_t.buyer_id