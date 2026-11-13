{{ config(materialized='table') }}

select
    results.race_url,
    drivers.driver_id,
    results.car_number,
    results.team,
    results.position_code,
    results.finish_position,
    results.laps,
    results.time_retired,
    results.race_points
from {{ ref('stg_results') }} as results
join {{ ref('dim_race') }} as races using (race_url)
join {{ ref('dim_driver') }} as drivers
    using (driver_first_name, driver_last_name, driver_short_name)
