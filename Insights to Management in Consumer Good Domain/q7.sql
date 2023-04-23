select monthname(date) as Month,year(date) as Year, 
concat('$ ',round(sum(c.gross_price*a.sold_quantity)/1000000,2),' M')
as Gross_sales_Amount
from fact_sales_monthly a
join dim_customer b on a.customer_code=b.customer_code 
join fact_gross_price c on a.product_code=c.product_code
and a.fiscal_year=c.fiscal_year
where customer="Atliq Exclusive"
group by monthname(date),year(date)
order by Year

