-- TODO: CREATING DB,TABLE and INSERTNG DATA

-- SHOW DATABASES;

-- CREATE DATABASE lco_users;
-- USE lco_users;

-- CREATE TABLE students(
--     student_id INT NOT NULL AUTO_INCREMENT,
--     email VARCHAR(60),
--     stu_fname VARCHAR(60),
--     stu_lname VARCHAR(60),
--     login_count INT,
--     course_count INT,
--     signup_month INT,
--     PRIMARY KEY (student_id)
-- );

-- INSERT INTO students(
--     email, 
--     stu_fname, 
--     stu_lname, 
--     login_count, 
--     course_count,
--     signup_month
--     )
-- VALUES
-- ('yogeshk@gmail.com', 'Yogesh', 'kumar', 23, 5, 7),
-- ('anshus@yahoo.com', 'Anshu', 'Sharma', 8, 2, 3),
-- ('suryare@gmail.com', 'Surya', 'Reddy', 28, 5, 8),
-- ('ravis@gmail.com', 'Ravi', 'Sharma', 15, 7, 4),
-- ('aReallyLongLikeReallyLongEmail@gmail.com', 'tom', 'broody', 15, 7, 4),
-- ('akki@gmail.com', 'akki', 'sawarup', 35, 8, 1),
-- ('gurk@gmail.com', 'gur', 'karan', 18, 3, 9),
-- ('keertib@yahoo.com', 'keerti', 'balan', 38, 13, 12),
-- ('piyushc@gmail.com', 'piyush', 'chauhan', 9, 3, 7),
-- ('satishk@gmail.com', 'satish', 'karnati', 39, 13, 9),
-- ('dineshs@gmail.com', 'dinesh', 'sharma', 9, 1, 12),
-- ('mukeshv@gmail.com', 'mukesh', 'verma', 17, 4, 11),
-- ('mukeshv@gmail.com', 'mukesh', 'verma', 17, 4, 11),
-- ('hemants@yahoo.com', 'hemant', 'singh', 37, 14, 10),
-- ('hemants@yahoo.com', 'hemant', 'singh', 37, 14, 10),
-- ('priyala@gmail.com', 'priyal', 'aryan', 19, 5, 9),
-- ('snigdha@yahoo.com', 'Snigdha', 'Prasad', 19, 5, 9),
-- ('mikeg@yahoo.com', 'Mike', 'george', 39, 15, 4),
-- ('manon@gmail.com', 'manon', 'lea', 27, 6, 7),
-- ('pauline@gmail.com', 'pauline', 'lucas', 15, 1, 8);

-- SELECT * FROM STUDENTS;


-- TODO: RETREIVING SOME DATA
-- TODO: 1. Give me full name of all the students --> CONCAT

-- SELECT concat(stu_fname, ' ', stu_lname) as FULL_NAME from students;

-- TODO: 2. Give me full name and login count of all users.

-- SELECT CONCAT(stu_fname, ' ', stu_lname) as FullName, 
-- login_count 
-- from students;

-- SELECT CONCAT('User login count is ', login_count , ' and course count is ', course_count)
-- from students;

-- TODO: 3. While getting first names , change a to @

-- select stu_fname from students;
-- SELECT REPLACE('Aamir','a', '$'); - CASE SENSITIVE

-- SELECT REPLACE(stu_fname,'a','@') from students;

-- TODO: 4. Give me list of emails. If email is longer than 7 character, truncate it with ...
-- SELECT SUBSTRING('Aamir',2,4);
-- SELECT SUBSTRING(email, 1, 7) from students;

-- SELECT CONCAT(SUBSTRING(email, 1, 7), "...") AS Emails from students;

-- TODO: 5. REVERSE FUNCTION
-- SELECT REVERSE(stu_fname) from students;

-- TODO: 6. Get the length of all the registerd emails
-- SELECT email, CHAR_LENGTH(email) as length from students;

-- TODO: 7. Get me all first name in uppercase and last name in lower case
-- SELECT UPPER(stu_fname) AS FNAME, LOWER(stu_lname) as LNAME from students;

-- TODO: MORE FUNCTIONS
-- 8. How many users are there on your website
-- SELECT DISTINCT stu_fname as USERS from students;

-- TODO: 9. Arrange all users based on number of login count
-- SELECT DISTINCT stu_fname, login_count, course_count 
-- from students 
-- ORDER BY login_count DESC;

-- SELECT DISTINCT stu_fname, login_count, course_count 
-- from students 
-- ORDER BY stu_fname ASC;

-- SELECT DISTINCT stu_fname, login_count, course_count 
-- from students 
-- ORDER BY 3;

-- TODO: 10. Get sorted result but top 5
-- SELECT stu_fname, login_count from students
-- ORDER BY login_count DESC 
-- LIMIT 5;

-- 11. top 3rd user
-- SELECT stu_fname, login_count from students
-- ORDER BY login_count DESC 
-- LIMIT 2,1; 

-- TODO: 12. Get the info of user whose name is like 'esh'
-- SELECT stu_fname from students
-- WHERE stu_fname LIKE '%esh'; 
-- Here '%' means any number of characters but ending with 'esh'

-- SELECT stu_fname from students
-- WHERE stu_fname LIKE 'Y_g%';

-- here underscore means one character

-- TODO: 13. How many users on registerd on this website. Give a number
-- SELECT COUNT(DISTINCT stu_fname, stu_lname)As COUNT from students;

-- TODO: GROUP BY clause - THE GROUP BY CLAUSE allows us to group rows based on the values of one or more columns. It returns one row for each group. The columns that appear in hte GROUP BY clause are called group columns.
-- SELECT signup_month 
-- from students;

-- SELECT signup_month 
-- from students
-- GROUP BY signup_month;

-- SELECT signup_month, COUNT(*) as Count 
-- from students
-- GROUP BY signup_month;

-- TODO: 14. Find the student with max login and also find the one with min course count: MIN MAX and SUBQUERIES
-- SELECT email, login_count from students
-- WHERE login_count = (SELECT MAX(login_count) from students);

-- SELECT email, course_count from students
-- WHERE course_count = (SELECT MIN(course_count) from students);

-- TODO: 15. Lowes number of login count in 7th and 10th month: MIN MAX and GROUP BY
-- SELECT MAX(login_count), signup_month from students
-- WHERE signup_month = 7 OR signup_month = 10
-- GROUP BY signup_month;

-- SELECT MIN(login_count), signup_month from students
-- WHERE signup_month = 7 OR signup_month = 10
-- GROUP BY signup_month;

-- TODO: 16. Total number of login and average number of courses taken by users by month
-- SELECT SUM(login_count), AVG(course_count), signup_month from students
-- GROUP BY signup_month;

-- TODO: 17. Range based selection BETWEEN AND
-- SELECT email, login_count, signup_month from students
-- WHERE signup_month BETWEEN 7 AND 10

-- TODO: 18. CASE THEN
-- SELECT stu_fname, signup_month, email,
--     CASE
--         WHEN signup_month BETWEEN 7 AND 10 THEN 'Early Bird'
--         WHEN signup_month BETWEEN 11 AND 12 THEN 'Regular Bird'
--         ELSE 'Normal'
--     END 
-- from students;

-- SELECT stu_fname, signup_month, email,
--     CASE
--         WHEN signup_month BETWEEN 7 AND 10 THEN 'Early Bird'
--         WHEN signup_month BETWEEN 11 AND 12 THEN 'Regular Bird'
--         ELSE 'Normal'
--     END as Label
-- from students;