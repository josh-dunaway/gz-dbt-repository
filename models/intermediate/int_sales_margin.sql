SELECT 
    date_date, 
    orders_id,
    products_id, 
    revenue, 
    quantity, 
    CAST(purchase_price AS FLOAT64) AS purchase_price, 
    ROUND(s.quantity*CAST(p.purchase_price AS FLOAT64),2) AS purchase_cost,
    ROUND(s.revenue - s.quantity*CAST(p.purchase_price AS FLOAT64),2) AS margin,
    {{ margin_percent('s.revenue', 's.quantity*CAST(p.purchase_price AS FLOAT64)')}} AS margin_percent
FROM {{ref("stg_raw__sales")}} s
LEFT JOIN {{ref("stg_raw__product")}} p 
USING (products_id)