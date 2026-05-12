-- which category that contribute the most total sales, its the 'Bikes'

with cte as 
(
select category,
	sum(s.sales_amount) as total_sales_category
from gold.dim_products as p
left join gold.fact_sales as s on p.product_key = s.product_key
where s.order_date is not null
group by category
)
select category,
	total_sales_category,
	sum(total_sales_category) over() as overall_sales,
	concat(round(cast(total_sales_category as float) / cast(sum(total_sales_category) over() as float) * 100,2),' %') as percentage
from cte
order by concat(round(cast(total_sales_category as float) / cast(sum(total_sales_category) over() as float) * 100,2),' %') desc;


-- which product contribute the most for total sales 'Mountain-200 Black- 46'
with cte as 
(
select p.product_name,
	sum(s.sales_amount) as total_sales_product
from gold.dim_products as p
left join gold.fact_sales as s on p.product_key = s.product_key
where s.order_date is not null
group by p.product_name
)
select product_name,
	total_sales_product,
	sum(total_sales_product) over() as overall_sales,
	concat(round(cast(total_sales_product as float) / cast(sum(total_sales_product) over() as float) * 100,2),' %') as percentage
from cte
order by concat(round(cast(total_sales_product as float) / cast(sum(total_sales_product) over() as float) * 100,2),' %') desc;
