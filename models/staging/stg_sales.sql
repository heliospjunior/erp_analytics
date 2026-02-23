with source as (

    SELECT 
        sale_id,
        sale_datetime,
        store_id,
        product_id,
        quantity,
        unit_price,
        total_amount
    from {{ source('erp', 'raw_sales')}}
),

casted as (

    SELECT
        cast(sale_id as int64) as sale_id,
        cast(sale_datetime as timestamp) as sale_datetime,
        cast(store_id as int64) as store_id,
        cast(product_id as int64) as product_id,
        cast(quantity as int64) as quantity,
        cast(unit_price as numeric) as unit_price,
        cast(total_amount as numeric) as total_amount
    from source
),

enriched as (

    SELECT
        s.*,
        p.product_name,
        p.category_name,
        p.brand_name
    from casted s
    LEFT JOIN {{ ref('stg_products') }} p
        on s.product_id = p.product_id

)

SELECT *
from enriched