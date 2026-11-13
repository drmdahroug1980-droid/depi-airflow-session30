with entries as (
    select distinct race_url, driver_id, car_number
    from {{ ref('fct_race_results') }}
)

select
    races.season,
    count(distinct races.race_url) as race_count,
    count(distinct entries.driver_id) as driver_count,
    count(entries.driver_id) as entry_count
from {{ ref('dim_race') }} as races
left join entries using (race_url)
group by races.season
