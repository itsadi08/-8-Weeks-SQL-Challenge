#  👆🎣 Case Study #6 - Clique Bait

<p align ="center">
 <img width="300" height="300" src="https://user-images.githubusercontent.com/121611397/233766882-bdf62853-0d52-4c0a-a74a-81302cc94f92.png">
</p>


## 📕 Table of Contents

 -	[Problem Statement](https://github.com/itsadi08/8-Weeks-SQL-Challenge/edit/main/Case%20Study%20%236%20-%20Clique%20Bait#-problem-statement)   

 - [Entity Relationship Diagram](https://github.com/itsadi08/8-Weeks-SQL-Challenge/edit/main/Case%20Study%20%236%20-%20Clique%20Bait#-entity-relationship-diagram)

 -	[Case Study Questions and Bonus Questions](https://github.com/itsadi08/8-Weeks-SQL-Challenge/edit/main/Case%20Study%20%236%20-%20Clique%20Bait#-case-study-and-bonus-questions)

 - [SQL Queries for Questions](https://github.com/itsadi08/8-Weeks-SQL-Challenge/edit/main/Case%20Study%20%236%20-%20Clique%20Bait#-sql-queries-for-questions)
 
 -	[Insights and Learnings](https://github.com/itsadi08/8-Weeks-SQL-Challenge/edit/main/Case%20Study%20%236%20-%20Clique%20Bait#-insights-and-learnings)

## 📝 Problem Statement

Alright folks, listen up! We've got a fishy situation on our hands. Clique Bait, an online seafood store, is run by the CEO Danny, who thinks he's a hotshot data analyst. He wants us to help him calculate funnel fallout rates for his store. Our mission, should we choose to accept it, is to dive deep into his dataset and come up with creative solutions to identify where customers are dropping off in the sales funnel. Danny wants to expand his knowledge of the seafood industry, and we're gonna help him do just that by optimizing his sales funnel and boosting his conversion rates. Let's show him how it's done!

## 🔐 Entity Relationship Diagram

<p align ="center">
 <img width="800" height="400" src="https://user-images.githubusercontent.com/121611397/233767096-c9839f19-a3fd-437a-85fa-79eb5201d0f4.png">
</p>


The tables are pretty self-explanatory based on the column names but here are some further details about the dataset:

- Users table shows the customers who visit the Clique Bait website are tagged via their cookie_id..

- Customer visits are logged in this events table at a cookie_id level and the event_type and page_id values can be used to join onto relevant satellite tables to   obtain further information about each event.The sequence_number is used to order the events within each visit.

- The event_identifier table shows the types of events which are captured by Clique Bait’s digital data systems.

- The campaign identifier table shows information for the 3 campaigns that Clique Bait has ran on their website so far in 2020.

- This page hierarchy table lists all of the pages on the Clique Bait website which are tagged and have data passing through from user interaction events.

## 📋 Case Study and Bonus Questions

<details>
<summary>
Click here to expand!
</summary>
  
### A. Digital Analysis

Using the available datasets - answer the following questions using a single query for each one:

1. How many users are there?
2. How many cookies does each user have on average?
3. What is the unique number of visits by all users per month?
4. What is the number of events for each event type?
5. What is the percentage of visits which have a purchase event?
6. What is the percentage of visits which view the checkout page but do not have a purchase event?
7. What are the top 3 pages by number of views?
8. What is the number of views and cart adds for each product category?
9. What are the top 3 products by purchases?

---
### B. Product Funnel Analysis

Using a single SQL query - create a new output table which has the following details:

  * How many times was each product viewed?
  * How many times was each product added to cart?
  * How many times was each product added to a cart but not purchased (abandoned)?
  * How many times was each product purchased?
  
Additionally, create another table which further aggregates the data for the above points but this time for each product category instead of individual products.

Use your 2 new output tables - answer the following questions:
1. Which product had the most views, cart adds and purchases?
2. Which product was most likely to be abandoned?
3. Which product had the highest view to purchase percentage?
4. What is the average conversion rate from view to cart add?
5. What is the average conversion rate from cart add to purchase?

---
### C. Campaigns Analysis

Generate a table that has 1 single row for every unique visit_id record and has the following columns:

  * `user_id`
  * `visit_id`
  * `visit_start_time`: the earliest event_time for each visit
  * `page_views`: count of page views for each visit
  * `art_adds`: count of product cart add events for each visit
  * `purchase`: 1/0 flag if a purchase event exists for each visit
  * `campaign_name`: map the visit to a campaign if the visit_start_time falls between the start_date and end_date
  * `impression`: count of ad impressions for each visit
  * `click`: count of ad clicks for each visit
  * (Optional column) `cart_products`: a comma separated text value with 
  products added to the cart sorted by the order they were added to the cart (hint: use the `sequence_number`)

---

### D. Bonus Questions

1. Some ideas to investigate further include:

   - Identifying users who have received impressions during each campaign period and comparing each metric with other users who did not have an impression event.
   
   - Does clicking on an impression lead to higher purchase rates?
   
   - What is the uplift in purchase rate when comparing users who click on a campaign impression versus users who do not receive an impression? What if we compare them      with users who have just an impression but do not click?
   
   - What metrics can you use to quantify the success or failure of each campaign compared to each other?

</details>

## 🔎 SQL Queries for Questions

<details>
<summary>
Click here to expand!
</summary> 

## A. Digital Analysis

#### 1. How many users are there?

```sql
select count(distinct user_id) as Total_users from users;
```
![image](https://user-images.githubusercontent.com/121611397/233767782-388f17d6-9572-4379-8157-0e88f21d48ce.png)


#### 2. How many cookies does each user have on average?

```sql
with cte as(select user_id,count(cookie_id) as Total_Cookies_Generated from users
group by user_id)
Select round(avg(Total_Cookies_Generated),0) as Avg_Cookies_Generated from cte;
```
![image](https://user-images.githubusercontent.com/121611397/233767831-8caecda1-07d9-40f2-be41-07caed1b9587.png)

#### 3. What is the unique number of visits by all users per month?

```sql
select monthname(event_time) as Months, count(distinct visit_id) as Unique_visits from events
group by Months,Month(event_time)
order by Month(event_time);
```
![image](https://user-images.githubusercontent.com/121611397/233767862-6216f63b-c7f9-4a1e-b5fb-e287755cad96.png)


#### 4. What is the number of events for each event type?

```sql
Select
event_type,count(event_type) as No_of_events
from events
group by event_type
order by event_type;
```
              
![image](https://user-images.githubusercontent.com/121611397/233768017-45ae3d97-7f7f-4043-9030-e9f99dcf02ad.png)

#### 5. What is the percentage of visits which have a purchase event?

```sql
select round(count(distinct visit_id)*100/(select count(distinct visit_id) from events),1) as Percentage_Visits
from events e
join event_identifier i on i.event_type= e.event_type
where event_name='Purchase';
```
![image](https://user-images.githubusercontent.com/121611397/233768050-1082021f-59d2-42d4-99d0-89ef71eed9a0.png)

#### 6. What is the percentage of visits which view the checkout page but do not have a purchase event?

```sql
with checkout as (
select count(distinct visit_id) as Count
from events 
where event_type=1 and page_id=12),

no_purchase as
(select count(distinct visit_id) as count1  from events 
where event_type=3)

select round((1-count1/count)*100,1) as percentage_checkout_with_no_purchase from checkout,no_purchase;
```

![image](https://user-images.githubusercontent.com/121611397/233768131-7e749c57-b21c-41a7-b76f-4410d739f24e.png)

#### 7. What are the top 3 pages by number of views?

```sql
select page_name, count(page_id) as Count
from events 
join page_hierarchy using(page_id)
where event_type=1
group by page_name
order by Count desc
limit 3;
```
![image](https://user-images.githubusercontent.com/121611397/233768143-e44711b5-d63a-4a4a-8072-c7c3a37550ed.png)

#### 8. What is the number of views and cart adds for each product category?

```sql
Select product_category,count(case when event_type=1 then event_type end) as Total_views, 
count( case when event_type=2 then event_type end) as Cart_adds
from events 
join event_identifier using (event_type)
join page_hierarchy using (page_id)
group by product_category
having product_category is not null
order by Total_views desc,Cart_adds desc;
```
![image](https://user-images.githubusercontent.com/121611397/233768168-983ca76d-a070-4f1e-a3f5-0b6f1bf77ae6.png)
  
#### 9. What are the top 3 products by purchases?
  
```sql
select page_name, count(event_type) purchase_count
from events
join event_identifier using (event_type)
join page_hierarchy using (page_id)
where event_name='Add to Cart'
and visit_id in (select visit_id
  from events 
  join event_identifier using (event_type)
  where event_name = 'Purchase')
group by page_name,event_name
order by event_name,count(visit_id) desc
limit 3;
```
![image](https://user-images.githubusercontent.com/121611397/233768269-3bdbe1e1-46fd-439b-b9f5-3196cf4aeb0d.png)
  
---
## B. Product Funnel Analysis
 
#### Using a single SQL query - create a new output table which has the following details:
 
  * How many times was each product viewed?
  * How many times was each product added to cart?
  * How many times was each product added to a cart but not purchased (abandoned)?
  * How many times was each product purchased?

The output table will look like:

| Columns          | Description                                                               |
|------------------|---------------------------------------------------------------------------|
| product_id       | Id of each product                                                        |
| product_name     | Name of each product                                                      |
| product_category | Category of each product                                                  |
| views            | Number of times each product viewed                                       |
| cart_adds        | Number of times each product added to cart                                |
| abondoned        | Number of times each product added to cart but not purchased (abandoned)  |
| purchases        | Number of times each product purchased                                    |
 
 
  ```sql
DROP TEMPORARY TABLE IF EXISTS product_summary;
CREATE TEMPORARY TABLE product_summary
AS
with cte as (select product_id as Product_id,page_name as Product_name,
sum(case when event_name='Page View' then 1 else 0 end) as Page_View,
sum(case when event_name='Add to Cart' then 1 else 0 end) as Add_to_Cart
from events
join event_identifier using (event_type)
join page_hierarchy using (page_id)
where product_id is not null
group by product_id ,page_name
order by product_id ,page_name)
,cte1 as( 
select cte.Product_id as Product_id,Product_name,Page_View,Add_to_Cart,count(event_type) as Purchased from events
join event_identifier using (event_type)
join page_hierarchy using (page_id)
join cte on cte.Product_id=page_hierarchy.Product_id
where event_name='Add to Cart'
and visit_id in (select visit_id
  from events join event_identifier using (event_type) where event_name = 'Purchase')
group by cte.Product_id,Product_name,Page_View,Add_to_Cart),
cte2 as(select cte1.Product_id as Product_id,Product_name,Page_View,Add_to_Cart,cte1.Purchased,Add_to_Cart-cte1.Purchased as Abandoned
from cte1
order by cte1.Product_id)
select *
from cte2
order by Product_id;
```
 ![image](https://user-images.githubusercontent.com/121611397/233769039-d944b414-4cf0-46fe-aa3d-0bc6f0362e0d.png)

 #### Additionally, create another table which further aggregates the data for the above points but this time for each product category instead of individual products.
  
 ```sql
 
DROP TEMPORARY TABLE IF EXISTS category_summary;
CREATE TEMPORARY TABLE category_summary AS
with cte as (select product_category,
sum(case when event_name='Page View' then 1 else 0 end) as Page_View,
sum(case when event_name='Add to Cart' then 1 else 0 end) as Add_to_Cart
from events
join event_identifier using (event_type)
join page_hierarchy using (page_id)
where product_id is not null
group by product_category
order by product_category)
 ,cte1 as( 
select cte.product_category as Category,Page_View,Add_to_Cart,count(event_type) as Purchased from events
join event_identifier using (event_type)
join page_hierarchy using (page_id)
join cte on cte.product_category=page_hierarchy.product_category
where event_name='Add to Cart'
and visit_id in (select visit_id
 from events join event_identifier using (event_type) where event_name = 'Purchase')
group by cte.product_category,Page_View,Add_to_Cart),
cte2 as(select cte1.Category,Page_View,Add_to_Cart,cte1.Purchased,Add_to_Cart-cte1.Purchased as Abandoned
from cte1)
select *
from cte2;
```
![image](https://user-images.githubusercontent.com/121611397/233769087-8a68121f-2af8-42e7-853c-bf28e6ca3edb.png)

 ---
 Use your 2 new output tables - Answer the following questions:
  
 #### 1. Which product had the most views, cart adds and purchases?
 
  - Most Product Views.
 
```sql
select Product_name from product_summary
order by Page_View desc
limit 1;
```
 ![image](https://user-images.githubusercontent.com/121611397/233769352-161fd66b-413c-487f-b50b-d60ee29650b5.png)
 
  - Most Cart Adds.
  
```sql
select Product_name from product_summary
order by Add_to_Cart desc
limit 1;
 ```
  ![image](https://user-images.githubusercontent.com/121611397/233769452-e8cd933e-b492-4563-9921-cfa5afbe9b99.png)
  
 - Most Purchases.
 
 ```sql
select Product_name from product_summary
order by Purchased desc
limit 1;
  ```
 ![image](https://user-images.githubusercontent.com/121611397/233769530-60d622c8-e7b8-46de-a134-ae8fad603549.png)

 #### 2. Which product was most likely to be abandoned?
 
  ```sql
select Product_name from product_summary
order by Abandoned desc
limit 1;
  ```
 ![image](https://user-images.githubusercontent.com/121611397/233770284-ee261328-eb4c-49ce-ac8e-fc0ae4eab88e.png)

  #### 3. Which product was most likely to be abandoned?
 
  ```sql
select Product_name,round(Purchased*100/Page_View,1) as Percentage from product_summary
 order by Percentage desc
 limit 1;
  ```
 ![image](https://user-images.githubusercontent.com/121611397/233770293-a1ed8fd9-1e49-4d98-9603-aa1ad01ef4ec.png)

 #### 4. What is the average conversion rate from view to cart add?
 
  ```sql
select round(avg(Add_to_Cart*100/Page_View),2) as Conversion_rate from product_summary;
  ```
 ![image](https://user-images.githubusercontent.com/121611397/233770381-f207c5c5-7d39-413c-956b-a6721333feb8.png)

  #### 5. What is the average conversion rate from cart add to purchase?
 
  ```sql
select round(avg(Purchased*100/Add_to_Cart),2) as Conversion_rate from product_summary;
  ```
 ![image](https://user-images.githubusercontent.com/121611397/233770414-222224b7-28c2-45cb-a97b-eff673e99fd2.png)

---  
 ## C. Campaigns Analysis
Generate a table that has 1 single row for every unique visit_id record and has the following columns:
  * `user_id`
  * `visit_id`
  * `visit_start_time`: the earliest event_time for each visit
  * `page_views`: count of page views for each visit
  * `art_adds`: count of product cart add events for each visit
  * `purchase`: 1/0 flag if a purchase event exists for each visit
  * `campaign_name`: map the visit to a campaign if the visit_start_time falls between the start_date and end_date
  * `impression`: count of ad impressions for each visit
  * `click`: count of ad clicks for each visit
  * (Optional column) `cart_products`: a comma separated text value with 
  products added to the cart sorted by the order they were added to the cart (hint: use the `sequence_number`)
 
 ```sql
 DROP TEMPORARY TABLE IF EXISTS campaigns_analysis;
CREATE TEMPORARY TABLE campaigns_analysis
select 
user_id,
visit_id,
min(event_time) as visit_start_time,
sum(case when event_name='Page View' then 1 else 0 end ) as page_views,
sum(case when event_name='Add to Cart' then 1 else 0 end ) as cart_adds,
sum(case when event_name='Purchase' then 1 else 0 end ) as purchase,
campaign_name,
sum(case when event_name='Ad Impression' then 1 else 0 end ) as impression,
sum(case when event_name='Ad Click' then 1 else 0 end ) as click,
group_concat(case when event_name = 'Add to Cart' then page_name end order by sequence_number separator ', ') as cart_products
from events 
join users using (cookie_id)
join event_identifier using (event_type)
join page_hierarchy using (page_id)
left join campaign_identifier c 
on event_time between c.start_date and c.end_date
group by user_id, visit_id, campaign_name;
```
 First 12 rows out of 3,564 rows in total:-
 
 ![image](https://user-images.githubusercontent.com/121611397/233770692-d7d88b09-002a-4694-be11-a00aed0b4718.png)

 
 ---
## 🔥 Bonus Questions

 Some ideas to investigate further include:


 #### 1. Identifying users who have received impressions during each campaign period and comparing each metric with other users who did not have an impression event.
   
  ```sql
 
 
 
 
 
  ```
 #### 2. Does clicking on an impression lead to higher purchase rates?
   
 
 
 
 
 
 #### 3. What is the uplift in purchase rate when comparing users who click on a campaign impression versus users who do not receive an impression? What if we compare          them with users who have just an impression but do not click?
   
 
 
 
 
 #### 4. What metrics can you use to quantify the success or failure of each campaign compared to each other?
 
  

  
</details> 
  
## 💡 Insights and Learnings


<details>
<summary>
Click here to expand!
</summary>

 <br> 
 
 
 TO BE UPDATED SOON
 
 

 
### Learnings....!!!
 
After analysing this case study, I have gained a strong understanding of the following concepts:

-Common Table Expressions.
 
-Group By Aggregates.
 
-Window Functions for ranking and row number.
 
-Joins with using keyword.
 
-Case Function with between and date function.



</details>


