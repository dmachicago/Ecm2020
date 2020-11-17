Use Smart
go

IF OBJECT_ID('Initiative') IS NOT NULL
BEGIN
    DROP TABLE Initiative
    PRINT '<<< DROPPED TABLE Initiative >>>'
END
go
IF OBJECT_ID('PlanGoal') IS NOT NULL
BEGIN
    DROP TABLE PlanGoal
    PRINT '<<< DROPPED TABLE PlanGoal >>>'
END
go
/* 
 * TABLE: Initiative 
 */

CREATE TABLE Initiative(
    PartnerName        nvarchar(25)      NOT NULL,
    PartnerDivision    nvarchar(25)      NOT NULL,
    InitCode           nvarchar(50)      NOT NULL,
    Initdesc           nvarchar(2000)    NULL,
    CONSTRAINT PK_Initiative PRIMARY KEY CLUSTERED (InitCode, PartnerName, PartnerDivision)
)
go



IF OBJECT_ID('Initiative') IS NOT NULL
    PRINT '<<< CREATED TABLE Initiative >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE Initiative >>>'
go

/* 
 * TABLE: PlanGoal 
 */

CREATE TABLE PlanGoal(
    PartnerName           nvarchar(25)    NOT NULL,
    PartnerDivision       nvarchar(25)    NOT NULL,
    InitCode              nvarchar(50)    NOT NULL,
    PlanYear              int             NOT NULL,
    January_Plan          money           NULL,
    January_Actual        money           NULL,
    Februrary_Plan        money           NULL,
    Februrary_Actual      money           NULL,
    March_Plan            money           NULL,
    March_Actual          money           NULL,
    April_Plan            money           NULL,
    April_Actual          money           NULL,
    May_Plan              money           NULL,
    May_Actual            money           NULL,
    June_Plan             money           NULL,
    June_Actual           money           NULL,
    July_Plan             money           NULL,
    July_Actual           money           NULL,
    August_Plan           money           NULL,
    August_Actual         money           NULL,
    September_Plan        money           NULL,
    September_Actual      money           NULL,
    October_Plan          money           NULL,
    October_Actual        money           NULL,
    November_Plan         money           NULL,
    November_Actual       money           NULL,
    December_Plan         money           NULL,
    December_Actual       money           NULL,
    TotalProjectedPlan    money           NULL,
    TotalActual           money           NULL,
    CONSTRAINT PK_Plan PRIMARY KEY NONCLUSTERED (InitCode, PlanYear, PartnerName, PartnerDivision)
)
go



IF OBJECT_ID('PlanGoal') IS NOT NULL
    PRINT '<<< CREATED TABLE PlanGoal >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE PlanGoal >>>'
go

/* 
 * TABLE: PlanGoal 
 */

ALTER TABLE PlanGoal ADD CONSTRAINT RefInitiative9 
    FOREIGN KEY (InitCode, PartnerName, PartnerDivision)
    REFERENCES Initiative(InitCode, PartnerName, PartnerDivision) ON DELETE CASCADE ON UPDATE CASCADE
go


/* 
 * PROCEDURE: InitiativeInsProc 
 */

CREATE PROCEDURE InitiativeInsProc
(
    @PartnerName         nvarchar(25),
    @PartnerDivision     nvarchar(25),
    @InitCode            nvarchar(50),
    @Initdesc            nvarchar(2000)            = NULL)
AS
BEGIN
    BEGIN TRAN

    INSERT INTO Initiative(PartnerName,
                           PartnerDivision,
                           InitCode,
                           Initdesc)
    VALUES(@PartnerName,
           @PartnerDivision,
           @InitCode,
           @Initdesc)

    IF (@@error!=0)
    BEGIN
        RAISERROR  20000 'InitiativeInsProc: Cannot insert because primary key value not found in Initiative '
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

END
go
IF OBJECT_ID('InitiativeInsProc') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE InitiativeInsProc >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE InitiativeInsProc >>>'
go


/* 
 * PROCEDURE: InitiativeUpdProc 
 */

CREATE PROCEDURE InitiativeUpdProc
(
    @PartnerName         nvarchar(25),
    @PartnerDivision     nvarchar(25),
    @InitCode            nvarchar(50),
    @Initdesc            nvarchar(2000)            = NULL)
AS
BEGIN
    BEGIN TRAN

    UPDATE Initiative
       SET Initdesc             = @Initdesc
     WHERE PartnerName     = @PartnerName
       AND PartnerDivision = @PartnerDivision
       AND InitCode        = @InitCode

    IF (@@error!=0)
    BEGIN
        RAISERROR  20001 'InitiativeUpdProc: Cannot update  in Initiative '
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

    RETURN(0)
END
go
IF OBJECT_ID('InitiativeUpdProc') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE InitiativeUpdProc >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE InitiativeUpdProc >>>'
go


/* 
 * PROCEDURE: InitiativeDelProc 
 */

