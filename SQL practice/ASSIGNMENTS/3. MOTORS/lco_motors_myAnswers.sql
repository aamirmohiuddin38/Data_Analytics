-- Q.1: How would you fetch details of the customers  who cancelled orders?

SELECT CONCAT(c.first_name," ",c.last_name) AS Cust_Name,
    c.customer_name AS Name,
    C.PHONE AS Mobile,
    CONCAT(COALESCE(c.address_line1,'')," ", COALESCE(c.address_line2,'')," ",COALESCE(c.city,'')," ",COALESCE(c.state,'')," ",COALESCE(c.postal_code,'')) AS Address,
    c.country AS country,
    o.status AS Order_Status
FROM customers C
    INNER JOIN orders o ON o.customer_id = c.customer_id
WHERE o.status = "Cancelled";

-- Q.2: Fetch the details of customers who have done payments between the amount 5,000 and 35,000?

SELECT CONCAT(c.first_name," ",c.last_name) AS Cust_Name,
    c.customer_name AS Name,
    C.PHONE AS Mobile,
    CONCAT(COALESCE(c.address_line1,'')," ", COALESCE(c.address_line2,'')," ",COALESCE(c.city,'')," ",COALESCE(c.state,'')," ",COALESCE(c.postal_code,'')) AS Address,
    c.country AS country,
    p.amount as amount
FROM customers c 
    INNER JOIN payments p ON p.customer_id = c.customer_id
WHERE p.amount BETWEEN 5000 AND 35000
ORDER BY p.amount;

-- Q.3: Add new employee/salesman with following details:- 
        -- EMP ID - 15657 
        -- First Name : Lakshmi 
        -- Last Name: Roy 
        -- Extension : x4065 
        -- Email: lakshmiroy1@lcomotors.com 
        -- Office Code: 4 
        -- Reports To: 1088 
        -- Job Title: Sales Rep

    INSERT INTO employees(employee_id, last_name, first_name, extension, email, office_code, reports_to, job_title) 
        VALUES (15657, "Roy", "Lakshmi", "x4065", "lakshmiroy1@lcomotors.com",4,1088, "Sales Rep");

-- Q.4: Assign the new employee(added above) to the customer whose phone is 2125557413 .
    UPDATE customers 
    SET sales_employee_id = 15657 
    WHERE phone = '2125557413';

-- Q.5: Write a SQL query to fetch shipped motorcycles. 

    SELECT o.order_id, o.order_date, o.required_date, o.shipped_date, o.status,
        p.product_name, p.product_line
        FROM orders o 
            INNER JOIN orderdetails od ON od.order_id = o.order_id
            INNER JOIN products p ON p.product_code = od.product_code
        WHERE p.product_line = "Motorcycles"
        AND o.status = "Shipped";

-- Q.6: Write a SQL query to get details of all employees/salesmen in the office located in Sydney.

SELECT employees.employee_id, CONCAT(employees.first_name," ", employees.last_name) AS Name, employees.email, employees.extension, employees.job_title, 
        offices.city 
    FROM employees 
        INNER JOIN offices ON employees.office_code=offices.office_code 
        WHERE offices.city="Sydney";

-- Q.7:  How would you fetch the details of customers whose orders are in process?
SELECT CONCAT(c.first_name," ",c.last_name) AS Cust_Name,
    c.customer_name AS Name,
    C.PHONE AS Mobile,
    CONCAT(COALESCE(c.address_line1,'')," ", COALESCE(c.address_line2,'')," ",COALESCE(c.city,'')," ",COALESCE(c.state,'')," ",COALESCE(c.postal_code,'')) AS Address,
    c.country AS country,
    o.status AS Order_Status
FROM customers C
    INNER JOIN orders o ON o.customer_id = c.customer_id
WHERE o.status = "In Process";

-- Q.8: How would you fetch the details of products with less than 30 orders?

SELECT p.product_code, p.product_name, p.product_line, p.product_vendor, p.stock, p.buy_price, p.mrp,
        od.quantity_ordered
    FROM products p
        INNER JOIN orderdetails od ON od.product_code = p.product_code
    WHERE od.quantity_ordered < 30;

-- Q.9: It is noted that the payment (check number OM314933) was actually 2575. Update the record

UPDATE payments 
    SET amount = 2575 
    WHERE payments.check_number = "OM314933";

-- Q.10: Fetch the details of salesmen/employees dealing with customers whose orders are resolved.

SELECT e.employee_id, CONCAT(e.first_name," " ,e.last_name) AS Name, e.email, e.job_title, e.extension, 
                c.customer_id, 
                o.order_id, o.status 
        FROM employees e 
            INNER JOIN customers c ON c.sales_employee_id = e.employee_id 
            INNER JOIN orders o ON o.customer_id = o.customer_id 
        WHERE o.status = "Resolved";

-- Q.11: Get the details of the customer who made the maximum payment. 

WITH 
CTE AS(
    SELECT c.customer_id, c.customer_name,C.PHONE AS Mobile,
    CONCAT(COALESCE(c.address_line1,'')," ", COALESCE(c.address_line2,'')," ",COALESCE(c.city,'')," ",COALESCE(c.state,'')," ",COALESCE(c.postal_code,'')) AS Address,
    c.country AS country,
            p.amount,
            DENSE_RANK() OVER(ORDER BY p.amount DESC) AS drnk
        FROM customers C
            INNER JOIN payments p ON p.customer_id = c.customer_id
)
SELECT * FROM CTE
    WHERE drnk = 1;

-- Q.12:  Fetch list of orders shipped to France.

SELECT o.*, c.country
    FROM orders o 
        INNER JOIN customers c ON o.customer_id = c.customer_id
    WHERE c.country = "France"
    AND o.status = "Shipped";

-- Q.13:  How many customers are from Finland who placed orders.
    SELECT  COUNT(c.customer_id) AS Order_count, c.country
            FROM customers c 
                INNER JOIN orders o ON o.customer_id = c.customer_id
            WHERE c.country = "Finland";

-- Q.14: Get the details of the customer who made the maximum payment

        Already done --> Q.11

-- Q. 15: Get the details of the customer and payments they made between May 2019 and June 2019.
SELECT c.customer_id, c.customer_name,C.PHONE AS Mobile,
        CONCAT(COALESCE(c.address_line1,'')," ", COALESCE(c.address_line2,'')," ",COALESCE(c.city,'')," ",COALESCE(c.state,'')," ",COALESCE(c.postal_code,'')) AS Address,
        c.country AS country,
        p.amount, p.payment_date
    FROM customers C
            INNER JOIN payments p ON p.customer_id = c.customer_id
    WHERE p.payment_date BETWEEN "2019-05-01" AND "2019-06-30";

-- Q.16: How many orders shipped to Belgium in 2018?

    SELECT COUNT(o.order_id) As no_of_orders,
            c.country, o.status
        FROM orders o
            INNER JOIN customers c ON o.customer_id = c.customer_id
        WHERE c.country = "Belgium"
        AND o.status = "Shipped"
        AND year(o.shipped_date) = "2018"; 
