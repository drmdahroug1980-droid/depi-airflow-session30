{{ config(materialized='table') }}

select distinct
    race_url,
    season,
    grand_prix,
    race_day_month
from {{ ref('stg_races') }}
