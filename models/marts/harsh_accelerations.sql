WITH acceleration AS (
    SELECT 
        deviceID,
        tripID,
        timeStamp,
        LAG(speed) OVER (PARTITION BY deviceID, tripID ORDER BY timeStamp) AS begin_speed,
        speed AS end_speed,
        (speed - LAG(speed) OVER (PARTITION BY deviceID, tripID ORDER BY timeStamp)) AS speed_diff
    FROM {{ ref('stg_telematics') }}
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