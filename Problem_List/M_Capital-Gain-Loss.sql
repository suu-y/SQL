# Write your MySQL query statement below
WITH calc_t AS(
    SELECT
        stock_name,
        price,
        RANK() OVER (PARTITION BY stock_name ORDER BY operation_day) AS ordered
    FROM
        Stocks
    ORDER BY
    stock_name, ordered
), income_n_expenditure AS(
    SELECT
        stock_name,
        CASE WHEN (ordered%2 = 1) THEN price*(-1) ELSE price END AS income,
        ordered
    FROM
        calc_t
)
SELECT DISTINCT
    stock_name,
    SUM(income) OVER (PARTITION BY stock_name) AS capital_gain_loss
FROM
    income_n_expenditure