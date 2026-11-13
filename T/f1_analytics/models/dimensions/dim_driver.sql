{{ config(materialized='table') }}

with identities as (
    select driver_first_name, driver_last_name, driver_short_name, driver_nationality
    from {{ ref('stg_drivers') }}

    union all

    select driver_first_name, driver_last_name, driver_short_name, cast(null as text)
    from {{ ref('stg_results') }}
)
select
    md5(json_build_array(driver_first_name, driver_last_name, driver_short_name)::text) as driver_id,
    driver_first_name,
    driver_last_name,
    driver_short_name,
    max(nullif(driver_nationality, '')) as driver_nationality
from identities
group by driver_first_name, driver_last_name, driver_short_name
