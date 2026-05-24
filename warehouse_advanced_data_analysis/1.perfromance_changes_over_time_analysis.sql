

select 
	datetrunc(month,order_date) as order_year,
	sum(sales_amount) as total_sales,
	sum(customer_key) as total_customer,
	sum(quantity) as total_quantity
from gold.fact_sales
where order_date is not null
group by datetrunc(month,order_date)
order by datetrunc(month,order_date);


-- or we can do this

select 
	year(order_date) as order_year,
	month(order_date) as order_month,
	sum(sales_amount) as total_sales,
	sum(customer_key) as total_customer,
	sum(quantity) as total_quantity
from gold.fact_sales
where order_date is not null
group by year(order_date),month(order_date)
order by year(order_date),month(order_date);
