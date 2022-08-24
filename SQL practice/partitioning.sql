-- create database ineuron_partition
-- use ineuron_partition

-- create table ineuron_course(
-- course_name varchar(50) ,
-- course_id int(10) , 
-- course_title varchar(60),
-- corse_desc varchar(60),
-- launch_date date,
-- course_fee int,
-- course_mentor varchar(60),
-- course_lauch_year int)

-- select * from ineuron_course ;

-- insert into ineuron_course values('machine_learning' , 101 , 'ML', "this is ML course" ,'2019-07-07',3540,'sudhanshu',2019) ,

-- ('aiops' , 101 , 'ML', "this is aiops course" ,'2019-07-07',3540,'sudhanshu',2019) ,
-- ('dlcvnlp' , 101 , 'ML', "this is ML course" ,'2020-07-07',3540,'sudhanshu',2020) ,
-- ('aws cloud' , 101 , 'ML', "this is ML course" ,'2020-07-07',3540,'sudhanshu',2020) ,
-- ('blockchain' , 101 , 'ML', "this is ML course" ,'2021-07-07',3540,'sudhanshu',2021) ,
-- ('RL' , 101 , 'ML', "this is ML course" ,'2022-07-07',3540,'sudhanshu',2022) ,
-- ('Dl' , 101 , 'ML', "this is ML course" ,'2022-07-07',3540,'sudhanshu',2022) ,
-- ('interview prep' , 101 , 'ML', "this is ML course" ,'2019-07-07',3540,'sudhanshu',2019) ,
-- ('big data' , 101 , 'ML', "this is ML course" ,'2020-07-07',3540,'sudhanshu',2020) ,
-- ('data analytics' , 101 , 'ML', "this is ML course" ,'2021-07-07',3540,'sudhanshu',2021) ,
-- ('fsds' , 101 , 'ML', "this is ML course" ,'2022-07-07',3540,'sudhanshu',2022) ,
-- ('fsda' , 101 , 'ML', "this is ML course" ,'2021-07-07',3540,'sudhanshu',2021) ,
-- ('fabe' , 101 , 'ML', "this is ML course" ,'2022-07-07',3540,'sudhanshu',2022) ,
-- ('java' , 101 , 'ML', "this is ML course" ,'2020-07-07',3540,'sudhanshu',2020) ,
-- ('MERN' , 101 , 'ML', "this is ML course" ,'2019-07-07',3540,'sudhanshu',2019) 

-- select * from ineuron_course
-- OUTPUT: 
/*
+------------------+-----------+--------------+----------------------+-------------+------------+---------------+-------------------+
| course_name      | course_id | course_title | corse_desc           | launch_date | course_fee | course_mentor | course_lauch_year |
+------------------+-----------+--------------+----------------------+-------------+------------+---------------+-------------------+
| machine_learning |       101 | ML           | this is ML course    | 2019-07-07  |       3540 | sudhanshu     |              2019 |
| aiops            |       101 | ML           | this is aiops course | 2019-07-07  |       3540 | sudhanshu     |              2019 |
| dlcvnlp          |       101 | ML           | this is ML course    | 2020-07-07  |       3540 | sudhanshu     |              2020 |
| aws cloud        |       101 | ML           | this is ML course    | 2020-07-07  |       3540 | sudhanshu     |              2020 |
| blockchain       |       101 | ML           | this is ML course    | 2021-07-07  |       3540 | sudhanshu     |              2021 |
| RL               |       101 | ML           | this is ML course    | 2022-07-07  |       3540 | sudhanshu     |              2022 |
| Dl               |       101 | ML           | this is ML course    | 2022-07-07  |       3540 | sudhanshu     |              2022 |
| interview prep   |       101 | ML           | this is ML course    | 2019-07-07  |       3540 | sudhanshu     |              2019 |
| big data         |       101 | ML           | this is ML course    | 2020-07-07  |       3540 | sudhanshu     |              2020 |
| data analytics   |       101 | ML           | this is ML course    | 2021-07-07  |       3540 | sudhanshu     |              2021 |
| fsds             |       101 | ML           | this is ML course    | 2022-07-07  |       3540 | sudhanshu     |              2022 |
| fsda             |       101 | ML           | this is ML course    | 2021-07-07  |       3540 | sudhanshu     |              2021 |
| fabe             |       101 | ML           | this is ML course    | 2022-07-07  |       3540 | sudhanshu     |              2022 |
| java             |       101 | ML           | this is ML course    | 2020-07-07  |       3540 | sudhanshu     |              2020 |
| MERN             |       101 | ML           | this is ML course    | 2019-07-07  |       3540 | sudhanshu     |              2019 |
+------------------+-----------+--------------+----------------------+-------------+------------+---------------+-------------------+
*/

