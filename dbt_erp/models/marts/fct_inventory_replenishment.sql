WITH base as (

    SELECT
        d.store_id,
        d.product_id,
        d.snapshot_date,

        d.stock_quantity as current_stock_quantity,
        r.avg_daily_consumption_7d,
        r.days_of_stock

    from {{ ref('fct_inventory_daily')}} d 
    left JOIN {{ ref('fct_inventory_risk')}} r 
        on d.store_id = r.store_id
        and d.product_id = r.product_id
        and r.snapshot_date = r.snapshot_date
),

decision as (

    SELECT *,
        CASE 
            WHEN avg_daily_consumption_7d is null THEN FALSE
            when days_of_stock <= 3 then TRUE  
            ELSE  FALSE
        END as should_replenish,

        7 as target_days_of_stock
    from base
)

SELECT
    store_id,
    product_id,
    snapshot_date,

    current_stock_quantity,
    avg_daily_consumption_7d,
    days_of_stock,
    target_days_of_stock,

    should_replenish,

    CASE 
        WHEN should_replenish = TRUE THEN
            greatest(
                cast(
                    (target_days_of_stock * avg_daily_consumption_7d)
                    - current_stock_quantity
                as int64),
                0
            )
        ELSE  0
    END as suggested_replenish_qty,

    CASE 
        WHEN avg_daily_consumption_7d is null then 'Consumo Insuficiente'
        WHEN days_of_stock <= 3 THEN 'Risco de Ruptura'  
        ELSE  'Estoque Saudável'
    END as replenishment_reason

FROM decision