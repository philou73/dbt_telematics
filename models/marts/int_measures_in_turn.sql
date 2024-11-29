WITH int_turns_intermediate AS (SELECT
    trip_id,
    device_id,
    measure_ts AS start_ts,
    LEAD(measure_ts) OVER (PARTITION BY trip_id, device_id ORDER BY measure_ts) AS end_ts,
    ROW_NUMBER() OVER(PARTITION BY trip_id, device_id ORDER BY measure_ts) as turn_number
FROM
    {{ref("int_measure_turn_delimiter")}}
WHERE
    is_turn_delimiter = true)

SELECT 
    start_ts as start_turn_ts,
    end_ts as end_turn_ts,
    turn_number,
    T.trip_id,
    T.device_id,
    T.car_speed_km_per_hour as car_speed_km_per_hour,
    T.my as my
FROM {{ ref("stg_telematics") }} T
LEFT JOIN int_turns_intermediate I
ON T.measure_ts < I.end_ts 
AND T.measure_ts >= I.start_ts
AND T.trip_id = I.trip_id
AND T.device_id = I.device_id