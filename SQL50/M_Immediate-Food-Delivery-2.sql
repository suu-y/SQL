# Write your MySQL query statement below
WITH isImmediate_order AS(
    SELECT
        customer_id,
        MIN(order_date) AS order_date,
        CASE WHEN (order_date = MIN(customer_pref_delivery_date)) THEN 'immediate'
            ELSE 'scheduled_order' END AS first_deliv_date
    FROM
        Delivery
    GROUP BY
        customer_id
)
SELECT
    ROUND(SUM(CASE WHEN isImmediate_order.first_deliv_date = 'immediate' THEN 1 ELSE 0 END) * 100 / COUNT(*), 2) AS immediate_percentage
FROM
    Delivery
    INNER JOIN isImmediate_order
        ON Delivery.order_date = isImmediate_order.order_date

-- これは動くけど、求めている結果は得られていない