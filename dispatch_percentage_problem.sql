/* we have to find the percentage of orders shipped before message date , 1 day after message date , 2 day
after message date and more than 2 days after message date */

/* here is our approch there are two table  we will join two table on user_id and then subtract the 
message date and disptach date*/

select * from ot
select * from os

/* there is a small hickup though, in the below table we want only the date part hence we will extract 
the date part*/
select date(actual_dispatch_date) from os

/* In the below table we have a json format we jus want the date part we will extract the date part only */
SELECT 
  (message->>'dispatch_date')::DATE AS message_date
FROM 
  ot;
  
 /* let's first do the join */
 
select os.order_id, (message->>'dispatch_date')::DATE AS message_date,date(actual_dispatch_date) as actual_dispatch_date from os
inner join ot 
on os.order_id = ot.order_id
where os.actual_dispatch_date is not null -- this line makes sure that the non null are only included

/* there are two way to solve the problem one is to create a view of the above join and run a case statement
or use it as a sub querry and then run case function we will go with the latter one for now*/

select 
sum(case when message_date >= actual_dispatch_date  then 1 else 0 end )*100.00/count(*) as ship_before_message_date,
sum(case when message_date +1 = actual_dispatch_date then 1 else 0 end )*100.00/count(*) as a_day_after_message_date,
sum(case when message_date+2 = actual_dispatch_date then 1 else 0 end )*100.00/count(*) as two_day_after_message_date,
sum(case when message_date+2 < actual_dispatch_date then 1 else 0 end )*100.00/count(*) as beyond_two_day_after_message_date
from
(select os.order_id, (message->>'dispatch_date')::DATE AS message_date,date(actual_dispatch_date) as actual_dispatch_date from os
inner join ot 
on os.order_id = ot.order_id
where os.actual_dispatch_date is not null) as subquery /* don't join the null values */