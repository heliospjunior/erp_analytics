--Grain: 1 linha por produto, por loja, por dia

WITH base as (

    SELECT
        DATE(sale_datetime) as snapshot_date,
        store_id,
        product_id,
        sum(quantity) as daily_consumption,
      
    from {{ ref('fct_sales')}}
    GROUP BY 1,2,3
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
        DATE(snapshot_date) as snapshot_date,
        stock_quantity

    from {{ ref('snap_inventory')}}
    

),

final as (

    SELECT
        s.snapshot_date,
        s.store_id,
        s.product_id,
        l.stock_quantity,
        s.avg_daily_consumption_7d,

        -- Dias de cobertura de estoque
        CASE 
            WHEN s.avg_daily_consumption_7d > 0
                THEN l.stock_quantity / s.avg_daily_consumption_7d

            ELSE NULL  
        END as days_of_stock,

        CASE 
            WHEN s.avg_daily_consumption_7d > 0
            and l.stock_quantity / s.avg_daily_consumption_7d <=3
                THEN true  
            ELSE  false
        END as is_stockout_risk

    from consumption_avg s
    left join latest_stock l
        on s.store_id = l.store_id
        and s.product_id = l.product_id
        and s.snapshot_date = l.snapshot_date
)

select * from final