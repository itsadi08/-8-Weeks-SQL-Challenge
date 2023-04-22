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
  
  * Create a new table ```customer_ordersnew``` from ```customer_orders``` table:
	
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
	
- Including cancelled orders(if cancelled orders excluded then 12)
	
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
	
- Including cancelled orders
	
```sql	
select extract (hour from order_time) as hour,count(order_id)as Total_Pizzas from customer_ordersnew
group by extract (hour from order_time)
order by extract (hour from order_time)
```
![image](https://user-images.githubusercontent.com/121611397/233774378-90027b3e-5e2d-4f3b-a917-308a3b805955.png)
	
### Q10 What was the volume of orders for each day of the week?
	
- Including cancelled orders
	
```sql	
select to_char(order_time,'Day') as DailyData,count(order_id)as Total_Pizzas from customer_ordersnew
group by to_char(order_time,'Day')
order by Total_Pizzas desc
```	
![image](https://user-images.githubusercontent.com/121611397/233774434-e80aaf30-29a2-447e-8151-89455a1d57c6.png)
	
---
## B. Runner and Customer Experience
	
### Q1. How many runners signed up for each 1 week period? (i.e. week starts 2021-01-01)

```sql
select extract(week from registration_date+interval '1 week') as Week_number,count(runner_id) as Total_Registration
from runners
group by extract(week from registration_date+interval '1 week')
order by Week_number;
```
![image](https://user-images.githubusercontent.com/121611397/233777072-9e228cfd-3ba4-4e6f-9d1e-750111048f24.png)

### Q2 What was the average time in minutes it took for each runner to arrive at the Pizza Runner HQ to pickup the order?

```sql
with cte as(select runner_id,avg(pickup_time-order_time) as Avg_time from runner_ordersnew
join customer_ordersnew using (order_id)
group by runner_id)
select runner_id, round(extract(minutes from Avg_time),2) as Avg_time_ from cte;

![image](https://user-images.githubusercontent.com/121611397/233777099-1db64006-28dc-4807-a22d-9f9f93e8c584.png)	
	
### Q3 Is there any relationship between the number of pizzas and how long the order takes to prepare?
	
```sql
with cte as(select order_id,count(order_id) as  total_pizza,avg(pickup_time-order_time) as Prep_time from runner_ordersnew
join customer_ordersnew using (order_id)
where cancellation is null
group by order_id)	
select total_pizza, round(avg(extract(minutes from Prep_time)),0) as Avg_time_ from cte 
group by total_pizza;
```
![image](https://user-images.githubusercontent.com/121611397/233777148-3e7671f4-3bf6-48b5-aff2-1a7846d30992.png)	

### Q4 What was the average distance travelled for each customer?
	
```sql
select customer_id,round(avg(distance),2) as Average_Distance_Travelled_inKM from runner_ordersnew
join customer_ordersnew using (order_id)
group by customer_id
order by customer_id;
```
![image](https://user-images.githubusercontent.com/121611397/233777180-ba90b8f9-6854-4101-9b9a-56a3a5d6645a.png)

### Q5 What was the difference between the longest and shortest delivery times for all orders?
	
```sql
select max(duration)as slowest_delivery_time,min(duration) as fastest_delivery_time,
max(duration)- min(duration) as Difference from runner_ordersnew;
```
![image](https://user-images.githubusercontent.com/121611397/233777232-3410cb48-2a8d-40d8-bc9e-ab4cd981fa5f.png)

### Q6 What was the average speed for each runner for each delivery and do you notice any trend for these values?
	
```sql	
select order_id,runner_id,round(avg (distance*60/duration),2) as Speed_kmph from runner_ordersnew
where distance<>0
group by order_id,runner_id
order by order_id;	
```
![image](https://user-images.githubusercontent.com/121611397/233777254-cd04dedc-4a7a-49fd-bd7d-eecde7cca85b.png)
	
### Q7 What is the successful delivery percentage for each runner?
	
```sql	
select runner_id,concat(count(distance)*100/count(order_id),'%') as Delivery_percentage 
from runner_ordersnew
group by runner_id
order by runner_id
select distinct(date_format(week_date, '%W')) as dayofweek from cleaned_weekly_sales;
```
![image](https://user-images.githubusercontent.com/121611397/233777271-ef6b4a6d-b014-443a-9ef1-b4411bbf685e.png)

---
## C. Ingredient Optimisation
	
### Data cleaning
	
** Create a new table ```pizza_recipesnew``` to separate ```toppings``` into multiple rows**
  
  ```sql
create table pizza_recipesnew (pizza_id integer,toppings integer);
INSERT INTO pizza_recipesnew (pizza_id, toppings)
  VALUES (1, 1), (1, 2), (1, 3), (1, 4), (1, 5), (1, 6), (1, 8), (1, 10),
  (2, 4), (2, 6), (2, 7), (2, 9), (2, 11), (2, 12);
```
 ![image](https://user-images.githubusercontent.com/121611397/233777515-140cc83d-a9a6-401d-b873-44ba4c212f53.png)

### Q1. What are the standard ingredients for each pizza?
  
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

  
 ### Q2. What was the most commonly added extra?
  
 ```sql
with cte as(select Year_ ,
sum(case when week_ between @week_change-4 and @week_change-1 then sales end) as before_weeks,
sum(case when week_ between @week_change and @week_change+3 then sales end) as after_weeks
from cleaned_weekly_sales
group by Year_)
select *,after_weeks-before_weeks as growth,round((after_weeks-before_weeks)*100/(before_weeks),2) as pct_change
from cte;
 ```

 
### Q3. What was the most common exclusion?
  
```sql
with cte as(select Year_,
sum(case when week_ between @week_change-12 and  @week_change-1 then sales end) as before_weeks,
sum(case when week_ between  @week_change and  @week_change+11 then sales end) as after_weeks
from cleaned_weekly_sales
group by Year_)
select *,after_weeks-before_weeks as growth,round((after_weeks-before_weeks)*100/(before_weeks),2) as pct_change
from cte;
```

 
### Q4.Generate an order item for each record in the ```customers_orders``` table in the format of one of the following
* ```Meat Lovers```
* ```Meat Lovers - Exclude Beef```
* ```Meat Lovers - Extra Bacon```
* ```Meat Lovers - Exclude Cheese, Bacon - Extra Mushroom, Peppers```
	
```sql
with cte as(select Year_,
sum(case when week_ between @week_change-12 and  @week_change-1 then sales end) as before_weeks,
sum(case when week_ between  @week_change and  @week_change+11 then sales end) as after_weeks
from cleaned_weekly_sales
group by Year_)
select *,after_weeks-before_weeks as growth,round((after_weeks-before_weeks)*100/(before_weeks),2) as pct_change
from cte;
```
  	
### Q5. Generate an alphabetically ordered comma separated ingredient list for each pizza order from the ```customer_orders``` table and add a 2x in front of any relevant ingredients.
* For example: ```"Meat Lovers: 2xBacon, Beef, ... , Salami"```	
	
```sql
with cte as(select Year_,
sum(case when week_ between @week_change-12 and  @week_change-1 then sales end) as before_weeks,
sum(case when week_ between  @week_change and  @week_change+11 then sales end) as after_weeks
from cleaned_weekly_sales
group by Year_)
select *,after_weeks-before_weeks as growth,round((after_weeks-before_weeks)*100/(before_weeks),2) as pct_change
from cte;
```
	
### Q6. What is the total quantity of each ingredient used in all delivered pizzas sorted by most frequent first?
	
```sql
with cte as(select Year_,
sum(case when week_ between @week_change-12 and  @week_change-1 then sales end) as before_weeks,
sum(case when week_ between  @week_change and  @week_change+11 then sales end) as after_weeks
from cleaned_weekly_sales
group by Year_)
select *,after_weeks-before_weeks as growth,round((after_weeks-before_weeks)*100/(before_weeks),2) as pct_change
from cte;
```	
	
---  
## D. Pricing and Ratings
### Q1. If a Meat Lovers pizza costs $12 and Vegetarian costs $10 and there were no charges for changes - how much money has Pizza Runner made so far if there are no delivery fees?

```TSQL
SELECT
  SUM(CASE WHEN p.pizza_name = 'Meatlovers' THEN 12
        ELSE 10 END) AS money_earned
FROM #customer_orders_temp c
JOIN pizza_names p
  ON c.pizza_id = p.pizza_id
JOIN #runner_orders_temp r
  ON c.order_id = r.order_id
WHERE r.cancellation IS NULL;
```
| money_earned  |
|---------------|
| 138           |

---
### Q2. What if there was an additional $1 charge for any pizza extras?
* Add cheese is $1 extra
```TSQL
DECLARE @basecost INT
SET @basecost = 138 	-- @basecost = result of the previous question

SELECT 
  @basecost + SUM(CASE WHEN p.topping_name = 'Cheese' THEN 2
		  ELSE 1 END) updated_money
FROM #extrasBreak e
JOIN pizza_toppings p
  ON e.extra_id = p.topping_id;
```
| updated_money  |
|----------------|
| 145            |

---
### Q3. The Pizza Runner team now wants to add an additional ratings system that allows customers to rate their runner, how would you design an additional table for this new dataset - generate a schema for this new table and insert your own data for ratings for each successful customer order between 1 to 5.
```TSQL
DROP TABLE IF EXISTS ratings
CREATE TABLE ratings (
  order_id INT,
  rating INT);
INSERT INTO ratings (order_id, rating)
VALUES 
  (1,3),
  (2,5),
  (3,3),
  (4,1),
  (5,5),
  (7,3),
  (8,4),
  (10,3);

 SELECT *
 FROM ratings;
 ```
| order_id | rating  |
|----------|---------|
| 1        | 3       |
| 2        | 5       |
| 3        | 3       |
| 4        | 1       |
| 5        | 5       |
| 7        | 3       |
| 8        | 4       |
| 10       | 3       |

---
### Q4. Using your newly generated table - can you join all of the information together to form a table which has the following information for successful deliveries?
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

```TSQL
SELECT 
  c.customer_id,
  c.order_id,
  r.runner_id,
  c.order_time,
  r.pickup_time,
  DATEDIFF(MINUTE, c.order_time, r.pickup_time) AS mins_difference,
  r.duration,
  ROUND(AVG(r.distance/r.duration*60), 1) AS avg_speed,
  COUNT(c.order_id) AS pizza_count
FROM #customer_orders_temp c
JOIN #runner_orders_temp r 
  ON r.order_id = c.order_id
GROUP BY 
  c.customer_id,
  c.order_id,
  r.runner_id,
  c.order_time,
  r.pickup_time, 
  r.duration;
  ```
| customer_id | order_id | runner_id | order_time              | pickup_time             | mins_difference | duration | avg_speed | pizza_count  |
|-------------|----------|-----------|-------------------------|-------------------------|-----------------|----------|-----------|--------------|
| 101         | 1        | 1         | 2020-01-01 18:05:02.000 | 2020-01-01 18:15:34.000 | 10              | 32       | 37.5      | 1            |
| 101         | 2        | 1         | 2020-01-01 19:00:52.000 | 2020-01-01 19:10:54.000 | 10              | 27       | 44.4      | 1            |
| 101         | 6        | 3         | 2020-01-08 21:03:13.000 | NULL                    | NULL            | NULL     | NULL      | 1            |
| 102         | 3        | 1         | 2020-01-02 23:51:23.000 | 2020-01-03 00:12:37.000 | 21              | 20       | 40.2      | 2            |
| 102         | 8        | 2         | 2020-01-09 23:54:33.000 | 2020-01-10 00:15:02.000 | 21              | 15       | 93.6      | 1            |
| 103         | 4        | 2         | 2020-01-04 13:23:46.000 | 2020-01-04 13:53:03.000 | 30              | 40       | 35.1      | 3            |
| 103         | 9        | 2         | 2020-01-10 11:22:59.000 | NULL                    | NULL            | NULL     | NULL      | 1            |
| 104         | 5        | 3         | 2020-01-08 21:00:29.000 | 2020-01-08 21:10:57.000 | 10              | 15       | 40        | 1            |
| 104         | 10       | 1         | 2020-01-11 18:34:49.000 | 2020-01-11 18:50:20.000 | 16              | 10       | 60        | 2            |
| 105         | 7        | 2         | 2020-01-08 21:20:29.000 | 2020-01-08 21:30:45.000 | 10              | 25       | 60        | 1            |

---
### Q5. If a Meat Lovers pizza was $12 and Vegetarian $10 fixed prices with no cost for extras and each runner is paid $0.30 per kilometre traveled - how much money does Pizza Runner have left over after these deliveries?
```TSQL
DECLARE @basecost INT
SET @basecost = 138

SELECT 
  @basecost AS revenue,
  SUM(distance)*0.3 AS runner_paid,
  @basecost - SUM(distance)*0.3 AS money_left
FROM #runner_orders_temp;
```
| revenue | runner_paid | money_left  |
|---------|-------------|-------------|
| 138     | 43.56       | 94.44       |
	
---	
## 🔥 Bonus Questions

### If Danny wants to expand his range of pizzas - how would this impact the existing data design? Write an INSERT statement to demonstrate what would happen if a new Supreme pizza with all the toppings was added to the Pizza Runner menu?

```TSQL
INSERT INTO pizza_names (pizza_id, pizza_name)
VALUES (3, 'Supreme');

ALTER TABLE pizza_recipes
ALTER COLUMN toppings VARCHAR(50);

INSERT INTO pizza_recipes (pizza_id, toppings)
VALUES (3, '1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12');
```
Notice that I had to update the column ```toppings``` because the Supreme pizza had all the toppings.
  
</details> 
  
## 💡 Insights and Learnings


<details>
<summary>
Click here to expand!
</summary>

 <br> 
 
 
 * Insights into customer preferences and ordering patterns at the restaurant.
	
      * ```Meatlover_pizzas``` are more ```popular``` than vegetarian pizzas, with 75% of total orders being for meatlovers. 
	
      * ```Standard_pizzas``` with standard toppings are also a ```popular_choice```, accounting for almost 50% of all orders.
	
      * ```Wednesdays``` and ```Saturdays``` are the ```busiest_days```, with 5 orders placed each.
	
      * ```Orders were placed at different times of the day```, including lunchtime (1 pm), in the evening (around 6 pm), and late at night (11 pm).
	
 
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


