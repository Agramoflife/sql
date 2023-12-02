INSERT INTO job(job_name)
values
('Data Scientist')
RETURNING *

INSERT INTO job(job_name)
VALUES
('Data Analyst')
RETURNING *
SELECT * FROM job

SELECT * from account_job

INSERT INTO account_job(user_id,job_id,hire_date)
VALUES
(1,1,CURRENT_DATE)
RETURNING *

INSERT INTO account_job(user_id,job_id,hire_date)
VALUES 
(10,10,CURRENT_DATE)

SELECT * FROM account_job

select * from account
UPDATE account 
SET last_login = CURRENT_TIMESTAMP
/* update command helps you update values in talbe */
/* u can make the values of two columns same within
the same talbe */
UPDATE account 
SET last_login = created_on
SELECT * FROM account_job

/* You can also make value of 2 columns same which are
in 2 different tables*/
UPDATE account_job
SET hire_date = account.created_on
FROM account 
WHERE account_job.user_id = account.user_id
UPDATE account_job
SET hire_date = account.created_on
FROM account
WHERE account_job.user_id = account.user_id

SELECT * FROM account_job
SELECT * FROM account

/*The returning keyword is used to return the 
changes made on the talbe ( only changes) */
-- you can induvidual call the columns
UPDATE account
SET last_login = CURRENT_TIMESTAMP
RETURNING username,email

-- Delete
INSERT INTO job(job_name)
VALUES
('Product Manager')
RETURNING *
SELECT * FROM job

-- just follow the syntax
-- the and job_id  = 3 is optional
DELETE FROM job 
WHERE job_name = 'Product Manager' AND job_id = 3

/* here is a caveat to the deleting and reinserting
values in the same table */
-- mind the serial of user_id
INSERT INTO job(job_name)
VALUES
('Product Manager')
RETURNING *
SELECT * FROM job
/*the serial no. is not 3 but 4 becasue it still
considers the initial deleted counts */

-- lets try to insert values in job_acocunt table
SELECT * FROM account_job
INSERT INTO account_job(user_id,job_id,hire_date)
VALUES
(10,10,CURRENT_TIMESTAMP)
--Read the error carefully it says
/* ERROR:  insert or update on table "account_job" violates foreign key constraint "account_job_user_id_fkey"
DETAIL:  Key (user_id)=(10) is not present in table "account". */
-- Hence ot enter value in reference talbes you have
-- from top to bottom approach

--ALTER TABLE
SELECT * FROM account
