create table student (
	student_id integer,
	student_name varchar(100)

)

insert into student( student_id,student_name)
values
(1,'Daniel'),
(2,'Jade'),
(3,'Stella'),
(4,'Jonathan'),
(5,'Will')

select * from student

create table exam (
	exam_id integer,
	student_id integer,
	score integer
)

select * from exam

insert into exam(exam_id,student_id,score)
values
(10,1,70),
(10,2,80),
(10,3,90),
(20,1,80),
(30,1,70),
(30,3,80),
(30,4,90),
(40,1,60),
(40,2,70),
(40,4,80)


select * from student

select * from exam


create temporary table Loud as
select distinct(student_id),
case when score = min_score then 'loud'
	when score = max_score then 'loud'
end
from 
(select *,
min(score) over(partition by exam_id) as min_score,
max(score) over(partition by exam_id) as max_score
from exam) as subquery
where min_score = score or max_score = score 

select * from Loud 
inner join student
on Loud.student_id = student.student_id
-- the first where basically tell's join only the null values and the second 
where Loud.case is null -- and Loud.student_id IN (SELECT student_id FROM exam) this line takes caret that the student has appeared in exam
select * from exam