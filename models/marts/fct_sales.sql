with sales as (

    SELECT
        sale_id,
        sale_datetime,
        store_id,
        product_id,
        quantity,
        unit_price,
        total_amount
    from {{ ref('stg_sales')}}

)

SELECT *
from sales