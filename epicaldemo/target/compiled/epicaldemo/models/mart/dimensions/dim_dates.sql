WITH

dates AS (
    SELECT
        *
    FROM EPICALDEMO.broman_analytics.stg_d365_fo__dates
),

final AS (
    SELECT
        date_id
        ,"Date"
        ,"Year"
        ,"Year Month"
        ,"Year Month Number"
        ,month_offset
        ,"Month Number"
        ,"Quarter"
        ,"Quarter Number"
        ,"Month"
        ,"Month Short"
    FROM dates
)

SELECT * FROM final