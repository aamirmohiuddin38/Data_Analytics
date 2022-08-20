-- TODO: TABLE: ineuron_students;
-- select * from ineuron_students;
/*
+------------+---------------+--------------+----------------+----------------+-------------------+
| student_id | student_batch | student_name | student_stream | students_marks | student_mail_id   |
+------------+---------------+--------------+----------------+----------------+-------------------+
|        100 | fsda          | saurabh      | cs             |             80 | saurabh@gmail.com |
|        102 | fsda          | sanket       | cs             |             81 | sanket@gmail.com  |
|        103 | fsda          | shyam        | cs             |             80 | shyam@gmail.com   |
|        104 | fsda          | sanket       | cs             |             82 | sanket@gmail.com  |
|        105 | fsda          | shyam        | ME             |             67 | shyam@gmail.com   |
|        106 | fsds          | ajay         | ME             |             45 | ajay@gmail.com    |
|        106 | fsds          | ajay         | ME             |             78 | ajay@gmail.com    |
|        108 | fsds          | snehal       | CI             |             89 | snehal@gmail.com  |
|        109 | fsds          | manisha      | CI             |             34 | manisha@gmail.com |
|        110 | fsds          | rakesh       | CI             |             45 | rakesh@gmail.com  |
|        111 | fsde          | anuj         | CI             |             43 | anuj@gmail.com    |
|        112 | fsde          | mohit        | EE             |             67 | mohit@gmail.com   |
|        113 | fsde          | vivek        | EE             |             23 | vivek@gmail.com   |
|        114 | fsde          | gaurav       | EE             |             45 | gaurav@gmail.com  |
|        115 | fsde          | prateek      | EE             |             89 | prateek@gmail.com |
|        116 | fsde          | mithun       | ECE            |             23 | mithun@gmail.com  |
|        117 | fsbc          | chaitra      | ECE            |             23 | chaitra@gmail.com |
|        118 | fsbc          | pranay       | ECE            |             45 | pranay@gmail.com  |
|        119 | fsbc          | sandeep      | ECE            |             65 | sandeep@gmail.com |
|        119 | fsbc          | saurabh      | ECE            |             65 | saurabh@gmail.com !
+------------+---------------+--------------+----------------+----------------+-------------------+
*/

-- ANALYTICAL based WINDOW FUNCTIONS

-- TODO:1. ROW_NUMBER()

-- select student_batch, student_name, student_stream, students_marks,
-- row_number() over (order by students_marks) as "RowNum" from ineuron_students; 

-- OUTPUT:
/* 
+---------------+--------------+----------------+----------------+--------+
| student_batch | student_name | student_stream | students_marks | RowNum |
+---------------+--------------+----------------+----------------+--------+
| fsde          | vivek        | EE             |             23 |      1 |
| fsde          | mithun       | ECE            |             23 |      2 |
| fsbc          | chaitra      | ECE            |             23 |      3 |
| fsds          | manisha      | CI             |             34 |      4 |
| fsde          | anuj         | CI             |             43 |      5 |
| fsds          | ajay         | ME             |             45 |      6 |
| fsds          | rakesh       | CI             |             45 |      7 |
| fsde          | gaurav       | EE             |             45 |      8 |
| fsbc          | pranay       | ECE            |             45 |      9 |
| fsbc          | sandeep      | ECE            |             65 |     10 |
| fsbc          | saurabh      | ECE            |             65 |     11 |
| fsda          | shyam        | ME             |             67 |     12 |
| fsde          | mohit        | EE             |             67 |     13 |
| fsds          | ajay         | ME             |             78 |     14 |
| fsda          | saurabh      | cs             |             80 |     15 |
| fsda          | shyam        | cs             |             80 |     16 |
| fsda          | sanket       | cs             |             81 |     17 |
| fsda          | sanket       | cs             |             82 |     18 |
| fsds          | snehal       | CI             |             89 |     19 |
| fsde          | prateek      | EE             |             89 |     20 |
+---------------+--------------+----------------+----------------+--------+
*/

-- select student_batch, student_name, student_stream, students_marks,
-- row_number() over (partition by student_batch order by students_marks) as "RowNum"
-- from ineuron_students; 

