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

-- Q.17: Get the details of the salesman/employee with offices dealing with customers in Germany.

SELECT e.employee_id, CONCAT(e.first_name," ", e.last_name) AS Emp_Name, e.extension, e.email, e.job_title,
        o.office_code, o.phone,
        CONCAT(COALESCE(o.city,''), ",", COALESCE(o.address_line1,''), "|",COALESCE(o.address_line2,''),"-", COALESCE(o.state,''),"-",COALESCE(o.country,''),"_",COALESCE(o.postal_code,'')) AS Offc_Address,
        c.customer_id,c.customer_name AS Cust_Name, c.country As cust_country
    FROM employees e
        INNER JOIN offices o ON o.office_code = e.office_code
        INNER JOIN customers c ON c.sales_employee_id = e.employee_id
    WHERE c.country = 'Germany';

-- Q.18:  The customer (id:496 ) made a new order today and the details are as follows: 
        -- Order id : 10426 
        -- Product Code: S12_3148 
        -- Quantity : 41 
        -- Each price : 151 
        -- Order line number : 11 
        -- Order date : <today’s date> 
        -- Required date: <10 days from today> 
        -- Status: In Process

    INSERT INTO orders(order_id, order_date, required_date, status,customer_id) 
        VALUES (10426, 
                CURRENT_DATE(), 
                (CURRENT_DATE() + INTERVAL 10 DAY), 
                "In Process" , 496);


    INSERT INTO orderdetails(order_id, product_code, quantity_ordered, each_price, order_line_number) 
        VALUES ( 10426 , "S12_3148" , 41, 151, 11);

-- Q.19: Fetch details of employees who were reported for the payments made by the customers between June 2018 and July 2018.

SELECT reported_emp.employee_id, reported_emp.first_name , reported_emp.last_name, reported_emp.email, reported_emp.job_title, 
        reported_emp.extension , 
        employees.employee_id AS reported_by_employee,
        CONCAT(employees.first_name, " ", employees.last_name) AS reported_emp_name, 
        customers.customer_id 
    FROM employees 
        INNER JOIN employees reported_emp ON reported_emp.employee_id = employees.reports_to 
        INNER JOIN customers ON customers.sales_employee_id = employees.employee_id 
        INNER JOIN payments ON payments.customer_id = customers.customer_id 
    WHERE payments.payment_date BETWEEN '2018-06-01' AND '2018-07-31';

-- Q.20: A new payment was done by a customer(id: 119). Insert the below details. 
        -- Check Number : OM314944 
        -- Payment date : <today’s date> 
        -- Amount : 33789.55 

    INSERT INTO payments(customer_id, check_number, payment_date, amount) 
        VALUES (119, "OM314944", CURRENT_DATE(), 33789.55);

-- Q.21: Get the address of the office of the employees that reports to the employee whose id is 1102

SELECT o.office_code, o.phone,
        CONCAT(COALESCE(o.city,''), ",", COALESCE(o.address_line1,''), "|",COALESCE(o.address_line2,''),"-", COALESCE(o.state,''),"-",COALESCE(o.country,''),"_",COALESCE(o.postal_code,'')) AS Offc_Address
    FROM employees 
        INNER JOIN employees reports_emp ON reports_emp.employee_id = employees.reports_to 
        INNER JOIN offices o ON o.office_code = employees.office_code 
        WHERE employees.reports_to = "1102";

-- Q.22: Get the details of the payments of classic cars.
SELECT payments.check_number, payments.payment_date, payments.amount, 
    products.product_name, products.product_line , customers.customer_id AS PaidBy 
FROM payments 
    INNER JOIN customers ON customers.customer_id = payments.customer_id 
    INNER JOIN orders ON orders.customer_id = customers.customer_id 
    INNER JOIN orderdetails ON orderdetails.order_id = orders.order_id 
    INNER JOIN products ON products.product_code = orderdetails.product_code 
WHERE products.product_line = "Classic Cars";

-- Q.23: How many customers ordered from the USA?

SELECT COUNT(customers.customer_id) 
    FROM customers 
        INNER JOIN orders ON orders.customer_id = customers.customer_id 
    WHERE customers.country = "USA";

-- Q.24: Get the comments regarding resolved orders.

SELECT orders.comments , orders.customer_id 
    FROM orders 
    WHERE orders.status = "Resolved";

-- Q.25: Fetch the details of employees/salesmen in the USA with office addresses.

SELECT employees.employee_id, employees.first_name ,employees.last_name, employees.email, employees.job_title, employees.extension, 
    offices.office_code, offices.address_line1, offices.address_line2, offices.phone, offices.city, offices.state, offices.country, offices.postal_code, offices.territory 
FROM employees 
    INNER JOIN offices ON offices.office_code = employees.office_code 
    WHERE offices.country = "USA";

-- Q.26: Fetch total price of each order of motorcycles. (Hint: quantity x price for each record).

SELECT products.product_code, products.product_line, 
        orderdetails.each_price AS Price_Per, orderdetails.order_id, orderdetails.quantity_ordered AS Qty,
        (orderdetails.each_price * orderdetails.quantity_ordered) AS Total_Price
    FROM products 
        INNER JOIN orderdetails ON orderdetails.product_code = products.product_code
    WHERE products.product_line = "Motorcycles";

-- Q.27: Get the total worth of all planes ordered.

SELECT products.product_line, 
        SUM(orderdetails.each_price * orderdetails.quantity_ordered) AS Total_Worth
    FROM products 
        INNER JOIN orderdetails ON orderdetails.product_code = products.product_code
    WHERE products.product_line = "Planes";

-- Q.28: How many customers belong to France?

SELECT COUNT(customer_id) As Cust_of_France
    FROM customers 
WHERE customers.country = "France";

-- Q.29: Get the payments of customers living in France.

SELECT customers.customer_id, customers.first_name, customers.last_name, customers.phone, customers.address_line1, customers.address_line2, customers.city, customers.state, customers.postal_code, customers.country, customers.credit_limit, 
        payments.payment_date, payments.amount, payments.check_number 
FROM customers 
    INNER JOIN payments ON payments.customer_id = customers.customer_id
    WHERE customers.country="France";

-- Q.30: Get the office address of the employees/salesmen who report to employee 1143.
SELECT DISTINCT o.office_code, o.phone,
        CONCAT(COALESCE(o.city,''), ",", COALESCE(o.address_line1,''), "|",COALESCE(o.address_line2,''),"-", COALESCE(o.state,''),"-",COALESCE(o.country,''),"_",COALESCE(o.postal_code,'')) AS Offc_Address,
        employees.employee_id
    FROM employees 
        INNER JOIN employees reports_emp ON reports_emp.employee_id = employees.reports_to 
        INNER JOIN offices o ON o.office_code = employees.office_code 
        WHERE employees.reports_to = "1143";