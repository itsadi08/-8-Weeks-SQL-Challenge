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
select pizza_name,string_agg(topping_name,', ') as Standard_Ingredient
from pizza_recipesnew 
join pizza_names 
using (pizza_id)
join pizza_toppings on pizza_recipesnew.toppings=pizza_toppings.topping_id
group by pizza_name
order by pizza_name;
```
![image](https://user-images.githubusercontent.com/121611397/233790646-b5842873-c95e-46fe-82a3-f05ec4649263.png)

  
 ### Q2. What was the most commonly added extra?
  
 ```sql
with cte as(select unnest(string_to_array(extras, ',')):: int as ext_top,count(*) as Occurence_count
from Customer_ordersnew c
where extras is not null
group by ext_top)
select topping_name as Extra_topping,Occurence_count from cte
join pizza_toppings p on
cte.ext_top = p.topping_id
order by Occurence_count desc;
 ```
![image](https://user-images.githubusercontent.com/121611397/233790691-7ad1043a-9610-4aa6-8138-7d72bcd060a9.png)

 
### Q3. What was the most common exclusion?
  
```sql
with cte as(select unnest(string_to_array(exclusions, ',')):: int as exclu_top,count(*) as Occurence_count
from Customer_ordersnew c
where exclusions is not null
group by exclu_top)
select topping_name as Exclusion_topping,Occurence_count from cte
join pizza_toppings p on
cte.exclu_top = p.topping_id
order by Occurence_count desc;
```
![image](https://user-images.githubusercontent.com/121611397/233790732-39fbf645-27ae-4317-b37e-e7482ac5a0ef.png)

 
### Q4.Generate an order item for each record in the ```customers_orders``` table in the format of one of the following
* ```Meat Lovers```
* ```Meat Lovers - Exclude Beef```
* ```Meat Lovers - Extra Bacon```
* ```Meat Lovers - Exclude Cheese, Bacon - Extra Mushroom, Peppers```
	
```sql
with cte as (select*,row_number()over()as rn from customer_ordersnew),
cte2 as(select rn,order_id,pizza_name,cte.pizza_id,customer_id,order_time,
      	case when cte.exclusions!='null' and topping_id in (select unnest(string_to_array(cte.exclusions,',')::int [])) 
		then topping_name end as exclusion_toppings,
      	case when cte.extras !='null' and topping_id in (select unnest(string_to_array(cte.extras,',')::int [])) 
		then topping_name end as extra_toppings
	from pizza_toppings as t,cte
    join pizza_names on cte.pizza_id=pizza_names.pizza_id
    group by 
      	 rn,
      	 order_id,
     	 pizza_name,customer_id,
	 	 cte.pizza_id ,order_time,
      	 exclusion_toppings,
      	 extra_toppings)
select
order_id,customer_id,cte2.pizza_id,order_time,
concat(pizza_name,
	   ' ',
	  case when count(exclusion_toppings)>0 then '-Exclude ' else '' end,
	  string_agg(exclusion_toppings,', '),
	  case when count(extra_toppings)>0 then '-Extra ' else '' end ,
	  string_agg(extra_toppings,', '))as ingredients_list
	  from cte2
	  group by order_id,pizza_name,customer_id,order_time,cte2.pizza_id,cte2.rn
	  order by rn;
```
![image](https://user-images.githubusercontent.com/121611397/233804066-03444148-0f14-480b-b4a9-068d52714350.png)

  	
### Q5. Generate an alphabetically ordered comma separated ingredient list for each pizza order from the ```customer_orders``` table and add a 2x in front of any relevant ingredients.
* For example: ```"Meat Lovers: 2xBacon, Beef, ... , Salami"```	
	
```sql
To be updated soon...
```
	
### Q6. What is the total quantity of each ingredient used in all delivered pizzas sorted by most frequent first?
	
```sql
with std as(select topping_name,count(toppings) as std_Occurence_count from pizza_recipesnew pr
join pizza_toppings pt on pr.toppings=pt.topping_id
join customer_ordersnew  co using(pizza_id)
join runner_ordersnew ro on ro.order_id=co.order_id
where pizza_id in (1,2) and cancellation is null
group by topping_name
order by count(toppings)desc),
extra as(
select topping_name,extra_count from (select unnest(string_to_array(extras, ',')):: int as topping_id,count(*) as extra_count
from Customer_ordersnew c
where extras is not null and order_id not in (6,9)
group by topping_id)t
join pizza_toppings p on
t.topping_id = p.topping_id
order by extra_count desc),
exclusion as(
select topping_name,exclude_count from (select unnest(string_to_array(exclusions, ',')):: int as topping_id,count(*) as exclude_count
from Customer_ordersnew c
where exclusions is not null and order_id not in (6,9)
group by topping_id)t
join pizza_toppings p on
t.topping_id = p.topping_id
order by exclude_count desc)
, total as (
select std.topping_name,std_Occurence_count, extra_count,exclude_count from std
left join extra on std.topping_name=extra.topping_name
left join exclusion on std.topping_name=exclusion.topping_name)

