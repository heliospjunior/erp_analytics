SELECT
    store_id,
    product_id,
    snapshot_date,
    current_stock_quantity,
    avg_daily_consumption_7d,
    days_of_stock,
    suggested_replenish_qty,
    should_replenish,

    CASE 
        WHEN avg_daily_consumption_7d = 0 THEN 'SEM_CONSUMO' 
        WHEN should_replenish = TRUE AND days_of_stock <=3 THEN 'URGENTE' 
        WHEN days_of_stock BETWEEN 4 and 7 THEN 'ATENCAO' 
        WHEN days_of_stock > 7 THEN 'OK' 
        ELSE 'REVISAR'
    END as replenishment_action

FROM {{ref('fct_inventory_replenishment')}}