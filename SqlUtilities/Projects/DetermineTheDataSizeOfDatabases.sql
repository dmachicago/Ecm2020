/*
The script below creates a table named DatabaseFiles (if it does not already exist) 
based upon the structure of the system view sys.database_files; it also adds a new 
column to capture when the record was added to the table.
*/
IF OBJECT_ID('DatabaseFiles') IS NULL
 BEGIN
     SELECT TOP 0 * INTO DatabaseFiles
     FROM sys.database_files    

     ALTER TABLE DatabaseFiles
     ADD CreationDate DATETIME DEFAULT(GETDATE())
 END
 go
 
 /* Populate the details into the new table */
 /* {PS - Never use Select *} */
 EXECUTE sp_msforeachdb 'INSERT INTO DatabaseFiles SELECT *, GETDATE() FROM [?].sys.database_files'
 go
 
 /* Get the size statistics */
 SELECT  size,* FROM DatabaseFiles
 order by name, type_desc