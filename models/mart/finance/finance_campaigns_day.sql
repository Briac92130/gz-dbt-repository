with 
campaigns_day as (
    select *
    from {{ ref('int_campaigns_day') }}
),

finance as (
    select *
    from {{ ref('finance_days') }}
),

joined as (
    select
        finance.date_date as date,
        -- computed field
        (finance.operational_margin - campaigns_day.ads_cost) as ads_margin,
        finance.average_basket,
        finance.operational_margin,
        
        -- from int_campaigns_day
        campaigns_day.ads_cost,
        campaigns_day.impressions as ads_impression,
        campaigns_day.clicks      as ads_clicks,

        -- from finance_days
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
