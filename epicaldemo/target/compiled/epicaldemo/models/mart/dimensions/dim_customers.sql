WITH

customers AS (
    SELECT
        *
    FROM EPICALDEMO.broman_analytics.stg_salesforce__customers
),

final AS (
    SELECT
        customer_id
        ,"Customer Number"
        ,"Customer Age"
        ,"Customer Age Group"
        ,customer_age_group_sort
        ,"Customer State"
    FROM customers
)

SELECT * FROM final