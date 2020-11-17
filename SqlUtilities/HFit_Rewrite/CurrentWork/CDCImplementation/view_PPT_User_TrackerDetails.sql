
-- use KenticoCMS_DataMart_2
GO
PRINT 'Executing view_PPT_User_TrackerDetails.sql';
GO
IF EXISTS (SELECT
                  name
           FROM sys.views
           WHERE
                  name = 'view_PPT_User_TrackerDetails') 
    BEGIN
        DROP VIEW
             view_PPT_User_TrackerDetails
    END;
GO

CREATE VIEW view_PPT_User_TrackerDetails
AS SELECT
          BASE_hfit_PPTEligibility.LastName + ', ' + BASE_hfit_PPTEligibility.FirstName + ' ' + BASE_hfit_PPTEligibility.MiddleInit AS FullName
        , BASE_hfit_PPTEligibility.LastName
        , BASE_hfit_PPTEligibility.FirstName
        , BASE_hfit_PPTEligibility.MiddleInit
        , BASE_hfit_PPTEligibility.BirthDate
        , BASE_hfit_PPTEligibility.Gender
        , BASE_hfit_PPTEligibility.City
        , BASE_hfit_PPTEligibility.State
        , BASE_hfit_PPTEligibility.PostalCode
        , BASE_hfit_PPTEligibility.DepartmentName
        , BASE_hfit_PPTEligibility.DepartmentCd
        , FACT_EDW_TrackerCompositeDetails.TrackerNameAggregateTable
        , FACT_EDW_TrackerCompositeDetails.ItemID
        , FACT_EDW_TrackerCompositeDetails.EventDate
        , FACT_EDW_TrackerCompositeDetails.IsProfessionallyCollected
        , FACT_EDW_TrackerCompositeDetails.TrackerCollectionSourceID
        , FACT_EDW_TrackerCompositeDetails.EventName
        , FACT_EDW_TrackerCompositeDetails.UOM
        , FACT_EDW_TrackerCompositeDetails.KEY1
        , FACT_EDW_TrackerCompositeDetails.VAL1
        , FACT_EDW_TrackerCompositeDetails.KEY2
        , FACT_EDW_TrackerCompositeDetails.VAL2
        , FACT_EDW_TrackerCompositeDetails.KEY3
        , FACT_EDW_TrackerCompositeDetails.VAL3
        , FACT_EDW_TrackerCompositeDetails.KEY4
        , FACT_EDW_TrackerCompositeDetails.VAL4
        , FACT_EDW_TrackerCompositeDetails.KEY5
        , FACT_EDW_TrackerCompositeDetails.VAL5
        , FACT_EDW_TrackerCompositeDetails.KEY6
        , FACT_EDW_TrackerCompositeDetails.VAL6
        , FACT_EDW_TrackerCompositeDetails.KEY7
        , FACT_EDW_TrackerCompositeDetails.VAL7
        , FACT_EDW_TrackerCompositeDetails.KEY8
        , FACT_EDW_TrackerCompositeDetails.VAL8
        , FACT_EDW_TrackerCompositeDetails.KEY9
        , FACT_EDW_TrackerCompositeDetails.VAL9
        , FACT_EDW_TrackerCompositeDetails.KEY10
        , FACT_EDW_TrackerCompositeDetails.VAL10
        , FACT_EDW_TrackerCompositeDetails.ItemCreatedWhen
        , FACT_EDW_TrackerCompositeDetails.TXTKEY1
        , FACT_EDW_TrackerCompositeDetails.TXTVAL1
        , FACT_EDW_TrackerCompositeDetails.TXTKEY2
        , FACT_EDW_TrackerCompositeDetails.TXTVAL2
        , FACT_EDW_TrackerCompositeDetails.TXTKEY3
        , FACT_EDW_TrackerCompositeDetails.TXTVAL3
        , FACT_EDW_TrackerCompositeDetails.MPI
        , FACT_EDW_TrackerCompositeDetails.SiteGUID
        , FACT_EDW_TrackerCompositeDetails.VendorID
        , FACT_EDW_TrackerCompositeDetails.VendorName
        , FACT_EDW_TrackerCompositeDetails.IsCustom
        , FACT_EDW_TrackerCompositeDetails.AccountCD
        , FACT_EDW_TrackerCompositeDetails.DBNAME
        , FACT_EDW_TrackerCompositeDetails.SVR
        , FACT_EDW_TrackerCompositeDetails.UserID
   FROM
        BASE_hfit_PPTEligibility
        INNER JOIN FACT_EDW_TrackerCompositeDetails
        ON
          BASE_hfit_PPTEligibility.SVR = FACT_EDW_TrackerCompositeDetails.SVR AND
          BASE_hfit_PPTEligibility.UserID = FACT_EDW_TrackerCompositeDetails.UserID AND
          BASE_hfit_PPTEligibility.DBNAME = FACT_EDW_TrackerCompositeDetails.DBNAME;
GO
PRINT 'Executed view_PPT_User_TrackerDetails.sql';
GO
