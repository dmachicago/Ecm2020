--* USEDFINAnalytics
go
--Create a dummy TABLE to generate a SEQUENCE. No actual records will be stored.

if not exists (select 1 from INFORMATION_SCHEMA.TABLES where TABLE_NAME = 'DFS_SequenceTABLE')
CREATE TABLE DFS_SequenceTABLE
(
    ID BIGINT IDENTITY  
);
GO

if exists (select 1 from sys.procedures where name = 'GetSEQUENCE')
	drop procedure GetSEQUENCE;
go

--This procedure is for convenience in retrieving a sequence.
create PROCEDURE dbo.GetSEQUENCE ( @value BIGINT OUTPUT)
AS
    --Act like we are INSERTing a row to increment the IDENTITY
  
    INSERT DFS_SequenceTABLE WITH (TABLOCKX) DEFAULT VALUES;
    --Return the latest IDENTITY value.
    SELECT @value = SCOPE_IDENTITY();
GO

/*Example execution
DECLARE @value BIGINT;
EXECUTE dbo.GetSEQUENCE @value OUTPUT;
SELECT @value AS [@value];
*/
