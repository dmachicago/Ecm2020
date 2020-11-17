--select * From [CouponPromoAssignment]

USE [CCInfo]
GO

declare
@EmailAddr as nvarchar(50) = 'xx@yy.com'
           ,@CouponID as nvarchar(50) = 'USN001'
           ,@AssignedByEmailAddr as nvarchar(50) = 'dm@dmachicago.com'
           ,@GlobalPromo as bit = 1 
           ,@EventPromo as bit = 0 
           ,@EventID as nvarchar(50) = '15594931'
           ,@CouponRedemmed as bit = 0 
           ,@ExpireDate as datetime = getdate() + 90
           ,@DateUsed as datetime = null
           ,@OpenViewing as bit = 0
           ,@MaxViews as int = 2
           ,@ViewCnt as int = 0 
           ,@NotifiedByEmail as bit = 0 ;

INSERT INTO [dbo].[CouponPromoAssignment]
           ([EmailAddr]
           ,[CouponID]
           ,[AssignedByEmailAddr]
           ,[GlobalPromo]
           ,[EventPromo]
           ,[EventID]
           ,[CouponRedemmed]
           ,[ExpireDate]
           ,[DateUsed]
           ,[OpenViewing]
           ,[MaxViews]
           ,[ViewCnt]
           ,[NotifiedByEmail])
     VALUES
           ('dpasol@ustream.tv'
           ,'TYSON$1'
           ,'dm@dmachicago.com'
           ,1
           ,0
           ,15594931
           ,0
           ,getdate() + 90
           ,<DateUsed, datetime,>
           ,<OpenViewing, bit,>
           ,<MaxViews, int,>
           ,<ViewCnt, int,>
           ,<NotifiedByEmail, bit,>)
GO


