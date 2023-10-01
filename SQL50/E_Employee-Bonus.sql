# Write your MySQL query statement below
SELECT
    Emp.name, Bonus.bonus
FROM
    Employee Emp
    LEFT OUTER JOIN Bonus
        ON Emp.empId = Bonus.empId
WHERE
    Bonus.bonus < 1000
    OR
    Bonus.bonus IS NULL