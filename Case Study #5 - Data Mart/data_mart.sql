select* from weekly_sales;

/*In a single query, perform the following operations and 
generate a new table in the data_mart schema named clean_weekly_sales:
Convert the week_date to a DATE format
Add a week_number as the second column for each week_date value, for example any value from the 1st of January to 7th of January will be 1, 8th to 14th will be 2 etc
Add a month_number with the calendar month for each week_date value as the 3rd column
Add a calendar_year column as the 4th column containing either 2018, 2019 or 2020 values*/
describe weekly_sales;

alter table weekly_sales
modify week_date varchar(15);
update weekly_sales
set week_date=str_to_date(week_date,"%d/%m/%Y");

drop table if exists cleaned_weekly_sales;
create table cleaned_weekly_sales
select
date_format(week_date,'%Y-%m-%d') as week_date,
extract(week from week_date+ interval 1 week ) as Week_,
extract(month from week_date) as Month_,  
extract(year from week_date) as Year_, 
region,
platform,
segment,
customer_type,
case
	when Right(segment,1)='1' then 'Young Adults'
    when Right(segment,1)='2' then 'Middle Aged'
    when Right(segment,1) in ('3','4') then 'Retirees'
    else 'Unknown' 
    end as age_band,
case
    when left(segment,1)='C' then 'Couples'
    when left(segment,1)='F' then 'Families'
    else 'Unknown' end as demographic,
transactions,
sales,
round(sales/transactions,2) as avg_transaction
from weekly_sales;

alter table cleaned_weekly_sales
modify column week_date date;
alter table cleaned_weekly_sales
modify column sales bigint;


select * from cleaned_weekly_sales;

-- 2. Data Exploration
-- What day of the week is used for each week_date value?
select distinct(date_format(week_date, '%W')) as dayofweek from cleaned_weekly_sales;

-- What range of week numbers are missing from the dataset?
with recursive week_num as  (
select 1 as num
union all
select 1+num 
from week_num
where num<52) 
select group_concat(num separator '; ') as missing_weeks , count(num) as total_miss_weeks from week_num wn
left join cleaned_weekly_sales cws on wn.num=cws.Week_
where Week_ is null
order by num;

-- How many total transactions were there for each year in the dataset?
select year(week_date) as Year_,sum(transactions) as Total_transactions from cleaned_weekly_sales
group by year(week_date);

-- What is the total sales for each region for each month?
select region,monthname(week_date) as Month_,sum(sales) as Total_sales from cleaned_weekly_sales
group by region,monthname(week_date)
order by region;

-- What is the total count of transactions for each platform
select platform,sum(transactions) as Total_transactions from cleaned_weekly_sales
group by platform;

-- What is the percentage of sales for Retail vs Shopify for each month?
with cte as(
select monthname(week_date) as Month,Year_,platform,sum(sales) as Monthly_sales
from cleaned_weekly_sales
group by Month,Year_,platform)
select 
Year_,Month,
round(max(case when platform='Retail' then Monthly_sales end)*100/sum(Monthly_sales),2) as pct_sales_Retail,
round(max(case when platform='Shopify' then Monthly_sales end)*100/sum(Monthly_sales),2) as pct_sales_Shopify
from cte
group by Year_,Month
order by Year_,Month;

-- What is the percentage of sales by demographic for each year in the dataset?

with cte as(
select Year_,demographic,sum(sales) as Yearly_sales
from cleaned_weekly_sales
group by Year_,demographic)
select 
Year_,
round(max(case when demographic='Couples' then Yearly_sales end)*100/sum(Yearly_sales),2) as Couples_pct_sales,
round(max(case when demographic='Families' then Yearly_sales end)*100/sum(Yearly_sales),2) as Families_pct_sales,
round(max(case when demographic='Unknown' then Yearly_sales end)*100/sum(Yearly_sales),2) as Unknown_pct_sales
from cte
group by Year_
order by Year_;

-- Which age_band and demographic values contribute the most to Retail sales?

select age_band,demographic,sum(sales) total_sales,round(sum(sales)*100/(select sum(sales) from cleaned_weekly_sales where platform='Retail'),2) as pct_sales
from cleaned_weekly_sales
where platform='Retail'
group by age_band,demographic
order by total_sales desc;

-- Can we use the avg_transaction column to find the average transaction size for each year for Retail vs Shopify? If not - how would you calculate it instead?


