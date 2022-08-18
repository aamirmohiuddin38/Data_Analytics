-- TODO: Dealing with DATA datatypes
-- create database date_db;
-- use date_db;

-- TODO: CREATE DUMMY TABLE
-- create table test_table(Date_New varchar(20))
-- Insert into test_table values
--     ('2021-Aug-02'),
--     ('2021-Jul-03'),
--     ('2021-Jun-04'),
--     ('2021-Apr-05')

-- select * from test_table;

-- till now we have just created a table and inserted some of the dummy dates as varchar. Lets check check can we retrieve some of the information as dates from these values

-- TODO: Let's get year from these values
-- SELECT Date_new, year('Date_New') from test_table; 
--  // We get the values as NULL because we applied date function on varchar. So we have to convert the datatype of this column to date:

-- DESC test_table;

-- TODO: Convert datatype from varchar to date 

-- UPDATE test_table
-- set Date_New = str_to_date(Date_New, '%Y-%b-%d')

-- ALTER TABLE test_table
-- MODIFY column Date_New date

-- select Date_New,Date_Format(Date_New, '%d/%b/%Y') from test_table;
-- DESC test_table

-- INSERT INTO test_table VALUES('2001-01-01')

-- alter table test_table
-- add column New_Date varchar(20)

-- drop table test_table