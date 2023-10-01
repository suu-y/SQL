# Write your MySQL query statement below
WITH get_managerID AS (
    SELECT
        managerId
    FROM
        Employee
    GROUP BY
        managerID
    HAVING
        COUNT(*) >= 5
)
SELECT
    Employee.name
FROM
    Employee
    INNER JOIN get_managerID
        ON Employee.id = get_managerID.managerId