select year_, platform, round(avg(avg_transaction),2) as avg_transaction_col,
round(sum(sales)/sum(transactions),2) as avg_transaction_group
from cleaned_weekly_sales
group by year_, platform
order by  year_, platform;

-- Taking the week_date value of 2020-06-15 as the baseline week where the Data Mart sustainable packaging changes came into effect.


-- What is the total sales for the 4 weeks before and after 2020-06-15? What is the growth or reduction rate in actual values and percentage of sales?

with cte as(select 
sum(case when week_ between '21' and '24' then sales end) as before_weeks,
sum(case when week_ between '25' and '28' then sales end) as after_weeks
from cleaned_weekly_sales
where Year_='2020')
select *,after_weeks-before_weeks as growth,round((after_weeks-before_weeks)*100/(before_weeks),2) as pct_change
from cte


-- What about the entire 12 weeks before and after?
set @week_change=25;
with cte as(select 
sum(case when week_ between @week_change-12 and  @week_change-1 then sales end) as before_weeks,
sum(case when week_ between  @week_change and  @week_change+11 then sales end) as after_weeks
from cleaned_weekly_sales
where Year_='2020')
select *,after_weeks-before_weeks as growth,round((after_weeks-before_weeks)*100/(before_weeks),2) as pct_change
from cte


-- How do the sale metrics for these 2 periods before and after compare with the previous years in 2018 and 2019?

with cte as(select Year_ ,
sum(case when week_ between @week_change-4 and @week_change-1 then sales end) as before_weeks,
sum(case when week_ between @week_change and @week_change+3 then sales end) as after_weeks
from cleaned_weekly_sales
group by Year_)
select *,after_weeks-before_weeks as growth,round((after_weeks-before_weeks)*100/(before_weeks),2) as pct_change
from cte

with cte as(select Year_,
sum(case when week_ between @week_change-12 and  @week_change-1 then sales end) as before_weeks,
sum(case when week_ between  @week_change and  @week_change+11 then sales end) as after_weeks
from cleaned_weekly_sales
group by Year_)
select *,after_weeks-before_weeks as growth,round((after_weeks-before_weeks)*100/(before_weeks),2) as pct_change
from cte

-- Which areas of the business have the highest negative impact in sales metrics performance in 2020 for the 12 week before and after period?

-- region
with cte as(select region,
sum(case when week_ between @week_change-12 and  @week_change-1 then sales end) as before_weeks,
sum(case when week_ between  @week_change and  @week_change+11 then sales end) as after_weeks
from cleaned_weekly_sales
where Year_='2020'
group by region)
select *,after_weeks-before_weeks as growth,round((after_weeks-before_weeks)*100/(before_weeks),2) as pct_change
from cte
order by pct_change desc


-- platform
with cte as(select platform,
sum(case when week_ between @week_change-12 and  @week_change-1 then sales end) as before_weeks,
sum(case when week_ between  @week_change and  @week_change+11 then sales end) as after_weeks
from cleaned_weekly_sales
where Year_='2020'
group by platform)
select *,after_weeks-before_weeks as growth,round((after_weeks-before_weeks)*100/(before_weeks),2) as pct_change
from cte
order by pct_change desc

-- age_band

with cte as(select age_band,
sum(case when week_ between @week_change-12 and  @week_change-1 then sales end) as before_weeks,
sum(case when week_ between  @week_change and  @week_change+11 then sales end) as after_weeks
from cleaned_weekly_sales
where Year_='2020'
group by age_band)
select *,after_weeks-before_weeks as growth,round((after_weeks-before_weeks)*100/(before_weeks),2) as pct_change
from cte
order by pct_change desc

-- demographic
with cte as(select demographic,
sum(case when week_ between @week_change-12 and  @week_change-1 then sales end) as before_weeks,
sum(case when week_ between  @week_change and  @week_change+11 then sales end) as after_weeks
from cleaned_weekly_sales
where Year_='2020'
group by demographic)
select *,after_weeks-before_weeks as growth,round((after_weeks-before_weeks)*100/(before_weeks),2) as pct_change
from cte
order by pct_change desc

-- customer_type
with cte as(select customer_type,
sum(case when week_ between @week_change-12 and  @week_change-1 then sales end) as before_weeks,
sum(case when week_ between  @week_change and  @week_change+11 then sales end) as after_weeks
from cleaned_weekly_sales
where Year_='2020'
group by customer_type)
select *,after_weeks-before_weeks as growth,round((after_weeks-before_weeks)*100/(before_weeks),2) as pct_change
from cte
order by pct_change desc