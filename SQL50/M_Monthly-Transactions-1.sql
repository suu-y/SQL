# Write your MySQL query statement below
SELECT
    SUBSTRING(trans_date, 1, 7) AS month,
    country,
    COUNT(*) AS trans_count,
    SUM(CASE state WHEN 'approved' THEN 1 ELSE 0 END) AS approved_count,
    SUM(amount) AS trans_total_amount,
    SUM(CASE state WHEN 'approved' THEN amount ELSE 0 END) AS approved_total_amount
FROM
    Transactions
GROUP BY
    SUBSTRING(trans_date, 1, 7),
    country

-- 遅いクエリになった
-- 次のようなSUMの書き方もできるみたい
/*
# Write your MySQL query statement below
select DATE_FORMAT(trans_date, '%Y-%m') as month, 
  country, 
  count(*) as trans_count, 
  sum(state='approved') as approved_count,
  sum(amount) as trans_total_amount,
  sum(if(state='approved', amount, 0)) as approved_total_amount
from Transactions
group by month, country
*/