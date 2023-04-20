# 🍜 Case Study #1 - Danny's Diner

<p align ="center">
 <img width="300" height="300" src="https://user-images.githubusercontent.com/121611397/233270716-adc25de5-b22e-4011-bc9f-bd216dcabdfe.png">
</p>

## 📕 Table of Contents

 -	[Problem Statement](https://github.com/itsadi08/8-Weeks-SQL-Challenge/tree/main/Case%20Study%20%231%20-%20Danny's%20Diner#-problem-statement)   

 - [Entity Relationship Diagram](https://github.com/itsadi08/8-Weeks-SQL-Challenge/tree/main/Case%20Study%20%231%20-%20Danny's%20Diner#-entity-relationship-diagram)

 -	[Case Study Questions & Bonus Questions](https://github.com/itsadi08/8-Weeks-SQL-Challenge/tree/main/Case%20Study%20%231%20-%20Danny's%20Diner#-case-study-&amp;-bonus-questions)

 - [SQL Queries for Questions](https://github.com/itsadi08/8-Weeks-SQL-Challenge/tree/main/Case%20Study%20%231%20-%20Danny's%20Diner#-sql-queries-for-questions)
 
 -	[Insights & Learnings](https://github.com/itsadi08/8-Weeks-SQL-Challenge/tree/main/Case%20Study%20%231%20-%20Danny's%20Diner#-insights-&amp;-learnings)

## 📝 Problem Statement
Danny wants to use the data to answer a few simple questions about his customers, especially about their visiting patterns, how much money they’ve spent and also which menu items are their favourite. Having this deeper connection with his customers will help him deliver a better and more personalised experience for his loyal customers.

He plans on using these insights to help him decide whether he should expand the existing customer loyalty program - additionally he needs help to generate some basic datasets so his team can easily inspect the data without needing to use SQL.

## 🔐 Entity Relationship Diagram

<p align ="center">
 <img width="600" height="300" src="https://user-images.githubusercontent.com/121611397/233428417-6cc826cf-c4cf-4598-801f-9d507c664780.png">
</p>

## 📋 Case Study & Bonus Questions

1.	What is the total amount each customer spent at the restaurant?

2.	How many days has each customer visited the restaurant?

3.	What was the first item from the menu purchased by each customer?

4.	What is the most purchased item on the menu and how many times was it purchased by all customers?

5.	Which item was the most popular for each customer?

6.	Which item was purchased first by the customer after they became a member?

7.	Which item was purchased just before the customer became a member?

8.	What is the total items and amount spent for each member before they became a member?

9.	If each $1 spent equates to 10 points and sushi has a 2x points multiplier - how many points would each customer have?

10.	In the first week after a customer joins the program (including their join date) they earn 2x points on all items, not just sushi - how many points do customer A and B have at the end of January?

### 🔥 Bonus Questions

1. Join All The Things - Create a table that has these columns: customer_id, order_date, product_name, price, member (Y/N).

2. Rank All The Things - Based on the table above, add ranking.

## 🔎 SQL Queries for Questions

1.	What is the total amount each customer spent at the restaurant?

```sql
Select customer_id,sum(price) as Total_Amount_Spent
from dannys_diner.sales s
left join dannys_diner.menu m on m.product_id=s.product_id
group by customer_id
order by customer_id;
```
![image](https://user-images.githubusercontent.com/121611397/233430825-e0c56041-adeb-4926-8388-2fd7295e61d7.png)


2.	How many days has each customer visited the restaurant?

```sql
Select customer_id,count(distinct order_date) as Total_Visits
from dannys_diner.sales s
group by customer_id
order by customer_id;
```
![image](https://user-images.githubusercontent.com/121611397/233431208-3284916c-0ef5-4381-b5f9-24b56bbac99f.png)


3.	What was the first item from the menu purchased by each customer?

```sql
Select customer_id,product_name from 
(select customer_id,order_date,product_name,row_number() over(partition by customer_id order by order_date,s.product_id) as rn
from dannys_diner.sales s
join dannys_diner.menu m on m.product_id=s.product_id) t
where rn<=1;
```
![image](https://user-images.githubusercontent.com/121611397/233431580-631e94a4-6349-4bc8-a0b7-c199a6afce8d.png)

4.	What is the most purchased item on the menu and how many times was it purchased by all customers?

```sql
Select product_name,count(*) as Purchased_quantity
from dannys_diner.sales s
join dannys_diner.menu m
using( product_id ) 
group by product_name
limit 1;
```
![image](https://user-images.githubusercontent.com/121611397/233432050-e923801a-c655-4c59-8308-e1dc1aecdf8e.png)


5.	Which item was the most popular for each customer?

```sql
with cte as (
select s.customer_id, m.product_name, count(*) as purchase_count,
rank() over(partition by s.customer_id order by count(*) desc) as rn
from dannys_diner.sales s
join dannys_diner.menu m
using (product_id)
group by s.customer_id, m.product_name )
select customer_id, product_name, purchase_count
from cte
where rn = 1;
```
![image](https://user-images.githubusercontent.com/121611397/233432567-708112ee-000f-4223-bc46-0d88bfefc195.png)

6.	Which item was purchased first by the customer after they became a member?

```sql
with cte as (select s.customer_id,product_name,order_date, rank() over(partition by s.customer_id order by order_date)rn
from dannys_diner.sales s
left join dannys_diner.members mb on s.customer_id=mb.customer_id
join dannys_diner.menu m 
using (product_id)
where order_date>= join_date)
select customer_id,product_name from cte
where rn=1;
```
![image](https://user-images.githubusercontent.com/121611397/233432897-abfaa8a8-e61f-4406-bf2b-68ac2ffd22de.png)

7.	Which item was purchased just before the customer became a member?

```sql
with cte as (select s.customer_id,max(order_date) as last_date
from dannys_diner.sales s
left join dannys_diner.members mb on s.customer_id=mb.customer_id
where order_date< join_date
group by s.customer_id)
select s.customer_id,product_name from cte
join dannys_diner.sales s on s.customer_id=cte.customer_id and s.order_date=cte.last_date
join dannys_diner.menu m
using (product_id);
```
![image](https://user-images.githubusercontent.com/121611397/233433141-d9e1457b-07e1-4b91-9b28-56ca8b5c4d9d.png)

8.	What is the total items and amount spent for each member before they became a member?

```sql
select s.customer_id,count(s.product_id) as total_items, sum(price) as total_amount_spent 
from dannys_diner.sales s
left join dannys_diner.members mb on s.customer_id=mb.customer_id
join dannys_diner.menu m
using (product_id)
where order_date< join_date or join_date is null
group by s.customer_id
order by customer_id;
```
![image](https://user-images.githubusercontent.com/121611397/233434547-421c03f6-273f-44b7-85ba-c35a3c2c5e5f.png)

9.	If each $1 spent equates to 10 points and sushi has a 2x points multiplier - how many points would each customer have?

```sql
with cte as (select *,case when product_name='sushi'then price*20 else price *10 end as points
from dannys_diner.menu m)
select customer_id,sum (points)
from cte
join dannys_diner.sales s 
using (product_id)
group by s.customer_id
order by customer_id;
```
![image](https://user-images.githubusercontent.com/121611397/233434436-2f081722-a0e8-4d14-a5b4-bbf438b39548.png)

10.	In the first week after a customer joins the program (including their join date) they earn 2x points on all items, not just sushi - how many points do customer A and B have at the end of January?

```sql
with cte as (select s.customer_id,
case when order_date between join_date and join_date + interval '6 days' then price*20 else price*10 end as points
from dannys_diner.menu m
join dannys_diner.sales s on s.product_id= m.product_id
join dannys_diner.members mb on mb.customer_id = s.customer_id
where s.order_date >= '2021-01-01' and s.order_date <= '2021-01-31')
select customer_id,sum (points)
from cte
group by customer_id
order by customer_id;
```
![image](https://user-images.githubusercontent.com/121611397/233434353-2064efec-fdcd-4e83-9c0b-e0687f44804d.png)


#### 🔥 Bonus Questions

1. Join All The Things - Create a table that has these columns: customer_id, order_date, product_name, price, member (Y/N).

```sql
select s.customer_id, s.order_date,m.product_name,m.price,
case when s.order_date >= mb.join_date then 'Y' else 'N' end as member
from dannys_diner.sales s
join dannys_diner.menu m using (product_id) 
left join dannys_diner.members mb using (customer_id);
```
![image](https://user-images.githubusercontent.com/121611397/233434210-9524d3c0-e1b4-4188-a1a3-300552a9aed0.png)

2. Rank All The Things - Based on the table above, add ranking.

```sql
with cte as (select s.customer_id, s.order_date,m.product_name,m.price,
case when s.order_date >= mb.join_date then 'Y' else 'N' end as member
from dannys_diner.sales s
join dannys_diner.menu m using (product_id) 
left join dannys_diner.members mb using (customer_id)
order by order_date)
select *,
case when member='Y' then dense_rank()over(partition by customer_id,member order by order_date) else Null end as Ranking
from cte;
```
![image](https://user-images.githubusercontent.com/121611397/233434031-c2522086-c524-4c4b-bcef-0648548f9125.png)

### Insights & Learnings

