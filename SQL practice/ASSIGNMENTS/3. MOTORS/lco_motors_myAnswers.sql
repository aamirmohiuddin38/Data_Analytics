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