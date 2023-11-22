# Write your MySQL query statement below
WITH ranking_t AS(
    -- 先にランキングのテーブルを作成
    SELECT
        name,
        salary,
        departmentId,
        DENSE_RANK() OVER (PARTITION BY departmentId ORDER BY salary DESC) AS RankNo
    FROM
        Employee
)
SELECT
    Department.name AS Department,
    ranking_t.name AS Employee,
    ranking_t.salary AS Salary
FROM
    ranking_t
    LEFT OUTER JOIN Department
        ON ranking_t.departmentId = Department.id
WHERE
    ranking_t.RankNo <= 3