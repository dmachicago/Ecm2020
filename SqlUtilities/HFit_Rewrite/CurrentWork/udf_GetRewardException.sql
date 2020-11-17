
go
print 'Creating udf_GetRewardException.sql';
go
IF EXISTS (SELECT *
           FROM   sys.objects
           WHERE  object_id = OBJECT_ID(N'[dbo].[udf_GetRewardException]')
                  AND type IN ( N'FN', N'IF', N'TF', N'FS', N'FT' ))
  DROP FUNCTION [dbo].udf_GetRewardException ;
go

create function udf_GetRewardException (@UserID as int, @RewardActivityID as int)
returns datetime
as
begin
return (select TOP 1 dateapproved from HFit_RewardException	 --dateapproved
where  [UserID] = 129361 and
       [RewardActivityID] = 1509
    ORDER BY DateApproved DESC);

end ; 
go
print 'Created udf_GetRewardException.sql';
go