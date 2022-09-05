--TODO: Q.1: Get me all order id, customer name and date when order was placed.

SELECT O.OrderID, C.CustomerName, O.OrderDate
    -> from (Orders O
    -> INNER JOIN Customers C
    -> ON O.CustomerID = C.CustomerID);

--TODO: Q.2: Get me order_id, customer name and who is the shipper for that order.
    SELECT O.OrderID, C.CustomerName, S.ShipperName
    -> FROM ((Orders O
    -> INNER JOIN Customers C
    -> ON O.CustomerID = C.CustomerID)
    -> INNER JOIN Shippers S
    -> ON O.ShipperID = S.ShipperID) 
    -> LIMIT 5;

--TODO: Q.3: Get me all customers name and their order id.
    SELECT C.CustomerName, O.OrderID
    -> FROM (Customers C
    -> LEFT JOIN Orders O
    -> ON C.CustomerID = O.CustomerID);