CREATE PROCEDURE InitiativeDelProc
(
    @PartnerName         nvarchar(25),
    @PartnerDivision     nvarchar(25),
    @InitCode            nvarchar(50))
AS
BEGIN
    BEGIN TRAN

    DELETE
      FROM Initiative
     WHERE PartnerName     = @PartnerName
       AND PartnerDivision = @PartnerDivision
       AND InitCode        = @InitCode

    IF (@@error!=0)
    BEGIN
        RAISERROR  20002 'InitiativeDelProc: Cannot delete because foreign keys still exist in Initiative '
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

    RETURN(0)
END
go
IF OBJECT_ID('InitiativeDelProc') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE InitiativeDelProc >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE InitiativeDelProc >>>'
go


/* 
 * PROCEDURE: InitiativeSelProc 
 */

CREATE PROCEDURE InitiativeSelProc
(
    @PartnerName         nvarchar(25),
    @PartnerDivision     nvarchar(25),
    @InitCode            nvarchar(50))
AS
BEGIN
    SELECT PartnerName,
           PartnerDivision,
           InitCode,
           Initdesc
      FROM Initiative
     WHERE PartnerName     = @PartnerName
       AND PartnerDivision = @PartnerDivision
       AND InitCode        = @InitCode

    RETURN(0)
END
go
IF OBJECT_ID('InitiativeSelProc') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE InitiativeSelProc >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE InitiativeSelProc >>>'
go


/* 
 * PROCEDURE: PlanGoalInsProc 
 */

CREATE PROCEDURE PlanGoalInsProc
(
    @PartnerName            nvarchar(25),
    @PartnerDivision        nvarchar(25),
    @InitCode               nvarchar(50),
    @PlanYear               int,
    @January_Plan           money                   = NULL,
    @January_Actual         money                   = NULL,
    @Februrary_Plan         money                   = NULL,
    @Februrary_Actual       money                   = NULL,
    @March_Plan             money                   = NULL,
    @March_Actual           money                   = NULL,
    @April_Plan             money                   = NULL,
    @April_Actual           money                   = NULL,
    @May_Plan               money                   = NULL,
    @May_Actual             money                   = NULL,
    @June_Plan              money                   = NULL,
    @June_Actual            money                   = NULL,
    @July_Plan              money                   = NULL,
    @July_Actual            money                   = NULL,
    @August_Plan            money                   = NULL,
    @August_Actual          money                   = NULL,
    @September_Plan         money                   = NULL,
    @September_Actual       money                   = NULL,
    @October_Plan           money                   = NULL,
    @October_Actual         money                   = NULL,
    @November_Plan          money                   = NULL,
    @November_Actual        money                   = NULL,
    @December_Plan          money                   = NULL,
    @December_Actual        money                   = NULL,
    @TotalProjectedPlan     money                   = NULL,
    @TotalActual            money                   = NULL)
AS
BEGIN
    BEGIN TRAN

    INSERT INTO PlanGoal(PartnerName,
                         PartnerDivision,
                         InitCode,
                         PlanYear,
                         January_Plan,
                         January_Actual,
                         Februrary_Plan,
                         Februrary_Actual,
                         March_Plan,
                         March_Actual,
                         April_Plan,
                         April_Actual,
                         May_Plan,
                         May_Actual,
                         June_Plan,
                         June_Actual,
                         July_Plan,
                         July_Actual,
                         August_Plan,
                         August_Actual,
                         September_Plan,
                         September_Actual,
                         October_Plan,
                         October_Actual,
                         November_Plan,
                         November_Actual,
                         December_Plan,
                         December_Actual,
                         TotalProjectedPlan,
                         TotalActual)
    VALUES(@PartnerName,
           @PartnerDivision,
           @InitCode,
           @PlanYear,
           @January_Plan,
           @January_Actual,
           @Februrary_Plan,
           @Februrary_Actual,
           @March_Plan,
           @March_Actual,
           @April_Plan,
           @April_Actual,
           @May_Plan,
           @May_Actual,
           @June_Plan,
           @June_Actual,
           @July_Plan,
           @July_Actual,
           @August_Plan,
           @August_Actual,
           @September_Plan,
           @September_Actual,
           @October_Plan,
           @October_Actual,
           @November_Plan,
           @November_Actual,
           @December_Plan,
           @December_Actual,
           @TotalProjectedPlan,
           @TotalActual)

    IF (@@error!=0)
    BEGIN
        RAISERROR  20000 'PlanGoalInsProc: Cannot insert because primary key value not found in PlanGoal '
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

END
go
IF OBJECT_ID('PlanGoalInsProc') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE PlanGoalInsProc >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE PlanGoalInsProc >>>'
go


/* 
 * PROCEDURE: PlanGoalUpdProc 
 */

