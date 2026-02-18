with inventory as (

    SELECT 
        store_id,
        product_id,
        date(snapshot_date) as snapshot_date,
        stock_quantity,

        lag(stock_quantity) over (
            partition by store_id, product_id
            order by snapshot_date
        ) as previous_stock_quantity

    from {{ ref('snap_inventory')}}

)

SELECT 
    store_id,
    product_id,
    snapshot_date,
    stock_quantity,
    previous_stock_quantity,

    stock_quantity - previous_stock_quantity as stock_delta,

    CASE 
        WHEN stock_quantity = 0 THEN true  
        ELSE  false
    END as is_stockout

from inventory