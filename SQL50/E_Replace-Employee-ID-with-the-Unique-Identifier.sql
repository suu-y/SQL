# Write your MySQL query statement below
SELECT
    EmpUNI.unique_id, Emp.name
FROM
    Employees AS Emp
    LEFT OUTER JOIN EmployeeUNI AS EmpUNI
        ON Emp.id = EmpUNI.id