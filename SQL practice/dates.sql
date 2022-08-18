-- TODO: Dealing with DATA datatypes
-- create database date_db;
-- use date_db;

-- TODO: CREATE DUMMY TABLE
-- create table test_table(`Date` varchar(20))
-- Insert into test_table values
--     ('01-07-2022'),
--     ('22-05-2021'),
--     ('15-04-1997'),
--     ('03-04-1996')

-- select * from test_table;

-- till now we have just created a table and inserted some of the dummy dates as varchar. Lets check check can we retrieve some of the information as dates from these values

-- TODO: Let's get year from these values
-- SELECT 'Date', year('date') from test_table;  // We get the values as NULL because we applied date function on varchar. So we have to convert the datatype of this column to date:

-- DESC test_table;

-- TODO: Convert datatype from varchar to date 

-- UPDATE test_table
-- set `Date` = str_to_date(`Date`, '%d-%m-%Y')

-- ALTER TABLE test_table
-- MODIFY column `Date` date

-- select * from test_table;
-- DESC test_table

-- INSERT INTO test_table VALUES('2001-01-01')

-- alter table test_table
-- add column New_Date varchar(20)

-- drop table test_table