SELECT * FROM Sales.Orders

SELECT * 
FROM Sales.CustomerTransactions
WHERE PaymentMethodID = 4

SELECT CustomerID, OrderID, OrderDate, ExpectedDeliveryDate
FROM Sales.Orders
WHERE CustomerPurchaseOrderNumber = '16374'

SELECT SalespersonPersonID, OrderDate
FROM Sales.Orders
ORDER BY SalespersonPersonID ASC, OrderDate DESC;

CREATE INDEX SalespersonPersonID_OrderDate ON Sales.Orders (SalespersonPersonID ASC, OrderDate ASC);

SELECT OrderId, OrderDate, ExpectedDeliveryDate, People.FullName
FROM Sales.Orders
     JOIN Application.People
	      ON People.PersonID = Orders.ContactPersonID
WHERE PreferredName = 'Aakriti';

SELECT Orders.ContactPersonID, People.PreferredName
FROM Sales.Orders
     JOIN Application.People
	      ON People.PersonID = Orders.ContactPersonID
WHERE PreferredName = 'Aakriti';

CREATE NONCLUSTERED INDEX ContactPersonID_Include_OrderDate_ExpectedDate_ExpectedDeliveryDate
ON Sales.Orders ( ContactPersonId)
INCLUDE (OrderDate, ExpectedDeliveryDate)
ON USERDATA;
GO