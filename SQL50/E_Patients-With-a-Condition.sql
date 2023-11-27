# Write your MySQL query statement below
SELECT
    *
FROM
    Patients
WHERE
    conditions REGEXP '[^a-zA-Z](DIAB1)|(^DIAB1)'