WITH breakings AS (
    SELECT 
        device_id,
        trip_id,
        measure_ts,
        LAG(car_speed_km_per_hour) OVER (PARTITION BY device_id, trip_id ORDER BY measure_ts) AS begin_speed,
        car_speed_km_per_hour AS end_speed
    FROM {{ ref('stg_telematics') }}
)
SELECT 
    device_id,
    trip_id,
    measure_ts,
    begin_speed,
    end_speed,
    (end_speed - begin_speed) AS speed_diff
FROM breakings
WHERE ABS(end_speed - begin_speed) < -8.9
ORDER BY device_id, trip_id, measure_ts