# Write your MySQL query statement below
-- 冗長なクエリになっている
WITH num_of_followers AS(
    SELECT DISTINCT
        requester_id,
        COUNT(requester_id) AS sum_of_followers
    FROM
        RequestAccepted
    GROUP BY
        requester_id
), num_of_followees AS(
    SELECT DISTINCT
        accepter_id,
        COUNT(accepter_id) AS sum_of_followees
    FROM
        RequestAccepted
    GROUP BY
        accepter_id 
), all_id AS(
    SELECT id
    FROM (
        SELECT requester_id AS id FROM RequestAccepted
        UNION
        SELECT accepter_id AS id FROM RequestAccepted
    ) AS combined_ids
    ORDER BY id
), count_friends AS(
    SELECT
        all_id.id,
        IFNULL(num_of_followers.sum_of_followers, 0) 
            + IFNULL(num_of_followees.sum_of_followees, 0) AS friends
    FROM
        all_id
        LEFT OUTER JOIN num_of_followers
            ON all_id.id = num_of_followers.requester_id
        LEFT OUTER JOIN num_of_followees
            ON all_id.id = num_of_followees.accepter_id
)
SELECT
    id,
    friends AS num
FROM
    count_friends
WHERE
    friends = (SELECT MAX(friends) FROM count_friends)