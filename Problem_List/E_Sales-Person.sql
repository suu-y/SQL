# Write your MySQL query statement below
WITH Com_RED AS(
    SELECT
        com_id
    FROM
        Company
    WHERE
        name = 'RED'
), RED_SP AS(
SELECT
    Orders.sales_id
FROM
    Orders
    LEFT OUTER JOIN Com_RED
        ON Orders.com_id = Com_RED.com_id
WHERE
    Com_RED.com_id IS NOT NULL
)
SELECT
   SalesPerson.name
FROM
    SalesPerson
    LEFT OUTER JOIN RED_SP
        ON SalesPerson.sales_id = RED_SP.sales_id
WHERE
    RED_SP.sales_id IS NULL
