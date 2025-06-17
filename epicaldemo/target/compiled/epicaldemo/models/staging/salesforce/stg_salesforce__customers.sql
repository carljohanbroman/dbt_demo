WITH

source AS (
    SELECT
        *
    FROM EPICALDEMO.salesforce.customer
),

final AS (
    SELECT
        id AS customer_id
        ,customernumber AS "Customer Number"
        ,age AS "Customer Age"

        ,CASE
            WHEN age < 20 THEN '< 20'
            WHEN age >= 20 AND age < 30 THEN '20 - 30'
            WHEN age >= 30 AND age < 50 THEN '30 - 50'
            WHEN age >= 50 AND age < 60 THEN '50 - 60'
            ELSE '60+'
         END AS "Customer Age Group"

        ,CASE
            WHEN age < 20 THEN 1
            WHEN age >= 20 AND age < 30 THEN 2
            WHEN age >= 30 AND age < 50 THEN 3
            WHEN age >= 50 AND age < 60 THEN 4
            ELSE 5
         END AS customer_age_group_sort

        ,state AS "Customer State"
    FROM source
)

SELECT * FROM final