-- OUTPUT:
/*
+---------------+--------------+----------------+----------------+--------+
| student_batch | student_name | student_stream | students_marks | RowNum |
+---------------+--------------+----------------+----------------+--------+
| fsbc          | chaitra      | ECE            |             23 |      1 |
| fsbc          | pranay       | ECE            |             45 |      2 |
| fsda          | shyam        | cs             |             80 |      3 |
| fsda          | sanket       | cs             |             81 |      4 |
| fsda          | sanket       | cs             |             82 |      5 |
| fsde          | vivek        | EE             |             23 |      1 |
| fsde          | mithun       | ECE            |             23 |      2 |
| fsde          | anuj         | CI             |             43 |      3 |
| fsde          | gaurav       | EE             |             45 |      4 |
| fsde          | mohit        | EE             |             67 |      5 |
| fsde          | prateek      | EE             |             89 |      6 |
| fsds          | manisha      | CI             |             34 |      1 |
| fsds          | ajay         | ME             |             45 |      2 |
| fsds          | rakesh       | CI             |             45 |      3 |
| fsds          | ajay         | ME             |             78 |      4 |
| fsds          | snehal       | CI             |             89 |      5 |
+---------------+--------------+----------------+----------------+--------+
*/

-- TODO: get the toppers of each batch
-- SELECT * FROM (
--     SELECT student_batch, student_name, student_stream, students_marks,
--     ROW_NUMBER() OVER (PARTITION BY student_batch ORDER BY students_marks DESC) as "Rownum"
--     FROM ineuron_students
-- ) AS testData WHERE Rownum = 1;

-- output:
/*
+---------------+--------------+----------------+----------------+--------+
| student_batch | student_name | student_stream | students_marks | Rownum |
+---------------+--------------+----------------+----------------+--------+
| fsbc          | sandeep      | ECE            |             65 |      1 |
| fsda          | sanket       | cs             |             82 |      1 |
| fsde          | prateek      | EE             |             89 |      1 |
| fsds          | snehal       | CI             |             89 |      1 |
+---------------+--------------+----------------+----------------+--------+
but this query has problem if there two students with same marks as in fsbc batch we have two toppers with 65, it will always get only one */

-- TODO: RANK()
-- so here will give same rank to the same values.

-- select student_batch, student_name, student_stream, students_marks,
-- row_number() over (order by students_marks desc) as "RowNum" ,
-- rank() over (order by students_marks desc) as "Rnk"
-- from ineuron_students; 

-- Output:
/*
+---------------+--------------+----------------+----------------+--------+-----+
| student_batch | student_name | student_stream | students_marks | RowNum | Rnk |
+---------------+--------------+----------------+----------------+--------+-----+
| fsds          | snehal       | CI             |             89 |      1 |   1 |
| fsde          | prateek      | EE             |             89 |      2 |   1 |
| fsda          | sanket       | cs             |             82 |      3 |   3 |
| fsda          | sanket       | cs             |             81 |      4 |   4 |
| fsda          | saurabh      | cs             |             80 |      5 |   5 |
| fsda          | shyam        | cs             |             80 |      6 |   5 |
| fsds          | ajay         | ME             |             78 |      7 |   7 |
| fsda          | shyam        | ME             |             67 |      8 |   8 |
| fsde          | mohit        | EE             |             67 |      9 |   8 |
| fsbc          | sandeep      | ECE            |             65 |     10 |  10 |
| fsbc          | saurabh      | ECE            |             65 |     11 |  10 |
| fsds          | ajay         | ME             |             45 |     12 |  12 |
| fsds          | rakesh       | CI             |             45 |     13 |  12 |
| fsde          | gaurav       | EE             |             45 |     14 |  12 |
| fsbc          | pranay       | ECE            |             45 |     15 |  12 |
| fsde          | anuj         | CI             |             43 |     16 |  16 |
| fsds          | manisha      | CI             |             34 |     17 |  17 |
| fsde          | vivek        | EE             |             23 |     18 |  18 |
| fsde          | mithun       | ECE            |             23 |     19 |  18 |
| fsbc          | chaitra      | ECE            |             23 |     20 |  18 |
+---------------+--------------+----------------+----------------+--------+-----+
*/

-- select student_batch, student_name, student_stream, students_marks,
-- row_number() over (partition by student_batch order by students_marks desc) as "RowNum" ,
-- rank() over (partition by student_batch order by students_marks desc) as "Rnk"
-- from ineuron_students;

