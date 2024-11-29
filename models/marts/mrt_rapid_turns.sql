SELECT
    trip_id,
    device_id,
    start_turn_ts,
    max(my) as max_my,
    max(car_speed_km_per_hour) as max_speed
FROM
  {{ref("mrt_measures")}}
GROUP BY 
    trip_id, 
    device_id, 
    start_turn_ts
HAVING max_my > 9.81
