{{ config(
    materialized='incremental',
    unique_key=['transaction_date_id', 'item_id', 'store_key', 'customer_id']
) }}

WITH

sales AS (
    SELECT
        *
    FROM {{ ref('stg_netsuite__transactions')}}

    {% if is_incremental() %}
    WHERE UPDATED_AT >= (SELECT MAX(UPDATED_AT) FROM {{ this }})
    {% endif %}
),

items AS (
    SELECT
        *
    FROM {{ ref('stg_d365_fo__items')}}
),

stores AS (
    SELECT
        *
    FROM {{ ref('stg_d365_fo__stores')}}
),

customers AS (
    SELECT
        *
    FROM {{ ref('stg_salesforce__customers')}}
),

final AS (
    SELECT
        -- Identifiers
        sales.id
        ,sales.transaction_date_id
        ,sales.updated_at
        ,CONVERT_TIMEZONE('Europe/Stockholm', CURRENT_TIMESTAMP()) AS loaded_at

        ,CASE
            WHEN sales.sku IS NULL THEN -2 -- SKU is missing FROM Source
            WHEN items.item_id IS NULL THEN -1 -- SKU is not known FROM Source
            ELSE items.item_id -- Use item_id FROM Dim based on SKU
         END AS item_id

        ,CASE
            WHEN sales."Store" IS NULL THEN -2
            WHEN stores.store_key IS NULL THEN -1
            ELSE stores.store_key
         END AS store_key

        ,CASE
            WHEN sales."Customer Number" IS NULL THEN -2
            WHEN customers.customer_id IS NULL THEN -1
            ELSE customers.customer_id
         END AS customer_id

        -- Metrics
        ,sales."Qty"
        ,sales."Unit Price"
        ,sales."Sales Amount"
        ,sales."Unit Cost"
        ,sales."Cost"
        ,sales."Margin"
    FROM sales
    LEFT JOIN items ON items."SKU" = sales."SKU"
    LEFT JOIN stores ON stores."Store" = sales."Store" AND sales.transaction_date_id >= stores.valid_from AND sales.transaction_date_id < stores.valid_to
    LEFT JOIN customers ON customers."Customer Number" = sales."Customer Number"
)

SELECT * FROM final