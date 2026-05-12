/* product report
pourpose :
	- this report consolidates key product metrics and behaviors

highlights:
	1. gathers essential fields such as product name, category, subcategory and cost.
	2. segments roduct by revenue to identity high-performers, mid-range, or low-performance.
	3. aggregates product-level metric:
		- total orders
		- total sales
		- total quantity
		- total customer (unique)
		- lifespan (in month)
	4. calculate valuable KPIs:
		- recency (month since last sale)
		- average order revenue (AOR)
		- average monthly revenue
*/

create view gold.report_product as 
with cte as
(
select
	p.product_key,
	p.product_name,
	p.category,
	p.subcategory,
	p.cost,
	s.order_number,
	s.customer_key,
	s.order_date,
	s.sales_amount,
	s.quantity,
	s.price
from gold.dim_products as p
left join gold.fact_sales as s
on p.product_key = s.product_key
where s.order_date is not null
)

select 
	product_name,
	sum(cost) as total_cost,
	count(distinct order_number) as total_order,
	sum(sales_amount) as total_sales,
	sum(quantity) as total_quantity,
	count(distinct customer_key) as total_customer,
	DATEDIFF(month,min(order_date),max(order_date)) as lifespan,
	sum(sales_amount) - sum(cost) as revenue,
	case when sum(sales_amount) - sum(cost) between 15000 and 40000 then 'mid range'
		 when sum(sales_amount) - sum(cost) >40000 then 'high performance'
		 else 'low performance'
		 end as performance_revenue,
	DATEDIFF(month,max(order_date),GETDATE()) as recency_in_month,
	case when count(distinct order_number) = 0 then '0'
		 else sum(sales_amount) - sum(cost) / count(distinct order_number)
		 end as average_order_revenue,
	case when count(distinct order_number) = 0 then '0'
		 else sum(sales_amount) - sum(cost) / DATEDIFF(month,min(order_date),max(order_date))
		 end as average_monthly_revenue
from cte
group by product_name














