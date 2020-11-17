--One quite common problem is to query all dates from a specified period and 
--then have some results from a table which doesn’t have entries for all the 
--dates. In our test data, there is a row for today and tomorrow but the next 
--few dates are missing. So, if we want to get the amount of tracking items 
--for each day for the next seven days, it wouldn’t be so simple. One typical 
--solution is to create a table that contains all the necessary dates and then 
--use that table in the query. Table-Valued Function can be used as an alternative. 
--If we pass the date range to a function, we can create the necessary data 
--on-the-fly with a simple loop.

CREATE FUNCTION DatesBetween(@startDate date, @endDate date)
RETURNS @dates TABLE (
   DateValue date NOT NULL
) 
AS
BEGIN
   WHILE (@startDate <= @endDate) BEGIN
      INSERT INTO @dates VALUES (@startDate);
      SET @startDate = DATEADD(day, 1, @startDate);
   END;
   
   RETURN;
END;

GO

--USE:
--And the query for the TrackingItem amounts would be:
SELECT d.DateValue,
       (SELECT COUNT(*)
        FROM   TrackingItem ti
        WHERE  d.DateValue = ti.Issued) AS Items
FROM DatesBetween(DATEADD(day, 1, GETDATE()), DATEADD(day, 7, GETDATE())) d
ORDER BY d.DateValue;

GO

--Now, if we add a clustered primary key index to the table (which is a great 
--opportunity in certain situations), we will first re-create the function
--and performance will improve significantly:
DROP FUNCTION DatesBetween;
 go

CREATE FUNCTION DatesBetween(@startDate date, @endDate date)
RETURNS @dates TABLE (
   DateValue date NOT NULL PRIMARY KEY CLUSTERED
) 
AS
BEGIN
   WHILE (@startDate <= @endDate) BEGIN
      INSERT INTO @dates VALUES (@startDate);
      SET @startDate = DATEADD(day, 1, @startDate);
   END;
 
   RETURN;
END;
-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016
