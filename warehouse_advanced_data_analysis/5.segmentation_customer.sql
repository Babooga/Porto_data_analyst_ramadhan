with cte as
(
select c.customer_key,
	sum(s.sales_amount) as total_spending,
	min(s.order_date) as first_order,
	max(s.order_date) as last_order,
	DATEDIFF(month,min(s.order_date),max(s.order_date)) as lifespan
from gold.dim_customers as c
left join gold.fact_sales as s
on c.customer_key = s.customer_key
where order_date is not null
group by c.customer_key
),

segment as 
(
select customer_key,
	total_spending,
	lifespan,
	case when total_spending > 5000 and lifespan >= 12 then 'VIP'
		 when total_spending <= 5000 and lifespan >= 12 then 'Regular'
		 else 'New'
		 end as segmentation
from cte
)
select segmentation,
	count(customer_key)
from segment
group by segmentation
order by segmentation asc;