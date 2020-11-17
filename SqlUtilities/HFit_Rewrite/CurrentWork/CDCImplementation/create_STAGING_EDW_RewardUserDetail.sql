

GO

PRINT 'FROM: DIM_EDW_RewardUserDetail.sql';
PRINT GETDATE () ;
PRINT 'creating DIM_EDW_RewardUserDetail.sql';
GO

IF  EXISTS (SELECT
                   name
                   FROM sys.tables
              WHERE name = 'DIM_EDW_RewardUserDetail') 
    BEGIN
        PRINT 'Dropping DIM_EDW_RewardUserDetail';
        DROP TABLE
             DIM_EDW_RewardUserDetail;
    END;
GO
PRINT 'POPULATING DIM_EDW_RewardUserDetail with first load';
PRINT GETDATE () ;
GO
SELECT
       *
INTO
     DIM_EDW_RewardUserDetail
       FROM view_EDW_RewardUserDetail;

ALTER TABLE DIM_EDW_RewardUserDetail
ADD
            LastModifiedDate datetime2 (7) NULL;
ALTER TABLE DIM_EDW_RewardUserDetail
ADD
            RowNbr int IDENTITY (1, 1) ;

SET ANSI_PADDING ON;
GO
PRINT 'POPULATED DIM_EDW_RewardUserDetail with first load';
PRINT GETDATE () ;
PRINT 'Creating PI indexes';
GO

CREATE CLUSTERED INDEX PI_EDW_RewardUserDetail ON dbo.DIM_EDW_RewardUserDetail
(
UserGUID ASC,
AccountID ASC,
AccountCD ASC,
SiteGUID ASC,
HFitUserMpiNumber ASC,
RewardActivityGUID ASC,
RewardTriggerGUID ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ;

CREATE NONCLUSTERED INDEX PI_EDW_RewardUserDetail_RowNbrCDate ON dbo.DIM_EDW_RewardUserDetail
(
RowNbr, LastModifiedDate, DeletedFlg
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ;

GO
PRINT 'Created PI indexes';
PRINT GETDATE () ;
GO

PRINT 'created DIM_EDW_RewardUserDetail.sql';
PRINT GETDATE () ;

GO


