WITH

source AS (
    SELECT
        *
    FROM {{ source('inriver', 'item_attributes') }}
),

final AS (
    SELECT
        id AS item_attributes_id
        ,sku AS "SKU"
        ,COALESCE(crunch_level, 'Missing') AS "Crunch Level"
        ,COALESCE(snack_time, 'Missing') AS "Snack Time"
    FROM source
)

SELECT * FROM final