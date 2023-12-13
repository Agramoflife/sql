/* solving the problem quite student without using common table expression */
/* We will create a partition on exam_id and make a feild called highest_marks and lowest marks 
Then we will compare the score on the student_id in exam table with the highest_marks and lowest marks
we will then write a case command where if a student_id marks is same as highest or lowest marks then we will
label it as loud this will give us those student_id which have score highest or lowest score 
Now we will do a left join of the student_id with student table, this will give null values in place
where the student was not loud i.e did not score highest or lowest*/

select * from exam

-- the window function on exam_id in exam table with agg function as min and max
select *,
min(score) over(partition by exam_id) as lowest_score,
max(score) over(partition by exam_id) as highest_score
from exam

-- running a case function on top of it 

create temporary table tab1 as -- consider this after you have read the below comment only else skip this line

select distinct(student_id),
case
	when score = lowest_score then 'loud'
	when score = highest_score then 'loud'
end as classify
from 
(select *,
min(score) over(partition by exam_id) as lowest_score,
max(score) over(partition by exam_id) as highest_score
from exam) as subquerry
where score = lowest_score or score = highest_score -- this check that if they guy has scored max,min even if once it will be a loud guy

--Now we cannot use nested subquerry so we will have to create a table of abouve and the do a join
select * from tab1

--Now since we have required table we will join this table with the student table and find the quite kid
select * from student
left join tab1
on student.student_id = tab1.student_id
where tab1.student_id is null and student.student_id in (select student_id from exam)
-------------------------------------------------------------------------------------------------------
/* lets write the same code and see how the cte , common table expression creates a reference table and then
with the newly created refrence table and new feilds in the reference table we can run querry on the 
reference table */
/* with myCTE as(
run querry and create a table
)

select * from myCTE
where condition */

-- creating a reference table
with my_first_cte as(
select distinct(student_id),
case
	when score = lowest_score then 'loud'
	when score = highest_score then 'loud'
end as classify
from 
(select *,
min(score) over(partition by exam_id) as lowest_score,
max(score) over(partition by exam_id) as highest_score
from exam) as subquerry
where score = lowest_score or score = highest_score
)
 --running a querry on the created reference table 
select student.student_id,student_name from my_first_cte
right join student
on my_first_cte.student_id = student.student_id
where my_first_cte.student_id is null and student.student_id in (select student_id from exam)