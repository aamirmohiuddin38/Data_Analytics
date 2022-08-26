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


-- TODO: "KEY" PARTITION
/*
Partitioning by key is similar to partitioning by hash, except that where hash partitioning employs a user-defined expression,
the hashing function for key partitioning is supplied by the MySQL server.
*/

-- create table ineuron_courses4(
-- course_name varchar(50),
-- course_id int(10) primary key ,
-- course_title varchar(60),
-- course_desc varchar(80),
-- launch_date date,
-- course_fee int,
-- course_mentor varchar(60),
-- course_launch_year int)
-- partition by key()
-- partitions 10;



-- select partition_name , table_name , table_rows from information_schema.partitions where table_name = 'ineuron_courses4'


-- insert into ineuron_courses4 values('machine_learning' , 101 , 'ML', "this is ML course" ,'2019-07-07',3540,'sudhanshu',2019) ,

-- ('aiops' , 102 , 'ML', "this is aiops course" ,'2019-07-07',3540,'sudhanshu',2019) ,
-- ('dlcvnlp' , 103 , 'ML', "this is ML course" ,'2020-07-07',3540,'sudhanshu',2020) ,
-- ('aws cloud' , 104 , 'ML', "this is ML course" ,'2020-07-07',3540,'sudhanshu',2020) ,
-- ('blockchain' , 105, 'ML', "this is ML course" ,'2021-07-07',3540,'sudhanshu',2021) ,
-- ('RL' , 106 , 'ML', "this is ML course" ,'2022-07-07',3540,'sudhanshu',2022) ,
-- ('Dl' , 107 , 'ML', "this is ML course" ,'2022-07-07',3540,'sudhanshu',2022) ,
-- ('interview prep' , 108 , 'ML', "this is ML course" ,'2019-07-07',3540,'sudhanshu',2019) ,
-- ('big data' , 109 , 'ML', "this is ML course" ,'2020-07-07',3540,'sudhanshu',2020) ,
-- ('data analytics' , 110 , 'ML', "this is ML course" ,'2021-07-07',3540,'sudhanshu',2021) ,
-- ('fsds' , 1011 , 'ML', "this is ML course" ,'2022-07-07',3540,'sudhanshu',2022) ,
-- ('fsda' , 1012 , 'ML', "this is ML course" ,'2021-07-07',3540,'sudhanshu',2021) ,
-- ('fabe' , 1013 , 'ML', "this is ML course" ,'2022-07-07',3540,'sudhanshu',2022) ,
-- ('java' , 1014 , 'ML', "this is ML course" ,'2020-07-07',3540,'sudhanshu',2020) ,
-- ('MERN' , 1015 , 'ML', "this is ML course" ,'2019-07-07',3540,'sudhanshu',2019)

-- select * from ineuron_courses4 

-- SELECT MD5('MERN')

-- TODO: "LIST" Partitioning
/*
List partitioning in MySQL is similar to range partitioning in many ways. As in partitioning by RANGE, each partition must be explicitly defined. 
The chief difference between the two types of partitioning is that, in list partitioning, each partition is defined and selected based on the 
membership of a column value in one of a set of value lists, rather than in one of a set of contiguous ranges of values. 
This is done by using PARTITION BY LIST(expr) where expr is a column value or an expression based on a column value and returning an integer 
value, and then defining each partition by means of a VALUES IN (value_list), where value_list is a comma-separated list of integers.
*/

-- create table ineuron_courses6(
-- course_name varchar(50) ,
-- course_id int(10) ,
-- course_title varchar(60),
-- course_desc varchar(80),
-- launch_date date,
-- course_fee int,
-- course_mentor varchar(60),
-- course_launch_year int)
-- partition by list(course_launch_year)(
-- partition p0 values in(2019,2020),
-- partition p1 values in(2022,2021)
-- )

-- insert into ineuron_courses6 values('machine_learning' , 101 , 'ML', "this is ML course" ,'2019-07-07',3540,'sudhanshu',2019) ,

-- ('aiops' , 102 , 'ML', "this is aiops course" ,'2019-07-07',3540,'sudhanshu',2019) ,
-- ('dlcvnlp' , 103 , 'ML', "this is ML course" ,'2020-07-07',3540,'sudhanshu',2020) ,
-- ('aws cloud' , 104 , 'ML', "this is ML course" ,'2020-07-07',3540,'sudhanshu',2020) ,
-- ('blockchain' , 105, 'ML', "this is ML course" ,'2021-07-07',3540,'sudhanshu',2021) ,
-- ('RL' , 106 , 'ML', "this is ML course" ,'2022-07-07',3540,'sudhanshu',2022) ,
-- ('Dl' , 107 , 'ML', "this is ML course" ,'2022-07-07',3540,'sudhanshu',2022) ,
-- ('interview prep' , 108 , 'ML', "this is ML course" ,'2019-07-07',3540,'sudhanshu',2019) ,
-- ('big data' , 109 , 'ML', "this is ML course" ,'2020-07-07',3540,'sudhanshu',2020) ,
-- ('data analytics' , 110 , 'ML', "this is ML course" ,'2021-07-07',3540,'sudhanshu',2021) ,
-- ('fsds' , 1011 , 'ML', "this is ML course" ,'2022-07-07',3540,'sudhanshu',2022) ,
-- ('fsda' , 1012 , 'ML', "this is ML course" ,'2021-07-07',3540,'sudhanshu',2021) ,
-- ('fabe' , 1013 , 'ML', "this is ML course" ,'2022-07-07',3540,'sudhanshu',2022) ,
-- ('java' , 1014 , 'ML', "this is ML course" ,'2020-07-07',3540,'sudhanshu',2020) ,
-- ('MERN' , 1015 , 'ML', "this is ML course" ,'2019-07-07',3540,'sudhanshu',2019)

-- select partition_name , table_name , table_rows from information_schema.partitions where table_name = 'ineuron_courses6'

-- TODO: ANOTHER EXAMPLE OF LIST PARTITIONING
/*
CREATE TABLE employees (
    id INT NOT NULL,
    fname VARCHAR(30),
    lname VARCHAR(30),
    hired DATE NOT NULL DEFAULT '1970-01-01',
    separated DATE NOT NULL DEFAULT '9999-12-31',
    job_code INT,
    store_id INT
)
PARTITION BY LIST(store_id) (
    PARTITION pNorth VALUES IN (3,5,6,9,17),
    PARTITION pEast VALUES IN (1,2,10,11,19,20),
    PARTITION pWest VALUES IN (4,12,13,14,18),
    PARTITION pCentral VALUES IN (7,8,15,16)
);
This makes it easy to add or drop employee records relating to specific regions to or from the table. For instance, suppose that all stores in 
the West region are sold to another company. In MySQL 5.6, all rows relating to employees working at stores in that region can be deleted 
with the query ALTER TABLE employees TRUNCATE PARTITION pWest, which can be executed much more efficiently than the equivalent DELETE 
statement DELETE FROM employees WHERE store_id IN (4,12,13,14,18);. (Using ALTER TABLE employees DROP PARTITION pWest would also delete 
all of these rows, but would also remove the partition pWest from the definition of the table; you would need to use an ALTER TABLE ... ADD 
PARTITION statement to restore the table's original partitioning scheme.)
*/