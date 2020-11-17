use TIcketWitch
go

INSERT INTO [dbo].[Event] ([EventID], [EventDate], [EventTitle], [EventIntroParagraph], [EventWriteUp], [LastModDate], [CreateDate], [EventCenterID], [ShowDate], [RowIdentifier], [IDGUID], [EventImage], [LiveEvent], [OrigDate], [ClassID], [OnDemand], [StreamingEvent], [RecordedDate], [LatModDate], [Comment], [OriginalData], [ViewingCost], [HighLiteThisEvent], [EventExpired], [TotalShowings], [ExpireDate], [PrivateVideo], [NotAvailable], [EventURL], [ClipURL], [ImageURL], [BackBone], [UstreamID]) VALUES 

(N'18797462'
, getdate()
,N'Universal Stremaing Network Redirect'
,N'Universal Stremaing Network Test'
,N'Universal Stremaing Network is the new sleeping giant of streaming'
,getdate()
,getdate()
, N'00239'
,getdate()
,newid()
,newid()
, NULL
, 1
, '20140904 00:00:00.000'
, N'resserver'
, 1
, 0
, '30140204 00:00:00.000'
, getdate()
, N'L1'
, NULL
, 4.95
, 1
, 0
, 0
, NULL
, 0
, 0
, NULL
, NULL
, NULL
, N'USTREAM'
, N'18797462'
)

USE [CCInfo]
GO

INSERT INTO [dbo].[CouponDetail]
           ([CPID]
           ,[PublicCoupon]
           ,[CouponID]
           ,[Description]
           ,[CreationDate]
           ,[ActivationDate]
           ,[ExpireDate]
           ,[CreateDate]
           ,[LastModDate]
           ,[Amt]
           ,[NbrRedemptions]
           ,[PromoGlobal]
           ,[PromoEvent]
           ,[EventID]
           ,[MaxAllocation])
     VALUES
           ('DMA'
           ,0
           ,'DMA001'
           ,'Test Coupon for Ustream'
           ,getdate()
           ,getdate()
           ,getdate() + 90
           ,getdate()
           ,getdate()
           ,4.95
           ,0
           ,0
           ,1
           ,'18797462'
           ,5000)
GO

USE [CCInfo]
GO

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
           ('wdm@dmachicago.com'
           ,'DMA001'
           ,'dm@dmachicago.com'
           ,0
           ,0
           ,'18797462'
           ,0
           ,getdate()+90
           ,null
           ,0
           ,2500
           ,0
           ,1)
GO

