with campaigns as (

    select *
    from {{ ref('int_campaigns') }}
),

aggregated as (
    select
        date_date,
        paid_source,
        sum(ads_cost)      as ads_cost,
        sum(impression)    as impressions,
        sum(click)         as clicks
    from campaigns
    group by
        date_date,
        paid_source
)

select
    *
from aggregated
order by
    date_date desc,
    paid_source
 

