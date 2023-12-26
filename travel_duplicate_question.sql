--https://www.youtube.com/watch?v=9gHIiuyySws&list=PLdOKnrf8EcP1y_LPEv7uBpzoRmlATjCVr
-- the travel question 
select * from travel

--Method 1
select greatest(source,destination),least(source, destination),max(distance) from travel
group by greatest(source,destination),least(source, destination)



--method 2

-- by using row function 
/* first assign row_number and then do a self join and check the rownumber of the two tables combined*/

select source, destination, distance,
row_number() over( ) as serial_no
from travel

with cte as (
select source, destination, distance,
row_number() over( ) as serial_no
from travel
)

select * from cte t1
join cte t2
on t1.source = t2.destination 
where t1.serial_no < t2.serial_no -- remember this is happening between two tables i.e t1 and t2 which evern serial_no is greater will be 
-- considered 

select * from travel
select *, source > destination as compare from travel

-- method 3 - by uisng the compare and case function
with mycte as (
select source, destination,distance,
case	
	when source > destination then 1
	else 0
end as compare
from travel
)
select source, destination, distance from mycte
where compare = 1