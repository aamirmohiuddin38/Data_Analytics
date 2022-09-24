-- Q.1: Insert the details of new customer:- 
    -- First name : Nancy 
    -- Last Name: Perry 
    -- Dob : 1988-05-16 
    -- License Number: K59042656E 
    -- Email : nancy@gmail.com 

INSERT INTO customer(first_name, last_name, dob, driver_license_number, email)
        VALUES('Nancy', 'Perry', '1988-05-06', 'K59042656E', 'nancy@gmail.com');


-- Q2: The new customer (inserted above) wants to rent a car from 2020-08-25 to 2020-08-30. 
    -- More details are as follows: 

    -- Vehicle Type : Economy SUV 
    -- Fuel Option : Market 
    -- Pick Up location: 5150 W 55th St , Chicago, IL, zip- 60638 
    -- Drop Location: 9217 Airport Blvd, Los Angeles, CA, zip - 90045

    INSERT into rental(start_date, end_date, customer_id, vehicle_type_id, fuel_option_id, pickup_location_id, drop_off_location_id)
        VALUES (
            "2020-08-25",
            "2020-08-30",
            (SELECT customer.id FROM customer WHERE customer.first_name = "Nancy" AND customer.last_name = "Perry"),
            (SELECT vehicle_type.id FROM vehicle_type WHERE vehicle_type.name = "Economy SUV"),
            (SELECT fuel_option.id FROM fuel_option WHERE fuel_option.name = "Market"),
            (SELECT location.id FROM location WHERE location.street_address = "5150 W 55th St"),
            (SELECT location.id FROM location WHERE location.street_address = "9217 Airport Blvd")
        );

-- Q.3:  The customer with the driving license W045654959 changed his/her drop off location to 
        -- 1001 Henderson St,  Fort Worth, TX, zip - 76102  and wants to extend the rental upto 4 more 
        -- days. Update the record.

UPDATE rental
    INNER JOIN customer ON customer.id = rental.customer_id 
    SET drop_off_location_id = (SELECT location.id FROM location WHERE location.zipcode=76102),
        end_date=(SELECT end_date + INTERVAL 4 DAY) WHERE customer.driver_license_number="W045654959";

    -- Q.4: Fetch all rental details with their equipment type.

    --(**  https://stackoverflow.com/questions/10710271/join-table-twice-on-two-different-columns-of-the-same-table)

SELECT CONCAT(c.first_name, ' ', c.last_name) AS CustName, c.driver_license_number As LIC_NO,
        r.start_date, r.end_date, 
        CONCAT(p.street_address,' ',p.city,' ',p.state,' ',p.zipcode) AS PickUp_Loc,
        CONCAT(d.street_address,' ',d.city,' ',d.state,' ',d.zipcode) AS DropOff_Loc,
        v.name AS VehicleType,
        f.name AS FuelOption,
        e.name AS EquipType
    FROM customer c
        INNER JOIN rental r ON r.id = c.id
        INNER JOIN location p ON p.id = r.pickup_location_id
        INNER JOIN location d ON d.id = r.drop_off_location_id
        INNER JOIN vehicle_type v ON v.id = r.vehicle_type_id
        INNER JOIN fuel_option f ON f.id = r.fuel_option_id
        INNER JOIN rental_has_equipment_type ON rental_has_equipment_type.rental_id = r.id
        INNER JOIN equipment_type e ON e.id = rental_has_equipment_type.equipment_type_id;

-- Q.5: Fetch all details of vehicles

SELECT v.id, v.brand, v.model, v.model_year, v.mileage, v.color,
        vt.name AS VehicleType, vt.rental_value,
        CONCAT(l.street_address," ",l.city," ",l.state," ", l.zipcode) AS CurLoc
    FROM vehicle v
    INNER JOIN vehicle_type vt ON vt.id = v.vehicle_type_id
    INNER JOIN location l ON l.id = v.current_location_id;

-- Q.6: Get driving license of the customer with most rental insurances.
WITH
CTE AS(
SELECT c.driver_license_number AS LIC_NO,ri.insurance_cost_total AS TotalInsuCost, COUNT(rhi.insurance_id) AS No_of_Insr,
        DENSE_RANK() OVER(ORDER BY  COUNT(rhi.insurance_id) DESC) AS drnk
        FROM customer c
        INNER JOIN rental r ON r.customer_id = c.id
        INNER JOIN rental_invoice ri ON ri.rental_id = r.id
        INNER JOIN rental_has_insurance rhi ON rhi.rental_id = r.id
        GROUP BY rhi.rental_id
)
SELECT * FROM CTE WHERE drnk = 1;


-- Q.7: Insert a new equipment type with following details. 
        -- Name : Mini TV 
        -- Rental Value : 8.99

INSERT INTO equipment_type(name, rental_value)
        VALUES("Mini Tv", 8.99);
