# Write your MySQL query statement below
WITH Lowest_t AS(
    SELECT
        user_id,
        COUNT(*) AS cnt
    FROM
        MovieRating
    GROUP BY
        user_id
    ORDER BY
        COUNT(*) DESC
), t2 AS(
    SELECT
        Users.name
    FROM
        Lowest_t
        INNER JOIN Users
            ON Lowest_t.user_id = Users.user_id
    ORDER BY
        Lowest_t.cnt DESC, Users.name
    LIMIT 1
), Average_t AS(
    SELECT DISTINCT
        MovieRating.movie_id,
        created_at,
        t2.name,
        Movies.title
    FROM
        MovieRating
        CROSS JOIN t2
        INNER JOIN Movies
            ON MovieRating.movie_id = Movies.movie_id
    WHERE
        created_at BETWEEN '2020-02-01' AND '2020-02-28'
    GROUP BY
        MovieRating.movie_id
    ORDER BY
        AVG(MovieRating.rating) DESC, Movies.title
    LIMIT 1
), t3 AS(
    SELECT
        Movies.title,
        Average_t.name
    FROM
        Average_t
        INNER JOIN Movies
            ON Average_t.movie_id = Movies.movie_id 
)
SELECT t3.name AS results FROM t3
    UNION ALL
SELECT title FROM t3