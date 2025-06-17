WITH

source AS (
    SELECT
        *
    FROM EPICALDEMO.d365_fo.category
),

final AS (
    SELECT
        id AS category_id
        ,INITCAP(name) AS "Category"
        ,managerid AS manager_id
    FROM source
)

SELECT * FROM final