


/*
Obtaining Initial Data:
Before an application can obtain changes for the first time, the application must send a query to obtain the initial data and the synchronization version. The application must obtain the appropriate data directly from the table, and then use CHANGE_TRACKING_CURRENT_VERSION() to obtain the initial version. This version will be passed to CHANGETABLE(CHANGES …) the first time that changes are obtained.
The following example shows how to obtain the initial synchronization version and the initial data set.
    -- Obtain the current synchronization version. This will be used next time that changes are obtained.
*/

declare @synchronization_version as int = 0 ;
    SET @synchronization_version = CHANGE_TRACKING_CURRENT_VERSION();
print @synchronization_version ;

    -- Obtain initial data set.
    SELECT
        P.ProductID, P.Name, P.ListPrice
    FROM
        SalesLT.Product AS P

/*
Using the Change Tracking Functions to Obtain Changes
To obtain the changed rows for a table and information about the changes, use CHANGETABLE(CHANGES…). For example, the following query obtains changes for the SalesLT.Product table.
*/
SELECT
    CT.ProductID, CT.SYS_CHANGE_OPERATION,
    CT.SYS_CHANGE_COLUMNS, CT.SYS_CHANGE_CONTEXT
FROM
    CHANGETABLE(CHANGES SalesLT.Product, @last_synchronization_version) AS CT

/*
Usually, a client will want to obtain the latest data for a row instead of only the primary keys for the row. Therefore, an application would join the results from CHANGETABLE(CHANGES …) with the data in the user table. For example, the following query joins with the SalesLT.Product table to obtain the values for the Name and ListPrice columns. Note the use of OUTER JOIN. This is required to make sure that the change information is returned for those rows that have been deleted from the user table.
*/
SELECT
    CT.ProductID, P.Name, P.ListPrice,
    CT.SYS_CHANGE_OPERATION, CT.SYS_CHANGE_COLUMNS,
    CT.SYS_CHANGE_CONTEXT
FROM
    SalesLT.Product AS P
RIGHT OUTER JOIN
    CHANGETABLE(CHANGES SalesLT.Product, @last_synchronization_version) AS CT
ON
    P.ProductID = CT.ProductID

/*
To obtain the version for use in the next change enumeration, use CHANGE_TRACKING_CURRENT_VERSION(), as shown in the following example.
*/
SET @synchronization_version = CHANGE_TRACKING_CURRENT_VERSION()

--When an application obtains changes, it must use both CHANGETABLE(CHANGES…) and CHANGE_TRACKING_CURRENT_VERSION(), as shown in the following example.
-- Obtain the current synchronization version. This will be used the next time CHANGETABLE(CHANGES...) is called.
SET @synchronization_version = CHANGE_TRACKING_CURRENT_VERSION();

-- Obtain incremental changes by using the synchronization version obtained the last time the data was synchronized.
SELECT
    CT.ProductID, P.Name, P.ListPrice,
    CT.SYS_CHANGE_OPERATION, CT.SYS_CHANGE_COLUMNS,
    CT.SYS_CHANGE_CONTEXT
FROM
    SalesLT.Product AS P
RIGHT OUTER JOIN
    CHANGETABLE(CHANGES SalesLT.Product, @last_synchronization_version) AS CT
ON
    P.ProductID = CT.ProductID

/*
Version Numbers
A database that has change tracking enabled has a version counter that increases as changes are made to change tracked tables. Each changed row has a version number that is associated with it. When a request is sent to an application to query for changes, a function is called that supplies a version number. The function returns information about all the changes that have been made since that version. In some ways, change tracking version is similar in concept to the rowversion data type.
Validating the Last Synchronized Version

Information about changes is maintained for a limited time. The length of time is controlled by the CHANGE_RETENTION parameter that can be specified as part of the ALTER DATABASE.
Be aware that the time specified for CHANGE_RETENTION determines how frequently all applications must request changes from the database. If an application has a value for last_synchronization_version that is older than the minimum valid synchronization version for a table, that application cannot perform valid change enumeration. This is because some change information might have been cleaned up. Before an application obtains changes by using CHANGETABLE(CHANGES …), the application must validate the value for last_synchronization_version that it plans to pass to CHANGETABLE(CHANGES …). If the value of last_synchronization_version is not valid, that application must reinitialize all the data.
The following example shows how to verify the validity of the value of last_synchronization_version for each table.
    -- Check individual table.
*/
    IF (@last_synchronization_version < CHANGE_TRACKING_MIN_VALID_VERSION(
                                       OBJECT_ID('SalesLT.Product')))
    BEGIN
      -- Handle invalid version and do not enumerate changes.
      -- Client must be reinitialized.
    END

/*
As the following example shows, the validity of the value of last_synchronization_version can be checked against all tables in the database.
    -- Check all tables with change tracking enabled
*/
    IF EXISTS (
      SELECT * FROM sys.change_tracking_tables
      WHERE min_valid_version > @last_synchronization_version )
    BEGIN
      -- Handle invalid version & do not enumerate changes
      -- Client must be reinitialized
    END

/*
Using Column Tracking

Column tracking enables applications to obtain the data for only the columns that have changed instead of the whole row. For example, consider the scenario in which a table has one or more columns that are large, but rarely change; and also has other columns that frequently change. Without column tracking, an application can only determine that a row has changed and would have to synchronize all the data that includes the large column data. However, by using column tracking, an application can determine whether the large column data changed and only synchronize the data if it has changed.
Column tracking information appears in the SYS_CHANGE_COLUMNS column that is returned by the CHANGETABLE(CHANGES …) function.
Column tracking can be used so that NULL is returned for a column that has not changed. If the column can be changed to NULL, a separate column must be returned to indicate whether the column changed.
In the following example, the CT_ThumbnailPhoto column will be NULL if that column did not change. This column could also be NULL because it was changed to NULL - the application can use the CT_ThumbNailPhoto_Changed column to determine whether the column changed.
*/
DECLARE @PhotoColumnId int = COLUMNPROPERTY(
    OBJECT_ID('SalesLT.Product'),'ThumbNailPhoto', 'ColumnId')

SELECT
    CT.ProductID, P.Name, P.ListPrice, -- Always obtain values.
    CASE
           WHEN CHANGE_TRACKING_IS_COLUMN_IN_MASK(
                     @PhotoColumnId, CT.SYS_CHANGE_COLUMNS) = 1
            THEN ThumbNailPhoto
            ELSE NULL
      END AS CT_ThumbNailPhoto,
      CHANGE_TRACKING_IS_COLUMN_IN_MASK(
                     @PhotoColumnId, CT.SYS_CHANGE_COLUMNS) AS
                                   CT_ThumbNailPhoto_Changed
     CT.SYS_CHANGE_OPERATION, CT.SYS_CHANGE_COLUMNS,
     CT.SYS_CHANGE_CONTEXT
FROM
     SalesLT.Product AS P
INNER JOIN
     CHANGETABLE(CHANGES SalesLT.Product, @last_synchronization_version) AS CT
ON
     P.ProductID = CT.ProductID AND
     CT.SYS_CHANGE_OPERATION = 'U'
-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016
