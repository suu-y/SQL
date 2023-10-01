# Write your MySQL query statement below
WITH Exam_cnt AS(
    SELECT
        Stu.student_id, Stu.student_name, Exam.subject_name, COUNT(*) AS cnt
    FROM
        Students Stu
        LEFT OUTER JOIN Examinations Exam
            ON Stu.student_id = Exam.student_id

    GROUP BY
        Stu.student_id, Stu.student_name, Exam.student_id, Exam.subject_name
    -- 0回受験者の情報が失われている
), Join_Stu_n_Sub AS (
    SELECT
        *
    FROM
        Students
        CROSS JOIN Subjects       
)
SELECT
    Stu.student_id,
    Stu.student_name,
    Stu.subject_name,
    COALESCE(Exam_cnt.cnt, 0) AS attended_exams
FROM
    Join_Stu_n_Sub Stu
    LEFT OUTER JOIN Exam_cnt
        ON(
            Stu.student_id = Exam_cnt.student_id
            AND
            Stu.subject_name = Exam_cnt.subject_name
        )
ORDER BY
    Stu.student_id, Stu.subject_name