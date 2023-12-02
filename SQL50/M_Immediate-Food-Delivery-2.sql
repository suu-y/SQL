# Write your MySQL query statement below
WITH min_order_date AS (
    SELECT
        customer_id,
        MIN(order_date) AS min_order_date
    FROM
        Delivery
    GROUP BY
        customer_id
), order_type AS(
    SELECT
        CASE WHEN(delivery_id IS NULL) THEN 'imm'
            ELSE 'sch' END AS type
    FROM
        min_order_date
        LEFT OUTER JOIN Delivery
        ON (
            min_order_date.min_order_date = Delivery.customer_pref_delivery_date
            AND
            min_order_date.customer_id = Delivery.customer_id
        )
)
SELECT
    ROUND(SUM(CASE WHEN type = 'imm' THEN 0 ELSE 1 END) * 100 / COUNT(*), 2) AS immediate_percentage
FROM
    order_type