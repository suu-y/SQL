# Write your MySQL query statement below
-- まだ解けていない
WITH Prod_price AS(
    SELECT
        product_id,
        new_price,
        MAX(change_date) AS MAX_change_date
    FROM
        Products
    WHERE
        change_date <= '2019-08-16'
    GROUP BY
        product_id, new_price
), All_prod AS(
    SELECT DISTINCT
        p2.product_id,
        Prod_price.new_price,
        Prod_price.MAX_change_date
    FROM
        Products p2
        LEFT OUTER JOIN Prod_price
            ON p2.product_id = Prod_price.product_id
    GROUP BY
        p2.product_id
)
SELECT
    product_id,
    IFNULL(new_price, 10) AS price
    -- MAX_change_date
    -- CASE WHEN(MAX_change_date <= '2019-08-16') THEN new_price ELSE 10 END AS price
FROM
    All_prod
GROUP BY
    product_id