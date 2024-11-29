{{
  config(
    materialized = "table",
    cluster_by = ["measure_ts"],
  )
}}

SELECT
  dataID AS measure_id,
  deviceID AS device_id,
  timeStamp AS measure_ts,
  tripID as trip_id,
  mx,
  my,
  mz,
  IFNULL(kpl,0) AS consumption_km_by_liter,
  maf AS mass_air_flow,
  rpm AS revolutions_per_min,
  CAST(speed AS INT) AS car_speed_km_per_hour
FROM {{ source('telematics_src', 'telematics_src') }}