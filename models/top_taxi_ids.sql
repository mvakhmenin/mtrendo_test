SELECT taxi_id
     , SUM(src.tips) AS tips_sum
     , MIN(EXTRACT(YEAR FROM CAST(src.trip_start_timestamp AS date))) AS year
     , MIN(EXTRACT(MONTH FROM CAST(src.trip_start_timestamp AS date))) AS month
FROM {{ source('bigquery', 'taxi_trips') }} AS src
WHERE trip_start_timestamp >= '2018-04-01' AND trip_start_timestamp < '2018-05-01'
GROUP BY taxi_id
ORDER BY SUM(tips) DESC
LIMIT 3