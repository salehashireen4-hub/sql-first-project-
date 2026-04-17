select * from sales
--data cleaning 
select * from sales where
	transaction_id is null or
	sale_date is null or 
	sale_time is null or 
	customer_id is null or 
	gender is null or 
	age is null or 
	category is null or 
	quantity is null or
	price_per_unit is null or 
	cogs is null or
	total_sale is null 

delete from sales where
	transaction_id is null or
	sale_date is null or 
	sale_time is null or 
	customer_id is null or 
	gender is null or 
	age is null or 
	category is null or 
	quantity is null or
	price_per_unit is null or 
	cogs is null or
	total_sale is null 

-- Data Exploration

-- How many sales we have?
SELECT COUNT(*) as total_sale FROM retail_sales

-- How many uniuque customers we have ?

SELECT COUNT(DISTINCT customer_id) as total_sale FROM retail_sales


--data analysis problems and answers 


-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 
-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)

-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05
select * from sales where sale_date = '2022-11-05'

-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 10 in the month of Nov-2022

select *, extract(month from sale_date) as month, extract(year from sale_date) as year  from sales
where category = 'Clothing' and quantity > 3 and  extract(month from sale_date) = 11 and extract(year from sale_date) = 2022

-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.

select sum(total_sale), category, count(*) from sales group by 2

-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
select avg(age) from sales where category = 'Beauty'

-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
select * from sales where total_sale>1000

-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
select count(transaction_id), gender from sales group by gender

-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
select * from
(select *,
rank() over (partition by yr order by tt desc ) as new
from 
(select cast(avg(total_sale) as integer) as tt , to_char(sale_date, 'mm') as mn, to_char(sale_date,'yyyy') as yr
 from sales group by to_char(sale_date, 'mm'), to_char(sale_date,'yyyy') order by 3) as q) as qq
where new = 1

-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 
select customer_id, sum(total_sale) from sales group by customer_id order by 2 desc limit 5 

-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
select count(distinct(customer_id)), category from sales group by category

-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17)
select count(transaction_id), shift from
(select *, 
	case
	when extract(hour from sale_time) < 12 then 'morning'
	when extract(hour from sale_time) between 12 and 17 then 'afternoon'
	when extract(hour from sale_time) > 17 then  'evening'
	end as shift
from sales) as e
group by shift

