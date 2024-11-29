SELECT 
    start_ts as start_turn_ts,
    end_ts as end_turn_ts,
    T.trip_id,
    T.device_id,
    T.car_speed_km_per_hour as car_speed_km_per_hour,
    T.my as my
FROM {{ ref("stg_telematics") }} T
LEFT JOIN {{ref("int_periods")}} I
ON T.measure_ts < I.end_ts 
AND T.measure_ts >= I.start_ts
AND T.trip_id = I.trip_id
AND T.device_id = I.device_id