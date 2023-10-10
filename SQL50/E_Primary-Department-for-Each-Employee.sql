# Write your MySQL query statement below
WITH Table1 AS(
    SELECT
        e1.employee_id,
        CASE WHEN(COUNT(*) = 1) THEN department_id
            ELSE (
                SELECT department_id
                FROM Employee e2
                WHERE primary_flag = 'Y' 
                    AND e1.employee_id = e2.employee_id
            ) END AS department_id
    FROM
        Employee e1
    GROUP BY
        e1.employee_id
)
SELECT
    *
FROM
    Table1
WHERE
    department_id NOT IN ('null')
