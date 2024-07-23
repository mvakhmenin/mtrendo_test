
SELECT *
     , (tips_sum - LAG(tips_sum) OVER (PARTITION BY taxi_id ORDER BY year, month)) / NULLIF(LAG(tips_sum) OVER (PARTITION BY taxi_id ORDER BY year, month), 0) AS tips_change
FROM {{ ref('main_report') }}