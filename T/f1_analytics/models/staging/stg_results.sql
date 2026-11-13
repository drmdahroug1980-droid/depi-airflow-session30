select distinct
    btrim(url) as race_url,
    btrim(pos) as position_code,
    case when btrim(pos) ~ '^[0-9]+$'
        then btrim(pos)::integer
    end as finish_position,
    btrim(no) as car_number,
    btrim(driver_first_name) as driver_first_name,
    btrim(driver_last_name) as driver_last_name,
    btrim(driver_short_name) as driver_short_name,
    btrim(team) as team,
    case when btrim(laps) ~ '^[0-9]+$'
        then btrim(laps)::integer
    end as laps,
    nullif(btrim(time_retired), '') as time_retired,
    case when btrim(pts) ~ '^[0-9]+([.][0-9]+)?$'
        then btrim(pts)::numeric
    end as race_points
from {{ source('f1_raw', 'raw_results') }}
