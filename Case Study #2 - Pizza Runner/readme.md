# 🍕 Case Study #2 - Pizza Runner

<p align ="center">
 <img width="300" height="300" src="https://user-images.githubusercontent.com/121611397/233771885-06100aec-a370-474b-a0c7-50dcebcfb56e.png">
</p>


## 📕 Table of Contents

 -	[Problem Statement](https://github.com/itsadi08/8-Weeks-SQL-Challenge/edit/main/Case%20Study%20%232%20-%20Pizza%20Runner#-problem-statement)   

 - [Entity Relationship Diagram](https://github.com/itsadi08/8-Weeks-SQL-Challenge/edit/main/Case%20Study%20%232%20-%20Pizza%20Runner#-entity-relationship-diagram)

 -	[Case Study Questions and Bonus Questions](https://github.com/itsadi08/8-Weeks-SQL-Challenge/edit/main/Case%20Study%20%232%20-%20Pizza%20Runner#-case-study-and-bonus-questions)

 - [SQL Queries for Questions](https://github.com/itsadi08/8-Weeks-SQL-Challenge/edit/main/Case%20Study%20%232%20-%20Pizza%20Runner#-sql-queries-for-questions)
 
 -	[Insights and Learnings](https://github.com/itsadi08/8-Weeks-SQL-Challenge/edit/main/Case%20Study%20%232%20-%20Pizza%20Runner#-insights-and-learnings)

## 📝 Problem Statement

The objective of this case study is to optimize the operations of Pizza Runner, a pizza delivery service founded by Danny. The project will involve analyzing data from several areas, including pizza metrics, runner and customer experience, ingredient optimization, pricing, and ratings. The data in the customer_orders and runner_orders tables needs to be cleaned up to enable accurate data manipulation. Using SQL queries, the team will seek to answer key questions to help Pizza Runner improve its overall efficiency, enhance customer satisfaction, and maximize profits. The end goal is to provide actionable insights and recommendations to take Pizza Runner to the next level of success.

## 🔐 Entity Relationship Diagram

<p align ="center">
 <img width="700" height="350" src="https://user-images.githubusercontent.com/121611397/233772164-adab2253-58aa-495b-b1a8-f228ebbb3d00.png">
</p>

The columns are pretty self-explanatory based on the column names but here are some further details about the dataset:

- The runners table shows the registration_date for each new runner.

- The customer_orders table captures pizza orders with pizza_id, exclusions, and extras columns. Customers can order multiple pizzas with varying exclusions and extras values, requiring data cleanup before using in queries.

- The runner_orders table in Pizza Runner captures the assignment of each order to a runner, along with pickup time, distance, and duration of the delivery.

- At the moment - Pizza Runner only has 2 pizzas available the Meat Lovers or Vegetarian!

- Each pizza_id has a standard set of toppings which are used as part of the pizza recipe.

- This table contains all of the topping_name values with their corresponding topping_id value.

## 📋 Case Study and Bonus Questions

<details>
<summary>
Click here to expand!
</summary>
  
### A. Pizza Metrics

1. How many pizzas were ordered?
2. How many unique customer orders were made?
3. How many successful orders were delivered by each runner?
4. How many of each type of pizza was delivered?
5. How many Vegetarian and Meatlovers were ordered by each customer?
6. What was the maximum number of pizzas delivered in a single order?
7. For each customer, how many delivered pizzas had at least 1 change and how many had no changes?
8. How many pizzas were delivered that had both exclusions and extras?
9. What was the total volume of pizzas ordered for each hour of the day?
10. What was the volume of orders for each day of the week?

---
### B. Runner and Customer Experience

1. How many runners signed up for each 1 week period? (i.e. week starts 2021-01-01)
2. What was the average time in minutes it took for each runner to arrive at the Pizza Runner HQ to pickup the order?
3. Is there any relationship between the number of pizzas and how long the order takes to prepare?
4. What was the average distance travelled for each customer?
5. What was the difference between the longest and shortest delivery times for all orders?
6. What was the average speed for each runner for each delivery and do you notice any trend for these values?
7. What is the successful delivery percentage for each runner?

---
### C. Ingredient Optimisation

1. What are the standard ingredients for each pizza?
2. What was the most commonly added extra?
3. What was the most common exclusion?
4. Generate an order item for each record in the customers_orders table in the format of one of the following:
    * ```Meat Lovers```
    * ```Meat Lovers - Exclude Beef```
    * ```Meat Lovers - Extra Bacon```
    * ```Meat Lovers - Exclude Cheese, Bacon - Extra Mushroom, Peppers```
5. Generate an alphabetically ordered comma separated ingredient list for each pizza order from the customer_orders table and add a 2x in front of any relevant ingredients
    * For example: ```"Meat Lovers: 2xBacon, Beef, ... , Salami"```
6. What is the total quantity of each ingredient used in all delivered pizzas sorted by most frequent first?

---
### D. Pricing and Ratings

1. If a Meat Lovers pizza costs $12 and Vegetarian costs $10 and there were no charges for changes - how much money has Pizza Runner made so far if there are no delivery fees?
2. What if there was an additional $1 charge for any pizza extras?
    * Add cheese is $1 extra
3. The Pizza Runner team now wants to add an additional ratings system that allows customers to rate their runner, how would you design an additional table for this new dataset - generate a schema for this new table and insert your own data for ratings for each successful customer order between 1 to 5.
4. Using your newly generated table - can you join all of the information together to form a table which has the following information for successful deliveries?
    * ```customer_id```
    * ```order_id```
    * ```runner_id```
    * ```rating```
    * ```order_time```
    * ```pickup_time```
    * Time between order and pickup
    * Delivery duration
    * Average speed
    * Total number of pizzas
5. If a Meat Lovers pizza was $12 and Vegetarian $10 fixed prices with no cost for extras and each runner is paid $0.30 per kilometre traveled - how much money does Pizza Runner have left over after these deliveries?

---
### E. Bonus questions

If Danny wants to expand his range of pizzas - how would this impact the existing data design? Write an ```INSERT``` statement to demonstrate what would happen if a new ```Supreme``` pizza with all the toppings was added to the Pizza Runner menu?

---
	
</details>

## 🔎 SQL Queries for Questions

<details>
<summary>
Click here to expand!
</summary>

## A. Pizza Metrics
	
### Data cleaning
  
  * Create a new table ```#customer_ordersnew``` from ```customer_orders``` table:
	
  	* Convert the ```blank``` text values in ```exclusions``` and ```extras``` into null ```''```.

```sql	
drop table if exists customer_ordersnew;
create table customer_ordersnew as
(select order_id, customer_id, pizza_id, exclusions, extras, order_time 
from customer_orders);
								 
update customer_ordersnew
set exclusions=case when exclusions ='No Record' then null else exclusions end,
extras=case when extras='No Record' then null else extras end;
```
![image](https://user-images.githubusercontent.com/121611397/233773193-3adb31fe-89ae-432a-b9dd-5898ce9dce5e.png)


  * Create a new table ```runner_ordersnew``` from ```runner_orders``` table:
  	* Convert ```'null'``` text values in ```pickup_time```, ```duration```,```distance``` and ```cancellation``` into ```null``` values. 
	* Cast ```pickup_time``` to TIMESTAMP.
	* Cast ```distance``` to FLOAT.
	* Cast ```duration``` to INT.
	
```sql	

drop table if exists runner_ordersnew;
create table runner_ordersnew as 
(select order_id, runner_id, pickup_time,
case
 when distance like '%km' then trim('km' from distance)else distance end as distance,
case
 when duration like '%minutes' then trim('minutes' from duration)
 when duration like '%mins' then trim('mins' from duration)
 when duration like '%minute' then trim('minute' from duration)
else duration end as duration, 
cancellation 
from runner_orders);

update runner_ordersnew
set pickup_time = case when pickup_time ='null' then null  else pickup_time end,
distance = case  when distance= 'null' then null else distance end,
duration = case  when duration ='null' then null else duration end,
cancellation = case when cancellation ='null' then null else cancellation end,

update runner_ordersnew
set cancellation = case when cancellation ='' then null else cancellation end;

alter table runner_ordersnew
alter column pickup_time type timestamp USING TO_TIMESTAMP(pickup_time, 'YYYY-MM-DD HH24:MI:SS'),
alter column distance type decimal USING CAST(distance AS DECIMAL),
alter column duration type int USING CAST(duration AS int) ;
```
	
![image](https://user-images.githubusercontent.com/121611397/233773272-e6348049-c168-4e85-98b1-4cd55d927027.png)

---
 
### Q1. How many pizzas were ordered? 
	
```sql
 select count(order_id)as Total_Pizzas_Ordered from customer_ordersnew; 
```
![image](https://user-images.githubusercontent.com/121611397/233773752-41aa619c-dc24-4b9b-b9d5-f1a9e30227f1.png)
  
### Q2. How many unique customer orders were made?
	
```sql
 select count(distinct order_id)as Total_Orders from customer_ordersnew;
```	
![image](https://user-images.githubusercontent.com/121611397/233773960-73e89869-250b-4f45-b798-6a651b60a28f.png)
	
### Q3. How many successful orders were delivered by each runner? 
	
```sql
select runner_id,count(order_id) as Successful_orders from runner_ordersnew
where cancellation is null
group by runner_id;
```
![image](https://user-images.githubusercontent.com/121611397/233773988-14294256-b1f0-4e34-b295-e56ee343b9e0.png)
	
### Q4. How many of each type of pizza was delivered? 
	
```sql
select pizza_name,count(pizza_id) as No_of_Pizzas from customer_ordersnew
join pizza_names using (pizza_id)
join runner_ordersnew  using(order_id)
where cancellation is null
group by pizza_name; 
```	
![image](https://user-images.githubusercontent.com/121611397/233774028-ff06172f-d56d-4f88-8dee-c5372073b236.png)
	
### Q5 How many Vegetarian and Meatlovers were ordered by each customer?
	
```sql	
select customer_id,pizza_name,count(pizza_id) as No_of_Pizzas from customer_ordersnew
join pizza_names using (pizza_id)
join runner_ordersnew  using(order_id)
where cancellation is null
group by customer_id,pizza_name;	
```	
![image](https://user-images.githubusercontent.com/121611397/233774169-83b5407e-6b9b-4912-8c6c-6e8aaeb3495b.png)
	
### Q6 What was the maximum number of pizzas delivered in a single order?

```sql	
select order_id ,count(pizza_id) as No_of_Pizzas_Ordered from customer_ordersnew
join runner_ordersnew  using(order_id)
group by order_id 
order by No_of_Pizzas_Ordered desc
limit 1;
```
![image](https://user-images.githubusercontent.com/121611397/233774190-21e04f3d-a3ee-40e6-be34-0de32239c770.png)
	
### Q7 For each customer, how many delivered pizzas had at least 1 change and how many had no changes?

```sql
select customer_id,count(order_id)as total_orders,sum(case when exclusions is not null or extras is not null then 1 
else 0 end )as AleastOneChange,sum(case when exclusions is null and extras is null then 1 
else 0 end )as NoChange
from customer_ordersnew 
join runner_ordersnew  using(order_id)
where cancellation is null   
group by customer_id;
```
![image](https://user-images.githubusercontent.com/121611397/233774213-81d22b49-08e1-4d8f-9abd-76a4a7e2caf9.png)
	
### Q8 How many pizzas were delivered that had both exclusions and extras?
	
```sql
select count(pizza_id) as Exclusion_Extra_Pizza
from customer_ordersnew 
join runner_ordersnew  using(order_id)
where exclusions is not null and extras is not null and cancellation is null
```
![image](https://user-images.githubusercontent.com/121611397/233774356-3c643fce-2379-44be-9c19-766961b3c06b.png)
	
### Q9 What was the total volume of pizzas ordered for each hour of the day?
	
```sql	
select extract (hour from order_time) as hour,count(order_id)as Total_Pizzas from customer_ordersnew
group by extract (hour from order_time)
order by extract (hour from order_time)
```
![image](https://user-images.githubusercontent.com/121611397/233774378-90027b3e-5e2d-4f3b-a917-308a3b805955.png)
	
### Q10 What was the volume of orders for each day of the week?
	
```sql	
select to_char(order_time,'Day') as DailyData,count(order_id)as Total_Pizzas from customer_ordersnew
group by to_char(order_time,'Day')
order by Total_Pizzas desc
```	
![image](https://user-images.githubusercontent.com/121611397/233774434-e80aaf30-29a2-447e-8151-89455a1d57c6.png)
	
	
	
	
	
	
	
	
	
	
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
select year(week_date) as Year_,count(transactions) as Total_transactions from cleaned_weekly_sales
group by year(week_date);
```
![image](https://user-images.githubusercontent.com/121611397/233734571-c503d6d5-9133-4bf5-ab04-9d8f72a188aa.png)


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
select platform,count(transactions) as Total_transactions from cleaned_weekly_sales
group by platform;
```
![image](https://user-images.githubusercontent.com/121611397/233735055-cb63c36c-ac39-42e9-b638-b7dc8fa8c3a7.png)

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
 
 
 **1.** **Customer A** spent the **most ($76)**,while **Customer C** spent the **least ($36)**.
 
 **2.** **Customer B** made the most **visits (6 times)** which is the highest,while **Customer C visited just twice**.
 
 **3.** All the **3 customers purchased different items** on their **first visit** to the diner.
 
 **4.** Out of the three dishes,**Ramen** is the **most purchased item** and has been ordered **8 times**.
 
 **5.** **Most popular item for Customers A & C is Ramen** whereas Customer B has ordered all the 3 items, an equal number of times.
 
 **6.** **Customer A ordered curry** and **Customer B order sushi** after they became a member.
 
 **7.** **Customer A ordered both sushi & curry** and **Customer B ordered curry** before they both became members.
 
 **8.** **Customer A** purchased 2 items in total and **spent $25** before becoming a member. **Customer B** purchased 2 items in total and **spent $40** before               becoming a member.While **Customer C** purchased 3 items and **spent $36 without being a member**.
         
 **9.** **Customer B has the most 940 points**, while Customer A has 860 points  and Customer C has 360 points.
 
**10.** **Customer A has 1270 points** and **Customer B had 720 points** by the **end of January 2021**.

 
### Learnings....!!!
 
After analysing this case study, I have gained a strong understanding of the following concepts:

-Common Table Expressions.
 
-Group By Aggregates.
 
-Window Functions for ranking and row number.
 
-Joins with using keyword.
 
-Case Function with between and date function.



</details>


