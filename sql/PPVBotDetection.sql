WITH jdv_subset AS (SELECT date_trunc('month', jcd.date_created)::DATE AS jdv_month
                         , jcd.country_name
                         , jcd.client_ip
                         , count(*) AS jdvs
                    FROM analytics.job_clicks_details_geo jcd
                    WHERE date_trunc('month', jcd.date_created) = '2020-10-01' --change this for a specified month or use function to get current month
                     AND jcd.country_iso_code IN ('US') --comment this line out if you want all countries
                    GROUP BY 1
                           , 2
                           , 3
                    HAVING count(*) >= 1000)
SELECT js.jdv_month
    , js.country_name
    , js.client_ip
    , js.jdvs
    , 0 AS application_attempts
FROM jdv_subset js
     LEFT OUTER JOIN repl_dice_skr.application_detail ad
                     ON ad.client_ip = js.client_ip
                     AND date_trunc('month', ad.application_date) = js.jdv_month
WHERE ad.client_ip IS NULL;


SELECT date_trunc('month', jcd.date_created)::DATE AS jdv_month
    , jcd.country_name
    , jcd.client_ip
    , count(*) AS jdvs
FROM analytics.job_clicks_details_geo jcd
WHERE date_trunc('month', jcd.date_created) = '2020-10-01' --change this for a specified month or use function to get current month
  AND jcd.country_iso_code NOT IN ('US','CA')
GROUP BY 1
       , 2
       , 3
HAVING count(*) >= 500 --can change JDV limit here
ORDER BY 4 DESC
