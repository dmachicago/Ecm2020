
DECLARE @TableVar TABLE (
						NewPK int IDENTITY (1, 1) 
					  , UserID int NOT NULL
					  , FullName nvarchar(900) null) ;
INSERT INTO @TableVar (
			UserID, FullName) 
SELECT
	   UserID, FullName
	   FROM CMS_USER;
SELECT *
	   FROM @TableVar;
go

--exec sp_help CMS_USER
--select top 1000 * from CMS_USER
-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016
