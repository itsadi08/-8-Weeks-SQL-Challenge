select* from (select b.division,b.product_code,b.product,sum(a.sold_quantity) as total_sold_quantity,
rank() over(partition by b.division order by sum(a.sold_quantity) desc) as rank_order from dim_product b
join fact_sales_monthly a on b.product_code=a.product_code
where fiscal_year=2021
group by b.division,b.product_code,b.product) t1
where t1.rank_order<4