-- Output:
/*
+---------------+--------------+----------------+----------------+--------+-----+
| student_batch | student_name | student_stream | students_marks | RowNum | Rnk |
+---------------+--------------+----------------+----------------+--------+-----+
| fsbc          | sandeep      | ECE            |             65 |      1 |   1 |
| fsbc          | saurabh      | ECE            |             65 |      2 |   1 |
| fsbc          | pranay       | ECE            |             45 |      3 |   3 |
| fsbc          | chaitra      | ECE            |             23 |      4 |   4 |
| fsda          | sanket       | cs             |             82 |      1 |   1 |
| fsda          | sanket       | cs             |             81 |      2 |   2 |
| fsda          | saurabh      | cs             |             80 |      3 |   3 |
| fsda          | shyam        | cs             |             80 |      4 |   3 |
| fsda          | shyam        | ME             |             67 |      5 |   5 |
| fsde          | prateek      | EE             |             89 |      1 |   1 |
| fsde          | mohit        | EE             |             67 |      2 |   2 |
| fsde          | gaurav       | EE             |             45 |      3 |   3 |
| fsde          | anuj         | CI             |             43 |      4 |   4 |
| fsde          | vivek        | EE             |             23 |      5 |   5 |
| fsde          | mithun       | ECE            |             23 |      6 |   5 |
| fsds          | snehal       | CI             |             89 |      1 |   1 |
| fsds          | ajay         | ME             |             78 |      2 |   2 |
| fsds          | ajay         | ME             |             45 |      3 |   3 |
| fsds          | rakesh       | CI             |             45 |      4 |   3 |
| fsds          | manisha      | CI             |             34 |      5 |   5 |
+---------------+--------------+----------------+----------------+--------+-----+
*/

-- SELECT * FROM (
--     select student_batch, student_name, student_stream, students_marks,
--     ROW_NUMBER() over (PARTITION BY student_batch order by students_marks DESC) as "RowNum" ,
--     RANK() over (PARTITION BY student_batch order by students_marks DESC) as "Rnk"
-- from ineuron_students)AS testData where Rnk = 1;

-- OUTPUT:
/*
+---------------+--------------+----------------+----------------+--------+-----+
| student_batch | student_name | student_stream | students_marks | RowNum | Rnk |
+---------------+--------------+----------------+----------------+--------+-----+
| fsbc          | sandeep      | ECE            |             65 |      1 |   1 |
| fsbc          | saurabh      | ECE            |             65 |      2 |   1 |
| fsda          | sanket       | cs             |             82 |      1 |   1 |
| fsde          | prateek      | EE             |             89 |      1 |   1 |
| fsds          | snehal       | CI             |             89 |      1 |   1 |
+---------------+--------------+----------------+----------------+--------+-----+
*/

-- ok we got what we wanted to, but again there is a problem, when same rank is given, the next rank value is assigned to any other (2 in our case)

-- TODO: DENSE_RANK():

-- SELECT student_batch, student_name, student_stream, students_marks,
-- ROW_NUMBER() OVER (ORDER BY students_marks) AS "RowNum",
-- RANK() OVER (ORDER BY students_marks) AS "Rnk",
-- DENSE_RANK() OVER (ORDER BY students_marks) AS "DenseRnk"
-- FROM ineuron_students;

