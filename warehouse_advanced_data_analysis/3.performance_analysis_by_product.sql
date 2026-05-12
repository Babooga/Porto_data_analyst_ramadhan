with cte as 
(
select 
	year(s.order_date) as order_year,
	p.product_name,
	sum(s.sales_amount) as current_sales
from gold.dim_products as p
left join gold.fact_sales as s on p.product_key = s.product_key
where year(s.order_date) is not null
group by year(s.order_date), p.product_name
)
select 
	order_year,
	product_name,
	current_sales,
	avg(current_sales) over(partition by product_name) as average_sales,
	current_sales - avg(current_sales) over(partition by product_name) as diff_avg,
	case when current_sales - avg(current_sales) over(partition by product_name) > 0 then 'above_avg'
		 when current_sales - avg(current_sales) over(partition by product_name) < 0 then 'below_avg'
		 else 'avg'
		 end as avg_changes,
	lag(current_sales) over(partition by product_name order by order_year) as previus_year_sales,
	current_sales - lag(current_sales) over(partition by product_name order by order_year) as previus_year_diff,
	case when current_sales - lag(current_sales) over(partition by product_name order by order_year) > 0 then 'increase'
		 when current_sales - lag(current_sales) over(partition by product_name order by order_year) < 0 then 'decrease'
		 else 'no change'
		 end as change
from cte
order by product_name, order_year;

-- if want to zoom in the analysis to month to month then just change the 'month(order_date) as order_month'
