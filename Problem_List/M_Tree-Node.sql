# Write your MySQL query statement below
WITH leaf_or_inner_t AS(
    SELECT DISTINCT
        t1.id,
        CASE WHEN t1.p_id IS NULL THEN 'Root' ELSE t1.p_id END AS 'isROOT',
        CASE WHEN t2.p_id IS NULL THEN 0 ELSE 1 END AS 'isInner'
    FROM
        Tree t1
        LEFT OUTER JOIN Tree t2
            ON  t1.id = t2.p_id
)
SELECT
    id,
    CASE WHEN (isROOT = 'Root') THEN 'Root'
         WHEN (isInner = 1) THEN 'Inner'
         ELSE 'Leaf' END AS type
FROM
    leaf_or_inner_t