--Grain: 1 linha por produto, por loja, por dia

WITH base as (

    SELECT
        snapshot_date,
        store_id,
        product_id,
        stock_quantity,
        stock_delta,

        -- Consumo diário real (somente quando o estoque diminui)

        CASE 
            WHEN stock_delta < 0 THEN abs(stock_delta)
            ELSE 0 
        END as daily_consumption

    from {{ ref('fct_inventory_daily')}}
),

consumption_avg as (

    SELECT
        *,
        avg(daily_consumption) over (
            partition by store_id, product_id
            order by snapshot_date
            rows between 6 preceding and current ROW

        ) as avg_daily_consumption_7d

    from base

),

latest_stock as (

    SELECT
        store_id,
        product_id,
        snapshot_date,
        stock_quantity,

    from {{ ref('snap_inventory')}}
    

),

final as (

    SELECT
        snapshot_date,
        store_id,
        product_id,
        stock_quantity,
        avg_daily_consumption_7d,

        -- Dias de cobertura de estoque
        CASE 
            WHEN avg_daily_consumption_7d > 0
                THEN stock_quantity / avg_daily_consumption_7d

            ELSE NULL  
        END as days_of_stock,

        CASE 
            WHEN avg_daily_consumption_7d > 0
            and stock_quantity / avg_daily_consumption_7d <=3
                THEN true  
            ELSE  false
        END as is_stockout_risk

    from consumption_avg
)

select * from final