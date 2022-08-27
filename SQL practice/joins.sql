create database operation
use operation

create table if not exists course (
course_id int ,
course_name varchar(50),
course_desc varchar(60),
course_tag varchar(50))


create table if not exists student(
student_id int ,
student_name varchar(30),
student_mobile int ,
student_course_enroll varchar(30),
student_course_id int )

insert into course values(101 , 'fsda' , 'full stack data analytics' , 'Analytics'),
(102 , 'fsds' , 'full stack data analytics' , 'Analytics'),
(103 , 'fsds' , 'full stack data science' , 'DS'),
(104 , 'big data' , 'full stack big data' , 'BD'),
(105 , 'mern' , 'web dev' , 'mern'),
(106 , 'blockchain' , 'full stack blockchain' , 'BC'),
(101 , 'java' , 'full stack java' , 'java'),
(102 , 'testing' , 'full testing ' , 'testing '),
(105 , 'cybersecurity' , 'full stack cybersecurity' , 'cybersecurity'),
(109 , 'c' , 'c language' , 'c'),
(108 , 'c++' , 'C++ language' , 'language')

insert into student values(301 , "sudhanshu", 3543453,'yes', 101),
(302 , "sudhanshu", 3543453,'yes', 102),
(301 , "sudhanshu", 3543453,'yes', 105),
(302 , "sudhanshu", 3543453,'yes', 106),
(303 , "sudhanshu", 3543453,'yes', 101),
(304 , "sudhanshu", 3543453,'yes', 103),
(305 , "sudhanshu", 3543453,'yes', 105),
(306 , "sudhanshu", 3543453,'yes', 107),
(306 , "sudhanshu", 3543453,'yes', 103)

select * from course
select * from student

-- JOINS
--TODO: INNER JOIN 

SELECT c.course_id, c.course_name, c.course_desc, 
s.student_id, s.student_name, s.student_course_id
FROM course c 
INNER JOIN student s
ON c.course_id = s.student_course_id

-- TODO: LEFT JOIN
SELECT c.course_id, c.course_name, c.course_desc, 
s.student_id, s.student_name, s.student_course_id
FROM course c 
LEFT JOIN student s
ON c.course_id = s.student_course_id

SELECT c.course_id, c.course_name, c.course_desc, 
s.student_id, s.student_name, s.student_course_id
FROM course c 
LEFT JOIN student s
ON c.course_id = s.student_course_id
WHERE s.student_id IS NULL

--TODO: RIGHT JOIN 
SELECT c.course_id, c.course_name, c.course_desc, 
s.student_id, s.student_name, s.student_course_id
FROM course c 
RIGHT JOIN student s
ON c.course_id = s.student_course_id

SELECT c.course_id, c.course_name, c.course_desc, 
s.student_id, s.student_name, s.student_course_id
FROM course c 
RIGHT JOIN student s
ON c.course_id = s.student_course_id
WHERE c.course_id IS NULL