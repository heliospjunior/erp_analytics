{{ config(materialized='table') }}

WITH SOURCE as (

    SELECT
        product_id,
        product_name,
        category as category_name,
        brand as brand_name,
        unit_cost,
        unit_price,
        created_at as product_created_at
    FROM {{source('erp', 'raw_products')}}

),


    casted as (

        SELECT
            cast(product_id as int64) as product_id,
            cast(product_name as string) as product_name,
            cast(category_name as string) as category_name,
            cast(brand_name as string)  as brand_name,
            cast(unit_cost as numeric) as unti_cost,
            cast(unit_price as NUMERIC) as unit_price,
            timestamp(product_created_at) as product_created_at
        from source


    )

SELECT *
FROM casted