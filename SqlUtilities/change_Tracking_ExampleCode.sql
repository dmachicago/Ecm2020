--A. Returning rows for an initial synchronization of data
--The following example shows how to obtain data for an initial synchronization of the table data. The query returns all row data and their associated versions. You can then insert or add this data to the system that will contain the synchronized data.
--Transact-SQL
-- Get all current rows with associated version
SELECT top 1000 e.*,
    c.*
FROM KenticoCMS_1.dbo.CMS_User AS e
CROSS APPLY CHANGETABLE 
    (VERSION KenticoCMS_1.dbo.CMS_User, (UserID), (e.UserID)) AS c;

--B. Listing all changes that were made since a specific version
--The following example lists all changes that were made in a table since the specified version (@last_sync_version). [Emp ID] and SSN are columns in a composite primary key.
--Transact-SQL
DECLARE @last_sync_version bigint;
SET @last_sync_version = 0;
SELECT top 100 UserID
    SYS_CHANGE_VERSION, SYS_CHANGE_OPERATION,
    SYS_CHANGE_COLUMNS, SYS_CHANGE_CONTEXT 
FROM CHANGETABLE (CHANGES KenticoCMS_1.dbo.CMS_User, @last_sync_version) AS C;


DECLARE @last_sync_version bigint;
SET @last_sync_version = 165414842;
SET @last_sync_version = @last_sync_version -1 ;
SELECT 'KenticoCMS_2' as DBNAME, 'CMS_User' as TBL_NAME, getdate() as PullDate, c.*
    --SYS_CHANGE_VERSION, SYS_CHANGE_OPERATION,
    --SYS_CHANGE_COLUMNS, SYS_CHANGE_CONTEXT 
FROM CHANGETABLE (CHANGES KenticoCMS_2.dbo.CMS_User, @last_sync_version) AS C
order by C.SYS_CHANGE_VERSION desc


--C. Obtaining all changed data for a synchronization
--The following example shows how you can obtain all data that has changed. This query joins the change tracking information with the user table so that user table information is returned. A LEFT OUTER JOIN is used so that a row is returned for deleted rows.
--Transact-SQL
-- Get all changes (inserts, updates, deletes)
DECLARE @last_sync_version bigint;
SET @last_sync_version =< value obtained from query>;
SELECT e.FirstName, e.LastName, c.[Emp ID], c.SSN,
    c.SYS_CHANGE_VERSION, c.SYS_CHANGE_OPERATION,
    c.SYS_CHANGE_COLUMNS, c.SYS_CHANGE_CONTEXT 
FROM CHANGETABLE (CHANGES Employees, @last_sync_version) AS c
    LEFT OUTER JOIN Employees AS e
        ON e.[Emp ID] = c.[Emp ID] AND e.SSN = c.SSN;

--D. Detecting conflicts by using CHANGETABLE(VERSION...)
--The following example shows how to update a row only if the row has not changed since the last synchronization. The version number of the specific row is obtained by using CHANGETABLE. If the row has been updated, changes are not made and the query returns information about the most recent change to the row.
--Transact-SQL
-- @last_sync_version must be set to a valid value
UPDATE
    SalesLT.Product
SET
    ListPrice = @new_listprice
FROM
    SalesLT.Product AS P
WHERE
    ProductID = @product_id AND
    @last_sync_version >= ISNULL (
        (SELECT CT.SYS_CHANGE_VERSION FROM 
            CHANGETABLE(VERSION SalesLT.Product,
            (ProductID), (P.ProductID)) AS CT), 0);
-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016
