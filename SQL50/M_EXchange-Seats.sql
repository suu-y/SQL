# Write your MySQL query statement below
WITH exchange AS(
    SELECT
        t1.id,
        t1.student AS stu1,
        t2.student AS stu2
    FROM
        Seat t1
        LEFT OUTER JOIN Seat t2
            ON IF(t1.id % 2 = 0, t1.id = t2.id + 1, t1.id = t2.id - 1) 
), last AS(
    SELECT IF(MAX(id) %2 = 1, MAX(id), NULL) AS last_id FROM Seat
)
SELECT
    exchange.id,
    IF(last_id IS NOT NULL, stu1, stu2) AS student
FROM exchange
    LEFT OUTER JOIN last
        ON exchange.id = last.last_id
