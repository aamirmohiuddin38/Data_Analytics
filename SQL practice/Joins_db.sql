--TODO: Q.1: Get me all order id, customer name and date when order was placed.

SELECT O.OrderID, C.CustomerName, O.OrderDate
    -> from Orders O
    -> INNER JOIN Customers C
    -> ON O.CustomerID = C.CustomerID;