-- select * from ineuron_course where course_lauch_year = 2020
/* What above query does is it will check all the rows of a table for given condition and will return the resulting records. So this query will take longer time for large data table.
Now what we can do is we can create new table where in we can store the data year wise, so when we look for data of some particular year, only that chunk or portion of data is examined,
which will optimise our query execution -> for this PARTITIONING COMES INTO PICTURE */

-- TODO: TYPES OF PARTITIONING
-- TODO: "RANGE" PARTITIONING: A table that is partitioned by range is partitioned in such a way that each partition contains rows for which the partitioning expression value lies within a given range.
-- Ranges should be contiguous but not overlapping, and are defined using the VALUES LESS THAN operator.

/* https://dev.mysql.com/doc/mysql-partitioning-excerpt/5.6/en/partitioning-range.html */

-- create table ineuron_courses1(
-- course_name varchar(50),
-- course_id int,
-- course_title varchar(60),
-- course_desc varchar(80),
-- launch_date date,
-- course_fee int,
-- course_mentor varchar(60),
-- course_launch_year int)
-- PARTITION BY RANGE(course_launch_year)(
-- PARTITION p0 VALUES less than (2019),
-- PARTITION p1 VALUES less than (2020),
-- PARTITION p2 VALUES less than (2021),
-- PARTITION p3 VALUES less than (2022),
-- PARTITION p4 VALUES less than(2023));

-- insert into ineuron_courses1 values('machine_learning' , 101 , 'ML', "this is ML course" ,'2019-07-07',3540,'sudhanshu',2019) ,

-- ('aiops' , 101 , 'ML', "this is aiops course" ,'2019-07-07',3540,'sudhanshu',2019) ,
-- ('dlcvnlp' , 101 , 'ML', "this is ML course" ,'2020-07-07',3540,'sudhanshu',2020) ,
-- ('aws cloud' , 101 , 'ML', "this is ML course" ,'2020-07-07',3540,'sudhanshu',2020) ,
-- ('blockchain' , 101 , 'ML', "this is ML course" ,'2021-07-07',3540,'sudhanshu',2021) ,
-- ('RL' , 101 , 'ML', "this is ML course" ,'2022-07-07',3540,'sudhanshu',2022) ,
-- ('Dl' , 101 , 'ML', "this is ML course" ,'2022-07-07',3540,'sudhanshu',2022) ,
-- ('interview prep' , 101 , 'ML', "this is ML course" ,'2019-07-07',3540,'sudhanshu',2019) ,
-- ('big data' , 101 , 'ML', "this is ML course" ,'2020-07-07',3540,'sudhanshu',2020) ,
-- ('data analytics' , 101 , 'ML', "this is ML course" ,'2021-07-07',3540,'sudhanshu',2021) ,
-- ('fsds' , 101 , 'ML', "this is ML course" ,'2022-07-07',3540,'sudhanshu',2022) ,
-- ('fsda' , 101 , 'ML', "this is ML course" ,'2021-07-07',3540,'sudhanshu',2021) ,
-- ('fabe' , 101 , 'ML', "this is ML course" ,'2022-07-07',3540,'sudhanshu',2022) ,
-- ('java' , 101 , 'ML', "this is ML course" ,'2020-07-07',3540,'sudhanshu',2020) ,
-- ('MERN' , 101 , 'ML', "this is ML course" ,'2019-07-07',3540,'sudhanshu',2019) 

-- select * from ineuron_courses1 where course_launch_year = 2020

