/*
pourpose:
	- this report consolidates key customer and behaviors

highlights:
	1. gathers essential fields suchs as names, ages, and transaction details
	2. segments customer into categories (vip, regular, new) and age group
	3. aggregates customer-level metrics:
		- total orders
		- total sales
		- total quantity purchased
		- total products
		- lifespan (in month)
	4. calculate valuable KPIs:
		- recency (months since last order)
		- average order value
		- average monthly spend
*/

create view gold.report_customer as 
with cte as 
(
select 
	c.customer_key,
	c.customer_number,
	concat(c.first_name,' ', c.last_name) as full_name,
	c.birthdate,
	DATEDIFF(year,min(c.birthdate),GETDATE()) as age,
	s.order_number,
	s.product_key,
	s.order_date,
	s.sales_amount,
	s.quantity,
	s.price
from gold.dim_customers as c
left join gold.fact_sales as s
on c.customer_key = s.customer_key
where s.order_date is not null
group by 
	c.customer_key,
	c.customer_number,
	concat(c.first_name,' ', c.last_name),
	c.birthdate,s.order_number,
	s.product_key,
	S.order_date,
	s.sales_amount,
	s.quantity,
	s.price
),
cte2 as 
(
select 
	customer_key,
	customer_number,
	full_name,
	age,
	min(order_date) as first_order,
	max(order_date) as last_order,
	count(order_number) as total_order,
	sum(sales_amount) as total_sales,
	sum(quantity) as total_quantity,
	count(distinct product_key) as total_product,
	datediff(month,min(order_date), max(order_date)) as lifespan
from cte
group by 
	customer_key,
	customer_number,
	full_name,
	age
)

select
	customer_key,
	customer_number,
	full_name,
	age,
	case when age < 20 then 'under 20'
		 when age between 20 and 29 then '20-29'
		 when age between 30 and 39 then '30-39'
		 when age between 40 and 49 then '40-49'
		 when age between 50 and 59 then '50-59'
		 else '59+'
		 end as segmentation_age,
	case when total_sales > 5000 and lifespan >= 12 then 'VIP'
		 when total_sales <= 5000 and lifespan >= 12 then 'Regular'
		 else 'New'
		 end as segmentation_performance,
	total_order,
	total_sales,
	total_quantity,
	total_product,
	lifespan,
	DATEDIFF(month,last_order,GETDATE()) as recency_in_month,
	case when total_sales = 0 then '0'
		 else total_sales / total_order
		 end as average_order_value,
	case when lifespan = 0 then '0'
		 else total_sales / lifespan
		 end as average_monthly_spend
from cte2
group by 
	customer_key,
	customer_number,
	full_name,
	age,
	total_order,
	total_sales,
	total_quantity,
	total_product,
	lifespan,
	DATEDIFF(month,last_order,GETDATE());
	




