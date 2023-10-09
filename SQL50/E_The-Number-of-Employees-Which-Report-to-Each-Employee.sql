# Write your MySQL query statement below
WITH Manager AS(
    SELECT
        employee_id,
        name,
        reports_to AS manager_id,
        age
    FROM
        Employees e1
    WHERE
        reports_to IS NOT NULL
)
SELECT DISTINCT
    e2.employee_id,
    e2.name,
    COUNT(*) AS reports_count,
    ROUND(AVG(Manager.age), 0) AS average_age
FROM
    Employees e2
    INNER JOIN Manager
        ON e2.employee_id = Manager.manager_id
GROUP BY
    e2.employee_id
ORDER BY
    e2.employee_id
