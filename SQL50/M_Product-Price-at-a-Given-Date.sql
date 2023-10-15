
WITH max_date AS(
    SELECT
        product_id,
        MAX(change_date) as max_date
    FROM
        Products
    WHERE
        change_date <= '2019-08-16'
    GROUP BY
        product_id
), prod_n_date AS(
    SELECT
        p1.product_id,
        max_date.max_date
    FROM
        Products p1
        LEFT OUTER JOIN max_date
            ON p1.product_id = max_date.product_id
    GROUP BY
        p1.product_id
)
SELECT
    prod_n_date.product_id,
    CASE WHEN(p2.new_price IS NOT NULL) THEN p2.new_price
        ELSE 10 END AS price
FROM
    prod_n_date
    LEFT OUTER JOIN Products p2
        ON(
            prod_n_date.product_id = p2.product_id
            AND
            prod_n_date.max_date = p2.change_date
        )
