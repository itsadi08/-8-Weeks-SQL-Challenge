with cte as
 (select 
	count(distinct case when fiscal_year=2020 then product_code end )as Unique_product_2020,
	count(distinct case when fiscal_year=2021 then product_code end) as Unique_product_2021
from fact_gross_price ) 
select Unique_product_2020,Unique_product_2021,
concat(round((Unique_product_2021-Unique_product_2020)*100/Unique_product_2020,2),'%') as pct_change from cte


select * from dim_customer