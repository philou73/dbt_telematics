WITH breakings AS (
    SELECT 
        device_id,
        trip_id,
        measure_ts,
        LAG(car_speed_km_per_hour) OVER (PARTITION BY device_id, trip_id ORDER BY measure_ts) AS begin_speed,
        car_speed_km_per_hour AS end_speed,
        (car_speed_km_per_hour - LAG(car_speed_km_per_hour) OVER (PARTITION BY device_id, trip_id ORDER BY measure_ts)) AS speed_diff
    FROM {{ ref('stg_telematics') }}
)
SELECT 
    device_id,
    trip_id,
    measure_ts,
    begin_speed,
    end_speed,
    speed_diff
FROM breakings
WHERE speed_diff < -8.9
ORDER BY device_id, trip_id, measure_ts