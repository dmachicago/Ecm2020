
-- use KenticoCMSDev
-- select * from BIGINT_Conversion_Errors

/*  USAGE:
    BEGIN CATCH
		  EXEC dbo.PrintImmediate 'ERRORS DETECTED, ROLLING BACK - PLEASE STANDBY.';

		  INSERT INTO BIGINT_Conversion_Errors (
			    err_txt) 
		  VALUES ('ERRORS DETECTED, ROLLING BACK - PLEASE STANDBY.') ;
		  SET @msg = (SELECT
						 ERROR_MESSAGE ()) ;
		  INSERT INTO BIGINT_Conversion_Errors (
			    err_txt) 
		  VALUES (@msg) ;
		  EXECUTE dbo.USP_GETERRORINFO;
		  IF @@TRANCOUNT > 0
			 BEGIN
				ROLLBACK TRANSACTION TX01
			 END;
	   END CATCH;
*/
go
if exists (select name from sys.procedures where name = 'usp_GetErrorInfo')
    drop procedure usp_GetErrorInfo;
go
CREATE PROCEDURE usp_GetErrorInfo
AS
SELECT
    ERROR_NUMBER() AS ErrorNumber
    ,ERROR_SEVERITY() AS ErrorSeverity
    ,ERROR_STATE() AS ErrorState
    ,ERROR_PROCEDURE() AS ErrorProcedure
    ,ERROR_LINE() AS ErrorLine
    ,ERROR_MESSAGE() AS ErrorMessage;
GO