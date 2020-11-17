
declare
 @EventID as nvarchar(50) = '54289254' 
, @EventDate as datetime = '04.30.2015'
, @ExpireDate as datetime = getdate() + 90
, @EventTitle as nvarchar(100) = 'This is the EVENT Title'
, @EventIntroParagraph as nvarchar(1000) = ''

, @EventWriteUp as nvarchar(4000) = ''		   --The WriteUp is unlimited in size.
, @EventCenterID as nvarchar(50) = '00239'
, @EventCenterID as nvarchar(50) = '00239'

, @ShowDate as datetime = '03.30.2015'	    --This is the date to start showing the EVENT promo material
, @EventImage as nvarchar(1000) = ''
, @LiveEvent as bit = 0 
, @OrigDate as datetime = getdate()
, @ClassID as nvarchar(50) = 'resserver'    --The classification ID
, @OnDemand as bit = 0 
, @StreamingEvent as bit = 0 
, @RecordedDate as datetime =  = '03.30.2015'	    --the date the event was recorded
, @LatModDate as datetime = getdate()
, @Comment as nvarchar(2000) = '' 
, @OriginalData as datetime = getdate()
, @ViewingCost as decimal = 4.95
, @HighLiteThisEvent as bit = 1 
, @EventExpired as bit = 0 
, @TotalShowings as int = 0 
, @PrivateVideo as bit = 0 
, @NotAvailable as bit = 0 
, @EventURL as nvarchar(1000) = 'xxx@yy.com'
, @ClipURL as nvarchar(1000) = 'xxx@yy.com'
, @ImageURL as nvarchar(1000) = 'xxx@yy.com'
, @BackBone as nvarchar(50) = 'USTREAM'
, @UstreamID as nvarchar(50) = 'xxxxx' ;

--COUPON STUFF
declare @CouponEmailAddr as nvarchar(200) = 'xx@yy.com' ;
declare @Description as nvarchar(500) = 'Test Coupon for Ustream' ;
declare @AssignedByEmailAddr as nvarchar(100) = 'dm@dmachicago.com' ;

declare @CouponID as nvarchar(50) = 'DMA001' ;
declare @CPID as nvarchar(50) = 'DMA' ;


declare @CreationDate as datetime = getdate() ;
declare @CreateDate as datetime = getdate() ;
declare @ActivationDate as datetime = getdate()-1 ;
declare @LastModDate as datetime = getdate() ;
declare @Amt as decimal = 4.95 ;
declare @NbrRedemptions as int = 0 ; 
declare @PromoGlobal as bit = 0 ; 
declare @PromoEvent as bit = 0 ; 
declare @MaxAllocation as int = 5000 ;
declare @NotifiedByEmail as bit = 1 ;	--Notify this person by email that the coupon is available.

INSERT INTO TicketWitch.dbo.Event (EventID
                     , EventDate
                     , EventTitle
                     , EventIntroParagraph
                     , EventWriteUp
                     , LastModDate
                     , CreateDate
                     , EventCenterID
                     , ShowDate
                     , RowIdentifier
                     , IDGUID
                     , EventImage
                     , LiveEvent
                     , OrigDate
                     , ClassID
                     , OnDemand
                     , StreamingEvent
                     , RecordedDate
                     , LatModDate
                     , Comment
                     , OriginalData
                     , ViewingCost
                     , HighLiteThisEvent
                     , EventExpired
                     , TotalShowings
                     , [ExpireDate]
                     , PrivateVideo
                     , NotAvailable
                     , EventURL
                     , ClipURL
                     , ImageURL
                     , BackBone
                     , UstreamID) 
VALUES

       (@EventID
       , @EventDate
       , @EventTitle
       , @EventIntroParagraph
       , @EventWriteUp
       , @LastModDate
       , @CreateDate
       , @EventCenterID
       , @ShowDate
       , NEWID () 
       , NEWID () 
       , @EventImage
       , @LiveEvent
       , @OrigDate
       , N'resserver'
       , @OnDemand
       , @StreamingEvent
       , @RecordedDate
       , GETDATE () 
       , @Comment
       , NULL
       , @ViewingCost
       , @HighLiteThisEvent
       , @EventExpired
       , @TotalShowings
       , @ExpireDate
       , @PrivateVideo
       , @NotAvailable
       , @EventURL
       , @ClipURL
       , @ImageURL
       , @BackBone
       , @EventID
       );


INSERT INTO [CCInfo].dbo.CouponDetail
(CPID
, PublicCoupon
, CouponID
, [Description]
, CreationDate
, ActivationDate
, [ExpireDate]
, CreateDate
, LastModDate
, Amt
, NbrRedemptions
, PromoGlobal
, PromoEvent
, EventID
, MaxAllocation) 
VALUES
       (@CPID
       , 0
       , @CouponID
       , @Description
       , @CreationDate
       , @ActivationDate
       , @ExpireDate
       , @CreateDate
       , @LastModDate
       , 4.95
       , 0
       , 0
       , 1
       , @EventID
       , 5000) ;

INSERT INTO [CCInfo].dbo.CouponPromoAssignment
(EmailAddr
, CouponID
, AssignedByEmailAddr
, GlobalPromo
, EventPromo
, EventID
, CouponRedemmed
, [ExpireDate]
, DateUsed
, OpenViewing
, MaxViews
, ViewCnt
, NotifiedByEmail) 
VALUES
       (@CouponEmailAddr
       , @CouponID
       , @AssignedByEmailAddr
       , @GlobalPromo
       , @EventPromo
       , @EventID
       , 0
       , @ExpireDate
       , NULL
       , @OpenViewing
       , @MaxViews
       , 0
       , @NotifiedByEmail) ;
GO

