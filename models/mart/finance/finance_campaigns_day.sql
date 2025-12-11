with 
campaigns_day as (
    -- We agregate here to have one line on date
    select
        date_date,
        sum(ads_cost)    as ads_cost,
        sum(impressions) as ads_impression,
        sum(clicks)      as ads_clicks
    from {{ ref('int_campaigns_day') }}
    group by date_date
),

finance as (
    select *
    from {{ ref('finance_days') }}
),

joined as (
    select
        finance.date_date as date,

        -- calculated field
        (finance.operational_margin - coalesce(campaigns_day.ads_cost, 0)) as ads_margin,

        finance.average_basket,
        finance.operational_margin,

        campaigns_day.ads_cost,
        campaigns_day.ads_impression,
        campaigns_day.ads_clicks,

        finance.quantity,
        finance.revenue,
        finance.purchase_cost,
        finance.margin,
        finance.shipping_fee,
        finance.log_cost,
        finance.ship_cost

    from finance
    left join campaigns_day
        on finance.date_date = campaigns_day.date_date
)

select *
from joined
order by date desc

