-- the moving average quesiton of amber
-- just focus on syntax and do a group nate theat when you are doing a order by choose column which has unique vaues only 


with mycte as(
select order_date,sum(amount) as per_day_net from orders
group by 1 -- represt the very first column after the select keyword in above line similarly sum(amount) is 2 
order by 1 
)

select order_date,per_day_net,
round(avg(per_day_net) over (order by order_date rows between 6 preceding and current row ),2) as running_average
from mycte
offset 6


