USE AdventureWorks2012
EXEC dbo.PurchaseOrderInformation;

USE AdventureWorks2012;
EXEC dbo.PurchaseOrderInformation
WITH RESULT SETS
(
(
[Purchase Order ID] int,
[Purchase Order Detail ID] int,
[Order Date] datetime,
[Total Due] Money,
[Received Quantity] float,
[Product Name] varchar(50)
)
)