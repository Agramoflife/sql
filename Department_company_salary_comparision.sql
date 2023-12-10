--question solution company average and department average comparision month on month--
/* There are two departments you will have to take the average of department salary and compare it to the company
average salary, month on month */

Select * from salary

update salary 
set employee_id = 3 
where id = 3

select *  from salary 
order by id

update salary 
set employee_id = 3
where id = 6

select * from salary
select * from employee

select to_char(pay_date,'YYYY-MM') as months,avg(amount) as company_average_salary from salary
group by months -- this query gives you the company average 

/* This gives you the department average month on month I have just join the 2 tables and applied group by, just make
sure you follow the correct syntax and you are good to go */
select department_id,to_char(pay_date,'YYYY-MM') as months,avg(amount) as department_average_salary from salary a 
inner join employee b
on a.employee_id = b.employee_id
group by department_id,months
order by months 

/* To make things easy I have just joined the above table and then created a tempory table */
create temporary table table1 as
(select x.months,y.department_id,x.company_average_salary,y.department_average_salary from
(select to_char(pay_date,'YYYY-MM') as months,avg(amount) as company_average_salary from salary
group by months) x
inner join 
(select department_id,to_char(pay_date,'YYYY-MM') as months,avg(amount) as department_average_salary from salary a 
inner join employee b
on a.employee_id = b.employee_id
group by department_id,months
order by months) y

on x.months = y.months)

select * from table1
/* Now just run a simple case statement by comparing the columns together*/
select months,department_id,
case
	when company_average_salary = department_average_salary then 'same'
	when company_average_salary < department_average_salary then 'higher'
	when company_average_salary > department_average_salary then 'lower'
end
from table1
order by months desc

select * from table1
