--customer retention using sql---

select * from q1

--this querry is a naive one I just used a subquery to extract day 
-- and then used case to group the day into weeks assuming that the
-- week starts from day 1 ie monday is date 1
select  id,user_id,total,created,day_part,
case 
when day_part between 1 and 7 then 1
when day_part between 8 and 14 then 2
when day_part between 15 and 21 then 3
when day_part between 22 and 28 then 4
end
from 
(SELECT id,user_id,total,created,EXTRACT(DAY FROM q1.created::date) AS day_part
FROM q1) as subquery
----------------------let's do the more logical one 


select user_id, min(date_part('week',created)) as first_week from q1
group by user_id
order by user_id

/* group by is like we have say user 1 we have mulitple records of user1 
we take the min of multiple records of user 1 that is what is done above */

select * from q1
/* let's make a table w0 for first week of every user i.e the date
is 23 of april 2023 and I go for the first time on 23 april then
that will be my first week*/

create temporary table w0 as
select user_id, min(date_part('week',created)) as first_week from q1
group by user_id
order by user_id

select * from w0

/* Now we will create all the weeks the customer came to our store*/

create temporary table all_weeks as
select user_id,date_part('week',created) as login_week from q1
group by user_id,login_week
order by user_id,login_week

select * from all_weeks

/* now we will create a table which will have first week of the user that came to 
store , and relative to the first week what week it came next time in our store */
/* the login_wekk will have all the weeks he visted store this is non relative , the 
first week will be the week he came for firt time and week number will be the relative 
weeks with respect to the first vist of the customer at store*/

create temporary table week_diff as
select user_id,login_week, first_week, (login_week - first_week) as week_number from 
(select w0.user_id,first_week,login_week from w0
join all_weeks 
on w0.user_id = all_weeks.user_id) as subquery

select * from week_diff

select count(distinct(login_week)) from week_diff --this will form the all weeks in year

/* let's under stand the below querry, give me the customer who came in the first week of
of the year and their first visit is also the 1 week of year*/
select count(*) from week_diff
where week_number = 0 and login_week = 1

select count(*) from week_diff
where week_number = 0 and login_week = 2 -- has a first week as 1 and came again on week 2 i.e same customer

select count(*) from week_diff
where week_number = 0 and login_week = 3 -- has a first week as 1 and came again on 2 week i.e same customer can in second week 

select * from week_diff

select *, 
case 
when week_number = 0 and login_week = 1 then 1
end
from week_diff
order by login_week

select count(user_id) from week_diff
where week_number = 0 and login_week =2
group by login_week


/* This is the actual query*/
select first_week from week_diff

create view ans_table as
select first_week ,
	sum(case when week_number = 0 then 1 else 0 end) as week_0,
	sum(case when week_number = 1 then 1 else 0 end) as week_1,
	sum(case when week_number = 2 then 1 else 0 end) as week_2,
	sum(case when week_number = 3 then 1 else 0 end) as week_3,
	sum(case when week_number = 4 then 1 else 0 end) as week_4,
	sum(case when week_number = 5 then 1 else 0 end) as week_5,
	sum(case when week_number = 6 then 1 else 0 end) as week_6,
	sum(case when week_number = 7 then 1 else 0 end) as week_7,
	sum(case when week_number = 0 then 1 else 0 end) as week_8,
	sum(case when week_number = 0 then 1 else 0 end) as week_9,
	sum(case when week_number = 0 then 1 else 0 end) as week_10

from week_diff
group by first_week
order by first_week

select * from ans_table
select * from week_diff

/* let's understand the intracacies of the querry */
/* simple I want peole who visted in the first week on january and that was the first time the visited my 
store hence that week_number will be 0 and login_will will be 1*/

select count(*) from week_diff
where first_week = 1 and login_week = 1 and week_number = 0

/*I want those customer who came first time on 1st week on january and they came again in the second week
which means the week_number will be 1, and since they are visiting again in second week the last login
will be 2 week that login_week = 2 */

select count(*) from week_diff
where first_week = 1 and login_week = 2 and week_number = 1

/* I want those customer which came on the 1st week on january for the first time and then they visite me on 3rd
week of January that is last login will be 3 and week_number should be 2 and first_week will be 1 */

select count(*) from week_diff
where login_week = 3 and first_week = 1 and week_number = 2

/* I want those customer that came on the 1st week on january and the the again visited me on 4th week on january 
this means our last login/login_week will be 4 or week_number will be 3 and our first_week will be 1*/
select count(*) from week_diff
where login_week = 4 and week_number = 3 and first_week = 1

/* So this is what is happening in the ans_table as well */
select * from week_diff

select login_week, count() from week_diff

select * from week_diff
order by first_week,week_number -- this is the querry which is done for all weeks in year, how - by group bying 


/* Try imagining this as a groupby first we will have a group by table as per the first week 
corresponding to these we will have week_number and user_id ,count the week number of the different users */

select first_week, -- this is takeing caring of login week as well 
	sum(case when week_number = 0 then 1 else 0 end) as week_0,
	sum(case when week_number = 1 then 1 else 0 end) as week_1,
	sum(case when week_number = 2 then 1 else 0 end) as week_2,
	sum(case when week_number = 3 then 1 else 0 end) as week_3
from week_diff
group by first_week -- group by has a more emphasis here 
order by first_week

select * from q1