# Write your MySQL query statement below

-- 今回の例では「販売している商品は必ず一度は売れている」ので、
-- JOINの方法に気を配る必要はない
-- しかしここでは練習のため、「売れなかった商品」がある想定で進める
SELECT
    Prices.product_id,
    COALESCE(ROUND(SUM(Prices.price * Sold.units) / SUM(Sold.units), 2), 0) AS average_price
FROM
    Prices
    LEFT OUTER JOIN UnitsSold Sold
        ON(
            Prices.product_id = Sold.product_id
            AND
            -- 次の条件で、「売れなかった商品」の情報も含まれるかは自信がない
            Sold.purchase_date BETWEEN Prices.start_date AND Prices.end_date
        )
GROUP BY
    Prices.product_id
