WITH cte AS (
  SELECT 
    a.product, 
    a.category, 
    a.brand, 
    a.description, 
    a.sale_price, 
    a.cost_price, 
    a.image_url, 
    b.date, 
    b.customer_type, 
    b.discount_band, 
    b.units_sold, 
    (sale_price * units_sold) AS Revenue, 
    (cost_price * units_sold) AS Total_Cost, 
    FORMAT(date, 'MMMM') AS month, 
    FORMAT(date, 'yyyy') AS Year 
  FROM 
    product_data a 
    JOIN product_sales b ON a.product_id = b.product
)
SELECT
  *,
  (1 - Discount * 1.0 / 100) * Revenue AS Discount_Revenue
FROM cte a 
JOIN discount_data b 
  ON a.Discount_Band = b.Discount_Band 
  AND a.month = b.Month;
