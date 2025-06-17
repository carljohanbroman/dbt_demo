WITH

source AS (
    SELECT
        *
    FROM EPICALDEMO.d365_fo.date
),

final AS (
    SELECT
        id AS date_id
        ,date AS "Date"
        ,year AS "Year"
        ,yearmonth AS "Year Month"
        ,TO_CHAR(TO_DATE(id::string, 'YYYYMMDD'), 'YYYY-MM') AS "Year Month Number"
        ,DATEDIFF(MONTH, DATE_TRUNC('MONTH', CURRENT_DATE), DATE_TRUNC('MONTH', date)) AS month_offset
        ,monthnumber AS "Month Number"
        ,quarter AS "Quarter"
        ,quarternumber AS "Quarter Number"
        ,monthname AS "Month"
        ,LEFT(monthname,3) AS "Month Short"
    FROM source
)

SELECT * FROM final