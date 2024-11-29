WITH int_telematics_ms AS (
    SELECT 
        trip_id,
        device_id,
        CAST(measure_ts AS TIMESTAMP) as measure_ts,
        car_speed_km_per_hour,
        my
    FROM {{ ref("stg_telematics") }}
),

int_periods_ms AS (
    SELECT 
        CAST(start_ts AS TIMESTAMP) as start_ts,
        CAST(end_ts AS TIMESTAMP) as end_ts,
        trip_id,
        device_id
    FROM 
        {{ ref("int_turns") }}
)

SELECT 
    start_ts as start_turn_ts,
    end_ts as end_turn_ts,
    T.trip_id as trip_id,
    T.device_id as device_id,
    T.car_speed_km_per_hour as car_speed_km_per_hour,
    T.my as my
FROM int_telematics_ms T
LEFT JOIN int_periods_ms I
ON T.measure_ts < I.end_ts 
AND T.measure_ts >= I.start_ts
AND T.trip_id = I.trip_id
AND T.device_id = I.device_id