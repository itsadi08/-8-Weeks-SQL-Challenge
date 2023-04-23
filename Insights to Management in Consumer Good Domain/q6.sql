select b.customer_code,b.customer,
concat(round(avg(pre_invoice_discount_pct)*100,2),'%') as average_discount_percentage 
from fact_pre_invoice_deductions a
join dim_customer b 
on a.customer_code=b.customer_code
where b.market="India" and a.fiscal_year=2021
group by b.customer_code,b.customer
order by avg(pre_invoice_discount_pct) desc
limit 5