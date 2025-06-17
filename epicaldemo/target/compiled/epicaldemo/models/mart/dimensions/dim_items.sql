WITH

items AS (
    SELECT
        *
    FROM EPICALDEMO.broman_analytics.stg_d365_fo__items
),

item_attributes AS (
    SELECT
        *
    FROM EPICALDEMO.broman_analytics.stg_inriver__item_attributes
),

categories AS (
    SELECT
        *
    FROM EPICALDEMO.broman_analytics.stg_d365_fo__categories
),

managers AS (
    SELECT
        *
    FROM EPICALDEMO.broman_analytics.stg_d365_fo__managers
),

unknown AS (
    SELECT
        -1 AS item_id
        ,'Unknown' AS "SKU"
        ,'Unknown' AS "Item"
        ,'Missing' AS "Brand"
        ,'Missing' AS "Flavor"
        ,'Missing' AS "Crunch Level"
        ,'Missing' AS "Snack Time"
        ,'Missing' AS "Category"
        ,'Missing' AS "Manager"
),

missing AS (
    SELECT
        -2 AS item_id
        ,'Missing' AS "SKU"
        ,'Missing' AS "Item"
        ,'Missing' AS "Brand"
        ,'Missing' AS "Flavor"
        ,'Missing' AS "Crunch Level"
        ,'Missing' AS "Snack Time"
        ,'Missing' AS "Category"
        ,'Missing' AS "Manager"
),

final AS (
    SELECT
        items.item_id
        ,items."SKU"
        ,items."Item"
        ,items."Brand"
        ,items."Flavor"
        ,COALESCE(item_attributes."Crunch Level", 'Missing') AS "Crunch Level"
        ,COALESCE(item_attributes."Snack Time", 'Missing') AS "Snack Time"
        ,categories."Category"
        ,managers."Manager"
    FROM items
    LEFT JOIN item_attributes ON item_attributes."SKU" = items."SKU"
    LEFT JOIN categories ON categories.category_id = items.category_id
    LEFT JOIN managers ON managers.manager_id = categories.manager_id

    UNION

    SELECT * FROM unknown

    UNION

    SELECT * FROM missing
)

SELECT * FROM final