-- select partition_name, table_name, table_rows from information_schema.partitions where table_name = 'ineuron_courses1'
-- output:
/*
+----------------+------------------+------------+
| PARTITION_NAME | TABLE_NAME       | TABLE_ROWS |
+----------------+------------------+------------+
| p0             | ineuron_courses1 |          0 |
| p1             | ineuron_courses1 |          4 |
| p2             | ineuron_courses1 |          4 |
| p3             | ineuron_courses1 |          3 |
| p4             | ineuron_courses1 |          4 |
+----------------+------------------+------------+
*/

-- TODO: "HASH" Partitioning:
/*
Partitioning by HASH is used primarily to ensure an even distribution of data among a predetermined number of partitions.
With range or list partitioning, you must specify explicitly into which partition a given column value or set of column values is to be stored; with hash partitioning,
MySQL takes care of this for you, and you need only specify a column value or expression based on a column value to be hashed and the number of partitions into
which the partitioned table is to be divided.
To partition a table using HASH partitioning, it is necessary to append to the CREATE TABLE statement a PARTITION BY HASH (expr) clause, where expr is an expression that returns an integer.
This can simply be the name of a column whose type is one of MySQL's integer types. In addition,
you most likely want to follow this with PARTITIONS num, where num is a positive integer representing the number of partitions into which the table is to be divided.
*/

-- create table ineuron_courses2(
-- course_name varchar(50),
-- course_id int(10),
-- course_title varchar(60),
-- course_desc varchar(80),
-- launch_date date,
-- course_fee int,
-- course_mentor varchar(60),
-- course_launch_year int)
-- partition by hash(course_launch_year)
-- partitions 5;

-- select partition_name , table_name , table_rows from information_schema.partitions where table_name = 'ineuron_courses2'

-- create table ineuron_courses3(
-- course_name varchar(50),
-- course_id int(10),
-- course_title varchar(60),
-- course_desc varchar(80),
-- launch_date date,
-- course_fee int,
-- course_mentor varchar(60),
-- course_launch_year int)
-- partition by hash(course_launch_year)
-- partitions 10;

-- select partition_name , table_name , table_rows from information_schema.partitions where table_name = 'ineuron_courses3'


-- insert into ineuron_courses3 values('machine_learning' , 101 , 'ML', "this is ML course" ,'2019-07-07',3540,'sudhanshu',2019) ,

-- ('aiops' , 101 , 'ML', "this is aiops course" ,'2019-07-07',3540,'sudhanshu',2019) ,
-- ('dlcvnlp' , 101 , 'ML', "this is ML course" ,'2020-07-07',3540,'sudhanshu',2020) ,
-- ('aws cloud' , 101 , 'ML', "this is ML course" ,'2020-07-07',3540,'sudhanshu',2020) ,
-- ('blockchain' , 101 , 'ML', "this is ML course" ,'2021-07-07',3540,'sudhanshu',2021) ,
-- ('RL' , 101 , 'ML', "this is ML course" ,'2022-07-07',3540,'sudhanshu',2022) ,
-- ('Dl' , 101 , 'ML', "this is ML course" ,'2022-07-07',3540,'sudhanshu',2022) ,
-- ('interview prep' , 101 , 'ML', "this is ML course" ,'2019-07-07',3540,'sudhanshu',2019) ,
-- ('big data' , 101 , 'ML', "this is ML course" ,'2020-07-07',3540,'sudhanshu',2020) ,
-- ('data analytics' , 101 , 'ML', "this is ML course" ,'2021-07-07',3540,'sudhanshu',2021) ,
-- ('fsds' , 101 , 'ML', "this is ML course" ,'2022-07-07',3540,'sudhanshu',2022) ,
-- ('fsda' , 101 , 'ML', "this is ML course" ,'2021-07-07',3540,'sudhanshu',2021) ,
-- ('fabe' , 101 , 'ML', "this is ML course" ,'2022-07-07',3540,'sudhanshu',2022) ,
-- ('java' , 101 , 'ML', "this is ML course" ,'2020-07-07',3540,'sudhanshu',2020) ,
-- ('MERN' , 101 , 'ML', "this is ML course" ,'2019-07-07',3540,'sudhanshu',2019) 