# Write your MySQL query statement below
WITH Customer_purchase AS(
    SELECT DISTINCT
        customer_id,
        COUNT(DISTINCT product_key) AS cnt
    FROM
        Customer
    GROUP BY
        customer_id
), Product_cnt AS(
    SELECT
        COUNT(*) AS prod_cnt
    FROM
        Product
)
SELECT
    c1.customer_id AS customer_id
FROM
    Customer_purchase c1
    CROSS JOIN Product_cnt p
WHERE
    c1.cnt = p.prod_cnt

-- 方針：Customerから重複したタプルを除き、customer_idごとにCOCUNT
-- その数がProductのタプル数と一致すれば抽出