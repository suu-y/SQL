# Write your MySQL query statement below
-- 初めに重複するtiv_2015だけを取り出すテーブル
WITH same_tiv2015 AS(
    SELECT
        tiv_2015,
        COUNT(*) AS cnt
    FROM
        Insurance
    GROUP BY
        tiv_2015
    HAVING
        cnt > 1
), t1 AS(
    -- same_tiv2015で見つかった重複するtiv_2015のタプルを取り出す
    SELECT
        Insurance.pid,
        Insurance.tiv_2015,
        Insurance.tiv_2016
    FROM
        Insurance
        INNER JOIN same_tiv2015
            ON Insurance.tiv_2015 = same_tiv2015.tiv_2015
), extract_lat_lon AS(
    -- lat, lonが重複するものを弾く
    SELECT
        lat,
        lon,
        COUNT(*) AS cnt
    FROM
        Insurance
    GROUP BY
        lat, lon
    HAVING
        cnt = 1
), t2 AS(
    -- extract_lat_lonで見つかったlat, lonが重複しないタプルを取り出す
    SELECT
        Insurance.pid,
        Insurance.lat,
        Insurance.lon
    FROM
        Insurance
        INNER JOIN extract_lat_lon
            ON (
                Insurance.lat = extract_lat_lon.lat
                AND
                Insurance.lon = extract_lat_lon.lon
            )
)
SELECT
    ROUND(SUM(t1.tiv_2016), 2) AS tiv_2016
FROM
    t1
    INNER JOIN t2
        ON t1.pid = t2.pid