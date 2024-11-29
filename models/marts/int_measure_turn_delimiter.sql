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
FROM {{ ref("int_measure") }}