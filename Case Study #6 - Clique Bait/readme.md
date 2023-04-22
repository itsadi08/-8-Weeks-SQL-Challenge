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
set @week_change=25;
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


