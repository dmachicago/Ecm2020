--Script from step 2 in Parition a table using SSMS section.  This script creates the table that will be partitioned.
USE [AdventureWorks2012];
IF(OBJECT_ID('dbo.PurchaseOrderHeader')) IS NOT NULL
DROP TABLE dbo.PurchaseOrderHeader
GO
CREATE TABLE dbo.[PurchaseOrderHeader](
[PurchaseOrderID] [int] NOT NULL,
[RevisionNumber] [tinyint] NOT NULL,
[Status] [tinyint] NOT NULL,
[EmployeeID] [int] NOT NULL,
[VendorID] [int] NOT NULL,
[ShipMethodID] [int] NOT NULL,
[OrderDate] [datetime] NOT NULL,
[ShipDate] [datetime] NULL,
[SubTotal] [money] NOT NULL,
[TaxAmt] [money] NOT NULL,
[Freight] [money] NOT NULL,
[TotalDue] money,
[ModifiedDate] [datetime] NOT NULL
);