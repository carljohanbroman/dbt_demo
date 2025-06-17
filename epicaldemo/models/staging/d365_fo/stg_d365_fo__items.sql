WITH

source AS (
    SELECT
        *
    FROM {{ source('d365_fo', 'item') }}
),

final AS (
    SELECT
        id AS item_id
        ,name AS "Item"
        ,COALESCE(brand, 'Missing') AS "Brand"
        ,categoryid AS category_id
        ,COALESCE(flavor, 'Missing') AS "Flavor"
        ,sku AS "SKU"
    FROM source
)

SELECT * FROM final