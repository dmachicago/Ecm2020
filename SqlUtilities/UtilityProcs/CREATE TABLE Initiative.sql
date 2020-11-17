
CREATE TABLE Initiative(
    InitCode    nvarchar(25)      NOT NULL,
    Initdesc    nvarchar(2000)    NULL,
    CONSTRAINT PK_Initiative PRIMARY KEY CLUSTERED (InitCode)
)
go

CREATE TABLE Plan(
    InitCode              nvarchar(25)    NOT NULL,
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
    CONSTRAINT PK_Plan PRIMARY KEY NONCLUSTERED (InitCode, PlanYear)
)
go

ALTER TABLE Plan ADD CONSTRAINT RefInitiative9 
    FOREIGN KEY (InitCode)
    REFERENCES Initiative(InitCode) ON DELETE CASCADE ON UPDATE CASCADE
go


CREATE PROCEDURE InitiativeInsProc
(
    @InitCode     nvarchar(25),
    @Initdesc     nvarchar(2000)            = NULL)
AS
BEGIN
    BEGIN TRAN

    INSERT INTO Initiative(InitCode,
                           Initdesc)
    VALUES(@InitCode,
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

CREATE PROCEDURE InitiativeUpdProc
(
    @InitCode     nvarchar(25),
    @Initdesc     nvarchar(2000)            = NULL)
AS
BEGIN
    BEGIN TRAN

    UPDATE Initiative
       SET Initdesc      = @Initdesc
     WHERE InitCode = @InitCode

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

CREATE PROCEDURE InitiativeDelProc
(
    @InitCode     nvarchar(25))
AS
BEGIN
    BEGIN TRAN

    DELETE
      FROM Initiative
     WHERE InitCode = @InitCode

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

CREATE PROCEDURE InitiativeSelProc
(
    @InitCode     nvarchar(25))
AS
BEGIN
    SELECT InitCode,
           Initdesc
      FROM Initiative
     WHERE InitCode = @InitCode

    RETURN(0)
END
go

CREATE PROCEDURE PlanInsProc
(
    @InitCode               nvarchar(25),
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

    INSERT INTO Plan(InitCode,
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
    VALUES(@InitCode,
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
        RAISERROR  20000 'PlanInsProc: Cannot insert because primary key value not found in Plan '
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

END
go

CREATE PROCEDURE PlanUpdProc
(
    @InitCode               nvarchar(25),
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

    UPDATE Plan
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
     WHERE InitCode = @InitCode
       AND PlanYear = @PlanYear

    IF (@@error!=0)
    BEGIN
        RAISERROR  20001 'PlanUpdProc: Cannot update  in Plan '
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

    RETURN(0)
END
go

CREATE PROCEDURE PlanUpdProcMonthPlan
(
    @InitCode               nvarchar(25),
    @PlanYear               int,
    @MonthNbr               int,
    @Amt					Money)
AS
BEGIN
    BEGIN TRAN
	IF @MonthNbr = 1
	BEGIN
		UPDATE Plan
		   SET January_Plan            = @Amt	   
		 WHERE InitCode = @InitCode
		   AND PlanYear = @PlanYear
	End
	IF @MonthNbr = 2
	BEGIN
		UPDATE Plan
		   SET Februrary_Plan          = @Amt			   
		 WHERE InitCode = @InitCode
		   AND PlanYear = @PlanYear
	EndIF @MonthNbr = 3
	BEGIN
		UPDATE Plan
		   SET March_Plan              = @Amt			  
		 WHERE InitCode = @InitCode
		   AND PlanYear = @PlanYear
	End
	IF @MonthNbr = 4
	BEGIN
		UPDATE Plan
		   SET April_Plan              = @Amt			   
		 WHERE InitCode = @InitCode
		   AND PlanYear = @PlanYear
	End
	IF @MonthNbr = 5
	BEGIN
		UPDATE Plan
		   SET May_Plan                = @Amt			   
		 WHERE InitCode = @InitCode
		   AND PlanYear = @PlanYear
	End
	IF @MonthNbr = 6
	BEGIN
		UPDATE Plan
		   SET June_Plan               = @Amt			   
		 WHERE InitCode = @InitCode
		   AND PlanYear = @PlanYear
	End
	IF @MonthNbr = 7
	BEGIN
		UPDATE Plan
		   SET July_Plan               = @Amt
		 WHERE InitCode = @InitCode
		   AND PlanYear = @PlanYear
	End
	IF @MonthNbr = 8
	BEGIN
		UPDATE Plan
		   SET August_Plan             = @Amt
		 WHERE InitCode = @InitCode
		   AND PlanYear = @PlanYear
	End
	IF @MonthNbr = 9
	BEGIN
		UPDATE Plan
		   SET September_Plan          = @Amt
		 WHERE InitCode = @InitCode
		   AND PlanYear = @PlanYear
	End
	IF @MonthNbr = 10
	BEGIN
		UPDATE Plan
		   SET October_Plan            = @Amt
		 WHERE InitCode = @InitCode
		   AND PlanYear = @PlanYear
	End
	IF @MonthNbr = 11
	BEGIN
		UPDATE Plan
		   SET November_Plan           = @Amt
		 WHERE InitCode = @InitCode
		   AND PlanYear = @PlanYear
	End
	IF @MonthNbr = 12
	BEGIN
		UPDATE Plan
		   SET December_Plan           = @Amt
		 WHERE InitCode = @InitCode
		   AND PlanYear = @PlanYear
	End
    
    IF (@@error!=0)
    BEGIN
        RAISERROR  20001 'PlanUpdProcMonthPlan: Cannot update  in Plan '
        ROLLBACK TRAN
        RETURN(1)    
    END

    COMMIT TRAN

    RETURN(0)
END
go

CREATE PROCEDURE PlanUpdProcMonthActual
(
    @InitCode               nvarchar(25),
    @PlanYear               int,
    @MonthNbr               int,
    @Amt					Money)
AS
BEGIN
    BEGIN TRAN
	IF @MonthNbr = 1
	BEGIN
		UPDATE Plan
			   January_Actual          = @Amt			   
		 WHERE InitCode = @InitCode
		   AND PlanYear = @PlanYear
	End
	IF @MonthNbr = 2
	BEGIN
		UPDATE Plan
		   SET Februrary_Actual          = @Amt			   
		 WHERE InitCode = @InitCode
		   AND PlanYear = @PlanYear
	EndIF @MonthNbr = 3
	BEGIN
		UPDATE Plan
		   SET March_Actual              = @Amt			  
		 WHERE InitCode = @InitCode
		   AND PlanYear = @PlanYear
	End
	IF @MonthNbr = 4
	BEGIN
		UPDATE Plan
		   SET April_Actual              = @Amt			   
		 WHERE InitCode = @InitCode
		   AND PlanYear = @PlanYear
	End
	IF @MonthNbr = 5
	BEGIN
		UPDATE Plan
		   SET May_Actual                = @Amt			   
		 WHERE InitCode = @InitCode
		   AND PlanYear = @PlanYear
	End
	IF @MonthNbr = 6
	BEGIN
		UPDATE Plan
		   SET June_Actual               = @Amt			   
		 WHERE InitCode = @InitCode
		   AND PlanYear = @PlanYear
	End
	IF @MonthNbr = 7
	BEGIN
		UPDATE Plan
		   SET July_Actual               = @Amt
		 WHERE InitCode = @InitCode
		   AND PlanYear = @PlanYear
	End
	IF @MonthNbr = 8
	BEGIN
		UPDATE Plan
		   SET August_Actual             = @Amt
		 WHERE InitCode = @InitCode
		   AND PlanYear = @PlanYear
	End
	IF @MonthNbr = 9
	BEGIN
		UPDATE Plan
		   SET September_Actual          = @Amt
		 WHERE InitCode = @InitCode
		   AND PlanYear = @PlanYear
	End
	IF @MonthNbr = 10
	BEGIN
		UPDATE Plan
		   SET October_Actual            = @Amt
		 WHERE InitCode = @InitCode
		   AND PlanYear = @PlanYear
	End
	IF @MonthNbr = 11
	BEGIN
		UPDATE Plan
		   SET November_Actual           = @Amt
		 WHERE InitCode = @InitCode
		   AND PlanYear = @PlanYear
	End
	IF @MonthNbr = 12
	BEGIN
		UPDATE Plan
		   SET December_Actual           = @Amt
		 WHERE InitCode = @InitCode
		   AND PlanYear = @PlanYear
	End
    
    IF (@@error!=0)
    BEGIN
        RAISERROR  20001 'PlanUpdProcMonthActual: Cannot update  in Plan '
        ROLLBACK TRAN
        RETURN(1)    
    END

    COMMIT TRAN

    RETURN(0)
END
go

CREATE PROCEDURE PlanDelProc
(
    @InitCode               nvarchar(25),
    @PlanYear               int)
AS
BEGIN
    BEGIN TRAN

    DELETE
      FROM Plan
     WHERE InitCode = @InitCode
       AND PlanYear = @PlanYear

    IF (@@error!=0)
    BEGIN
        RAISERROR  20002 'PlanDelProc: Cannot delete because foreign keys still exist in Plan '
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

    RETURN(0)
END
go

CREATE PROCEDURE PlanSelProc
(
    @InitCode               nvarchar(25),
    @PlanYear               int)
AS
BEGIN
    SELECT InitCode,
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
      FROM Plan
     WHERE InitCode = @InitCode
       AND PlanYear = @PlanYear
    RETURN(0)
END
go


CREATE TRIGGER CalculateActual
ON Plan
AFTER INSERT or AFTER Update
AS
BEGIN
UPDATE Plan
SET TotalActual = 
    January_Actual         +
    Februrary_Actual       +
    March_Actual           +
    April_Actual           +
    May_Actual             +
    June_Actual            +
    July_Actual            +
    August_Actual          +
    September_Actual       +
    October_Actual         +
    November_Actual        +
    December_Actual
FROM Plan, inserted
WHERE Plan.Initcode = Plan.Initcode
	AND Plan.PlanYear = Plan.PlanYear
END

CREATE TRIGGER CalculatePlan
ON Plan
AFTER INSERT or AFTER Update
AS
BEGIN
UPDATE Plan
SET TotalProjectedPlan = 
	January_Plan           +
    Februrary_Plan         +
    March_Plan             +
    April_Plan             +
    May_Plan               +
    June_Plan              +
    July_Plan              +
    August_Plan            +
    September_Plan         +
    October_Plan           +
    November_Plan          +
    December_Plan    
FROM Plan, inserted
WHERE Plan.Initcode = Plan.Initcode
	AND Plan.PlanYear = Plan.PlanYear
END