-- Output:
/*
+---------------+--------------+----------------+----------------+--------+-----+----------+
| student_batch | student_name | student_stream | students_marks | RowNum | Rnk | DenseRnk |
+---------------+--------------+----------------+----------------+--------+-----+----------+
| fsde          | vivek        | EE             |             23 |      1 |   1 |        1 |
| fsde          | mithun       | ECE            |             23 |      2 |   1 |        1 |
| fsbc          | chaitra      | ECE            |             23 |      3 |   1 |        1 |
| fsds          | manisha      | CI             |             34 |      4 |   4 |        2 |
| fsde          | anuj         | CI             |             43 |      5 |   5 |        3 |
| fsds          | ajay         | ME             |             45 |      6 |   6 |        4 |
| fsds          | rakesh       | CI             |             45 |      7 |   6 |        4 |
| fsde          | gaurav       | EE             |             45 |      8 |   6 |        4 |
| fsbc          | pranay       | ECE            |             45 |      9 |   6 |        4 |
| fsbc          | sandeep      | ECE            |             65 |     10 |  10 |        5 |
| fsbc          | saurabh      | ECE            |             65 |     11 |  10 |        5 |
| fsda          | shyam        | ME             |             67 |     12 |  12 |        6 |
| fsde          | mohit        | EE             |             67 |     13 |  12 |        6 |
| fsds          | ajay         | ME             |             78 |     14 |  14 |        7 |
| fsda          | saurabh      | cs             |             80 |     15 |  15 |        8 |
| fsda          | shyam        | cs             |             80 |     16 |  15 |        8 |
| fsda          | sanket       | cs             |             81 |     17 |  17 |        9 |
| fsda          | sanket       | cs             |             82 |     18 |  18 |       10 |
| fsds          | snehal       | CI             |             89 |     19 |  19 |       11 |
| fsde          | prateek      | EE             |             89 |     20 |  19 |       11 |
+---------------+--------------+----------------+----------------+--------+-----+----------+
*/

-- SELECT student_batch, student_name, student_stream, students_marks,
-- ROW_NUMBER() OVER (PARTITION BY student_batch ORDER BY students_marks DESC) AS "RowNum",
-- RANK() OVER (PARTITION BY student_batch ORDER BY students_marks DESC) AS "Rnk",
-- DENSE_RANK() OVER (PARTITION BY student_batch ORDER BY students_marks DESC) AS "DenseRnk"
-- FROM ineuron_students;

-- Output:
/*
+---------------+--------------+----------------+----------------+--------+-----+----------+
| student_batch | student_name | student_stream | students_marks | RowNum | Rnk | DenseRnk |
+---------------+--------------+----------------+----------------+--------+-----+----------+
| fsbc          | sandeep      | ECE            |             65 |      1 |   1 |        1 |
| fsbc          | saurabh      | ECE            |             65 |      2 |   1 |        1 |
| fsbc          | pranay       | ECE            |             45 |      3 |   3 |        2 |
| fsbc          | chaitra      | ECE            |             23 |      4 |   4 |        3 |
| fsda          | sanket       | cs             |             82 |      1 |   1 |        1 |
| fsda          | sanket       | cs             |             81 |      2 |   2 |        2 |
| fsda          | saurabh      | cs             |             80 |      3 |   3 |        3 |
| fsda          | shyam        | cs             |             80 |      4 |   3 |        3 |
| fsda          | shyam        | ME             |             67 |      5 |   5 |        4 |
| fsde          | prateek      | EE             |             89 |      1 |   1 |        1 |
| fsde          | mohit        | EE             |             67 |      2 |   2 |        2 |
| fsde          | gaurav       | EE             |             45 |      3 |   3 |        3 |
| fsde          | anuj         | CI             |             43 |      4 |   4 |        4 |
| fsde          | vivek        | EE             |             23 |      5 |   5 |        5 |
| fsde          | mithun       | ECE            |             23 |      6 |   5 |        5 |
| fsds          | snehal       | CI             |             89 |      1 |   1 |        1 |
| fsds          | ajay         | ME             |             78 |      2 |   2 |        2 |
| fsds          | ajay         | ME             |             45 |      3 |   3 |        3 |
| fsds          | rakesh       | CI             |             45 |      4 |   3 |        3 |
| fsds          | manisha      | CI             |             34 |      5 |   5 |        4 |
+---------------+--------------+----------------+----------------+--------+-----+----------+
*/

-- TODO: Get the toppers of each batch (back to our question)
-- SELECT * FROM (
--     SELECT student_batch, student_name, student_stream, students_marks,
--     ROW_NUMBER() OVER (PARTITION BY student_batch ORDER BY students_marks DESC) AS "RowNum",
--     RANK() OVER (PARTITION BY student_batch ORDER BY students_marks DESC) AS "Rnk",
--     DENSE_RANK() OVER (PARTITION BY student_batch ORDER BY students_marks DESC) AS "DenseRnk"
--     FROM ineuron_students
-- ) AS testData where DenseRnk = 1;

