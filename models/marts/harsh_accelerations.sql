WITH acceleration AS (
    SELECT 
        deviceID,
        tripID,
        timeStamp,
        LAG(speed) OVER (PARTITION BY deviceID, tripID ORDER BY timeStamp) AS begin_speed,
        speed AS end_speed,
        (speed - LAG(speed) OVER (PARTITION BY deviceID, tripID ORDER BY timeStamp)) AS speed_diff
    FROM `blent-sandbox-6169080881.dbt_telematics.telematics_src`
)

SELECT 
    deviceID,
    tripID,
    timeStamp,
    begin_speed,
    end_speed,
    speed_diff
FROM acceleration
WHERE ABS(speed_diff) > 6.9
ORDER BY deviceID, tripID, timeStamp;