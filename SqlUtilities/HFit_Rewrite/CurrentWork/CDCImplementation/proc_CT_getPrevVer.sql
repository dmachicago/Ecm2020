
GO
PRINT 'Executing proc_CT_getPrevVer.sql';
GO

IF EXISTS (SELECT
				  name
				  FROM sys.procedures
				  WHERE name = 'proc_CT_getPrevVer') 
	BEGIN
		DROP PROCEDURE
			 proc_CT_getPrevVer
	END;

GO
-- exec proc_CT_getPrevVer "hfit_PPtEligibility"
CREATE PROCEDURE proc_CT_getPrevVer (
	   @Tblname nvarchar (100)) 
AS
	 BEGIN
		 DECLARE @Ct TABLE (
						   ver bigint) ;
		 INSERT INTO @Ct
		 SELECT DISTINCT TOP 2
				CT.SYS_CHANGE_VERSION
				FROM CHANGETABLE (CHANGES HFIT_PPTEligibility, NULL) AS CT
				ORDER BY
						 CT.SYS_CHANGE_VERSION DESC;

		 DECLARE @Tgtver bigint = (SELECT TOP 1
										  ver
										  FROM @Ct
										  ORDER BY
												   ver) ;

		 RETURN @Tgtver;
	 END;

GO
PRINT 'Executed proc_CT_getPrevVer.sql';
GO