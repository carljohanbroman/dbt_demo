WITH

stores_snapshots AS (
    SELECT
        *
    FROM {{ ref('stores_snapshot')}}
),

final AS (
    SELECT
        -- Identifiers
        id AS store_id

        -- SCD2 Fields
        ,dbt_scd_id
        ,ROW_NUMBER() OVER (ORDER BY id ASC, dbt_valid_from ASC) AS store_key
        ,CASE WHEN dbt_valid_to = '9999-12-31' THEN 1 ELSE 0 END AS is_current
        ,modified
        ,CAST(TO_CHAR(dbt_valid_from::DATE, 'YYYYMMDD') AS INTEGER) AS valid_from
        ,CAST(TO_CHAR(dbt_valid_to::DATE, 'YYYYMMDD') AS INTEGER) AS valid_to

        -- Attributes
        ,name AS "Store"
        ,SPLIT_PART(location, ',', 1) AS "Store State"
        ,SPLIT_PART(location, ',', 2) AS "Store City"
        ,latitude AS "Lat"
        ,longitude AS "Lon"
        ,onlinepresence AS "Online Presence"
    FROM stores_snapshots
)

SELECT * FROM final