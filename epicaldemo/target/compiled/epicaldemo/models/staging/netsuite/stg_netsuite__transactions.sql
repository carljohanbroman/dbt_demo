WITH

source AS (
    SELECT
        *
    FROM EPICALDEMO.netsuite.transactions
),

final AS (
    SELECT
        -- Identifiers
        id
        ,updated_at
        ,CAST(TO_CHAR(transaction_date::DATE, 'YYYYMMDD') AS INTEGER) AS transaction_date_id
        ,sku AS "SKU"
        ,store AS "Store"
        ,customernumber AS "Customer Number"

        -- Metrics
        ,quantity AS "Qty"
        ,unitprice::NUMERIC(10,2) AS "Unit Price"
        ,(quantity * unitprice)::NUMERIC(10,2) AS "Sales Amount"
        ,unitcost::NUMERIC(10,2) AS "Unit Cost"
        ,(quantity * unitcost)::NUMERIC(10,2) AS "Cost"
        ,(quantity * unitprice)::NUMERIC(10,2) - (quantity * unitcost)::NUMERIC(10,2) AS "Margin"
    FROM source
)

SELECT * FROM final