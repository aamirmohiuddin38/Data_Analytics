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

select * from ineuron_course where course_lauch_year = 2020