WITH

source AS (
    SELECT
        *
    FROM EPICALDEMO.d365_fo.manager
),

final AS (
    SELECT
        id AS manager_id
        ,INITCAP(firstname || ' ' || lastname) AS "Manager"
    FROM source
)

SELECT * FROM final