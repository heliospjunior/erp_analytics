with source as (

    SELECT
        store_id,
        store_name,
        city,
        state,
        opened_at
    from {{ source('erp', 'raw_stores')}}
),

casted as (

    SELECT
        cast(store_id as int64) as store_id,
        cast(store_name as string) as store_name,
        cast(city as string) as city,
        cast(state as string) as state,
        timestamp(opened_at) as opened_at
    from source
)

SELECT *
from casted