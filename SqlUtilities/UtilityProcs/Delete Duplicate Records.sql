/*
SQL SERVER Delete Duplicate Records – Rows
March 1, 2007 by W. Dale MIller 
*/

/*
Following code is useful to delete duplicate records. 
The table must have identity column, which will be used to 
identify the duplicate records. Table in example is has ID 
as Identity Column and Columns which have duplicate data 
are DuplicateColumn1, DuplicateColumn2 and DuplicateColumn3.
*/

DELETE
FROM Customer_Info
WHERE ID NOT IN
(
SELECT MAX(ID)
FROM Customer_Info
GROUP BY DuplicateColumn1, DuplicateColumn2, DuplicateColumn3)