select total.topping_name,(std_Occurence_count+coalesce(extra_count,0)-coalesce(exclude_count,0)) as Total_ingredients from total
order by Total_ingredients desc
```	
![image](https://user-images.githubusercontent.com/121611397/233807536-efdf5829-c810-486f-b215-bf32eec94f06.png)
	
---  
## D. Pricing and Ratings
	
### Q1. If a Meat Lovers pizza costs $12 and Vegetarian costs $10 and there were no charges for changes - how much money has Pizza Runner made so far if there are no delivery fees?

```sql
select sum(case when pizza_id = 1 then 12 else 10 end) as TotalAmount
from runner_ordersnew 
join customer_ordersnew
using(order_id)
where cancellation is null;
```
![image](https://user-images.githubusercontent.com/121611397/233802987-da48253a-025c-468a-b041-9bdfe2cbd651.png)

---
### Q2. What if there was an additional $1 charge for any pizza extras?
* Add cheese is $1 extra
	
```sql
with std_total as (select sum(case when pizza_id = 1 then 12 else 10 end) as TotalAmount
from runner_ordersnew 
join customer_ordersnew
using(order_id)
where cancellation is null),
extras as (select sum(case when topping_id=4 then extra_count*2 else extra_count*1 end) as extras_sum
		   from (select unnest(string_to_array(extras, ',')):: int as topping_id,count(*) as extra_count
from Customer_ordersnew c
where extras is not null and order_id not in (6,9)
group by topping_id)t)
select TotalAmount+extras_sum as total_amount from std_total,extras
```
![image](https://user-images.githubusercontent.com/121611397/233808249-6f68cb1a-11e2-47f3-87e4-bd4f48a4814c.png)


### Q3. The Pizza Runner team now wants to add an additional ratings system that allows customers to rate their runner, how would you design an additional table for this new dataset - generate a schema for this new table and insert your own data for ratings for each successful customer order between 1 to 5.
	
```sql
drop table if exists ratings;
create table ratings (
order_id integer,
rating integer);
insert into ratings
(order_id, rating)
values
(1,4),
(2,5),
(3,3),
(4,5),
(5,2),
(6,null),
(7,3),
(9,null),
(8,4),
(10,4);

 SELECT *
 FROM ratings;
	
 ```
![image](https://user-images.githubusercontent.com/121611397/233802951-d4cb9496-0925-4d4e-9626-06a43c0533a4.png)

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

```sql
Select customer_id,o.order_id,runner_id,rating,order_time,pickup_time,
--extract (minute from 
(pickup_time-order_time)as Time_between_order_pickup, duration as Delivery_duration,
round((distance*60/duration),2) as Average_speed,count(pizza_id) as Total_number_of_pizzas
from customer_ordersnew o
join runner_ordersnew using (order_id)
join ratings using (order_id)
where cancellation is null
group by customer_id,o.order_id,runner_id,rating,order_time,pickup_time,
extract (minute from (pickup_time-order_time)), duration,
(distance*60/duration);
  ```
![image](https://user-images.githubusercontent.com/121611397/233802764-c10b85e3-7fdd-463c-88cb-7bf0afec2b27.png)


### Q5. If a Meat Lovers pizza was $12 and Vegetarian $10 fixed prices with no cost for extras and each runner is paid $0.30 per kilometre traveled - how much money does Pizza Runner have left over after these deliveries?
	
```sql
with total_price as (select sum(case when pizza_id = 1 then 12 else 10 end) as total_amount
from runner_ordersnew 
join customer_ordersnew
using(order_id)
where cancellation is null),
delivery_charges as(select sum(distance)*0.3 as delivery_cost from runner_ordersnew)
select round((total_amount-delivery_cost),1) money_left from total_price,delivery_charges
```
![image](https://user-images.githubusercontent.com/121611397/233802895-30220231-0142-4095-bdc2-7859d3d7c90e.png)
	
---	
## 🔥 Bonus Questions

#### If Danny wants to expand his range of pizzas - how would this impact the existing data design? Write an INSERT statement to demonstrate what would happen if a new      Supreme pizza with all the toppings was added to the Pizza Runner menu?

```sql
Create table pizza_namesnew as Select* from pizza_names

insert into pizza_namesnew (pizza_id, pizza_name)
values (3, 'Supreme');

Create table pizza_recipesnew1 as Select* from pizza_recipesnew

INSERT INTO pizza_recipesnew1 (pizza_id, toppings)
VALUES (3,1),(3,2),(3,3),(3,4),(3,5),(3,6),(3,7),(3,8),(3,9),(3,10),(3,11),(3,12);
	
```
 * Showing 15 rows out of total 26 rows.
	
  ![image](https://user-images.githubusercontent.com/121611397/233804546-b821bf94-427a-4d81-8dfe-5e7bd42f78fd.png)

</details> 
  
## 💡 Insights and Learnings


<details>
<summary>
Click here to expand!
</summary>

 <br> 
 
 
 * Insights into customer preferences and ordering patterns at the restaurant:
	
      * ```Meatlover_pizzas``` are more ```popular``` than vegetarian pizzas, with 75% of total orders being for meatlovers. 
	
      * ```Standard_pizzas``` with standard toppings are also a ```popular_choice```, accounting for almost 50% of all orders.
	
      * ```Wednesdays``` and ```Saturdays``` are the ```busiest_days```, with 5 orders placed each.
	
      * ```Orders were placed at different times of the day```, including lunchtime (1 pm), in the evening (around 6 pm), and late at night (11 pm).
	
* Insights into delivery operations and performance of runners at the restaurant:	
	
     * ```Runner 3 arrives at the restaurant in 10 minutes on average```, while Runner 1 and Runner 2 take 15 and 23 minutes respectively to arrive. This information 		can help the restaurant optimize their delivery operations by assigning deliveries to the fastest runner to ensure timely delivery of orders to their 		  customers.
	
     * On average, a ```single pizza takes 11-12 minutes to prepare```, but this time can increase if the quantity is more. However, the average time to prepare a 	  pizza drops to 9-10 minutes when quantity is more.
	
     * ```Orders are coming from an average distance of 10 km to 25 km```, with Runner 2 covering the most distance of approximately 24 km, while Runner 3 covered only 	10 km.
	
     * The ```shortest delivery time was 10 minutes```, and the ```longest delivery time was 40 minutes```, with an ```average speed of around 45 km/hr per order```.
	
     * ```Runner 1 has a 100% successful delivery record```, while Runner 2 and Runner 3 have a 75% and 50% success rate respectively, due to order cancellations.
	
     * Runner 2's speed of 94 km/hr for order #8 is way too fast compared to other deliveries. It is possible that there is a misspelling error in the distance for the       customer with ID 102, and the actual distance to their address is 13.4 km, not 23.4 km 
	
* Insights into Popularity of Ingredients:

     * ```Bacon is the most popular extra ingredient```, and it was added to 4 pizzas. This suggests that bacon is a popular choice among customers who like to customize their pizzas. 
  
     * ```Similarly, cheese is the most common exclusion, and it was excluded from 4 pizzas. This could be due to various reasons, such as dietary restrictions or personal preferences.
 
     * Ingredients  that are popular among customers are,Bacon is the most frequently used ingredient with a total quantity of 12. It is followed closely by mushrooms with a quantity of 11, and cheese with a quantity of 10.

     * ```BBQ sauce is the most frequently used sauce with a quantity of 8```, followed by tomato sauce with a quantity of 3. This will be useful for the restaurant in terms of understanding which sauces are popular and how much of each sauce to keep in stock.

* Insights into Pricing and Ratings:

     * The ```total revenue generated``` from pizza sales, considering 9 Meat Lovers pizzas sold at $12 each and 3 Vegetarian pizzas sold at $10 each, is ```$138```.
     
     *  Runner 1 has an average rating of 3.5 stars from 4 orders, Runner 2 has an average rating of 3 stars from 3 orders, and Runner 3 has an average rating of 5 stars from 1 order only.
     
     * Pizza Runner has made a ``` net revenue of $94.44``` after paying the runners for their distance traveled at $0.30/km..

### Learnings....!!!
 
After analysing this case study, I have gained a strong understanding of the following concepts:

-Common Table Expressions.
 
-Group By Aggregates.
 
-Window Functions for row number.
 
-Joins with using keyword.
 
-Case Function with between and date function.

-String transformations(like Unnest and string toarray functions,string_agg)

- Dealing with null values and table normalisations.

</details>


