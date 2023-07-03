-- Creating my database for the first time 
--steps 
-- step1 left click on database 
-- click on the create option 
-- Name the database
-- left click on the newly created database and open query tool
-- enter the below query to create a table in the schema 
-- alternatively you can also create table by going in the scenme 

CREATE TABLE account(
	user_id SERIAL PRIMARY KEY,
	username VARCHAR(50) UNIQUE NOT NULL,
	password VARCHAR(50) NOT NULL,
	email VARCHAR(250) UNIQUE NOT NULL,
	created_on TIMESTAMP NOT NULL,
	last_login TIMESTAMP 
)
SELECT * FROM account -- checking the newly created table 
/*Constrains are basically the rules which can be set on the 
columns that you create  during create table like suppose you 
don't want the user to leave the column blank then you can 
add constrain as not null after column name */

--lets create another table
CREATE TABLE job(
job_id SERIAL PRIMARY KEY,
job_name VARCHAR(200) UNIQUE NOT NULL
)
SELECT * FROM job

-- Now lets add VALUES to the table
-- INSERT
INSERT INTO account(username,password,email,created_on)
VALUES
('Jose','password','jose@gmail.com',CURRENT_TIMESTAMP)
SELECT * FROM account

-- LETS ADD VALUES TO TALBE JOB
INSERT INTO job(job_name)
VALUES
('Data Scientist')
SELECT * FROM job

INSERT INTO job(job_name)
VALUES
('Data Analyst')
SELECT * FROM job

-- lets have a look at account_job
SELECT * FROM account_job
--oh i forgot creating account_job table lets do that asap
CREATE TABLE account_job(
user_id INTEGER REFERENCES account(user_id),
job_id INTEGER REFERENCES job(job_id),	
hire_date TIMESTAMP
)
SELECT * FROM account_job
SELECT * FROM account
SELECT * FROM job
--lets add values to the table account_job
INSERT INTO account_job(user_id,job_id,hire_date)
VALUES
(1,1,CURRENT_TIMESTAMP)
SELECT * FROM account_job
-- okay you must be wondering why is the syntax
-- of account table has reference keyword well 
/* it means that before entering the values in the 
account_job table refer to the referenced table if 
the value exist then only add the value in the acc
ount job here is an example to show that */
-- we know 10 = job_id and 10 = user_id does not
-- lets try adding it and see what happens

INSERT INTO acount_job(user_id,job_id,hire_date)
VALUES 
(10,10,CURRENT_TIMESTAMP)
/* So since we have set references in the account_job 
columns so there will be entry in the account_job table 
only when that value exist in the referenced table here 
referenced table for job_id is job table */

-- UPDATE--
SELECT * FROM account
/* Now in the account table we had created last_login column
we also did not set any constrain so it took null value and 
while inserting we didnot inserted last_login column and its
value so lets update it */
UPDATE account 
SET last_login = created_on
SELECT * FROM account
/* using update and set you can set values in the column 
you can set new values or copy values from different column 
in the same */
/* Update is basically used to update the value in the column 
of the table you can also use it to update multiple columns,
you can also use subquery in the column etc */

-- Lets update columns form different table 
SELECT * FROM account_job

UPDATE account_job
SET hire_date=account.created_on
FROM account 
WHERE account_job.user_id = account.user_id
SELECT * FROM account_job
-- instead of selecting the table again and again afer to make
-- changes you can do returing * this will show the table with
-- change
UPDATE account_job
SET hire_date = account.created_on
FROM account
WHERE account_job.user_id = account.user_id
RETURNING *

/* Lets understand how does the serial works in the table */
SELECT * FROM job

-- lets add the job_name and then delete 
INSERT INTO job(job_name)
VALUES 
('Product Manager')
RETURNING * -- Note this will just show the latest added values
SELECT * FROM job
--lets delete it and re insert and see what effect it has on table
DELETE FROM job
WHERE job_name = 'Product Manager'
RETURNING job_id,job_name

SELECT * FROM job
-- Lets re insert the value and see the serial number 
INSERT INTO job(job_name)
VALUES
('Product Manager')
RETURNING *
/*Note once you insert the values, it gets assigned the job_id
Now if you delete the values the count of the job_id does
not gets deleted it still takes the count from the previous value
only but now you can not get access to the old job_id 
value */
select * from job
SELECT * FROM account
SELECT * FROM account_job -- one can not simply add values in the 
-- account table because of the references we have set the value 
-- the values has to be present in the mentioned column of the 
-- mentioned table

select * from job
-- lets again delete and re insert 
DELETE FROM job 
WHERE job_name = 'Data Analyst' -- Note we used Data Scientist and 
-- it showed some error which I was not able to comprehend now 
-- changed it to Data Analyst

-- lets re insert 
INSERT INTO job(job_name)
values
('Data Analyst')
Returning *

SELECT * FROM job
/* We were not able to delete the Data Scientist as the value is 
being refered to other tables coloumn */ 

/*Next is alter command lets create a new table to grasp
the alter table command */
--alter is used to change the schema of the database,name
--of table etc

CREATE TABLE information(
info_id SERIAL PRIMARY KEY,
title VARCHAR NOT NULL,
person VARCHAR(5) NOT NULL UNIQUE
)

SELECT * FROM information 

ALTER TABLE information
RENAME TO new_info

SELECT * FROM information
SELECT * FROM new_info

ALTER TABLE new_info 
RENAME COLUMN person To people
	
SELECT * FROM new_info

INSERT INTO new_info(title)
VALUES
('Doctor')
/*error as we had set not null constrain we will have to 
take the both columns */

--lets drop not null constrain
ALTER TABLE new_info
ALTER COLUMN people DROP NOT NULL

SELECT * FROM new_info

-- ALTER HELPS US TO RENAME TABLE , RENAME COLUMNS 
-- IT ASLO HELPS US TO DROP CONSTRAIN ON COLUMNS 

INSERT INTO new_info( title)
values
('some title')
RETURNING *
SELECT * FROM new_info 

-- lets drop column using alter
ALTER TABLE new_info
DROP COLUMN people
SELECT * FROM new_info

DROP TABLE new_info
select * FROM 	new_info

DROP TABLE  if exists new_info /* this is to avoid the 
unknow what if you don't knows and have a readable error*/

-- CHECK CONSTRAIN--
/* it basically check the condition before enter the 
values */

CREATE TABLE employees(
emp_id SERIAL PRIMARY KEY NOT NULL,
first_name VARCHAR(50) NOT NULL,
last_name VARCHAR(50) NOT NULL,
birthday DATE CHECK (birthday > '2000-01-01'),
hire_date DATE CHECK (hire_date > birthday),
salary INTEGER CHECK (salary > 0)
)

ALTER TABLE employees
RENAME TO employees_info

select * from employees_info

INSERT INTO employees_info(
first_name,last_name,birthday,hire_date,salary
)
VALUES
('Deepu','Kumar','1999-01-01','2000-04-04',1000)
-- the above values violates the constarin hence entry was 
-- not made

INSERT INTO employees_info(
first_name,last_name,birthday,hire_date,salary)
VALUES
('Deepu','Kumar','2001-11-30','2022-03-07',18000)
RETURNING *

/*SO THE CONSTRAIN CHECK BASICALL WORKS LIKE THE PASSWORD 
WHERE YOUR PASWORDS REQUIRE THE INCLUSION OF CERTAIN 
NUMBER, Types of character */