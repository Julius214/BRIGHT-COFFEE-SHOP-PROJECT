select * from `workspace`.`default`.`bright_coffee_shop_sales` limit 1000;

-----TOTAL QUANTITY SOLD
select sum(transaction_qty)AS Total_quantity_sold
from `workspace`.`default`.`bright_coffee_shop_sales`;


----TOTAL REVENUE
select sum(transaction_qty*unit_price)as total_revenue
from `workspace`.`default`.`bright_coffee_shop_sales`;


----DIFFERENT STORE LOCATION
select distinct store_location
from `workspace`.`default`.`bright_coffee_shop_sales`;


----DIFFERENT PRODUCTS CATEGORY
select distinct product_category
from `workspace`.`default`.`bright_coffee_shop_sales`;


-----AVERAGE REVENUE
select avg(unit_price) as average_price
from `workspace`.`default`.`bright_coffee_shop_sales`;


----CHECKING THE DATE RANGE
select min(transaction_date) as start_date
from `workspace`.`default`.`bright_coffee_shop_sales`;


select max(transaction_date) as last_date
from `workspace`.`default`.`bright_coffee_shop_sales`;


select transaction_date,
transaction_time,
dayname(transaction_date) as Day_Name,
monthname(transaction_date) as Month_Name,
case
when cast(transaction_time as string) between '00:00:00' and '11:00:00' then 'morning'
when cast(transaction_time as string) between '11:00:01' and '17:00:00' then 'afternoon'
when cast(transaction_time as string) between '17:00:01' and '20:00:00' then 'evening'
else 'night'
end as time_bucket
from `workspace`.`default`.`bright_coffee_shop_sales`
group by transaction_date, transaction_time, day_name, month_name, time_bucket

---THE BIG CODE

select transaction_qty,store_id,store_location,
--- USE CASE STATEMENT
Dayname(transaction_date) as day_name,
Monthname(transaction_date) as month_name,
CASE
 when dayname(transaction_date) in ('Sun','Sat') then 'weekend' else 'weekday'
 end as day_classification,
 case
 when date_format(transaction_time, 'HH:mm:ss') between '00:00:00' and '11:00:00' then 'morning'
 when date_format(transaction_time, 'HH:mm:ss') between '11:00:01' and '17:00:00' then 'afternoon'
 when date_format(transaction_time, 'HH:mm:ss') between '17:00:01' and '23:00:00' then 'night'
 end as time_classification,
 ---- USE CASE TO SEE DIFFERENT SPENDERS
 case
 when(transaction_qty*unit_price) >=100 then 'low spender'
 when(transaction_qty*unit_price) between 101 and 300 then 'medium spender'
 else 'high spend'
 end as revenue_bucket
 from `workspace`.`default`.`bright_coffee_shop_sales`
