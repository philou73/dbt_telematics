WITH int_measures AS (
    SELECT
    trip_id,
    device_id,
    measure_ts,
    my,
    LAG(my) OVER (PARTITION BY trip_id, device_id ORDER BY measure_ts) AS prev_my
  FROM
    {{ ref("stg_telematics") }}
    WHERE 
        DATE(measure_ts) = '2017-09-26'
)
SELECT 
    trip_id, 
    device_id,
    measure_ts,
    my,
    prev_my,
    CASE WHEN (my >= 0 and prev_my >=0) OR (my <= 0 AND prev_my <= 0)
        THEN false
        ELSE true
    END as is_turn_delimiter
FROM int_measures