{% snapshot snap_inventory %}

{{
    config(
        unique_key= 'inventory_sk',
        strategy='timestamp',
        updated_at='snapshot_date'
    )
}}

SELECT
    cast(store_id as int64) as store_id,
    cast(product_id as int64) as product_id,
    concat(store_id, '-', product_id) as inventory_sk,
    cast(stock_quantity as int64) as stock_quantity,
    timestamp(snapshot_date) as snapshot_date
from {{ source('erp', 'raw_inventory_snapshot') }}

{% endsnapshot %}