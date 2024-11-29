WITH acceleration AS (
    SELECT 
        device_id,
        trip_id,
        measure_ts,
        LAG(car_speed_km_per_hour) OVER (PARTITION BY device_id, trip_id ORDER BY measure_ts) AS previous_end_speed_period,
        car_speed_km_per_hour AS end_speed
    FROM {{ ref('stg_telematics') }}
)

SELECT 
    device_id,
    trip_id,
    measure_ts,
    previous_end_speed_period,
    end_speed,
    (end_speed - previous_end_speed_period) AS speed_diff
FROM acceleration
WHERE ABS(end_speed - previous_end_speed_period) > 6.9