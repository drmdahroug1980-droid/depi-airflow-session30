select distinct
    year as season,
    btrim(url) as race_url,
    btrim(grand_prix) as grand_prix,
    btrim(date) as race_day_month,
    winner_driver_first_name,
    winner_driver_last_name,
    btrim(winner_driver_short_name) as winner_driver_short_name,
    winner_team,
    case when btrim(winner_laps) ~ '^[0-9]+$'
        then btrim(winner_laps)::integer
    end as winner_laps,
    winner_time
from {{ source('f1_raw', 'raw_races') }}
