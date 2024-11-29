SELECT
    trip_id,
    device_id,
    measure_ts AS start_ts,
    LEAD(measure_ts) OVER (PARTITION BY trip_id, device_id ORDER BY measure_ts) AS end_ts
FROM
    {{ref("int_measure_turn_delimiter")}}
WHERE
    is_turn_delimiter = true