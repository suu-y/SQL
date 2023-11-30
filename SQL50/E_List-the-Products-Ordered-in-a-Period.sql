# Write your MySQL query statement below
WITH order_in_Feb AS(
    SELECT
        product_id,
        SUM(unit) AS unit
    FROM
        Orders
    WHERE
        order_date LIKE '2020-02-%'
    GROUP BY
        product_id
    HAVING
        SUM(unit) >= 100
)
SELECT
    Products.product_name,
    order_in_Feb.unit
FROM
    Products
    INNER JOIN order_in_Feb
        ON Products.product_id = order_in_Feb.product_id

