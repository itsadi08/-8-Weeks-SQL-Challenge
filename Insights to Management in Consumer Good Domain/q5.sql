select a.product_code, p.product,concat('$',round(a.manufacturing_cost,2)) as manufacturing_cost from fact_manufacturing_cost as a
join dim_product p on
a.product_code=p.product_code
where a.manufacturing_cost=(select max(manufacturing_cost) from fact_manufacturing_cost) 
or a.manufacturing_cost=(select min(manufacturing_cost) from fact_manufacturing_cost)
order by a.manufacturing_cost desc