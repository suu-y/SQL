# Write your MySQL query statement below
WITH OUTER_JOIN_T AS(
SELECT
    t1.employee_id AS t1_id, t1.name, t2.salary, t2.employee_id AS t2_id
FROM
    Employees t1
    LEFT OUTER JOIN Salaries t2
        ON t1.employee_id = t2.employee_id
UNION
SELECT
    t1.employee_id AS t1_id, t1.name, t2.salary, t2.employee_id AS t2_id
FROM
    Employees t1
    RIGHT OUTER JOIN Salaries t2
        ON t1.employee_id = t2.employee_id
), UNION_T AS(
SELECT
    t2_id AS employee_id
FROM
    OUTER_JOIN_T
WHERE
    name IS NULL
UNION
SELECT
    t1_id AS employee_id
FROM
    OUTER_JOIN_T
WHERE
    salary IS NULL
)
SELECT
    *
FROM
    UNION_T
ORDER BY
    employee_id