-- Output:
/*
+---------------+--------------+----------------+----------------+--------+-----+----------+
| student_batch | student_name | student_stream | students_marks | RowNum | Rnk | DenseRnk |
+---------------+--------------+----------------+----------------+--------+-----+----------+
| fsbc          | sandeep      | ECE            |             65 |      1 |   1 |        1 |
| fsbc          | saurabh      | ECE            |             65 |      2 |   1 |        1 |
| fsda          | sanket       | cs             |             82 |      1 |   1 |        1 |
| fsde          | prateek      | EE             |             89 |      1 |   1 |        1 |
| fsds          | snehal       | CI             |             89 |      1 |   1 |        1 |
+---------------+--------------+----------------+----------------+--------+-----+----------+
*/

-- TODO: OTHER WINDOW FUNCTIONS:
-- TODO: NTILE(n): it distributes the total no. of rows of table into specifed no. of groups n.

-- SELECT student_id, student_name, students_marks,
-- NTILE(1) OVER() as "SingleGroup"
-- from ineuron_students;

-- OUTPUT:
/*
+------------+--------------+----------------+-------------+
| student_id | student_name | students_marks | SingleGroup |
+------------+--------------+----------------+-------------+
|        100 | saurabh      |             80 |           1 |
|        102 | sanket       |             81 |           1 |
|        103 | shyam        |             80 |           1 |
|        104 | sanket       |             82 |           1 |
|        105 | shyam        |             67 |           1 |
|        106 | ajay         |             45 |           1 |
|        106 | ajay         |             78 |           1 |
|        108 | snehal       |             89 |           1 |
|        109 | manisha      |             34 |           1 |
|        110 | rakesh       |             45 |           1 |
|        111 | anuj         |             43 |           1 |
|        112 | mohit        |             67 |           1 |
|        113 | vivek        |             23 |           1 |
|        114 | gaurav       |             45 |           1 |
|        115 | prateek      |             89 |           1 |
|        116 | mithun       |             23 |           1 |
|        117 | chaitra      |             23 |           1 |
|        118 | pranay       |             45 |           1 |
|        119 | sandeep      |             65 |           1 |
|        119 | saurabh      |             65 |           1 |
+------------+--------------+----------------+-------------+
*/

-- SELECT student_id, student_name, students_marks,
-- NTILE(2) OVER() as "TwoGroups"
-- from ineuron_students;

-- OUTPUT:
/*
+------------+--------------+----------------+-----------+
| student_id | student_name | students_marks | TwoGroups |
+------------+--------------+----------------+-----------+
|        100 | saurabh      |             80 |         1 |
|        102 | sanket       |             81 |         1 |
|        103 | shyam        |             80 |         1 |
|        104 | sanket       |             82 |         1 |
|        105 | shyam        |             67 |         1 |
|        106 | ajay         |             45 |         1 |
|        106 | ajay         |             78 |         1 |
|        108 | snehal       |             89 |         1 |
|        109 | manisha      |             34 |         1 |
|        110 | rakesh       |             45 |         1 |
|        111 | anuj         |             43 |         2 |
|        112 | mohit        |             67 |         2 |
|        113 | vivek        |             23 |         2 |
|        114 | gaurav       |             45 |         2 |
|        115 | prateek      |             89 |         2 |
|        116 | mithun       |             23 |         2 |
|        117 | chaitra      |             23 |         2 |
|        118 | pranay       |             45 |         2 |
|        119 | sandeep      |             65 |         2 |
|        119 | saurabh      |             65 |         2 |
+------------+--------------+----------------+-----------+
*/

-- TODO: LAG() and LEAD()
-- The LAG function has the ability to fetch the data from the previous row, while LEAD fetches from the subsequent row.

-- SELECT * , LAG(students_marks) OVER(order by students_marks desc) as "Prev Marks" FROM ineuron_students;

