USE [KenticoCMS_Prod3]
GO


--alter table [HFit_HealthAssesmentUserQuestion] add COLUMN DropMe bit null ;
--go 

--CREATE NONCLUSTERED INDEX TEMP_IDX_ONLY_FOR_TESTING ON [dbo].[HFit_HealthAssesmentUserQuestion]
--(
--	DropMe 
--)
--GO

	

--select top 10 * from HFit_HealthAssesmentUserQuestion
SET NOCOUNT ON;
declare @startingTime time = CONVERT (time, SYSDATETIME());
declare @NbrToInsert int = 250 ;
declare @intFlag int = 0 ;

print ('Starting Time: ' + cast(@startingTime as nvarchar(50)));

WHILE (@intFlag < @NbrToInsert)
BEGIN

	INSERT [dbo].[HFit_HealthAssesmentUserQuestion](
		[ItemCreatedBy], 
		[ItemCreatedWhen], 
		[ItemModifiedBy], 
		[ItemModifiedWhen], 
		[ItemOrder], 
		[ItemGUID], 
		[UserID], 
		[HAQuestionWeight], 
		[HAQuestionScore], 
		[HARiskAreaItemID], 
		[CodeName], 
		[PreWeightedScore], 
		[IsProfessionallyCollected], 
		[ProfessionallyCollectedEventDate], 
		[HARiskAreaDocumentID_old], 
		[HAQuestionDocumentID_old], [HAQuestionVersionID_old], [HAQuestionNodeGUID], DropMe)
	VALUES (-99, getdate(), -1, getdate(), NULL, newid(), 74, 0, 0, 8, 'VisionImpairment', NULL, 0, NULL, 0, 0, NULL, '829B4D17-C15B-4613-B5E9-874C2F64529B', 1)
	--SELECT [ItemID]
	--FROM [dbo].[HFit_HealthAssesmentUserQuestion]
	--WHERE @@ROWCOUNT > 0 AND [ItemID] = scope_identity() ;

	set @intFlag = @intFlag + 1 ;
END
declare @endingTime time = CONVERT (time, SYSDATETIME());
declare @ET nvarchar(100) = (select  CAST((DATEDIFF(SECOND, @startingTime, @endingTime) % 60) AS VARCHAR) +     ' Seconds ');

declare @esecs float = DATEDIFF(SECOND, @startingTime, @endingTime) % 60 ;
declare @rpersec float = @intFlag  / @esecs ;
declare @txtime float = @esecs /@intFlag * 1000 ;

print ('Total Inserts into HFit_HealthAssesmentUserQuestion: ' + cast(@intFlag as nvarchar(50))) ;
print ('Ending Time: ' + cast(@endingTime as nvarchar(50))) ;
print (' Total Seconds: ' + @ET);
print (' Inserts per Second: ' + cast(@rpersec as nvarchar(50)));
print ('Avg. Tx time: ' + cast(@txtime as nvarchar(50)) + 'ms');

declare @delstartingTime time = CONVERT (time, SYSDATETIME());

declare @id as int = 0 ; 
DECLARE db_cursor CURSOR FOR  
SELECT ItemID FROM HFit_HealthAssesmentUserQuestion where DropMe = 1 ;

set @intFlag = 0 ;

ALTER TABLE HFit_HealthAssesmentUserAnswers NOCHECK CONSTRAINT FK_HAQuestionItemID;

OPEN db_cursor   
FETCH NEXT FROM db_cursor INTO @id   ;

WHILE @@FETCH_STATUS = 0   
BEGIN   
	delete from HFit_HealthAssesmentUserQuestion where ItemID = @id and DropMe = 1 ;
	set @intFlag = @intFlag + 1 ;
	FETCH NEXT FROM db_cursor INTO @id   
END  

CLOSE db_cursor   
DEALLOCATE db_cursor

declare @delendingTime time = CONVERT (time, SYSDATETIME());
declare @delET nvarchar(100) = (select  CAST((DATEDIFF(SECOND, @delstartingTime, @delendingTime) % 60) AS VARCHAR) +     ' Seconds ');
declare @delesecs float = DATEDIFF(SECOND, @delstartingTime, @delendingTime) % 60 ;
declare @delrpersec float = @intFlag  / @delesecs ;


print ('-' );
print ('****************************' );
print ('-' );
print (' DELETING Test Records...' + cast(@delstartingTime as nvarchar(50)));
print ('Total Deletes from HFit_HealthAssesmentUserQuestion: ' + cast(@intFlag as nvarchar(50))) ;
print ('Delete Starting Time: ' + cast(@delstartingTime as nvarchar(50)));
print ('Delete Ending Time: ' + cast(@endingTime as nvarchar(50))) ;
print ('Delete  Total Seconds: ' + @ET);
print ('Deletes per Second: ' + cast(@rpersec as nvarchar(50)));
declare @txtime2 float = @esecs /@intFlag * 1000 ;
print ('Avg. Tx time: ' + cast(@txtime2 as nvarchar(50)) + 'ms');

SET NOCOUNT OFF;
--alter table HFit_HealthAssesmentUserQuestion DROP COLUMN  DropMe;
go
--ALTER TABLE HFit_HealthAssesmentUserAnswers WITH CHECK CHECK CONSTRAINT FK_HAQuestionItemID
ALTER TABLE HFit_HealthAssesmentUserAnswers CHECK CONSTRAINT ALL  ;

