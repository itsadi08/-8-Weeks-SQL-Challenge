select t1.segment,t1.product_count_2021,t1.product_count_2020,(product_count_2021-product_count_2020) as Difference 
from(SELECT p.segment as Segment, 
       COUNT(DISTINCT case when fiscal_year=2020 then f.product_code end) AS Product_count_2020,
       COUNT(DISTINCT case when fiscal_year=2021 then f.product_code end) AS Product_count_2021
FROM fact_gross_price f
join dim_product p on p.product_code=f.product_code 
group by segment) as t1
order by difference desc




