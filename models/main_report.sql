SELECT taxi_id, 2018 AS year, 4 AS month, tips_sum
FROM {{ ref('top_taxi_ids') }}

UNION ALL

SELECT src.taxi_id
    , EXTRACT(YEAR FROM CAST(src.trip_start_timestamp AS date)) AS year
    , EXTRACT(MONTH FROM CAST(src.trip_start_timestamp AS date)) AS month
    , SUM(src.tips) AS tips_sum
FROM `bigquery-public-data.chicago_taxi_trips.taxi_trips` AS src
        INNER JOIN {{ ref('top_taxi_ids') }} USING(taxi_id)
WHERE trip_start_timestamp >= '2018-05-01'
GROUP BY taxi_id, year, month
ORDER BY year, month