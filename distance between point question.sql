CREATE TABLE point_table_A(
X INTEGER NOT NULL,
Y INTEGER NOT NULL
)

select * from point_table_A

INSERT INTO point_table_A(x,y)
VALUES
('-1','-1'),
('0','0'),
('-1','-2')
RETURNING *

CREATE VIEW cartesian as
SELECT taba.x as tax,taba.y as tay,tabb.x as tbx,tabb.y as tby FROM point_table_A as taba
INNER JOIN point_table_A as tabb
ON taba.x != tabb.x or taba.y != tabb.y

--SELECT * FROM point_table_A
SELECT x,y,sqrt(y*y-x*x) as differnece FROM point_table_A

SELECT min(difference) FROM cartesian
WHERE difference 
(SELECT tax,tbx, tbx,tby,sqrt(power((tax-tbx),2) + power((tay-tby),2)) as difference FROM cartesian)

(SELECT min(sqrt(power((tax-tbx),2) + power((tay-tby),2))) as difference FROM cartesian)

-- The problem with this is it take 1,3 | 2,5 and 2,5 | 1,3 which is use less
-- lets use some other logic 
SELECT * FROM point_table_A 

SELECT p1.x,p1.y,p2.x,p2.y,sqrt(power((p1.x-p2.x),2)+power((p1.y-p2.y),2)) as distance FROM point_table_A as p1
INNER JOIN point_table_A as p2
ON p1.x != p2.x or p1.y != p2.y -- and gives the worng answer
ORDER BY distance asc
limit 2
 
SELECT tax,tay,tbx,tby,sqrt(power((tax-tbx),2)+power((tay-tby),2)) FROM cartesian