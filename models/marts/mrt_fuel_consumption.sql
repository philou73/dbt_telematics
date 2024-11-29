SELECT
  device_id,
  trip_id,
  avg(consumption_km_by_liter) AS avg_consumption_km_by_liter
FROM {{ ref('stg_telematics') }}
where revolutions_per_min > 0
GROUP  BY device_id , trip_id 