CREATE PROCEDURE PlanGoalUpdProc
(
    @PartnerName            nvarchar(25),
    @PartnerDivision        nvarchar(25),
    @InitCode               nvarchar(50),
    @PlanYear               int,
    @January_Plan           money                   = NULL,
    @January_Actual         money                   = NULL,
    @Februrary_Plan         money                   = NULL,
    @Februrary_Actual       money                   = NULL,
    @March_Plan             money                   = NULL,
    @March_Actual           money                   = NULL,
    @April_Plan             money                   = NULL,
    @April_Actual           money                   = NULL,
    @May_Plan               money                   = NULL,
    @May_Actual             money                   = NULL,
    @June_Plan              money                   = NULL,
    @June_Actual            money                   = NULL,
    @July_Plan              money                   = NULL,
    @July_Actual            money                   = NULL,
    @August_Plan            money                   = NULL,
    @August_Actual          money                   = NULL,
    @September_Plan         money                   = NULL,
    @September_Actual       money                   = NULL,
    @October_Plan           money                   = NULL,
    @October_Actual         money                   = NULL,
    @November_Plan          money                   = NULL,
    @November_Actual        money                   = NULL,
    @December_Plan          money                   = NULL,
    @December_Actual        money                   = NULL,
    @TotalProjectedPlan     money                   = NULL,
    @TotalActual            money                   = NULL)
AS
BEGIN
    BEGIN TRAN

    UPDATE PlanGoal
       SET January_Plan            = @January_Plan,
           January_Actual          = @January_Actual,
           Februrary_Plan          = @Februrary_Plan,
           Februrary_Actual        = @Februrary_Actual,
           March_Plan              = @March_Plan,
           March_Actual            = @March_Actual,
           April_Plan              = @April_Plan,
           April_Actual            = @April_Actual,
           May_Plan                = @May_Plan,
           May_Actual              = @May_Actual,
           June_Plan               = @June_Plan,
           June_Actual             = @June_Actual,
           July_Plan               = @July_Plan,
           July_Actual             = @July_Actual,
           August_Plan             = @August_Plan,
           August_Actual           = @August_Actual,
           September_Plan          = @September_Plan,
           September_Actual        = @September_Actual,
           October_Plan            = @October_Plan,
           October_Actual          = @October_Actual,
           November_Plan           = @November_Plan,
           November_Actual         = @November_Actual,
           December_Plan           = @December_Plan,
           December_Actual         = @December_Actual,
           TotalProjectedPlan      = @TotalProjectedPlan,
           TotalActual             = @TotalActual
     WHERE PartnerName     = @PartnerName
       AND PartnerDivision = @PartnerDivision
       AND InitCode        = @InitCode
       AND PlanYear        = @PlanYear

    IF (@@error!=0)
    BEGIN
        RAISERROR  20001 'PlanGoalUpdProc: Cannot update  in PlanGoal '
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

    RETURN(0)
END
go
IF OBJECT_ID('PlanGoalUpdProc') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE PlanGoalUpdProc >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE PlanGoalUpdProc >>>'
go


/* 
 * PROCEDURE: PlanGoalDelProc 
 */

CREATE PROCEDURE PlanGoalDelProc
(
    @PartnerName            nvarchar(25),
    @PartnerDivision        nvarchar(25),
    @InitCode               nvarchar(50),
    @PlanYear               int)
AS
BEGIN
    BEGIN TRAN

    DELETE
      FROM PlanGoal
     WHERE PartnerName     = @PartnerName
       AND PartnerDivision = @PartnerDivision
       AND InitCode        = @InitCode
       AND PlanYear        = @PlanYear

    IF (@@error!=0)
    BEGIN
        RAISERROR  20002 'PlanGoalDelProc: Cannot delete because foreign keys still exist in PlanGoal '
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

    RETURN(0)
END
go
IF OBJECT_ID('PlanGoalDelProc') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE PlanGoalDelProc >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE PlanGoalDelProc >>>'
go


/* 
 * PROCEDURE: PlanGoalSelProc 
 */

CREATE PROCEDURE PlanGoalSelProc
(
    @PartnerName            nvarchar(25),
    @PartnerDivision        nvarchar(25),
    @InitCode               nvarchar(50),
    @PlanYear               int)
AS
BEGIN
    SELECT PartnerName,
           PartnerDivision,
           InitCode,
           PlanYear,
           January_Plan,
           January_Actual,
           Februrary_Plan,
           Februrary_Actual,
           March_Plan,
           March_Actual,
           April_Plan,
           April_Actual,
           May_Plan,
           May_Actual,
           June_Plan,
           June_Actual,
           July_Plan,
           July_Actual,
           August_Plan,
           August_Actual,
           September_Plan,
           September_Actual,
           October_Plan,
           October_Actual,
           November_Plan,
           November_Actual,
           December_Plan,
           December_Actual,
           TotalProjectedPlan,
           TotalActual
      FROM PlanGoal
     WHERE PartnerName     = @PartnerName
       AND PartnerDivision = @PartnerDivision
       AND InitCode        = @InitCode
       AND PlanYear        = @PlanYear

    RETURN(0)
END
go
IF OBJECT_ID('PlanGoalSelProc') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE PlanGoalSelProc >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE PlanGoalSelProc >>>'
go


