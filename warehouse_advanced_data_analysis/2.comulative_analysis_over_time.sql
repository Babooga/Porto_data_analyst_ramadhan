WITH cte AS
(
    SELECT 
        DATETRUNC(month, order_date) AS order_month,
        SUM(sales_amount) AS total_sales,
        avg(price) as avg_price
    FROM gold.fact_sales
    WHERE order_date IS NOT NULL
    GROUP BY DATETRUNC(month, order_date)
)
SELECT 
    order_month,
    total_sales,
    SUM(total_sales) OVER(ORDER BY order_month) AS running_total_sales,
    avg_price,
    avg(avg_price) over(order by order_month) as moving_average_price
FROM cte;

-- can be quantity, price, sales