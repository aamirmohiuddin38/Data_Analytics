--TODO: Q.1: Get me all order id, customer name and date when order was placed.

SELECT O.OrderID, C.CustomerName, O.OrderDate
    -> from (Orders O
    -> INNER JOIN Customers C
    -> ON O.CustomerID = C.CustomerID);


    SELECT O.OrderID, C.CustomerName, S.ShipperName
    -> FROM ((Orders O
    -> INNER JOIN Customers C
    -> ON O.CustomerID = C.CustomerID)
    -> INNER JOIN Shippers S
    -> ON O.ShipperID = S.ShipperID) 
    -> LIMIT 5;