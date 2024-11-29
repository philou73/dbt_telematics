SELECT
    T.trip_id trip_id,
    T.device_id device_id,
    P.start_ts start_turn_ts,
    max(my) as max_my,
    max(car_speed_km_per_hour) as max_speed
FROM
  {{ref("int_measures_in_periods")}} M
GROUP BY 
    trip_id, 
    device_id, 
    start_turn_ts
HAVING max_my > 9.81
