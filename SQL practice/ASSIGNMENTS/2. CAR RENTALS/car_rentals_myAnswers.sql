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
        LEFT JOIN rental_has_insurance rhi ON rhi.rental_id = r.id
        GROUP BY rhi.rental_id
)
SELECT * FROM CTE WHERE drnk = 1;


-- Q.7: Insert a new equipment type with following details. 
        -- Name : Mini TV 
        -- Rental Value : 8.99

INSERT INTO equipment_type(name, rental_value)
        VALUES("Mini Tv", 8.99);


-- Q.8: Insert a new equipment with following details: 
        -- Name : Garmin Mini TV 
        -- Equipment type : Mini TV 
        -- Current Location zip code : 60638

INSERT INTO equipment(name, equipment_type_id, current_location_id)
        VALUES(
            "Garmin Mini TV",
            (SELECT id FROM equipment_type WHERE name = "Mini TV"),
            (SELECT id FROM location WHERE zipcode = 60638)
        );

-- Q.9: Fetch rental invoice for customer (email: smacias3@amazonaws.com).

SELECT c.email, ri.*
    FROM rental_invoice ri
        INNER JOIN rental r ON r.id = ri.rental_id
        INNER JOIN customer c ON c.id = r.customer_id
    WHERE c.email = "smacias3@amazonaws.com";

-- Q. 10: Insert the invoice for customer (driving license: K59042656E ) with following details:- 
    -- Car Rent : 785.4 
    -- Equipment Rent : 114.65 
    -- Insurance Cost : 688.2 
    -- Tax : 26.2 
    -- Total: 1614.45 
    -- Discount : 213.25 
    -- Net Amount: 1401.2

    INSERT INTO rental_invoice(car_rent, equipment_rent_total, insurance_cost_total, tax_surcharges_and_fees, total_amount_payable, 
        discount_amount, net_amount_payable, rental_id) 
        VALUES (785.4, 114.65, 688.2, 26.2, 1614.45, 213.25, 1401.2,
        (SELECT rental.id FROM rental 
        INNER JOIN customer ON customer.id = rental.customer_id 
        WHERE customer.driver_license_number = "K59042656E"));

-- Q. 11: Which rental has the most number of equipment

WITH
CTE as(
    SELECT rental_id, COUNT(equipment_type_id),
        DENSE_RANK() OVER(ORDER BY COUNT(equipment_type_id)) drnk
        FROM rental_has_equipment_type
        GROUP BY rental_id
)
SELECT * from CTE WHERE drnk = 1;

-- Q.12: Get driving license of a customer with least number of rental insurances. 
WITH
CTE AS(
SELECT c.driver_license_number AS LIC_NO,ri.insurance_cost_total AS TotalInsuCost, COUNT(rhi.insurance_id) AS No_of_Insr,
        DENSE_RANK() OVER(ORDER BY  COUNT(rhi.insurance_id) ASC) AS drnk
        FROM customer c
        INNER JOIN rental r ON r.customer_id = c.id
        INNER JOIN rental_invoice ri ON ri.rental_id = r.id
        LEFT JOIN rental_has_insurance rhi ON rhi.rental_id = r.id
        GROUP BY rhi.rental_id
)
SELECT * FROM CTE WHERE drnk = 1;

-- Q.13:  Insert new location with following details. 
    -- Street address : 1460  Thomas Street 
    -- City : Burr Ridge , State : IL, Zip - 61257

INSERT INTO location(street_address, city, state, zipcode) 
    VALUES ("1460 Thomas Street", "Burr Ridge", "IL", 61257);

-- Q. 14: Add the new vehicle with following details:- 
    -- Brand: Tata  
    -- Model: Nexon 
    -- Model Year : 2020 
    -- Mileage: 17000 
    -- Color: Blue 
    -- Vehicle Type: Economy SUV  
    -- Current Location Zip: 20011

    INSERT INTO vehicle(brand, model, model_year, mileage, color, vehicle_type_id, current_location_id) 
        VALUES ("Tata", "Nexon", 2020, 17000, "blue",
            (SELECT vehicle_type.id FROM vehicle_type WHERE vehicle_type.name="Economy SUV"), 
            (SELECT location.id FROM location WHERE location.zipcode=20011));

-- Q.15:  Insert new vehicle type Hatchback and rental value: 33.88.

INSERT INTO vehicle_type(name, rental_value) VALUES ("Hatchback", 33.88);

-- Q.16: Add new fuel option Pre-paid (refunded) with description: Customer buy a tank of fuel at pick-up and get refunded the amount customer don’t use..

INSERT INTO fuel_option(name, description) 
    VALUES ("Pre-paid (refunded)" , 
        "Customer buy a tank of fuel at pick-up and get refunded the amount customer don’t use.");

-- Q.17: Assign the insurance : Cover My Belongings (PEP), Cover The Car (LDW) to the rental 
    -- started on 25-08-2020 (created in Q2) by customer (Driving License:K59042656E).


INSERT INTO rental_has_insurance (rental_id, insurance_id) 
        VALUES
        ((SELECT rental.id FROM rental INNER JOIN customer ON customer.id=rental.customer_id WHERE rental.start_date="2020-08-25" AND customer.driver_license_number="K59042656E"), 
        (SELECT insurance.id FROM insurance WHERE insurance.name = "Cover My Belongings (PEP)")), 

        ((SELECT rental.id FROM rental INNER JOIN customer ON customer.id=rental.customer_id WHERE rental.start_date="2020-08-25" AND customer.driver_license_number="K59042656E"), 
        (SELECT insurance.id FROM insurance WHERE insurance.name = "Cover The Car (LDW)"));