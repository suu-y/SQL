# Write your MySQL query statement below
SELECT
    Project.project_id,
    ROUND(AVG(Emp.experience_years), 2) AS average_years
FROM
    Project
    LEFT OUTER JOIN Employee Emp
        ON Project.employee_id = Emp.employee_id
GROUP BY
    Project.project_id