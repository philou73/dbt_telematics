WITH breakings AS (
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
FROM breakings
WHERE speed_diff < -8.9  -- Filtrer pour garder les freinages forts (< -8.9 m/s²)
ORDER BY deviceID, tripID, timeStamp;