-- output:
/*
+------------+---------------+--------------+----------------+----------------+-------------------+------------+
| student_id | student_batch | student_name | student_stream | students_marks | student_mail_id   | Prev Marks |
+------------+---------------+--------------+----------------+----------------+-------------------+------------+
|        108 | fsds          | snehal       | CI             |             89 | snehal@gmail.com  |       NULL |
|        115 | fsde          | prateek      | EE             |             89 | prateek@gmail.com |         89 |
|        104 | fsda          | sanket       | cs             |             82 | sanket@gmail.com  |         89 |
|        102 | fsda          | sanket       | cs             |             81 | sanket@gmail.com  |         82 |
|        100 | fsda          | saurabh      | cs             |             80 | saurabh@gmail.com |         81 |
|        103 | fsda          | shyam        | cs             |             80 | shyam@gmail.com   |         80 |
|        106 | fsds          | ajay         | ME             |             78 | ajay@gmail.com    |         80 |
|        105 | fsda          | shyam        | ME             |             67 | shyam@gmail.com   |         78 |
|        112 | fsde          | mohit        | EE             |             67 | mohit@gmail.com   |         67 |
|        119 | fsbc          | sandeep      | ECE            |             65 | sandeep@gmail.com |         67 |
|        119 | fsbc          | saurabh      | ECE            |             65 | saurabh@gmail.com |         65 |
|        106 | fsds          | ajay         | ME             |             45 | ajay@gmail.com    |         65 |
|        110 | fsds          | rakesh       | CI             |             45 | rakesh@gmail.com  |         45 |
|        114 | fsde          | gaurav       | EE             |             45 | gaurav@gmail.com  |         45 |
|        118 | fsbc          | pranay       | ECE            |             45 | pranay@gmail.com  |         45 |
|        111 | fsde          | anuj         | CI             |             43 | anuj@gmail.com    |         45 |
|        109 | fsds          | manisha      | CI             |             34 | manisha@gmail.com |         43 |
|        113 | fsde          | vivek        | EE             |             23 | vivek@gmail.com   |         34 |
|        116 | fsde          | mithun       | ECE            |             23 | mithun@gmail.com  |         23 |
|        117 | fsbc          | chaitra      | ECE            |             23 | chaitra@gmail.com |         23 |
+------------+---------------+--------------+----------------+----------------+-------------------+------------+
*/

-- SELECT * , LEAD(students_marks) OVER(order by students_marks desc) as "Next Marks" FROM ineuron_students;

-- output:
/*
+------------+---------------+--------------+----------------+----------------+-------------------+------------+
| student_id | student_batch | student_name | student_stream | students_marks | student_mail_id   | Next Marks |
+------------+---------------+--------------+----------------+----------------+-------------------+------------+
|        108 | fsds          | snehal       | CI             |             89 | snehal@gmail.com  |         89 |
|        115 | fsde          | prateek      | EE             |             89 | prateek@gmail.com |         82 |
|        104 | fsda          | sanket       | cs             |             82 | sanket@gmail.com  |         81 |
|        102 | fsda          | sanket       | cs             |             81 | sanket@gmail.com  |         80 |
|        100 | fsda          | saurabh      | cs             |             80 | saurabh@gmail.com |         80 |
|        103 | fsda          | shyam        | cs             |             80 | shyam@gmail.com   |         78 |
|        106 | fsds          | ajay         | ME             |             78 | ajay@gmail.com    |         67 |
|        105 | fsda          | shyam        | ME             |             67 | shyam@gmail.com   |         67 |
|        112 | fsde          | mohit        | EE             |             67 | mohit@gmail.com   |         65 |
|        119 | fsbc          | sandeep      | ECE            |             65 | sandeep@gmail.com |         65 |
|        119 | fsbc          | saurabh      | ECE            |             65 | saurabh@gmail.com |         45 |
|        106 | fsds          | ajay         | ME             |             45 | ajay@gmail.com    |         45 |
|        110 | fsds          | rakesh       | CI             |             45 | rakesh@gmail.com  |         45 |
|        114 | fsde          | gaurav       | EE             |             45 | gaurav@gmail.com  |         45 |
|        118 | fsbc          | pranay       | ECE            |             45 | pranay@gmail.com  |         43 |
|        111 | fsde          | anuj         | CI             |             43 | anuj@gmail.com    |         34 |
|        109 | fsds          | manisha      | CI             |             34 | manisha@gmail.com |         23 |
|        113 | fsde          | vivek        | EE             |             23 | vivek@gmail.com   |         23 |
|        116 | fsde          | mithun       | ECE            |             23 | mithun@gmail.com  |         23 |
|        117 | fsbc          | chaitra      | ECE            |             23 | chaitra@gmail.com |       NULL |
+------------+---------------+--------------+----------------+----------------+-------------------+------------+
*/