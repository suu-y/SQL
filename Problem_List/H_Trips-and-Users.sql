# Write your MySQL query statement below
WITH banned_user AS(
    SELECT
        users_id
    FROM
        Users
    WHERE
        banned = 'No'
), date_t AS(
    SELECT
        *
    FROM
        Trips
    WHERE
        Trips.request_at BETWEEN '2013-10-01' AND '2013-10-03'
)
    SELECT DISTINCT
        date_t.request_at AS 'Day',
        ROUND(SUM(IF(date_t.status LIKE 'cancelled%' AND date_t.client_id = banned_user.users_id, 1, 0)) OVER (PARTITION BY date_t.request_at)
            / SUM(IF(date_t.client_id = banned_user.users_id, 1, 0)) OVER (PARTITION BY date_t.request_at), 2) AS Cancellation
    FROM
        date_t
        LEFT OUTER JOIN banned_user
            ON(
                date_t.client_id = banned_user.users_id
                OR
                date_t.driver_id = banned_user.users_id
            )
        