SELECT
    trip_id,
    device_id,
    measure_ts,
    my,
    LAG(my) OVER (PARTITION BY trip_id, device_id ORDER BY measure_ts) AS prev_my
  FROM
    {{ ref("stg_telematics") }}