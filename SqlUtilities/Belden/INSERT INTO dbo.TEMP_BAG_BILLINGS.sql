--SELECT B.ItemClass,
--B.SalesIncentiveRecapClass1,
--B.SalesIncentiveRecapClass2,
--B.DivisionCode,
--B.ExtendedQuantity,
--B.ItemFamily,
--B.UPDATE_DTTM
--INTO dbo.TEMP_BAG_BILLINGS
--FROM BDCSQLSP.SMART_DB.dbo.BAG_BILLINGS B

/***************************************/
INSERT INTO dbo.TEMP_BAG_BILLINGS 
(ItemClass,
SalesIncentiveRecapClass1,
SalesIncentiveRecapClass2,
DivisionCode,
ExtendedQuantity,
ItemFamily,
UPDATE_DTTM)
SELECT 
B.ItemClass,
B.SalesIncentiveRecapClass1,
B.SalesIncentiveRecapClass2,
B.DivisionCode,
B.ExtendedQuantity,
B.ItemFamily,
UPDATE_DTTM
FROM BDCSQLSP.SMART_DB.dbo.BAG_BILLINGS B

select top 10 * from BDCSQLSP.SMART_DB.dbo.BAG_BILLINGS