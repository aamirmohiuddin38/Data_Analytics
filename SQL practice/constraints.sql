-- SHOW DATABASES;
-- SELECT DATABASE();
-- USE photo_store;

-- TODO: CREATE TABLE
-- CREATE TABLE customers (
--     customer_id INT NOT NULL AUTO_INCREMENT,
--     name VARCHAR(30) NOT NULL,
--     email VARCHAR(30) NOT NULL DEFAULT "No Email Provided",
--     amount INT,
--     PRIMARY KEY (customer_id)
-- );

-- TODO: INSERT VALUES
-- INSERT INTO customers(name, email, amount)
-- VALUES
--     ('Basu', 'basu@co.in', 45),
--     ('Abid','Abid@dev.in',50),
--     ('Fzl','fzl@edu.in', 60),
--     ('Asu','asu@gmail.com',35) ;

-- TODO: RETRIEVE DATA
-- SELECT name from customers;
-- SELECT email from customers;
-- SELECT amount as PURCHASES from customers; (Alliasing)

-- TODO: UPDATE Tasks
-- SELECT * from customers 
-- WHERE name = "Sno";

UPDATE customers
SET email = "Sno@dev.in" 
WHERE name = "Sno";