select distinct
    year as season,
    btrim(driver_url) as driver_url,
    btrim(driver_first_name) as driver_first_name,
    btrim(driver_last_name) as driver_last_name,
    btrim(driver_short_name) as driver_short_name,
    btrim(driver_nationality) as driver_nationality,
    btrim(team) as team,
    btrim(team_url) as team_url,
    case when btrim(pts) ~ '^[0-9]+([.][0-9]+)?$'
        then btrim(pts)::numeric
    end as season_points
from {{ source('f1_raw', 'raw_drivers') }}
