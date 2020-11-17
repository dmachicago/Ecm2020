
go
print 'Executing udf_CT_GetCommitTime.sql'
go

IF OBJECT_ID (N'dbo.udf_CT_GetCommitTime', N'FN') IS NOT NULL
	BEGIN
		DROP FUNCTION
			 udf_CT_GetCommitTime
	END;
GO
CREATE FUNCTION dbo.udf_CT_GetCommitTime (
				@Verno bigint) 
RETURNS datetime
AS
	 BEGIN
		 DECLARE @Dt datetime;
		 SET @Dt = (SELECT
						   tc.commit_time
						   FROM
								CHANGETABLE (CHANGES HFIT_PPTEligibility, 0) c
									JOIN sys.dm_tran_commit_table AS tc
										ON c.sys_change_version = tc.commit_ts) ;

		 RETURN @Dt;
	 END;
GO

print 'Executed udf_CT_GetCommitTime.sql'
go
