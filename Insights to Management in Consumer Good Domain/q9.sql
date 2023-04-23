with cte as (select c.channel as channel_,round(sum(p.gross_price *m.sold_quantity)/1000000,2) as gross_sales_mln
from fact_sales_monthly m
join fact_gross_price p on 
m.product_code=p.product_code and m.fiscal_year=p.fiscal_year
join dim_customer c
on m.customer_code=c.customer_code
where m.fiscal_year=2021
group by channel_)
SELECT channel_,
       CONCAT('$',gross_sales_mln,' M') AS gross_sales,
	CONCAT(ROUND(gross_sales_mln/ SUM(gross_sales_mln) over () *100,2),'%') AS percentage
FROM cte
ORDER BY percentage DESC;

