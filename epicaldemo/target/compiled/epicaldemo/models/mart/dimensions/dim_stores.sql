WITH

store AS (
    SELECT
        *
    FROM EPICALDEMO.broman_analytics.stg_d365_fo__stores
),

final AS (
    SELECT
        -- Identifiers
        store_id

        -- SCD2 Fields
        ,store_key
        ,is_current
        --,modified
        ,valid_from
        ,valid_to

        -- Attributes
        ,"Store State"
        ,"Store City"
        ,"Store"
        ,"Lat"
        ,"Lon"
        ,"Online Presence"
    FROM store
)

SELECT * FROM final