# 🏬 Case Study #5 - Danny's Diner

<p align ="center">
 <img width="300" height="300" src="https://user-images.githubusercontent.com/121611397/233727924-ed8b7526-3b36-4554-bbca-28de416b114a.png">
</p>


## 📕 Table of Contents

 -	[Problem Statement](https://github.com/itsadi08/8-Weeks-SQL-Challenge/tree/main/Case%20Study%20%235%20-%20Data%20Mart#-problem-statement)   

 - [Entity Relationship Diagram](https://github.com/itsadi08/8-Weeks-SQL-Challenge/tree/main/Case%20Study%20%235%20-%20Data%20Mart#-entity-relationship-diagram)

 -	[Case Study Questions and Bonus Questions](https://github.com/itsadi08/8-Weeks-SQL-Challenge/tree/main/Case%20Study%20%235%20-%20Data%20Mart#-case-study-and-bonus-questions)

 - [SQL Queries for Questions](https://github.com/itsadi08/8-Weeks-SQL-Challenge/tree/main/Case%20Study%20%235%20-%20Data%20Mart#-sql-queries-for-questions)
 
 -	[Insights and Learnings](https://github.com/itsadi08/8-Weeks-SQL-Challenge/tree/main/Case%20Study%20%235%20-%20Data%20Mart#-insights-and-learnings)

## 📝 Problem Statement
Join Danny's latest venture at Data Mart! As the mastermind behind an online supermarket specializing in fresh produce, Danny needs your expertise to analyze the sales performance following a large-scale supply change. In June 2020, Data Mart implemented sustainable packaging methods throughout their entire farm-to-customer process. Now, Danny is seeking your help to measure the quantifiable impact of this change and identify which platforms, regions, segments, and customer types were most affected. Let's work together to discover the answers and find ways to minimize future sustainability updates' impact on sales.

## 🔐 Entity Relationship Diagram

<p align ="center">
 <img width="300" height="350" src="https://user-images.githubusercontent.com/121611397/233728530-77cfad64-64ef-4884-859c-323df5fe233b.png">
</p>

The columns are pretty self-explanatory based on the column names but here are some further details about the dataset:

- Data Mart has international operations using a multi-region strategy.

- Data Mart has both, a retail and online platform in the form of a Shopify store front to serve their customers.

- Customer segment and customer_type data relates to personal age and demographics information that is shared with Data Mart.

- Transactions is the count of unique purchases made through Data Mart and sales is the actual dollar amount of purchases.

- Each record in the dataset is related to a specific aggregated slice of the underlying sales data rolled up into a week_date value which represents the start of the   sales week.

## 📋 Case Study and Bonus Questions

<details>
<summary>
Click here to expand!
</summary>
  
### A. Data Cleansing Steps
  
In a single query, perform the following operations and generate a new table in the ```data_mart``` schema named ```clean_weekly_sales```:
  * Convert the ```week_date``` to a ```DATE``` format
  * Add a ```week_number``` as the second column for each ```week_date``` value, for example any value from the 1st of January to 7th of January will be 1, 8th to 14th will be 2 etc
  * Add a ```month_number``` with the calendar month for each ```week_date``` value as the 3rd column
  * Add a ```calendar_year``` column as the 4th column containing either 2018, 2019 or 2020 values
  * Add a new column called ```age_band``` after the original ```segment``` column using the following mapping on the number inside the ```segment``` value

| Segment | age_band     |
|--------|--------------|
| 1      | Young Adults |
| 2      | Middle Aged  |
| 3 or 4 | Retirees     |
  
  * Add a new ```demographic``` column using the following mapping for the first letter in the ```segment``` values
  
| segment | demographic |
|---------|-------------|
| C       | Couples     |
| F       | Families    |
  
  * Ensure all ```null``` string values with an ```"unknown"``` string value in the original ```segment``` column as well as the new ```age_band``` and ```demographic``` columns
  * Generate a new ```avg_transaction``` column as the sales value divided by ```transactions``` rounded to 2 decimal places for each record

---
### B. Data Exploration
  
1. What day of the week is used for each ```week_date``` value?
2. What range of week numbers are missing from the dataset?
3. How many total transactions were there for each year in the dataset?
4. What is the total sales for each region for each month?
5. What is the total count of transactions for each platform
6. What is the percentage of sales for Retail vs Shopify for each month?
7. What is the percentage of sales by demographic for each year in the dataset?
8. Which ```age_band``` and ```demographic``` values contribute the most to Retail sales?
9. Can we use the ```avg_transaction``` column to find the average transaction size for each year for Retail vs Shopify? If not - how would you calculate it instead?

---
### c. Before & After Analysis
  
This technique is usually used when we inspect an important event and want to inspect the impact before and after a certain point in time.
Taking the week_date value of 2020-06-15 as the baseline week where the Data Mart sustainable packaging changes came into effect.
We would include all week_date values for 2020-06-15 as the start of the period after the change and the previous week_date values would be before.

Using this analysis approach - answer the following questions:

1. What is the total sales for the 4 weeks before and after 2020-06-15? What is the growth or reduction rate in actual values and percentage of sales?
2. What about the entire 12 weeks before and after?
3. How do the sale metrics for these 2 periods before and after compare with the previous years in 2018 and 2019?

---

### D. Bonus Questions

1. Which areas of the business have the highest negative impact in sales metrics performance in 2020 for the 12 week before and after period?
  * ```region```
  * ```platform```
  * ```age_band```
  * ```demographic```
  * ```customer_type```
  
2. Do you have any further recommendations for Danny’s team at Data Mart or any interesting insights based off this analysis?

</details>

## 🔎 SQL Queries for Questions

<details>
<summary>
Click here to expand!
</summary>

## A. Data Cleansing Steps

In a single query, perform the following operations and generate a new table in the ```data_mart``` schema named ```clean_weekly_sales```:
  * Convert the ```week_date``` to a ```DATE``` format
  * Add a ```week_number``` as the second column for each ```week_date``` value, for example any value from the 1st of January to 7th of January will be 1, 8th to 14th will be 2 etc
  * Add a ```month_number``` with the calendar month for each ```week_date``` value as the 3rd column
  * Add a ```calendar_year``` column as the 4th column containing either 2018, 2019 or 2020 values
  * Add a new column called ```age_band``` after the original ```segment``` column using the following mapping on the number inside the ```segment``` value

| Segment | age_band     |
|--------|--------------|
| 1      | Young Adults |
| 2      | Middle Aged  |
| 3 or 4 | Retirees     |
  
  * Add a new ```demographic``` column using the following mapping for the first letter in the ```segment``` values
  
| segment | demographic |
|---------|-------------|
| C       | Couples     |
| F       | Families    |
  
  * Ensure all ```null``` string values with an ```"unknown"``` string value in the original ```segment``` column as well as the new ```age_band``` and ```demographic``` columns
  * Generate a new ```avg_transaction``` column as the sales value divided by ```transactions``` rounded to 2 decimal places for each record

---
  
```sql
  
  -- Alter exisitng table for date formating
  
alter table weekly_sales
modify week_date varchar(15);
update weekly_sales
set week_date=str_to_date(week_date,"%d/%m/%Y");

  -- Create a new table named cleaned_weekly_sales
  
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

  --Lastly alter other columns for further calculations to come.
  
alter table cleaned_weekly_sales
modify column week_date date;
alter table cleaned_weekly_sales
modify column sales bigint;
```
- First 10 rows of the generated table.
  
![image](https://user-images.githubusercontent.com/121611397/233733216-bc5bc61f-845b-49ac-894b-9a428a86b59a.png)
  
---
## B. Data Exploration

#### 1. What day of the week is used for each week_date value?

```sql
select distinct(date_format(week_date, '%W')) as dayofweek from cleaned_weekly_sales;
```
![image](https://user-images.githubusercontent.com/121611397/233733854-c320cfa3-777b-476e-9b79-8d9968487a83.png)


#### 2. What range of week numbers are missing from the dataset?

```sql
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
```
![image](https://user-images.githubusercontent.com/121611397/233734062-705b6287-5276-4154-ac84-527733525ea9.png)

#### 3. How many total transactions were there for each year in the dataset?

```sql
select year(week_date) as Year_,sum(transactions) as Total_transactions from cleaned_weekly_sales
group by year(week_date);
```
![image](https://user-images.githubusercontent.com/121611397/233826569-ca65b024-4e85-4f14-9672-72bc595c8515.png)


#### 4. What is the total sales for each region for each month?

```sql
select region,monthname(week_date) as Month_,sum(sales) as Total_sales from cleaned_weekly_sales
group by region,monthname(week_date)
order by region;
```
 - Showing 10 out 49 rows in total.
              
![image](https://user-images.githubusercontent.com/121611397/233734864-3a06a7ab-3b14-4628-a1ce-ee8755b4b598.png)

#### 5. What is the total count of transactions for each platform?

```sql
sselect platform,sum(transactions) as Total_transactions from cleaned_weekly_sales
group by platform;
```
![image](https://user-images.githubusercontent.com/121611397/233828621-4e7879df-3e60-4ac1-b791-ef0e765dc195.png)


#### 6. What is the percentage of sales for Retail vs Shopify for each month?

```sql
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
```
- Showing 11 out 20 rows in total.
              
![image](https://user-images.githubusercontent.com/121611397/233735465-8df8db18-3ce7-4946-98f8-4afb4b8e797c.png)

#### 7. What is the percentage of sales by demographic for each year in the dataset?

```sql
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
```
![image](https://user-images.githubusercontent.com/121611397/233735613-e3d306e8-ee19-40a4-b346-c1e6bc3c4857.png)

#### 8. Which age_band and demographic values contribute the most to Retail sales?

```sql
select age_band,demographic,sum(sales) total_sales,round(sum(sales)*100/(select sum(sales) from cleaned_weekly_sales where platform='Retail'),2) as pct_sales
from cleaned_weekly_sales
where platform='Retail'
group by age_band,demographic
order by total_sales desc;
```
![image](https://user-images.githubusercontent.com/121611397/233735677-33b917b0-b563-4860-9fe5-296e732b5830.png)
  
#### 9. Can we use the avg_transaction column to find the average transaction size for each year for Retail vs Shopify? If not - how would you calculate it instead?
  
Hence, we can not use avg_transaction column to find the average transaction size for each year and sales platform, because while calculating the average of the resultant averages we are giving equal weightage to all the average values but in reality all the columns have different weightage so it's better to calculate the sum of all the sales and divide it by total transactions.
  Example:-
  
  ![image](https://user-images.githubusercontent.com/121611397/233737168-f592dd5f-ac1c-4e27-9bec-d255b31b6308.png)

  
```sql
select year_, platform, round(avg(avg_transaction),2) as avg_transaction_col,
round(sum(sales)/sum(transactions),2) as avg_transaction_group
from cleaned_weekly_sales
group by year_, platform
order by  year_, platform;
```
![image](https://user-images.githubusercontent.com/121611397/233735782-c0b20208-b92e-4674-a2d5-77b98c8f648c.png)
  
---
## C. Before and After Analysis

This technique is usually used when we inspect an important event and want to inspect the impact before and after a certain point in time. 
Taking the week_date value of 2020-06-15 as the baseline week where the Data Mart sustainable packaging changes came into effect. 
We would include all week_date values for 2020-06-15 as the start of the period after the change and the previous week_date values would be before.

Using this analysis approach - answer the following questions:
  
#### 1. What is the total sales for the 4 weeks before and after 2020-06-15? What is the growth or reduction rate in actual values and percentage of sales?
  
  ```sql
with cte as(select 
sum(case when week_ between '21' and '24' then sales end) as before_weeks,
sum(case when week_ between '25' and '28' then sales end) as after_weeks
from cleaned_weekly_sales
where Year_='2020')
select *,after_weeks-before_weeks as growth,round((after_weeks-before_weeks)*100/(before_weeks),2) as pct_change
from cte;
```
 ![image](https://user-images.githubusercontent.com/121611397/233737587-e7ccc3c7-37ef-4b1c-be9e-3c7c5caadc30.png)

 #### 2. What about the entire 12 weeks before and after?
  
```sql
set @week_change=25
with cte as(select 
sum(case when week_ between @week_change-12 and  @week_change-1 then sales end) as before_weeks,
sum(case when week_ between  @week_change and  @week_change+11 then sales end) as after_weeks
from cleaned_weekly_sales
where Year_='2020')
select *,after_weeks-before_weeks as growth,round((after_weeks-before_weeks)*100/(before_weeks),2) as pct_change
from cte;
```
 ![image](https://user-images.githubusercontent.com/121611397/233737885-cdf15025-aa57-4905-a1f1-6ffdcd73bf2d.png)

  
 #### 3. How do the sale metrics for these 2 periods before and after compare with the previous years in 2018 and 2019?
  
 - For 4 weeks before and after 2020-06-15.
  
 ```sql
with cte as(select Year_ ,
sum(case when week_ between @week_change-4 and @week_change-1 then sales end) as before_weeks,
sum(case when week_ between @week_change and @week_change+3 then sales end) as after_weeks
from cleaned_weekly_sales
group by Year_)
select *,after_weeks-before_weeks as growth,round((after_weeks-before_weeks)*100/(before_weeks),2) as pct_change
from cte;
 ```
 ![image](https://user-images.githubusercontent.com/121611397/233738060-6f0530f5-c67a-43fd-b31e-3e7d282b15c5.png)
 
 - For 12 weeks before and after 2020-06-15.
  
```sql
with cte as(select Year_,
sum(case when week_ between @week_change-12 and  @week_change-1 then sales end) as before_weeks,
sum(case when week_ between  @week_change and  @week_change+11 then sales end) as after_weeks
from cleaned_weekly_sales
group by Year_)
select *,after_weeks-before_weeks as growth,round((after_weeks-before_weeks)*100/(before_weeks),2) as pct_change
from cte;
```
  ![image](https://user-images.githubusercontent.com/121611397/233738194-e549fb76-65d8-4a58-a152-7022895c0adf.png)
  
---  
## 🔥 Bonus Questions

### Which areas of the business have the highest negative impact in sales metrics performance in 2020 for the 12 week before and after period?
  
  * ```region```
  * ```platform```
  * ```age_band```
  * ```demographic```
  * ```customer_type```

 #### 1. Sales changes by ```regions```
  
```sql
with cte as(select region,
sum(case when week_ between @week_change-12 and  @week_change-1 then sales end) as before_weeks,
sum(case when week_ between  @week_change and  @week_change+11 then sales end) as after_weeks
from cleaned_weekly_sales
where Year_='2020'
group by region)
select *,after_weeks-before_weeks as growth,round((after_weeks-before_weeks)*100/(before_weeks),2) as pct_change
from cte
order by pct_change desc;
```
![image](https://user-images.githubusercontent.com/121611397/233738525-2f67ae7d-6b1f-42ff-a5b8-c426dd4aec02.png)

#### 2. Sales changes by ```platform```

```sql
with cte as(select platform,
sum(case when week_ between @week_change-12 and  @week_change-1 then sales end) as before_weeks,
sum(case when week_ between  @week_change and  @week_change+11 then sales end) as after_weeks
from cleaned_weekly_sales
where Year_='2020'
group by platform)
select *,after_weeks-before_weeks as growth,round((after_weeks-before_weeks)*100/(before_weeks),2) as pct_change
from cte
order by pct_change desc;
```
![image](https://user-images.githubusercontent.com/121611397/233738891-abf09ccf-d5f2-4fc6-98ce-18b60a9ee951.png)

#### 3. Sales changes by ```age_band```
  
  ```sql
with cte as(select age_band,
sum(case when week_ between @week_change-12 and  @week_change-1 then sales end) as before_weeks,
sum(case when week_ between  @week_change and  @week_change+11 then sales end) as after_weeks
from cleaned_weekly_sales
where Year_='2020'
group by age_band)
select *,after_weeks-before_weeks as growth,round((after_weeks-before_weeks)*100/(before_weeks),2) as pct_change
from cte
order by pct_change desc;
```
![image](https://user-images.githubusercontent.com/121611397/233738994-22be9f22-d38d-4a7b-881f-c0b89c293bef.png)
  
#### 4. Sales changes by ```demographic```
  
 ```sql
with cte as(select demographic,
sum(case when week_ between @week_change-12 and  @week_change-1 then sales end) as before_weeks,
sum(case when week_ between  @week_change and  @week_change+11 then sales end) as after_weeks
from cleaned_weekly_sales
where Year_='2020'
group by demographic)
select *,after_weeks-before_weeks as growth,round((after_weeks-before_weeks)*100/(before_weeks),2) as pct_change
from cte
order by pct_change desc;
```
![image](https://user-images.githubusercontent.com/121611397/233739063-a189016a-7643-405b-9ab0-7edb70598403.png) 
  
#### 5. Sales changes by ```customer_type```
  
  ```sql
with cte as(select customer_type,
sum(case when week_ between @week_change-12 and  @week_change-1 then sales end) as before_weeks,
sum(case when week_ between  @week_change and  @week_change+11 then sales end) as after_weeks
from cleaned_weekly_sales
where Year_='2020'
group by customer_type)
select *,after_weeks-before_weeks as growth,round((after_weeks-before_weeks)*100/(before_weeks),2) as pct_change
from cte
order by pct_change desc;
```
![image](https://user-images.githubusercontent.com/121611397/233739135-cfe57b93-439a-409f-b5bf-8fd6868eb20d.png)
  
</details> 
  
## 💡 Insights and Learnings


<details>
<summary>
Click here to expand!
</summary>

 <br> 
 
- **Insights of Business Sales Transactions:**

   * Each weeks starts from Monday and ```28 weeks data ranging from 1-12 and 37 is not available```.
  
   * ```Year on Year Transactions```: The data shows that the company has experienced growth in sales transactions year-on-year. The sales have increased from 346,406,460 in 2018 to 375,813,651 in 2020. Thus indicating that the business is performing well and has achieved growth.
  
   *  ```Regional Sales```: The information reveals that Oceania generates the highest sales, followed by Africa and Asia. It implies that the business has a stronger market presence in these regions, and they may be prioritizing their marketing efforts and resources accordingly.
   
     <p align ="center">
     <img width="800" height="400" src="https://user-images.githubusercontent.com/121611397/233828368-bee13fb4-a988-4447-bbbb-3b85362aa134.png">
      </p>

    * ```Retail vs. Shopify```: The data shows that the majority of sales transactions are made through retail channels. Only a small percentage of sales are done through Shopify. The table reveals that retail sales make up 99.4% of total sales transactions.
 
    * ```Sales by Year and Type```: The data shows the average percentage of sales made through Retail and Shopify channels. In 2018, Retail sales contributed to 97.8% of total sales, whereas Shopify sales contributed to 2.2%. Similarly, Retail sales contributed to 97.4% in 2019, and Shopify sales contributed to 2.6%. The trend continued in 2020, with Retail sales contributing to 96.8% and Shopify sales contributing to 3.2%. The trend suggests that the company's sales through Shopify have been increasing over the years.
   
       <p align ="center">
       <img width="800" height="400" src="https://user-images.githubusercontent.com/121611397/233829053-134fe9ab-7461-4ce9-b181-e2cedbd68c23.png">
      </p>

  * ```Sales by Year and Demographics```: The data shows that there has been an increase in the percentage of sales made to couples and a decrease in sales made to unknown demographics. In 2020, sales made to couples were 28.72%, an increase from 26.38% in 2018, while sales made to unknown demographics decreased from 41.63% in 2018 to 38.55% in 2020. The data also shows that sales made to families have remained relatively consistent over the years, contributing to around one-third of total sales.

  * ```Sales by Age Band```: The data shows that sales made to the Unknown age group contributes to the highest sales percentage at 40.52%. The retirees demographic group contributes to the next highest percentage, with families contributing to 16.73% and couples to 16.07%. 
 
 - **Impact Analysis of the sustainable packaging changes on the sales of Data Mart:**

 	* The baseline week for the sustainable packaging changes is week 25, which had sales of 570,025,348. In the following weeks, there was a fluctuation in sales, but in general, sales remained relatively stable.
 
 	* The 4 week sales before week 25 totaled 2,329,622,315, while the 4 week sales after week 25 totaled 2,333,907,223. This represents a decrease of 1.15% in sales.
 
 	* This decrease in sales may not necessarily be attributed solely to the sustainable packaging changes. There may have been other factors that influenced sales during this time period, such as seasonal trends, economic conditions, and competition.
 		
		![image](https://user-images.githubusercontent.com/121611397/233837352-07dbeb41-6eda-4034-9348-20618ee9de62.png)

- **The following data presents a comparative analysis of 12 weeks prior to and following a sustainable packaging change implemented by the company on 15th June 2020.**

	* Looking at the ```year-on-year trend for sales, we can see that there has been a general upward trend in sales``` from 2018 to 2020. However, there seems to be a slight dip in sales from 2019 to 2020. It is also worth noting that there are seasonal fluctuations in sales, with the highest sales usually occurring in weeks 13-15 and the lowest sales in weeks 32-36.
		
		![image](https://user-images.githubusercontent.com/121611397/233837670-9d0f4153-c3e7-458c-821a-cdadadd2b8a6.png)

	* ```Oceania had the highest percentage of sales contribution``` with 34.51% followed by Africa with 25.38% and then Asia with 19.45%. But, In terms of the percentage of change in sales after the change, Europe had the highest percentage of increase in sales with 4.73% followed by Asia with a decrease of 3.26%
		
		![image](https://user-images.githubusercontent.com/121611397/233835774-6aff984c-8657-4901-bccd-fc30883bc93b.png) 

	* ```Retail has a significantly higher total sales than Shopify```. However, Retail also experienced a decrease in sales by 2.43% over the given weeks, whereas Shopify experienced an increase in sales by 7.18%.
	
		![image](https://user-images.githubusercontent.com/121611397/233836054-201427ff-0f4b-49cd-968b-0e364a6217f6.png) 

	 * The ```age band Unknown had the highest total sales before and after the period```, but had a decrease in sales of 3.34%, the largest percentage decrease among the four age bands. "Middle Aged" had the second-highest total sales, but also had a decrease in sales of 1.97%, followed by "Retirees" with a decrease in sales of 1.23%, and "Young Adults" with a decrease in sales of 0.92%.
 		
		![image](https://user-images.githubusercontent.com/121611397/233836440-cc125228-0a7e-4504-b9da-63e5dd944d52.png) 

	*  ```Unknown demographic has the highest total sales```, but ```also has the largest percentage decrease of 3% in sales compared to previous weeks``` after the change occured. Families have the second-highest total sales and a moderate decrease in sales, while couples have the lowest total sales and a small decrease in sales.
		![image](https://user-images.githubusercontent.com/121611397/233836421-4eb903f3-8788-46a4-bdf0-cd3f193621f4.png) 

	* ```Existing customers have consistently generated the highest sales figures``` over the given period but have a sales drop 2.27%, followed by Guest customers but have highest sales drop of 3% , while New customers generated the lowest sales but has a increase in sales by 1.01%.
	
  		![image](https://user-images.githubusercontent.com/121611397/233836376-bc18e765-8ac2-4249-a53d-8a70526f2a53.png) 


### Learnings....!!!
 
After analysing this case study, I have gained a strong understanding of the following concepts:

-Common Table Expressions.
 
-Group By Aggregates.
 
-Basics of recursive & set function apllicability.
 
-Joins.
 
-Case Function with between and date function.



</details>

