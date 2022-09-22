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
