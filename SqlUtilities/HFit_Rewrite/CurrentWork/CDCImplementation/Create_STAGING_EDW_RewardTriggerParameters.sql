

go

print 'Creating the DIM_EDW_RewardTriggerParameters table.';
go

if exists (select name from sys.tables where name = 'DIM_EDW_RewardTriggerParameters')
BEGIN
    drop table DIM_EDW_RewardTriggerParameters;
END

select * 
into DIM_EDW_RewardTriggerParameters
from
view_EDW_RewardTriggerParameters;

GO
SET ANSI_PADDING ON
GO

CREATE CLUSTERED INDEX [PI_EDW_RewardTriggerParameters] ON [dbo].[DIM_EDW_RewardTriggerParameters]
(
	  [SiteGUID]
      ,[RewardTriggerID]
     ,[ParameterDisplayName]
      ,[RewardTriggerParameterOperator]
      ,[Value]
      ,[AccountID]
      ,[AccountCD]
      ,[DocumentGuid]
      ,[NodeGuid]
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)

 ALTER TABLE DIM_EDW_RewardTriggerParameters
                    ADD
                                LastModifiedDate datetime NULL;
                    ALTER TABLE DIM_EDW_RewardTriggerParameters
                    ADD
                                RowNbr  int IDENTITY (1, 1) ;
                    ALTER TABLE DIM_EDW_RewardTriggerParameters
                    ADD
                                DeletedFlg  bit NULL;


go
print 'Created the DIM_EDW_RewardTriggerParameters table.';
go
