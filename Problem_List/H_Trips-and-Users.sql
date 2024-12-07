# Write your MySQL query statement below
WITH ValidClients AS(
    SELECT
        users_id AS valid_client_id
    FROM
        Users
    WHERE
        banned = 'No'
        AND
        role = 'client'
), ValidDrivers AS(
    SELECT
        users_id AS valid_driver_id
    FROM
        Users
    WHERE
        banned = 'No'
        AND
        role = 'driver'
), OctoberTrips AS(
    SELECT
        *
    FROM
        Trips
    WHERE
        Trips.request_at BETWEEN '2013-10-01' AND '2013-10-03'
)
SELECT DISTINCT
    OctoberTrips.request_at AS 'Day',
    ROUND(SUM(IF(OctoberTrips.status LIKE 'cancelled%', 1, 0)) OVER (PARTITION BY OctoberTrips.request_at)
        / SUM(1) OVER (PARTITION BY OctoberTrips.request_at), 2) AS 'Cancellation Rate'
FROM
    OctoberTrips
    INNER JOIN ValidClients
        ON  OctoberTrips.client_id = ValidClients.valid_client_id
    INNER JOIN ValidDrivers
        ON  OctoberTrips.driver_id = ValidDrivers.valid_driver_id
