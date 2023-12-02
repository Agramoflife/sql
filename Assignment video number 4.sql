--ASSIGNMENTS IN THE VIDEO NO. 4--
--As per the question we have to create a table 
-- lets create a salry table

CREATE TABLE salary(
id SERIAL,
employee_id INTEGER NOT NULL,
amount INTEGER NOT NULL,
pay_date DATE NOT NULL
)
SELECT * FROM salary

INSERT INTO salary( employee_id,amount,pay_date)
VALUES
('1','9000','2017-03-31'),
('2','6000','2017-03-31'),
('2','10000','2017-03-31'),
('1','7000','2017-02-28'),
('2','6000','2017-02-28'),
('2','8000','2017-02-28')
SELECT * FROM salary

-- LET'S CREATE A EMPLOYEE TABLE

CREATE TABLE employee(
employee_id REFERENCES salary.employee_id,
department_id INTEGER NOT NULL	
)

/* oops we forgot to add employee as primary key let do it using the
alter keyword */
ALTER TABLE salary 
ADD CONSTRAINT pk_employee_id PRIMARY KEY (employee_id)
/* so we can't create that as primary key because in order to create 
a primary key the values in that columns should be unique as is the
property of primary key */

-- So may be the syntax for creating a reference was wrong let's redo

CREATE TABLE employee(
employee_id INTEGER NOT NULL,
department_id INTEGER NOT NULL
)
SELECT * FROM employee

INSERT INTO employee( employee_id,department_id)
VALUES
('1','1'),
('2','2'),
('3','2')
RETURNING *

SELECT * FROM salary
SELECT AVG(amount) FROM salary

SELECT pay_date,department_id,
CASE
WHEN amount > (SELECT AVG(amount) FROM salary) THEN 'Higher'
WHEN amount < (SELECT AVG(amount) FROM salary)THEN 'Lowerer'
WHEN amount = (SELECT AVG(amount) FROM salary) THEN 'Same'
END AS Comparison
FROM salary 
(SELECT salary.pay_date,employee.department_id FROM salary 
INNER JOIN employee 
ON salary.employee_id = employee.employee_id)
