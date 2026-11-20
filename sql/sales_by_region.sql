-- Example report query: sales by region (the kind of query a "Sales by Region" Tableau sheet is built on)
SELECT r.region_name,
       SUM(f.amount) AS total_sales
FROM   dwh.fact_orders  f
JOIN   dwh.dim_customer c ON c.customer_id = f.customer_id
JOIN   dwh.dim_region   r ON r.country     = c.country
GROUP  BY r.region_name
ORDER  BY total_sales DESC;
