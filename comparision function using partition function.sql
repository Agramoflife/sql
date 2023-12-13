-- comparision between department average salary and company average salary

select * from employee
select * from salary

-- joining the table and creating a temporary table
create temporary table tab as 
select a.employee_id,department_id,amount,to_char(pay_date,'YYYY-MM') as month from employee a
inner join salary b
on a.employee_id = b.employee_id
order by to_char(pay_date,'YYYY-MM')

--drop table tab
select * from tab

-- understanding partion function 
select employee_id,month,department_id,amount,
avg(amount) over (partition by department_id,month) as department_average,
avg(amount) over (partition by month) as company_average
from tab
order by month

/*understanding the nested partition i.e first partition as per month and then partition as per departemnt in every
month */
select employee_id,month,department_id,amount,
avg(amount) over (partition by department_id,month) as department_average,
avg(amount) over (partition by month) as company_average
from tab

/* running a case function on top of that table */

select distinct(department_id), month,
Case
	when department_average = company_average then 'same'
	when department_average > company_average then 'higher'
	when department_average < company_average then 'lower'
end
from 
(select employee_id,month,department_id,amount,
avg(amount) over (partition by department_id,month) as department_average,
avg(amount) over (partition by month) as company_average
from tab
order by month) as n
order by month desc