------------------------------- Aamir Mohiuddin ---------------------------------------

-- Select warehouse
USE WAREHOUSE AM_WAREHOUSE;
-- Create Database
CREATE DATABASE Task_db;
-- Choose Db
USE Task_db;

------------------------------- TASK 1 ---------------------------------------
CREATE TABLE shopping_history (
	product     VARCHAR(15) NOT NULL,
	quantity    INT  NOT NULL,
    unit_price  INT NOT NULL
);

INSERT INTO shopping_history
		VALUES('milk', 3, 10),
			    ('bread', 7, 3),
                ('bread', 5, 2);
            
SELECT * FROM shopping_history;

-- Ans. Query:

SELECT product,
	SUM(quantity * unit_price) AS total_price
FROM shopping_history
GROUP BY product;

----------------------------------- TASK 2 --------------------------------------

CREATE TABLE phones (
	name VARCHAR(30) NOT NULL UNIQUE,
    phone_number INT NOT NULL UNIQUE
);

CREATE TABLE calls (
	id INT   NOT NULL,
    caller   INT NOT NULL,
    callee   INT NOT NULL,
    duration INT NOT NULL,
    UNIQUE(id)
);

INSERT INTO phones VALUES
				('Jack', 1234),
                ('Lena', 3333),
                ('Mark', 9999),
                ('Anne', 7582);
                
INSERT INTO calls VALUES
				(25, 1234, 7582, 8),
                (7, 9999, 7582, 1),
                (18, 9999, 3333, 4),
                (2, 7582, 3333, 3),
                (3, 3333, 1234, 1),
                (21, 3333, 1234, 1);   
                
SELECT * FROM PHONES;
SELECT * FROM CALLS;

-- approach/try:

select caller, sum(duration) as dur from calls group by caller;
select callee, sum(duration) as dur from calls group by callee;

select caller, sum(duration) as dur from calls group by caller
union all
select callee, sum(duration) as dur from calls group by callee;

-- result of above query we have to group this, so we will use CTE and then getting the names, we will use JOINS

-- Ans. Query:
WITH
CTE AS
    (
        SELECT CALLER, SUM(DURATION) AS DUR FROM CALLS GROUP BY 1
        UNION ALL
        SELECT CALLEE, SUM(DURATION) FROM CALLS GROUP BY 1
    )
SELECT PHONES.NAME AS NAMES
    FROM CTE INNER JOIN PHONES ON PHONES.PHONE_NUMBER = CTE.CALLER
GROUP BY 1
HAVING SUM(CTE.DUR) >= 10
ORDER BY NAMES;

----------------------------------------- TASK 3 ----------------------------------------------

CREATE TABLE transactions(
	amount INT NOT NULL,
    date DATE NOT NULL
);

INSERT INTO transactions VALUES
	(1000, '2020-01-06'),
    (-10, '2020-01-14'),
    (-75, '2020-01-25'),
    (-5, '2020-01-25'),
    (-4, '2020-01-29'),
    (2000, '2020-03-10'),
    (-75, '2020-03-12'),
    (-20, '2020-03-15'),
    (40, '2020-03-15'),
    (-50, '2020-03-17'),
    (200, '2020-10-10'),
    (-200, '2020-10-10');

SELECT * FROM TRANSACTIONS;

-- approach/try:
select sum(amount) from transactions;
select count(date) from transactions;
select sum(amount), month(date) as Month from transactions group by 2;

select sum(amount), month(date), count(date) as Credit_TXNS from transactions where amount < 0 group by 2; 
-- in above query we have to filter it, where sum(amount) <= -100 and credit_txns >=3
-- so we have
select sum(amount), month(date), count(date) as Credit_TXNS from transactions where amount < 0 
group by 2 
having sum(amount) <= -100 and count(date) >= 3;

-- Ans. Query:

SELECT SUM(amount) - 
(
	WITH
	CRED_CTE AS
    (
		SELECT SUM(amount) as Card_pay, MONTH(date) AS MNTH, COUNT(date) AS NEG_TXNS FROM TRANSACTIONS WHERE amount < 0 group by 2
    )
    SELECT (12 - count(*)) * 5 FROM CRED_CTE WHERE Card_pay <= -100 and NEG_TXNS >= 3

) as balance from TRANSACTIONS;

----------------------------------------------------- THANK YOU --------------------------------------------------------------------


