
GO

Print('Creating proc proc_GenViewDDL') ;
go

if exists (Select name from sys.procedures where name = 'proc_GenViewDDL')
BEGIN
	drop procedure proc_GenViewDDL;
END
go

CREATE PROCEDURE proc_GenViewDDL (@ViewName as nvarchar(254))
AS
	 BEGIN
		 SELECT
				definition
		   FROM sys.objects AS o
					JOIN sys.sql_modules AS m
						ON m.object_id = o.object_id
		   WHERE o.object_id = OBJECT_ID (@ViewName) 
			 AND o.type = 'V';
	 END;

GO
Print('Created proc proc_GenViewDDL') ;
--exec proc_GenViewDDL 'view_EDW_HealthAssesment' ;
go
