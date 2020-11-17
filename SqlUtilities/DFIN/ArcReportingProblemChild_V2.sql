

----ALTER DATABASE AW2016 remove FILEGROUP AW2016_mod
--ALTER DATABASE AW2016 ADD FILEGROUP AW2016_mod CONTAINS MEMORY_OPTIMIZED_DATA   
--ALTER DATABASE AW2016 ADD FILE (name = AW2016_mod, filename = 'c:\temp\imoltp_mod1') TO FILEGROUP AW2016_mod   
----ALTER DATABASE AW2016 ADD FILE (name='AW2016_mod', filename='C:\MSSQL\Data\AW2016_mod') TO FILEGROUP [AW2016_mod];
--ALTER DATABASE Showdown SET MEMORY_OPTIMIZED_ELEVATE_TO_SNAPSHOT ON;
--GO

--ALTER DATABASE AW2016 SET MEMORY_OPTIMIZED_ELEVATE_TO_SNAPSHOT=ON  

/*
CREATE TABLE dbo.SalesOrder  
(  
    SalesOrderId   integer        not null  IDENTITY  
        PRIMARY KEY NONCLUSTERED,  
    CustomerId     integer        not null,  
    OrderDate      datetime       not null  
)  
    WITH  
        (MEMORY_OPTIMIZED = ON,  
        DURABILITY = SCHEMA_AND_DATA);  
*/

/*
Indexes can not be added to a CTE. However, in the CTE select adding 
an ORDER BY clause on the joined fields reduced the execution time 
from 20 minutes or more to under 10 seconds. You need to also ADD 
SELECT TOP 100 PERCENT to allow an ORDER BY in a CTE select.

If you have DISTINCT in the CTE then TOP 100 PERCENT doesn't work. This 
cheater method is always available: without needing TOP at all in the 
select, alter the ORDER BY statement to read:
ORDER BY [Blah] OFFSET 0 ROWS

*/

EXEC dbo.gp_InitializeProcedure @ProcedureName = 'gp_GetInputValuesForCalculationEngine',
                                @Description = 'Main stored procedure to retrieve data for calculation sheet calc engine.';
GO
SET ANSI_NULLS ON;
GO
SET QUOTED_IDENTIFIER ON;
GO

ALTER PROCEDURE dbo.gp_GetInputValuesForCalculationEngine
    @ComplexKey INT = NULL,
    @FundKey INT = NULL,
    @AccountPeriodKey INT = NULL,
    @TrialBalanceDefinitionKey INT = NULL,
    @BalanceTypeKey INT = 1,
    @FundRoundingLevel INT,
    @OtherAssetsOnly BIT = NULL,
    @CalculationBatchKey INT = NULL
AS
SET NOCOUNT ON;
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

DECLARE @procedureName NVARCHAR(128)
SET @procedureName = OBJECT_NAME(@@PROCID);

---------------------------------------------------------
--Check to make sure account period is open for this fund
---------------------------------------------------------
IF EXISTS
(
    SELECT 1
    FROM dbo.Fund f
        JOIN dbo.FundGroup fg
            ON fg.PK_FundGroup = f.FK_FundGroup
        JOIN dbo.ComplexAccountPeriod cap
            ON cap.FK_Complex = fg.FK_Complex
    WHERE f.PK_Fund = @FundKey
          AND cap.FK_AccountPeriod = @AccountPeriodKey
          AND cap.AccountPeriodOpen = 0 -- Looking for a closed account period
)
    EXEC dbo.gp_WriteToCalculationLog @CalculationType = 'Financial',
                                      @FundKey = @FundKey,
                                      @AccountPeriodKey = @AccountPeriodKey,
                                      @BalanceTypeKey = @BalanceTypeKey,
                                      @PortfolioStatementTemplateKey = NULL,
                                      @Result = 'Calculation Sheet Calculation cancelled due to closed account period.',
                                      @Source = @procedureName,
                                      @UserName = NULL,
                                      @ServerName = @@SERVERNAME,
                                      @CalculationBatchKey = @CalculationBatchKey;
ELSE
BEGIN

    EXEC dbo.gp_WriteToCalculationLog @CalculationType = 'Financial',
                                      @FundKey = @FundKey,
                                      @AccountPeriodKey = @AccountPeriodKey,
                                      @BalanceTypeKey = @BalanceTypeKey,
                                      @PortfolioStatementTemplateKey = NULL,
                                      @Result = 'Begin',
                                      @Source = @procedureName,
                                      @UserName = NULL,
                                      @ServerName = @@SERVERNAME,
                                      @CalculationBatchKey = @CalculationBatchKey;

    SELECT @TrialBalanceDefinitionKey = FK_TrialBalanceDefinition
    FROM dbo.TrialBalanceDefinitionFund
    WHERE FK_Fund = @FundKey
          AND @TrialBalanceDefinitionKey IS NULL;

    ---------------------------------------------------------
    --Gather basic info like balance set and rounding levels
    ---------------------------------------------------------
    DECLARE @BalanceSetKey INT,
            @FinancialWorkbookRoundingLevel INT,
            @FinancialWorkbookSecondaryRoundingLevel INT,
            @ConsolidatedWorkbook BIT,
            @PortfolioStatementTemplate INT,
            @CurrencyCaptionLibraryKey INT,
            @SecurityCaptionLibraryKey INT,
            @AccountPeriodEnd DATETIME;
    -- get the balance set based on Fund & Account Period
    SELECT @BalanceSetKey = PK_GLBalanceSet
    FROM dbo.GLBalanceSet
    WHERE FK_Fund = @FundKey
          AND FK_AccountPeriod = @AccountPeriodKey
          AND FK_BalanceType = @BalanceTypeKey;

    -- get the workbook rounding level
    SELECT @FinancialWorkbookRoundingLevel = RoundingLevel,
           @FinancialWorkbookSecondaryRoundingLevel = ISNULL(RoundingLevelSecondary, -1),
           @ConsolidatedWorkbook = ISNULL(ConsolidatedWorkbook, 0)
    FROM dbo.TrialBalanceDefinition
    WHERE PK_TrialBalanceDefinition = @TrialBalanceDefinitionKey;

    --if using fund-level rounding for either, set the fund-level rounding
    IF @FinancialWorkbookRoundingLevel = -10
        SET @FinancialWorkbookRoundingLevel = @FundRoundingLevel;
    IF @FinancialWorkbookSecondaryRoundingLevel = -10
        SET @FinancialWorkbookSecondaryRoundingLevel = @FundRoundingLevel;

    SELECT @AccountPeriodEnd = AccountPeriodEnd
    FROM dbo.AccountPeriod
    WHERE PK_AccountPeriod = @AccountPeriodKey;

    SELECT @PortfolioStatementTemplate = FK_PortfolioStatementTemplate,
           @CurrencyCaptionLibraryKey = FK_CurrencyCaptionLibrary,
           @SecurityCaptionLibraryKey = FK_SecurityCaptionLibrary
    FROM dbo.Fund
    WHERE PK_Fund = @FundKey;

END;

---------------------------------------------------------
--Gather Account Period Information
---------------------------------------------------------

CREATE TABLE #AccountPeriodCycle
(
    AccountPeriodCycle NVARCHAR(64) NOT NULL PRIMARY KEY CLUSTERED,
    FK_AccountPeriod INT NULL,
    FK_GLBalanceSet INT NULL
);

INSERT #AccountPeriodCycle
(
    AccountPeriodCycle,
    FK_AccountPeriod,
    FK_GLBalanceSet
)
SELECT DISTINCT
       csid.AccountPeriodCycle,
       APForCycle.AccountPeriodKey AS FK_AccountPeriod,
       bs.PK_GLBalanceSet AS FK_GLBalanceSet
FROM dbo.CalculationSheet cs
    JOIN dbo.CalculationSheetItem csiSection
        ON csiSection.FK_CalculationSheet = cs.PK_CalculationSheet
    JOIN dbo.CalculationSheetItem csiItem
        ON csiItem.FK_CalculationSheetItem = csiSection.PK_CalculationSheetItem
    JOIN dbo.CalculationSheetItemDetail csid
        ON csid.FK_CalculationSheetItem = csiItem.PK_CalculationSheetItem
    CROSS APPLY dbo.gf_GetAccountPeriodByPeriodTypeWithFYEChanges(@AccountPeriodKey, csid.AccountPeriodCycle, @FundKey) APForCycle
    LEFT JOIN dbo.GLBalanceSet bs
        ON bs.FK_AccountPeriod = APForCycle.AccountPeriodKey
           AND bs.FK_Fund = @FundKey
           AND bs.FK_BalanceType = @BalanceTypeKey
WHERE cs.FK_TrialBalanceDefinition = @TrialBalanceDefinitionKey
      AND csid.AccountPeriodCycle IS NOT NULL;

CREATE TABLE #APCForCurrency
(
    AccountPeriodCycle NVARCHAR(64) NOT NULL PRIMARY KEY CLUSTERED,
    FK_AccountPeriod INT NULL,
    FK_GLBalanceSet INT NULL
);
INSERT #APCForCurrency
(
    AccountPeriodCycle,
    FK_AccountPeriod,
    FK_GLBalanceSet
)
SELECT DISTINCT
       csid.AccountPeriodCycle,
       APForCycle.AccountPeriodKey AS FK_AccountPeriod,
       bs.PK_GLBalanceSet AS FK_GLBalanceSet
FROM dbo.CalculationSheet cs
    JOIN dbo.CalculationSheetItem csiSection
        ON csiSection.FK_CalculationSheet = cs.PK_CalculationSheet
    JOIN dbo.CalculationSheetItem csiItem
        ON csiItem.FK_CalculationSheetItem = csiSection.PK_CalculationSheetItem
    JOIN dbo.CalculationSheetItemDetail csid
        ON csid.FK_CalculationSheetItem = csiItem.PK_CalculationSheetItem
    CROSS APPLY dbo.gf_GetAccountPeriodByPeriodTypeWithFYEChanges(@AccountPeriodKey, csid.AccountPeriodCycle, @FundKey) APForCycle
    LEFT JOIN dbo.GLBalanceSet bs
        ON bs.FK_AccountPeriod = APForCycle.AccountPeriodKey
           AND bs.FK_Fund = @FundKey
           AND bs.FK_BalanceType = @BalanceTypeKey
WHERE cs.FK_TrialBalanceDefinition = @TrialBalanceDefinitionKey
      AND csid.AccountPeriodCycle IS NOT NULL
      AND cs.ClassDisplay = 'Currency';

----------------------------------------------------------
--Gather Class and Currency information 
----------------------------------------------------------
CREATE TABLE #Class
(
    PK_Class INT NOT NULL,
    FK_BaseClass INT NOT NULL,
    ClassName NVARCHAR(256) NOT NULL
);
CREATE TABLE #Currency
(
    PK_Currency INT NOT NULL,
    CurrencyCode NVARCHAR(256) NOT NULL
);
CREATE TABLE #ChildFunds
(
    ChildFundKey INT NOT NULL PRIMARY KEY CLUSTERED,
    Percentage_Child DECIMAL(19, 8) NOT NULL,
    Rate DECIMAL(30, 16) NOT NULL
);

INSERT INTO #Class
(
    PK_Class,
    FK_BaseClass,
    ClassName
)
SELECT PK_Class,
       FK_BaseClass,
       ClassName
FROM dbo.Class
WHERE FK_Fund = @FundKey
      AND Active = 1;

IF @ConsolidatedWorkbook = 0
BEGIN;

    INSERT INTO #Currency
    (
        PK_Currency,
        CurrencyCode
    )
    SELECT PK_Currency,
           CurrencyCode
    FROM dbo.Currency
    WHERE PK_Currency IN
          (
              SELECT cc.FK_Currency
              FROM dbo.CurrencyCaption cc
                  JOIN dbo.CurrencyCaptionLibrary ccl
                      ON ccl.PK_CurrencyCaptionLibrary = cc.FK_CurrencyCaptionLibrary
                  JOIN dbo.Fund f
                      ON f.FK_CurrencyCaptionLibrary = ccl.PK_CurrencyCaptionLibrary
                  JOIN dbo.GLBalance glb
                      ON glb.FK_Currency = cc.FK_Currency
              WHERE glb.FK_GLBalanceSet IN
                    (
                        SELECT FK_GLBalanceSet FROM #APCForCurrency
                    )
              UNION ALL
              SELECT cc.FK_Currency
              FROM dbo.CurrencyCaption cc
                  JOIN dbo.CurrencyCaptionLibrary ccl
                      ON ccl.PK_CurrencyCaptionLibrary = cc.FK_CurrencyCaptionLibrary
                  JOIN dbo.Fund f
                      ON f.FK_CurrencyCaptionLibrary = ccl.PK_CurrencyCaptionLibrary
                  JOIN dbo.SecurityBalance sb
                      ON sb.FK_Currency = cc.FK_Currency
              WHERE sb.FK_AccountPeriod IN
                    (
                        SELECT FK_AccountPeriod FROM #APCForCurrency
                    )
                    AND sb.FK_Fund = @FundKey
                    AND sb.FK_BalanceType = @BalanceTypeKey
          );

END;
ELSE --@ConsolidatedWorkbook = 1
BEGIN;

    INSERT INTO #ChildFunds
    (
        ChildFundKey,
        Percentage_Child,
        Rate
    )
    SELECT DISTINCT
           frChild.FK_Fund,
           ISNULL(frChild.[Percentage], 100) * 0.01 AS Percentage_Child,
           ISNULL(exrate.Rate, 1) AS Rate
    FROM dbo.FundRelation frParent
        JOIN dbo.FundRelation frChild
            ON frChild.FK_FundParent = frParent.FK_Fund
               AND frChild.FK_FundRelationGroup = frParent.FK_FundRelationGroup
        JOIN dbo.FundRelationGroup frg
            ON frg.PK_FundRelationGroup = frParent.FK_FundRelationGroup
        LEFT JOIN dbo.Fund fundParent
            ON fundParent.PK_Fund = frParent.FK_Fund
        LEFT JOIN dbo.Fund fundChild
            ON fundChild.PK_Fund = frChild.FK_Fund
        LEFT JOIN dbo.ExchangeRateSource exSource
            ON exSource.PK_ExchangeRateSource = frChild.FK_ExchangeRateSource_ExchangeRate
        LEFT JOIN dbo.ExchangeRateSet exSet
            ON exSet.FK_ExchangeRateSource = exSource.PK_ExchangeRateSource
               AND exSet.ExchangeRateType = 'ClosedOpen'
               --Get the UTC time
               AND exSet.ExchangeRateDate = dbo.gf_ConvertLocalToUtcByTimezoneIdentifier(
                                                                                            frChild.TimeZoneId_ExchangeRate,
                                                                                            DATEADD(
                                                                                                       HOUR,
                                                                                                       frChild.HourOfDay_ExchangeRate,
                                                                                                       @AccountPeriodEnd
                                                                                                   )
                                                                                        )
        LEFT JOIN dbo.ExchangeRate exrate
            ON exrate.FK_ExchangeRateSet = exSet.PK_ExchangeRateSet
               AND exrate.FK_CurrencyFrom = fundChild.FK_Currency
               AND exrate.FK_CurrencyTo = fundParent.FK_Currency
    WHERE frg.FK_AccountPeriod = @AccountPeriodKey
          AND frParent.FK_Fund = @FundKey;

    --Gathering Currency info
    INSERT INTO #Currency
    (
        PK_Currency,
        CurrencyCode
    )
    SELECT PK_Currency,
           CurrencyCode
    FROM dbo.Currency
    WHERE PK_Currency IN
          (
              SELECT cc.FK_Currency
              FROM dbo.CurrencyCaption cc
                  JOIN dbo.CurrencyCaptionLibrary ccl
                      ON ccl.PK_CurrencyCaptionLibrary = cc.FK_CurrencyCaptionLibrary
                  JOIN dbo.Fund f
                      ON f.FK_CurrencyCaptionLibrary = ccl.PK_CurrencyCaptionLibrary
                  JOIN dbo.GLBalance glb
                      ON glb.FK_Currency = cc.FK_Currency
                  JOIN dbo.GLBalanceSet glbs
                      ON glbs.PK_GLBalanceSet = glb.FK_GLBalanceSet
              WHERE glbs.FK_AccountPeriod IN
                    (
                        SELECT FK_AccountPeriod FROM #APCForCurrency
                    )
                    AND glbs.FK_Fund IN
                        (
                            SELECT @FundKey UNION SELECT ChildFundKey FROM #ChildFunds
                        )
                    AND glbs.FK_BalanceType = @BalanceTypeKey
              UNION ALL
              SELECT cc.FK_Currency
              FROM dbo.CurrencyCaption cc
                  JOIN dbo.CurrencyCaptionLibrary ccl
                      ON ccl.PK_CurrencyCaptionLibrary = cc.FK_CurrencyCaptionLibrary
                  JOIN dbo.Fund f
                      ON f.FK_CurrencyCaptionLibrary = ccl.PK_CurrencyCaptionLibrary
                  JOIN dbo.SecurityBalance sb
                      ON sb.FK_Currency = cc.FK_Currency
              WHERE sb.FK_AccountPeriod IN
                    (
                        SELECT FK_AccountPeriod FROM #APCForCurrency
                    )
                    AND sb.FK_Fund IN
                        (
                            SELECT @FundKey UNION SELECT ChildFundKey FROM #ChildFunds
                        )
                    AND sb.FK_BalanceType = @BalanceTypeKey
          );
END;

--CREATE UNIQUE CLUSTERED INDEX PK_Class ON #Class (PK_Class, FK_BaseClass, ClassName) WITH (FILLFACTOR = 100);
--CREATE CLUSTERED INDEX IX_ConsolidationSource ON #Currency (PK_Currency, CurrencyCode) WITH (FILLFACTOR = 100);

----------------------------------------------------------
--Get a list of calc sheet items with the formula elements (no values)
----------------------------------------------------------	

SELECT DISTINCT
       csStructure.PK_CalculationSheet,
       csStructure.FK_TrialBalanceDefinition,
       csStructure.CalculationSheetName,
       csStructure.ClassDisplay,
       csStructure.PK_CalculationSheetItem,
       csStructure.FK_CalculationSheetItem,
       csStructure.ClassMode,
       ISNULL(csStructure.FK_BaseClass, c.FK_BaseClass) AS FK_BaseClass,
       csStructure.ItemSortOrder,
       csStructure.RoundingLevel,
       csStructure.RoundToThousandsDecimalPlaces,
       csStructure.SectionRoundingLevel,
       csStructure.CalculateTotal,
       csStructure.ClassOrFundLevel,
       csStructure.PK_CalculationSheetItemDetail,
       csStructure.ItemType,
       csStructure.FK_TrialBalanceSection,
       csStructure.FK_TrialBalanceItem,
       csStructure.FK_SupplementalDataItem,
       csStructure.Operator,
       csStructure.ParenthesisLeft,
       csStructure.ParenthesisRight,
       csStructure.AccountPeriodCycle,
       csStructure.DetailsSortOrder,
       csStructure.FundDataPoint,
       csStructure.ClassDataPoint,
       c.PK_Class,
       c.ClassName,
       cu.PK_Currency,
       cu.CurrencyCode,
       csStructure.ValueRaw,
       csStructure.ValueRounded,
       csStructure.ConstantValue,
       csStructure.FK_GLBalanceSet,
       csStructure.IsCircularReferenceCheck,
       csStructure.UseAbsoluteValue,
       csStructure.FK_AccountPeriod,
       csStructure.TrialBalanceValueType,
       csStructure.DaysinPeriod,
       csStructure.ConsolidationSource,
       csStructure.FK_ConditionalFormula,
       csStructure.ConditionalValueReturned,
       csStructure.ConditionalValueReturnSourceSubType,
       csStructure.ConditionalValueReturnSourceKey,
       csStructure.PK_CalculationSheetColumn,
       csStructure.FK_CalculationSheetItemColumn,
       csStructure.FK_CalculationSheetItemColumn_Section,
       csStructure.FK_CalculationsheetItem_Other,
       csStructure.FK_CalculationSheetItemColumn_Other,
       csStructure.FK_CalculationSheetValue_Other,
       csStructure.SuppressBaseCurrency
INTO #CalcSheetItemFormulaDetails
FROM
(
    SELECT cs.PK_CalculationSheet,
           cs.FK_TrialBalanceDefinition,
           cs.CalculationSheetName,
           cs.ClassDisplay,
           csiItem.PK_CalculationSheetItem,
           csiItem.FK_CalculationSheetItem,
           csic.ClassMode,
           csic.FK_BaseClass,
           csiItem.SortOrder AS ItemSortOrder,
           CASE
               WHEN csid.ItemType IN ( 'HoldingsCategory', 'HoldingsCategoryMaturityRange', 'HoldingsCategorySubtotal' ) THEN
                   CASE psthcalcHoldingsCategory.UseFundLevelRounding
                       WHEN 1 THEN
                           @FundRoundingLevel
                       ELSE
                           ISNULL(psthcalcHoldingsCategory.RoundingLevel, 6)
                   END
               WHEN csid.ItemType IN ( 'HoldingsDetail' ) THEN
                   CASE psthcalcHoldingsDetail.UseFundLevelRounding
                       WHEN 1 THEN
                           @FundRoundingLevel
                       ELSE
                           ISNULL(psthcalcHoldingsDetail.RoundingLevel, 6)
                   END
               WHEN csid.ItemType IN ( 'PortfolioStatementDefinition' ) THEN
                   CASE psthcalcPortfolioDefinition.UseFundLevelRounding
                       WHEN 1 THEN
                           @FundRoundingLevel
                       ELSE
                           ISNULL(psthcalcPortfolioDefinition.RoundingLevel, 6)
                   END
               ELSE
                   CASE ISNULL(csiItem.RoundingLevel, -1)
                       WHEN -1 THEN
                           @FinancialWorkbookRoundingLevel
                       WHEN -4 THEN
                           @FinancialWorkbookSecondaryRoundingLevel
                       WHEN -10 THEN
                           @FundRoundingLevel
                       ELSE
                           csiItem.RoundingLevel
                   END
           END AS RoundingLevel,
           CASE
               WHEN csid.ItemType IN ( 'HoldingsCategory', 'HoldingsCategoryMaturityRange', 'HoldingsCategorySubtotal' ) THEN
                   psthcalcHoldingsCategory.RoundToThousandsDecimalPlaces
               WHEN csid.ItemType IN ( 'HoldingsDetail' ) THEN
                   psthcalcHoldingsDetail.RoundToThousandsDecimalPlaces
               WHEN csid.ItemType IN ( 'PortfolioStatementDefinition' ) THEN
                   psthcalcPortfolioDefinition.RoundToThousandsDecimalPlaces
               ELSE
                   ISNULL(csiItem.RoundToThousandsDecimalPlaces, 0)
           END AS RoundToThousandsDecimalPlaces,
           ISNULL(   CASE ISNULL(csiSection.RoundingLevel, -1)
                         WHEN -1 THEN
                             @FinancialWorkbookRoundingLevel
                         WHEN -4 THEN
                             @FinancialWorkbookSecondaryRoundingLevel
                         WHEN -10 THEN
                             @FundRoundingLevel
                         ELSE
                             csiSection.RoundingLevel
                     END,
                     6
                 ) AS SectionRoundingLevel,
           csiSection.CalculateTotal,
           csiItem.ClassOrFundLevel,
           csid.PK_CalculationSheetItemDetail,
           csid.ItemType,
           csid.FK_TrialBalanceSection,
           csid.FK_TrialBalanceItem,
           csid.FK_SupplementalDataItem,
           csid.Operator,
           csid.ParenthesisLeft,
           csid.ParenthesisRight,
           csid.AccountPeriodCycle,
           ISNULL(csid.SortOrder, 1) AS DetailsSortOrder,
           csid.FundDataPoint,
           csid.ClassDataPoint,
           CAST(NULL AS INT) AS PK_Class,
           CAST(NULL AS NVARCHAR(64)) AS ClassName,
           CAST(NULL AS INT) AS PK_Currency,
           CAST(NULL AS NVARCHAR(64)) AS CurrencyCode,
           0.00 AS ValueRaw,
           0.00 AS ValueRounded,
           csid.ConstantValue,
           CASE csid.FundSelectionBehavior
               WHEN 1 THEN
                   APCycle.FK_GLBalanceSet
               ELSE
                   glbsFundSelectionBehavior.PK_GLBalanceSet
           END AS FK_GLBalanceSet,
           CAST(1 AS BIT) AS IsCircularReferenceCheck,
           csid.UseAbsoluteValue,
           APCycle.FK_AccountPeriod,
           csiItem.TrialBalanceValueType,
           csid.DaysinPeriod,
           CASE @ConsolidatedWorkbook
               WHEN 0 THEN
                   'FundBalance'
               ELSE
                   CASE
                       WHEN csid.ItemType IN ( 'ConstantValue', 'DaysinPeriod' )
                            AND EXISTS
                                (
                                    SELECT *
                                    FROM dbo.CalculationSheetItemDetail
                                    WHERE FK_CalculationSheetItem = csiItem.PK_CalculationSheetItem
                                          AND ConsolidationSource = 'FundAndChildren'
                                ) THEN
                           'FundAndChildren'
                       ELSE
                           ISNULL(NULLIF(CAST(csid.ConsolidationSource AS NVARCHAR(64)), ''), 'FundBalance')
                   END
           END AS ConsolidationSource,
           csid.FK_ConditionalFormula,
           0 AS ConditionalValueReturned,
           '' AS ConditionalValueReturnSourceSubType,
           '' AS ConditionalValueReturnSourceKey,
           csc.PK_CalculationSheetColumn,
           csic.PK_CalculationSheetItemColumn AS FK_CalculationSheetItemColumn,
           csicSection.PK_CalculationSheetItemColumn AS FK_CalculationSheetItemColumn_Section,
           csicOther.FK_CalculationSheetItem AS FK_CalculationsheetItem_Other,
           csid.FK_CalculationSheetItemColumn_Other,
           0 AS FK_CalculationSheetValue_Other,
           cs.SuppressBaseCurrency
    FROM dbo.CalculationSheet cs
        JOIN dbo.CalculationSheetItem csiSection
            ON csiSection.FK_CalculationSheet = cs.PK_CalculationSheet
        JOIN dbo.CalculationSheetColumn csc
            ON csc.FK_CalculationSheet = cs.PK_CalculationSheet
        JOIN dbo.CalculationSheetItem csiItem
            ON csiItem.FK_CalculationSheetItem = csiSection.PK_CalculationSheetItem
        LEFT OUTER JOIN dbo.CalculationSheetItemColumn csic
            ON csic.FK_CalculationSheetColumn = csc.PK_CalculationSheetColumn
               AND csic.FK_CalculationSheetItem = csiItem.PK_CalculationSheetItem
        LEFT OUTER JOIN dbo.CalculationSheetItemColumn csicSection
            ON csicSection.FK_CalculationSheetColumn = csc.PK_CalculationSheetColumn
               AND csicSection.FK_CalculationSheetItem = csiItem.FK_CalculationSheetItem
        LEFT OUTER JOIN dbo.CalculationSheetItemDetail csid
            ON csid.FK_CalculationSheetItem = csiItem.PK_CalculationSheetItem
               AND csid.FK_CalculationSheetItemColumn = csic.PK_CalculationSheetItemColumn
        LEFT OUTER JOIN dbo.CalculationSheetItemColumn csicOther
            ON csid.FK_CalculationSheetItemColumn_Other = csicOther.PK_CalculationSheetItemColumn
        LEFT OUTER JOIN #AccountPeriodCycle APCycle
            ON APCycle.AccountPeriodCycle = csid.AccountPeriodCycle
        LEFT JOIN dbo.GLBalanceSet glbsFundSelectionBehavior
            ON glbsFundSelectionBehavior.FK_AccountPeriod = APCycle.FK_AccountPeriod
               AND glbsFundSelectionBehavior.FK_BalanceType = @BalanceTypeKey
               AND glbsFundSelectionBehavior.FK_Fund = csid.FK_Fund_FundSelectionBehavior
        --To get Roundinglevel for Portfolio type items	
        LEFT JOIN dbo.PortfolioStatementTemplateHierarchy psth
            ON psth.FK_PortfolioStatementTemplate = @PortfolioStatementTemplate --Primary Statment
               AND psth.HierarchyType = 'Statement'
        LEFT JOIN dbo.PortfolioStatementTemplateHierarchyCalculation psthcalcHoldingsCategory
            ON psthcalcHoldingsCategory.FK_PortfolioStatementTemplateHierarchy = psth.PK_PortfolioStatementTemplateHierarchy
               AND psthcalcHoldingsCategory.ColumnName = CASE
                                                             WHEN csid.HoldingsCategoryValue LIKE 'MarketValueLevel%' THEN
                                                                 'FairValue'
                                                             WHEN csid.HoldingsCategoryValue LIKE 'UnrealizedValueLevel%' THEN
                                                                 'FairValue'
                                                             WHEN csid.HoldingsCategoryValue LIKE 'MarketValueTransferLevel' THEN
                                                                 'FairValue'
                                                             WHEN csid.HoldingsCategoryValue = 'NetMarketValueofSharesActivityCalculated' THEN
                                                                 'NetShares'
                                                             WHEN csid.HoldingsCategoryValue = 'NetMarketValueofSharesSoldCalculated' THEN
                                                                 'NetShares'
                                                             WHEN csid.HoldingsCategoryValue = 'NetSharesActivityCalculated' THEN
                                                                 'NetShares'
                                                             WHEN csid.HoldingsCategoryValue = 'NetSharesSoldcalculated' THEN
                                                                 'NetShares'
                                                             ELSE
            (csid.HoldingsCategoryValue)
                                                         END
        LEFT JOIN dbo.PortfolioStatementTemplateHierarchyCalculation psthcalcHoldingsDetail
            ON psthcalcHoldingsDetail.FK_PortfolioStatementTemplateHierarchy = psth.PK_PortfolioStatementTemplateHierarchy
               AND psthcalcHoldingsDetail.ColumnName = CASE
                                                           WHEN csid.HoldingsDetailValue LIKE 'MarketValueLevel%' THEN
                                                               'FairValue'
                                                           WHEN csid.HoldingsDetailValue LIKE 'UnrealizedValueLevel%' THEN
                                                               'FairValue'
                                                           WHEN csid.HoldingsDetailValue LIKE 'MarketValueTransferLevel%' THEN
                                                               'FairValue'
                                                           WHEN csid.HoldingsDetailValue = 'NetMarketValueofSharesActivityCalculated' THEN
                                                               'NetShares'
                                                           WHEN csid.HoldingsDetailValue = 'NetMarketValueofSharesSoldCalculated' THEN
                                                               'NetShares'
                                                           WHEN csid.HoldingsDetailValue = 'NetSharesActivityCalculated' THEN
                                                               'NetShares'
                                                           WHEN csid.HoldingsDetailValue = 'NetSharesSoldcalculated' THEN
                                                               'NetShares'
                                                           ELSE
            (csid.HoldingsDetailValue)
                                                       END
        LEFT JOIN dbo.PortfolioStatementTemplate pst
            ON pst.PK_PortfolioStatementTemplate = csid.FK_PortfolioStatementTemplate
        LEFT JOIN dbo.PortfolioStatementTemplateHierarchy psthPortfolioDefinition
            ON psthPortfolioDefinition.FK_PortfolioStatementTemplate = CASE pst.UseNumbersFromPrimary
                                                                           WHEN 0 THEN
                                                                               csid.FK_PortfolioStatementTemplate
                                                                           ELSE
                                                                               @PortfolioStatementTemplate --Pulling from primaryStatement
                                                                       END
               AND psthPortfolioDefinition.HierarchyType = 'Statement'
        LEFT JOIN dbo.PortfolioStatementTemplateHierarchyCalculation psthcalcPortfolioDefinition
            ON psthcalcPortfolioDefinition.FK_PortfolioStatementTemplateHierarchy = psthPortfolioDefinition.PK_PortfolioStatementTemplateHierarchy
               AND psthcalcPortfolioDefinition.ColumnName = CASE
                                                                WHEN csid.PortfolioStatementTemplateColumnName LIKE 'MarketValueLevel%' THEN
                                                                    'FairValue'
                                                                WHEN csid.PortfolioStatementTemplateColumnName LIKE 'UnrealizedValueLevel%' THEN
                                                                    'FairValue'
                                                                WHEN csid.PortfolioStatementTemplateColumnName = 'PercentOfNetAssets' THEN
                                                                    'PercentOfNetAssets'
                                                                ELSE
                                                                    ISNULL(
                                                                              NULLIF(csid.PortfolioStatementTemplateColumnName, ''),
                                                                              'MarketValue'
                                                                          )
                                                            END
    WHERE cs.FK_TrialBalanceDefinition = @TrialBalanceDefinitionKey
) csStructure
    LEFT OUTER JOIN #Class c
        ON csStructure.ClassDisplay <> 'Currency'
           AND
           (
               csStructure.FK_BaseClass = c.FK_BaseClass --single
               OR csStructure.ClassMode = 'Multiple'
           )
    LEFT OUTER JOIN #Currency cu
        ON csStructure.ClassDisplay = 'Currency';


EXEC dbo.gp_WriteToCalculationLog 'Financial',
                                  @FundKey,
                                  @AccountPeriodKey,
                                  @BalanceTypeKey,
                                  NULL,
                                  'Begin index creation',
                                  'GetInputValuesForCalculationEngine',
                                  NULL,
                                  NULL,
                                  @CalculationBatchKey;

CREATE CLUSTERED INDEX IX_PK_CalculationSheetItemDetail_PK_Class_PK_Currency
ON #CalcSheetItemFormulaDetails (
                                    PK_CalculationSheetItemDetail,
                                    PK_Class,
                                    PK_Currency
                                )
WITH (FILLFACTOR = 100); -- confirmed read
CREATE NONCLUSTERED INDEX IX_ItemType_PK_CalculationSheetItemDetail
ON #CalcSheetItemFormulaDetails (
                                    ItemType,
                                    PK_CalculationSheetItemDetail
                                )
INCLUDE (
            PK_Currency,
            FK_CalculationSheetItemColumn,
            FK_AccountPeriod
        )
WITH (FILLFACTOR = 100); -- read
CREATE NONCLUSTERED INDEX IX_ItemType_FK_AccountPeriod
ON #CalcSheetItemFormulaDetails (
                                    ItemType,
                                    FK_AccountPeriod
                                )
WITH (FILLFACTOR = 100); -- read
CREATE NONCLUSTERED INDEX IX_ClassDataPoint
ON dbo.#CalcSheetItemFormulaDetails (ClassDataPoint)
INCLUDE (
            PK_CalculationSheetItemDetail,
            ItemType,
            PK_Class,
            PK_Currency,
            FK_GLBalanceSet,
            TrialBalanceValueType
        )
WITH (FILLFACTOR = 100); -- read
CREATE NONCLUSTERED INDEX IX_PK_CalcSheetItemFormulaDetails_PK_Class_PK_Currency_PK_CalculationSheetItem
ON #CalcSheetItemFormulaDetails (
                                    PK_CalculationSheetItemDetail,
                                    PK_Class,
                                    PK_Currency,
                                    PK_CalculationSheetItem
                                )
WITH (FILLFACTOR = 100); -- read
CREATE NONCLUSTERED INDEX IX_FK_CalculationSheetItemColumn_Other
ON #CalcSheetItemFormulaDetails (FK_CalculationSheetItemColumn_Other)
WITH (FILLFACTOR = 100); -- read
CREATE NONCLUSTERED INDEX IX_FK_CalculationSheetItemColumn
ON #CalcSheetItemFormulaDetails (FK_CalculationSheetItemColumn)
WITH (FILLFACTOR = 100); -- read
CREATE NONCLUSTERED INDEX IX_FK_TrialBalanceItem
ON #CalcSheetItemFormulaDetails (FK_TrialBalanceItem)
WITH (FILLFACTOR = 100); -- read

EXEC dbo.gp_EnsureCalculationSheetValueRecordsExist @BalanceSetKey,
                                                    @CalculationBatchKey;

UPDATE csvd
SET IsUpdated = 0
FROM dbo.CalculationSheetValue csv
    INNER JOIN dbo.CalculationSheetValueDetail csvd
        ON csv.PK_CalculationSheetValue = csvd.FK_CalculationSheetValue
WHERE csv.FK_GLBalanceSet = @BalanceSetKey;

-------------------------------------------------------------------------
--Get various PORTFOLIO formula elements
-------------------------------------------------------------------------

if exists (select 1 tempdb..#PortfolioResultTable)
	drop table #PortfolioResultTable;

CREATE TABLE #PortfolioResultTable
(
    FK_CalculationSheetItemDetail INT NOT NULL,
    FK_Currency INT,
    ValueFooted DECIMAL(28, 6)
) ;

CREATE CLUSTERED INDEX IX_FK_CalculationSheetItemDetail_FK_Currency
    ON #PortfolioResultTable (
                                 FK_CalculationSheetItemDetail,
                                 FK_Currency
                             )
    WITH (FILLFACTOR = 100);


-- This #temp table is used by procs gp_GetPortfolioHoldingsCategoryInputValuesForCalculationEngine & gp_GetPortfolioHoldingsCategorySubtotalInputValuesForCalculationEngine
CREATE TABLE #SecurityCategorizationTable
(
    PK_SecurityCategorization INT NOT NULL,
    FK_SecurityMaster INT,
    FK_CategoryLibrary INT,
    FK_Category INT,
    FK_Category_Negative INT,
    DynamicCategorizationColumnName NVARCHAR(256),
    FK_Accountperiod INT
);

IF @OtherAssetsOnly = 0
   OR @OtherAssetsOnly IS NULL
BEGIN

    EXEC dbo.gp_WriteToCalculationLog 'Financial',
                                      @FundKey,
                                      @AccountPeriodKey,
                                      @BalanceTypeKey,
                                      NULL,
                                      'Begin Portfolio data retrieval for calc sheet calculation engine.',
                                      'GetInputValuesForCalculationEngine',
                                      NULL,
                                      NULL,
                                      @CalculationBatchKey;

    CREATE TABLE #FUNDS
    (
        FK_Fund INT NOT NULL,
        BaseCurrencyKey INT NULL
    );

    IF EXISTS
    (
        SELECT 1
        FROM dbo.PortfolioStatementTemplate
        WHERE PK_PortfolioStatementTemplate = @PortfolioStatementTemplate
              AND MultimanagerConsolidatedStatement = 1
    )
        INSERT INTO #FUNDS
        (
            FK_Fund,
            BaseCurrencyKey
        )
        SELECT DISTINCT
               fr.FK_Fund,
               f.FK_Currency
        FROM dbo.FundRelationGroup frg
            JOIN dbo.FundRelation fr
                ON fr.FK_FundRelationGroup = frg.PK_FundRelationGroup
            JOIN dbo.Fund f
                ON f.PK_Fund IN ( fr.FK_FundParent, fr.FK_Fund )
        WHERE frg.FundRelationGroupType = 'SR'
              AND f.PK_Fund = @FundKey
              AND frg.FK_AccountPeriod = @AccountPeriodKey;

    IF NOT EXISTS (SELECT 1 FROM #FUNDS)
        INSERT INTO #FUNDS
        (
            FK_Fund,
            BaseCurrencyKey
        )
        SELECT PK_Fund,
               FK_Currency
        FROM dbo.Fund
        WHERE PK_Fund = @FundKey;

    CREATE UNIQUE CLUSTERED INDEX PK_FUNDS
    ON #FUNDS (
                  FK_Fund,
                  BaseCurrencyKey
              )
    WITH (FILLFACTOR = 100);


    IF EXISTS
    (
        SELECT 1
        FROM #CalcSheetItemFormulaDetails
        WHERE ItemType IN ( 'HoldingsCategory', 'HoldingsCategoryMaturityRange', 'HoldingsCategorySubtotal' )
    )
    BEGIN
        DECLARE @AccountPeriods AS dbo.UniqueKeys;

        INSERT @AccountPeriods
        (
            UniqueID
        )
        SELECT DISTINCT
               FK_AccountPeriod
        FROM #CalcSheetItemFormulaDetails
        WHERE ItemType IN ( 'HoldingsCategory', 'HoldingsCategoryMaturityRange', 'HoldingsCategorySubtotal',
                            'HoldingsDetail', 'PortfolioStatementDefinition'
                          )
              AND FK_AccountPeriod IS NOT NULL;

        IF (NOT EXISTS (SELECT * FROM @AccountPeriods))
           AND @AccountPeriodKey IS NOT NULL
            INSERT @AccountPeriods
            (
                UniqueID
            )
            VALUES
            (@AccountPeriodKey);

        --INSERT INTO #SecurityCategorizationTable (PK_SecurityCategorization, FK_SecurityMaster, FK_CategoryLibrary, FK_Category, CategoryBehavior, FK_Category_Negative, DynamicCategorizationColumnName, FK_Accountperiod)
        --EXEC dbo.gp_GetPortfolioHoldingsCategorizationInputValuesForCalculationEngine @FundKey, @AccountPeriods, @BalanceTypeKey, @CalculationBatchKey, @AccountPeriodKey;


        DECLARE @SQLStmt NVARCHAR(MAX);

        CREATE TABLE #Securities
        (
            FK_SecurityMaster INT NOT NULL,
            FK_AccountPeriod INT NOT NULL,
            PRIMARY KEY CLUSTERED (
                                      FK_SecurityMaster,
                                      FK_AccountPeriod
                                  )
        );

        INSERT #Securities
        (
            FK_SecurityMaster,
            FK_AccountPeriod
        )
        SELECT DISTINCT
               sb.FK_SecurityMaster,
               sb.FK_AccountPeriod
        FROM dbo.SecurityBalance sb
            JOIN @AccountPeriods p
                ON p.UniqueID = sb.FK_AccountPeriod
        WHERE sb.FK_BalanceType = @BalanceTypeKey
              AND sb.FK_Fund IN
                  (
                      SELECT FK_Fund FROM #FUNDS
                  );


        --for the specified period, get list of securities with categories in the category library for this fund
        CREATE TABLE #SecCat
        (
            PK_SecurityCategorization INT NOT NULL,
            FK_SecurityMaster INT,
            FK_CategoryLibrary INT,
            FK_category INT NOT NULL,
            CategoryBehaviorDynamic BIT NOT NULL,
            FK_Category_Negative INT NULL,
            DynamicCategorizationColumnName NVARCHAR(64),
            FK_AccountPeriod INT
        );

        -- If fund-specific exclusion rows exist, they survive and eliminate Lib rows
        INSERT #SecCat
        (
            PK_SecurityCategorization,
            FK_SecurityMaster,
            FK_CategoryLibrary,
            FK_category,
            CategoryBehaviorDynamic,
            FK_Category_Negative,
            DynamicCategorizationColumnName,
            FK_AccountPeriod
        )
        SELECT DISTINCT
               CASE
                   WHEN scEx.PK_SecurityCategorization IS NULL THEN
                       scLib.PK_SecurityCategorization
                   ELSE
                       scEx.PK_SecurityCategorization
               END AS PK_SecurityCategorization,
               s.FK_SecurityMaster,
               fcl.FK_CategoryLibrary,
               c.PK_Category AS FK_category,
               CASE c.CategoryBehavior
                   WHEN 'Dynamic' THEN
                       1
                   ELSE
                       0
               END AS CategoryBehaviorDynamic,
               c.FK_Category_Negative,
               c.DynamicCategorizationColumnName,
               CASE
                   WHEN scEx.PK_SecurityCategorization IS NULL THEN
                       scLib.FK_AccountPeriod
                   ELSE
                       scEx.FK_AccountPeriod
               END AS FK_AccountPeriod
        FROM #Securities s
            CROSS JOIN dbo.FundCategoryLibrary fcl
            LEFT JOIN dbo.SecurityCategorization scLib -- must be outer join because scEx rows without corresponding scLib rows are possible!
                ON scLib.FK_CategoryLibrary = fcl.FK_CategoryLibrary
                   AND scLib.FK_AccountPeriod = s.FK_AccountPeriod
                   AND scLib.FK_SecurityMaster = s.FK_SecurityMaster
                   AND scLib.FK_Fund_SecurityCategorization IS NULL
            LEFT JOIN dbo.SecurityCategorization scEx
                ON scEx.FK_CategoryLibrary = fcl.FK_CategoryLibrary
                   AND scEx.FK_AccountPeriod = s.FK_AccountPeriod
                   AND scEx.FK_SecurityMaster = s.FK_SecurityMaster
                   AND ISNULL(scEx.FK_Fund_SecurityCategorization, 0) = fcl.FK_Fund
            JOIN dbo.Category c
                ON c.PK_Category = CASE
                                       WHEN scEx.PK_SecurityCategorization IS NULL THEN
                                           scLib.FK_Category
                                       ELSE
                                           scEx.FK_Category
                                   END
        WHERE fcl.FK_Fund = @FundKey
              AND fcl.FK_CategoryLibrary IS NOT NULL;


        -- 1. modify the above query to insert into a temp table  - #SecurityCategorization  
        -- 2. Check if any CategoryBehavior is Dynamic.  
        -- 3. For each Category marked as Dynamic, Group the securities by that dynamic category settings  

        IF EXISTS (SELECT 1 FROM #SecCat WHERE CategoryBehaviorDynamic = 1)
        BEGIN

            CREATE TABLE #SecuritiesToRecategorize
            (
                FK_Category INT NOT NULL,
                FK_SecurityMaster INT NOT NULL,
                PRIMARY KEY CLUSTERED (
                                          FK_Category,
                                          FK_SecurityMaster
                                      )
            );

            DECLARE @CategoryKey INT,
                    @Select NVARCHAR(500),
                    @SecurityBalanceJoin NVARCHAR(1000),
                    @SecurityCaptionJoin NVARCHAR(1000),
                    @Where NVARCHAR(1000),
                    @AggregationColumnList NVARCHAR(512),
                    @DynamicCategorizationColumnName NVARCHAR(512),
                    @SecuritiesRecategorized INT,
                    @NegativeCategoryKey INT,
                    @Message NVARCHAR(1000),
                    @CalculationStatus NVARCHAR(32);

            SELECT @CalculationStatus = CalculationStatus
            FROM dbo.PortfolioStatementValueStatus
            WHERE FK_Fund = @FundKey
                  AND FK_BalanceType = @BalanceTypeKey
                  AND FK_PortfolioStatementTemplate = @PortfolioStatementTemplate
                  AND FK_AccountPeriod = @AccountPeriodKey;

            DECLARE DynamicCategoryCursor CURSOR LOCAL FAST_FORWARD FOR
            SELECT DISTINCT
                   FK_category,
                   DynamicCategorizationColumnName,
                   FK_Category_Negative
            FROM #SecCat
            WHERE CategoryBehaviorDynamic = 1;

            OPEN DynamicCategoryCursor;
            FETCH NEXT FROM DynamicCategoryCursor
            INTO @CategoryKey,
                 @DynamicCategorizationColumnName,
                 @NegativeCategoryKey;

            WHILE @@FETCH_STATUS = 0
            BEGIN
                /*
				SELECT
				@DynamicCategorizationColumnName = DynamicCategorizationColumnName,
				@NegativeCategoryKey = FK_Category_Negative
				FROM #SecCat
				WHERE FK_Category = @CategoryKey;
				*/

                IF NOT EXISTS
                (
                    SELECT 1
                    FROM dbo.CategoryDynamicAggregateColumn
                    WHERE FK_Category = @CategoryKey
                )
                    SET @SQLStmt
                        = N'INSERT #SecuritiesToRecategorize (FK_Category, FK_SecurityMaster)
					SELECT DISTINCT sc.FK_Category, sc.FK_SecurityMaster
					FROM dbo.SecurityBalance sb
					JOIN #Securities s ON sb.FK_SecurityMaster = s.FK_SecurityMaster AND sb.FK_AccountPeriod = s.FK_AccountPeriod
					JOIN #SecCat sc ON sc.FK_SecurityMaster = sb.FK_SecurityMaster
					JOIN #FUNDS f ON f.FK_Fund = sb.FK_Fund
					WHERE sb.FK_BalanceType = @BalanceTypeKey
					AND sc.FK_Category = @CategoryKey
					AND ' + @DynamicCategorizationColumnName + N' < 0';
                ELSE
                BEGIN
                    SET @AggregationColumnList = N'';
                    -- query CategoryDynamicAggregateColumn and build the @AggregationColumnList
                    SELECT @AggregationColumnList
                        = COALESCE(
                                      CASE @AggregationColumnList
                                          WHEN '' THEN
                                              CASE ColumnName
                                                  WHEN 'Caption' THEN
                                                      'SecurityCaption'
                                                  WHEN 'MaturityDate' THEN
                                                      'scap.MaturityDate'
                                                  WHEN 'CouponRate' THEN
                                                      'scap.CouponRate'
                                                  WHEN 'Cusip' THEN
                                                      ' scap.FK_SecurityMaster'
                                                  WHEN 'CustomIdentifier' THEN
                                                      ' scap.FK_SecurityMaster'
                                                  WHEN 'ISIN' THEN
                                                      ' scap.FK_SecurityMaster'
                                                  WHEN 'Issuer' THEN
                                                      ' scap.FK_SecurityMaster'
                                                  WHEN 'IssuerCIK' THEN
                                                      ' scap.FK_SecurityIssuer'
                                                  WHEN 'MasterIdentifier' THEN
                                                      ' scap.FK_SecurityMaster'
                                                  WHEN 'SEDOL' THEN
                                                      ' scap.FK_SecurityMaster'
                                                  WHEN 'Valoren' THEN
                                                      ' scap.FK_SecurityMaster'
                                                  WHEN 'Werkpapier' THEN
                                                      ' scap.FK_SecurityMaster'
                                                  WHEN 'ReferenceFundCode' THEN
                                                      ''
                                                  WHEN 'ReferenceFundCurrencyCode' THEN
                                                      ''
                                                  WHEN 'SecurityCurrencySymbol' THEN
                                                      ' sb.FK_Currency'
                                                  WHEN 'SecurityCurrencyCaption' THEN
                                                      ' sb.FK_Currency'
                                                  ELSE
                                                      ColumnName
                                              END
                                          ELSE
                                              @AggregationColumnList
                                              + CASE
                                                    WHEN ColumnName = 'Caption' THEN
                                                        ',SecurityCaption'
                                                    WHEN ColumnName = 'MaturityDate' THEN
                                                        ',scap.MaturityDate'
                                                    WHEN ColumnName = 'CouponRate' THEN
                                                        ',scap.CouponRate'
                                                    WHEN ColumnName IN ( 'SecurityCusip', 'CustomIdentifier', 'ISIN',
                                                                         'Issuer', 'MasterIdentifier', 'SEDOL',
                                                                         'Valoren', 'Werkpapier'
                                                                       ) THEN
                                                        CASE
                                                            WHEN CHARINDEX(
                                                                              ' scap.FK_SecurityMaster',
                                                                              @AggregationColumnList
                                                                          ) > 0 THEN
                                                                ''
                                                            ELSE
                                                                ', scap.FK_SecurityMaster'
                                                        END
                                                    WHEN ColumnName = 'IssuerCIK' THEN
                                                        ', scap.FK_SecurityIssuer'
                                                    WHEN ColumnName IN ( 'ReferenceFundCode',
                                                                         'ReferenceFundCurrencyCode'
                                                                       ) THEN
                                                        ''
                                                    WHEN ColumnName IN ( 'SecurityCurrencySymbol',
                                                                         'SecurityCurrencyCaption'
                                                                       ) THEN
                                                        CASE
                                                            WHEN CHARINDEX(' sb.FK_Currency', @AggregationColumnList) > 0 THEN
                                                                ''
                                                            ELSE
                                                                ', sb.FK_Currency'
                                                        END
                                                    ELSE
                                                        ',' + ColumnName
                                                END
                                      END,
                                      ''
                                  )
                    FROM dbo.CategoryDynamicAggregateColumn
                    WHERE FK_Category = @CategoryKey;

                    IF @AggregationColumnList <> ''
                        SET @AggregationColumnList = N',' + @AggregationColumnList;

                    -- Print @AggregationColumnList
                    -- PRINT @CategoryKey
                    --- Build SecurityBalance Join
                    SET @SecurityBalanceJoin = N'';
                    SELECT @SecurityBalanceJoin
                        = @SecurityBalanceJoin
                          + COALESCE(
                                        CASE
                                            WHEN ColumnName = 'BaseCurrencyBought' THEN
                                                ' AND sb.BaseCurrencyBought = negativeCategories.BaseCurrencyBought'
                                            WHEN ColumnName = 'BaseCurrencySold' THEN
                                                ' AND sb.BaseCurrencySold = negativeCategories.BaseCurrencySold'
                                            WHEN ColumnName = 'BaseUnitPrice' THEN
                                                ' AND sb.BaseUnitPrice = negativeCategories.BaseUnitPrice'
                                            WHEN ColumnName = 'Commitments' THEN
                                                ' AND sb.Commitments = negativeCategories.Commitments'
                                            WHEN ColumnName = 'ContractRate' THEN
                                                ' AND sb.ContractRate = negativeCategories.ContractRate'
                                            WHEN ColumnName = 'CounterParty' THEN
                                                ' AND sb.CounterParty = negativeCategories.CounterParty'
                                            WHEN ColumnName = 'CurrencyCodePurchased' THEN
                                                ' AND sb.CurrencyCodePurchased = negativeCategories.CurrencyCodePurchased'
                                            WHEN ColumnName = 'CurrencyCodeSold' THEN
                                                ' AND sb.CurrencyCodeSold = negativeCategories.CurrencyCodeSold'
                                            WHEN ColumnName = 'SecurityBalanceDescription11' THEN
                                                ' AND sb.SecurityBalanceDescription11 = negativeCategories.SecurityBalanceDescription11'
                                            WHEN ColumnName = 'SecurityBalanceDescription12' THEN
                                                ' AND sb.SecurityBalanceDescription12 = negativeCategories.SecurityBalanceDescription12'
                                            WHEN ColumnName = 'SecurityBalanceDescription13' THEN
                                                ' AND sb.SecurityBalanceDescription13 = negativeCategories.SecurityBalanceDescription13'
                                            WHEN ColumnName = 'SecurityBalanceDescription14' THEN
                                                ' AND sb.SecurityBalanceDescription14 = negativeCategories.SecurityBalanceDescription14'
                                            WHEN ColumnName = 'SecurityBalanceDescription15' THEN
                                                ' AND sb.SecurityBalanceDescription15 = negativeCategories.SecurityBalanceDescription15'
                                            WHEN ColumnName = 'SecurityBalanceDescription16' THEN
                                                ' AND sb.SecurityBalanceDescription16 = negativeCategories.SecurityBalanceDescription16'
                                            WHEN ColumnName = 'SecurityBalanceDescription17' THEN
                                                ' AND sb.SecurityBalanceDescription17 = negativeCategories.SecurityBalanceDescription17'
                                            WHEN ColumnName = 'SecurityBalanceDescription18' THEN
                                                ' AND sb.SecurityBalanceDescription18 = negativeCategories.SecurityBalanceDescription18'
                                            WHEN ColumnName = 'SecurityBalanceDescription19' THEN
                                                ' AND sb.SecurityBalanceDescription19 = negativeCategories.SecurityBalanceDescription19'
                                            WHEN ColumnName = 'SecurityBalanceDescription20' THEN
                                                ' AND sb.SecurityBalanceDescription20 = negativeCategories.SecurityBalanceDescription20'
                                            WHEN ColumnName = 'ExchangeRate' THEN
                                                ' AND sb.ExchangeRate = negativeCategories.ExchangeRate'
                                            WHEN ColumnName = 'ExpirationDate' THEN
                                                ' AND sb.ExpirationDate = negativeCategories.ExpirationDate'
                                            WHEN ColumnName = 'FixedInterest' THEN
                                                ' AND sb.FixedInterest = negativeCategories.FixedInterest'
                                            WHEN ColumnName = 'LocalUnitPrice' THEN
                                                ' AND sb.LocalUnitPrice = negativeCategories.LocalUnitPrice'
                                            WHEN ColumnName = 'Multiplier' THEN
                                                ' AND sb.Multiplier = negativeCategories.Multiplier'
                                            WHEN ColumnName = 'OnLoan' THEN
                                                ' AND sb.OnLoan = negativeCategories.OnLoan'
                                            WHEN ColumnName = 'OptionPremium' THEN
                                                ' AND sb.OptionPremium = negativeCategories.OptionPremium'
                                            WHEN ColumnName = 'PayType' THEN
                                                ' AND sb.PayType = negativeCategories.PayType'
                                            WHEN ColumnName = 'PriceAsk' THEN
                                                ' AND sb.PriceAsk = negativeCategories.PriceAsk'
                                            WHEN ColumnName = 'PriceBid' THEN
                                                ' AND sb.PriceBid = negativeCategories.PriceBid'
                                            WHEN ColumnName = 'ReceiveType' THEN
                                                ' AND sb.ReceiveType = negativeCategories.ReceiveType'
                                            WHEN ColumnName = 'ResetDate' THEN
                                                ' AND sb.ResetDate = negativeCategories.ResetDate'
                                            WHEN ColumnName = 'StrikePrice' THEN
                                                ' AND sb.StrikePrice = negativeCategories.StrikePrice'
                                            WHEN ColumnName = 'TBADescription' THEN
                                                ' AND sb.TBADescription = negativeCategories.TBADescription'
                                            WHEN ColumnName = 'Yield' THEN
                                                ' AND sb.Yield = negativeCategories.Yield'
                                            WHEN ColumnName = 'YieldDate' THEN
                                                ' AND sb.YieldDate = negativeCategories.YieldDate'
                                            WHEN ColumnName IN ( 'ReferenceFundCode', 'ReferenceFundCurrencyCode' ) THEN
                                                ''
                                            WHEN ColumnName IN ( 'SecurityCurrencySymbol', 'SecurityCurrencyCaption' ) THEN
                                                CASE
                                                    WHEN CHARINDEX(
                                                                      ' AND sb.FK_Currency = negativeCategories.FK_Currency',
                                                                      @SecurityBalanceJoin
                                                                  ) > 0 THEN
                                                        ''
                                                    ELSE
                                                        ' AND sb.FK_Currency = negativeCategories.FK_Currency'
                                                END
                                        END,
                                        ''
                                    )
                    FROM dbo.CategoryDynamicAggregateColumn
                    WHERE FK_Category = @CategoryKey;

                    IF @SecurityBalanceJoin <> ''
                    BEGIN
                        SET @SecurityBalanceJoin
                            = N' JOIN dbo.SecurityBalance sb ON '
                              + SUBSTRING(@SecurityBalanceJoin, 5, LEN(@SecurityBalanceJoin));
                        SET @SecurityBalanceJoin
                            = @SecurityBalanceJoin
                              + N' JOIN #Securities s ON sb.FK_SecurityMaster = s.FK_SecurityMaster AND sb.FK_AccountPeriod = s.FK_AccountPeriod  JOIN #FUNDS f ON f.FK_Fund = sb.FK_Fund';
                        SET @Where = N' WHERE sb.FK_BalanceType = @BalanceTypeKey';
                        SET @SecurityCaptionJoin
                            = N' JOIN dbo.SecurityCaption sc ON sc.FK_SecurityMaster = sb.FK_SecurityMaster
							AND sc.FK_AccountPeriod = s.FK_AccountPeriod
							AND sc.FK_SecurityCaptionLibrary = @SecurityCaptionLibraryKey';
                        SET @Select = N'SELECT DISTINCT negativeCategories.FK_Category, sb.FK_SecurityMaster';
                    END;
                    ELSE
                    BEGIN
                        SET @Select = N'SELECT DISTINCT negativeCategories.FK_Category, sc.FK_SecurityMaster';
                        SET @SecurityCaptionJoin
                            = N' JOIN dbo.SecurityCaption sc ON sc.FK_AccountPeriod = negativeCategories.FK_AccountPeriod AND sc.FK_SecurityCaptionLibrary = @SecurityCaptionLibraryKey';
                        SET @Where = N'';
                    END;
                    --- Build SecurityCaption Join

                    SELECT @SecurityCaptionJoin
                        = @SecurityCaptionJoin
                          + COALESCE(
                                        CASE
                                            WHEN ColumnName = 'Flag_144A' THEN
                                                ' AND sc.Flag_144A = negativeCategories.Flag_144A'
                                            WHEN ColumnName = 'AMBestCreditRating' THEN
                                                ' AND sc.AMBestCreditRating = negativeCategories.AMBestCreditRating'
                                            WHEN ColumnName = 'Class' THEN
                                                ' AND sc.Class = negativeCategories.Class'
                                            WHEN ColumnName = 'Caption' THEN
                                                ' AND sc.SecurityCaption = negativeCategories.SecurityCaption'
                                            WHEN ColumnName = 'CouponRate' THEN
                                                ' AND sc.CouponRate = negativeCategories.CouponRate'
                                            WHEN ColumnName = 'DBRSCreditRating' THEN
                                                ' AND sc.DBRSCreditRating = negativeCategories.DBRSCreditRating'
                                            WHEN ColumnName = 'SecurityCaptionDescription1' THEN
                                                ' AND sc.SecurityCaptionDescription1 = negativeCategories.SecurityCaptionDescription1'
                                            WHEN ColumnName = 'SecurityCaptionDescription2' THEN
                                                ' AND sc.SecurityCaptionDescription2 = negativeCategories.SecurityCaptionDescription2'
                                            WHEN ColumnName = 'SecurityCaptionDescription3' THEN
                                                ' AND sc.SecurityCaptionDescription3 = negativeCategories.SecurityCaptionDescription3'
                                            WHEN ColumnName = 'SecurityCaptionDescription4' THEN
                                                ' AND sc.SecurityCaptionDescription4 = negativeCategories.SecurityCaptionDescription4'
                                            WHEN ColumnName = 'SecurityCaptionDescription5' THEN
                                                ' AND sc.SecurityCaptionDescription5 = negativeCategories.SecurityCaptionDescription5'
                                            WHEN ColumnName = 'SecurityCaptionDescription6' THEN
                                                ' AND sc.SecurityCaptionDescription6 = negativeCategories.SecurityCaptionDescription6'
                                            WHEN ColumnName = 'SecurityCaptionDescription7' THEN
                                                ' AND sc.SecurityCaptionDescription7 = negativeCategories.SecurityCaptionDescription7'
                                            WHEN ColumnName = 'SecurityCaptionDescription8' THEN
                                                ' AND sc.SecurityCaptionDescription8 = negativeCategories.SecurityCaptionDescription8'
                                            WHEN ColumnName = 'SecurityCaptionDescription9' THEN
                                                ' AND sc.SecurityCaptionDescription9 = negativeCategories.SecurityCaptionDescription9'
                                            WHEN ColumnName = 'SecurityCaptionDescription10' THEN
                                                ' AND sc.SecurityCaptionDescription10 = negativeCategories.SecurityCaptionDescription10'
                                            WHEN ColumnName = 'EganJonesCreditRating' THEN
                                                ' AND sc.EganJonesCreditRating = negativeCategories.EganJonesCreditRating'
                                            WHEN ColumnName = 'FairValueLevel' THEN
                                                ' AND sc.FairValueLevel = negativeCategories.FairValueLevel'
                                            WHEN ColumnName = 'FairValueType' THEN
                                                ' AND sc.FairValueType = negativeCategories.FairValueType'
                                            WHEN ColumnName = 'FairValued' THEN
                                                ' AND sc.FairValued = negativeCategories.FairValued'
                                            WHEN ColumnName = 'FinalLegalMaturityDate' THEN
                                                ' AND sc.FinalLegalMaturityDate = negativeCategories.FinalLegalMaturityDate'
                                            WHEN ColumnName = 'FitchCreditRating' THEN
                                                ' AND sc.FitchCreditRating = negativeCategories.FitchCreditRating'
                                            WHEN ColumnName = 'HasDemandFeature' THEN
                                                ' AND sc.HasDemandFeature = negativeCategories.HasDemandFeature'
                                            WHEN ColumnName = 'HasEnhancement' THEN
                                                ' AND sc.HasEnhancement = negativeCategories.HasEnhancement'
                                            WHEN ColumnName = 'HasGuarantee' THEN
                                                ' AND sc.HasGuarantee = negativeCategories.HasGuarantee'
                                            WHEN ColumnName = 'IlliquidSecurity' THEN
                                                ' AND sc.IlliquidSecurity = negativeCategories.IlliquidSecurity'
                                            WHEN ColumnName = 'InDefault' THEN
                                                ' AND sc.InDefault = negativeCategories.InDefault'
                                            WHEN ColumnName = 'JCRCreditRating' THEN
                                                ' AND sc.JCRCreditRating = negativeCategories.JCRCreditRating'
                                            WHEN ColumnName = 'LACECreditRating' THEN
                                                ' AND sc.LACECreditRating = negativeCategories.LACECreditRating'
                                            WHEN ColumnName = 'MaturityDate' THEN
                                                ' AND sc.MaturityDate = negativeCategories.MaturityDate'
                                            WHEN ColumnName = 'LACECreditRating' THEN
                                                ' AND sc.LACECreditRating = negativeCategories.LACECreditRating'
                                            WHEN ColumnName = 'NonIncome' THEN
                                                ' AND sc.NonIncome = negativeCategories.NonIncome'
                                            WHEN ColumnName = 'MoodysCreditRating' THEN
                                                ' AND sc.MoodysCreditRating = negativeCategories.MoodysCreditRating'
                                            WHEN ColumnName = 'NMFPNotes' THEN
                                                ' AND sc.NMFPNotes = negativeCategories.NMFPNotes'
                                            WHEN ColumnName = 'OtherCreditRating1' THEN
                                                ' AND sc.OtherCreditRating1 = negativeCategories.OtherCreditRating1'
                                            WHEN ColumnName = 'OtherCreditRating2' THEN
                                                ' AND sc.OtherCreditRating2 = negativeCategories.OtherCreditRating2'
                                            WHEN ColumnName = 'OtherCreditRating3' THEN
                                                ' AND sc.OtherCreditRating3 = negativeCategories.OtherCreditRating3'
                                            WHEN ColumnName = 'OtherCreditRating4' THEN
                                                ' AND sc.OtherCreditRating4 = negativeCategories.OtherCreditRating4'
                                            WHEN ColumnName = 'OtherCreditRating5' THEN
                                                ' AND sc.OtherCreditRating5 = negativeCategories.OtherCreditRating5'
                                            WHEN ColumnName = 'OtherCreditRating6' THEN
                                                ' AND sc.OtherCreditRating6 = negativeCategories.OtherCreditRating6'
                                            WHEN ColumnName = 'Perpetual' THEN
                                                ' AND sc.Perpetual = negativeCategories.Perpetual'
                                            WHEN ColumnName = 'RepoUsedForDiversification' THEN
                                                ' AND sc.RepoUsedForDiversification = negativeCategories.RepoUsedForDiversification'
                                            WHEN ColumnName = 'RandICreditRating' THEN
                                                ' AND sc.RandICreditRating = negativeCategories.RandICreditRating'
                                            WHEN ColumnName = 'RealpointCreditRating' THEN
                                                ' AND sc.RealpointCreditRating = negativeCategories.RealpointCreditRating'
                                            WHEN ColumnName = 'SandPCreditRating' THEN
                                                ' AND sc.SandPCreditRating = negativeCategories.SandPCreditRating'
                                            WHEN ColumnName = 'Series' THEN
                                                ' AND sc.Series = negativeCategories.Series'
                                            WHEN ColumnName = 'StepUpBond' THEN
                                                ' AND sc.StepUpBond = negativeCategories.StepUpBond'
                                            WHEN ColumnName = 'Strips' THEN
                                                ' AND sc.Strips = negativeCategories.Strips'
                                            WHEN ColumnName = 'VariableRate' THEN
                                                ' AND sc.VariableRate = negativeCategories.VariableRate'
                                            WHEN ColumnName = 'WhenIssued' THEN
                                                ' AND sc.TBADescription = negativeCategories.WhenIssued'
                                            WHEN ColumnName = 'ZeroCoupon' THEN
                                                ' AND sc.ZeroCoupon = negativeCategories.ZeroCoupon'
                                            WHEN ColumnName IN ( 'SecurityCusip', 'CustomIdentifier', 'ISIN', 'Issuer',
                                                                 'MasterIdentifier', 'SEDOL', 'Valoren', 'Werkpapier'
                                                               ) THEN
                                                CASE
                                                    WHEN CHARINDEX(
                                                                      ' AND sc.FK_SecurityMaster = negativeCategories.FK_SecurityMaster',
                                                                      @SecurityCaptionJoin
                                                                  ) > 0 THEN
                                                        ''
                                                    ELSE
                                                        ' AND sc.FK_SecurityMaster = negativeCategories.FK_SecurityMaster'
                                                END
                                        END,
                                        ''
                                    )
                    FROM dbo.CategoryDynamicAggregateColumn
                    WHERE FK_Category = @CategoryKey;

                    -- get all the securities that sum to be negative
                    SET @SQLStmt
                        = N'INSERT #SecuritiesToRecategorize ' + @Select
                          + N' FROM
							(
							SELECT FK_Category ' + @AggregationColumnList
                          + N',s.FK_AccountPeriod
							FROM dbo.SecurityBalance sb
							JOIN #Securities s ON sb.FK_SecurityMaster = s.FK_SecurityMaster AND sb.FK_AccountPeriod = s.FK_AccountPeriod
							JOIN #SecCat sc ON sc.FK_SecurityMaster = sb.FK_SecurityMaster
							JOIN dbo.SecurityCaption scap
								ON scap.FK_SecurityMaster = sb.FK_SecurityMaster
								AND scap.FK_AccountPeriod = sb.FK_AccountPeriod
								AND scap.FK_SecurityCaptionLibrary = @SecurityCaptionLibraryKey
							WHERE sb.FK_BalanceType = @BalanceTypeKey
							AND sc.FK_Category = @CategoryKey
							GROUP BY FK_Category, s.FK_AccountPeriod' + @AggregationColumnList + N' HAVING SUM('
                          + @DynamicCategorizationColumnName + N') < 0
							) negativeCategories' + @SecurityBalanceJoin + @SecurityCaptionJoin + @Where;
                END;

                -- 4. for all securities that are in a negative group,  
                -- insert them into table variable so we can use it to join below  
                -- inserting all securities into another table that have a negative sum when grouped
                TRUNCATE TABLE #SecuritiesToRecategorize;

                EXEC sp_executesql @SQLStmt,
                                   N'@AccountPeriods dbo.UniqueKeys READONLY, @BalanceTypeKey INT, @CategoryKey INT, @FundKey INT, @SecurityCaptionLibraryKey INT',
                                   @AccountPeriods = @AccountPeriods,
                                   @BalanceTypeKey = @BalanceTypeKey,
                                   @CategoryKey = @CategoryKey,
                                   @FundKey = @FundKey,
                                   @SecurityCaptionLibraryKey = @SecurityCaptionLibraryKey;

                -- 5. Update @SecurityCategorization set FK_Category, CategoryCaption, CategoryTotalCaption, etc.
                -- to the category info of the negative category. (FK_Category_Negative)
                -- for the applicable securities
                UPDATE sc
                SET FK_category = sc.FK_Category_Negative
                FROM #SecCat sc
                    JOIN #SecuritiesToRecategorize securities
                        ON sc.FK_SecurityMaster = securities.FK_SecurityMaster
                           AND sc.FK_category = securities.FK_Category
                    JOIN dbo.Category c
                        ON sc.FK_Category_Negative = c.PK_Category
                WHERE sc.FK_category = @CategoryKey
                      AND sc.FK_category <> sc.FK_Category_Negative;

                SET @SecuritiesRecategorized = @@ROWCOUNT;
                IF (@SecuritiesRecategorized > 0 AND @CalculationStatus <> 'NotCalculated')
                BEGIN
                    SET @Message
                        = N'Dynamic Categorization: Calculation Recategorized ' + LTRIM(STR(@SecuritiesRecategorized))
                          + N' securities from Category ' + CAST(@CategoryKey AS NVARCHAR(50)) + N' to Category '
                          + CAST(@NegativeCategoryKey AS NVARCHAR(50));

                    EXEC dbo.gp_WriteToCalculationLog 'Portfolio',
                                                      @FundKey,
                                                      0,
                                                      @BalanceTypeKey,
                                                      @PortfolioStatementTemplate,
                                                      @Message,
                                                      'GetPortfolioStatementSecurityCategorizationByCriteria',
                                                      NULL,
                                                      NULL,
                                                      @CalculationBatchKey;
                END;

                FETCH NEXT FROM DynamicCategoryCursor
                INTO @CategoryKey,
                     @DynamicCategorizationColumnName,
                     @NegativeCategoryKey;
            END;
            CLOSE DynamicCategoryCursor;
            DEALLOCATE DynamicCategoryCursor;
            DROP TABLE #SecuritiesToRecategorize;
        END;

        DROP TABLE #Securities;

        EXEC dbo.gp_WriteToCalculationLog 'Financial',
                                          @FundKey,
                                          0,
                                          @BalanceTypeKey,
                                          NULL,
                                          'Portfolio Holdings Categorization for calc sheet calculation engine.',
                                          'GetPortfolioHoldingsCategorizationInputValuesForCalculationEngine',
                                          NULL,
                                          NULL,
                                          @CalculationBatchKey;

        -- 6.
        INSERT INTO #SecurityCategorizationTable
        (
            PK_SecurityCategorization,
            FK_SecurityMaster,
            FK_CategoryLibrary,
            FK_Category,
            FK_Category_Negative,
            DynamicCategorizationColumnName,
            FK_Accountperiod
        )
        SELECT PK_SecurityCategorization,
               FK_SecurityMaster,
               FK_CategoryLibrary,
               FK_category,
               FK_Category_Negative,
               DynamicCategorizationColumnName,
               FK_AccountPeriod
        FROM #SecCat;

        DROP TABLE #SecCat;
    END;
    -- gp_GetPortfolioHoldingsCategoryMaturityrangeInputValuesForCalculationEngine (called for ItemType = 'HoldingsCategoryMaturityRange' below) needs this clustered index to run in one second instead of 50 seconds!!
    CREATE CLUSTERED INDEX IX_FK_CategoryLibrary_FK_Accountperiod_FK_SecurityMaster
    ON #SecurityCategorizationTable (
                                        FK_CategoryLibrary,
                                        FK_Accountperiod,
                                        FK_SecurityMaster
                                    );
    CREATE NONCLUSTERED INDEX IX_FK_Category
    ON #SecurityCategorizationTable (FK_Category);
    CREATE NONCLUSTERED INDEX IX_PK_SecurityCategorization
    ON #SecurityCategorizationTable (PK_SecurityCategorization);


    IF EXISTS
    (
        SELECT 1
        FROM #CalcSheetItemFormulaDetails
        WHERE ItemType = 'HoldingsCategory'
    )
    BEGIN

        --EXEC dbo.gp_GetPortfolioHoldingsCategoryInputValuesForCalculationEngine @FundKey, @AccountPeriodKey, @BalanceTypeKey, @FundRoundingLevel, @CalculationBatchKey;

        CREATE TABLE #CalcSheetSecurityCategorization
        (
            PK_CalculationSheetItemDetail INT NOT NULL,
            FK_SecurityMaster INT NOT NULL,
            FK_CategoryLibrary INT NULL,
            FK_Category INT NULL,
            HoldingsCategoryValue VARCHAR(256) NOT NULL,
            FK_CalculationSheetItemColumn INT NOT NULL,
            FK_AccountPeriod INT NOT NULL,
            FK_Fund INT NOT NULL,
            FK_Currency INT NULL
        );

        CREATE CLUSTERED INDEX IX_PK_CalculationSheetItemDetail_FK_SecurityMaster_FK_Fund_FK_Currency
        ON #CalcSheetSecurityCategorization (
                                                PK_CalculationSheetItemDetail,
                                                FK_SecurityMaster,
                                                FK_Fund,
                                                FK_Currency
                                            ); -- match column order in GROUP BY below

        -- insert inclusions: THIS IS THE PERFORMANCE KILLER !!!
        INSERT INTO #CalcSheetSecurityCategorization
        (
            PK_CalculationSheetItemDetail,
            FK_SecurityMaster,
            FK_CategoryLibrary,
            FK_Category,
            HoldingsCategoryValue,
            FK_CalculationSheetItemColumn,
            FK_AccountPeriod,
            FK_Fund,
            FK_Currency
        )
        SELECT DISTINCT
               csid.PK_CalculationSheetItemDetail,
               sb.FK_SecurityMaster,
               szInclusionLib.FK_CategoryLibrary,
               szInclusionLib.FK_Category,
               csid.HoldingsCategoryValue,
               csifd.FK_CalculationSheetItemColumn,
               sb.FK_AccountPeriod,
               sb.FK_Fund,
               CASE
                   WHEN csifd.PK_Currency IS NOT NULL THEN
                       sb.FK_Currency
               END AS FK_Currency
        FROM #CalcSheetItemFormulaDetails csifd
            JOIN dbo.CalculationSheetItemDetail csid
                ON csid.PK_CalculationSheetItemDetail = csifd.PK_CalculationSheetItemDetail
            JOIN dbo.CalculationSheetItemHoldingsCategoryDetail Detail
                ON Detail.FK_CalculationSheetItemDetail = csid.PK_CalculationSheetItemDetail
            JOIN dbo.SecurityBalance sb
                ON sb.FK_AccountPeriod = csifd.FK_AccountPeriod
            JOIN #FUNDS f
                ON f.FK_Fund = sb.FK_Fund
            LEFT JOIN #SecurityCategorizationTable szInclusionLib
                ON szInclusionLib.FK_SecurityMaster = sb.FK_SecurityMaster
                   AND szInclusionLib.FK_Accountperiod = csifd.FK_AccountPeriod
                   AND szInclusionLib.FK_CategoryLibrary = Detail.FK_CategoryLibrary
                   AND Detail.Operator = '='
            LEFT JOIN #SecurityCategorizationTable szExclusionLib
                ON szExclusionLib.FK_SecurityMaster = sb.FK_SecurityMaster
                   AND szExclusionLib.FK_Accountperiod = csifd.FK_AccountPeriod
                   AND szExclusionLib.FK_CategoryLibrary = Detail.FK_CategoryLibrary
                   AND Detail.Operator = '!='
            JOIN dbo.CalculationSheetItemHoldingsCategoryDetailCategory DetailCategory
                ON DetailCategory.FK_CalculationSheetItemHoldingsCategoryDetail = Detail.PK_CalculationSheetItemHoldingsCategoryDetail
                   AND
                   (
                       (
                           Detail.Operator = '='
                           AND DetailCategory.FK_Category = szInclusionLib.FK_Category
                       )
                       OR
                       (
                           Detail.Operator = '!='
                           AND szExclusionLib.PK_SecurityCategorization IS NOT NULL
                           AND DetailCategory.FK_Category <> ISNULL(szExclusionLib.FK_Category, 0)
                       )
                   )
        WHERE csifd.ItemType = 'HoldingsCategory'
              AND Detail.Operator IN ( '=', '!=' )
              AND sb.FK_BalanceType = @BalanceTypeKey
              AND
              (
                  csifd.PK_Currency IS NULL
                  OR csifd.PK_Currency = 0
                  OR csifd.PK_Currency = ISNULL(sb.FK_Currency, 0)
              )
              AND NOT EXISTS
        (
            -- Exclusions
            SELECT *
            FROM dbo.CalculationSheetItemHoldingsCategoryDetail Detail2
                JOIN #SecurityCategorizationTable szExclusionLib2
                    ON szExclusionLib2.FK_CategoryLibrary = Detail2.FK_CategoryLibrary
                JOIN dbo.CalculationSheetItemHoldingsCategoryDetailCategory DetailCategory2
                    ON DetailCategory2.FK_CalculationSheetItemHoldingsCategoryDetail = Detail2.PK_CalculationSheetItemHoldingsCategoryDetail
                       AND DetailCategory2.FK_Category = szExclusionLib2.FK_Category
            WHERE Detail2.Operator = '!='
                  AND Detail2.FK_CalculationSheetItemDetail = csid.PK_CalculationSheetItemDetail
                  AND szExclusionLib2.FK_SecurityMaster = sb.FK_SecurityMaster
        );


        CREATE TABLE #CalcSheetSecuritiesToSum
        (
            PK_CalculationSheetItemDetail INT NOT NULL,
            FK_SecurityMaster INT NULL,
            HoldingsCategoryValue VARCHAR(256) NOT NULL,
            FK_CalculationSheetItemColumn INT NOT NULL,
            FK_AccountPeriod INT NULL,
            FK_Fund INT NULL,
            FK_Currency INT NULL
        );

        CREATE UNIQUE CLUSTERED INDEX PK_CalcSheetSecuritiesToSum
        ON #CalcSheetSecuritiesToSum (
                                         PK_CalculationSheetItemDetail,
                                         FK_AccountPeriod,
                                         FK_Fund,
                                         FK_Currency,
                                         HoldingsCategoryValue,
                                         FK_SecurityMaster,
                                         FK_CalculationSheetItemColumn
                                     );


        -- insert distinct securities
        INSERT INTO #CalcSheetSecuritiesToSum
        (
            PK_CalculationSheetItemDetail,
            FK_SecurityMaster,
            HoldingsCategoryValue,
            FK_CalculationSheetItemColumn,
            FK_AccountPeriod,
            FK_Fund,
            FK_Currency
        )
        SELECT DISTINCT
               PK_CalculationSheetItemDetail,
               FK_SecurityMaster,
               HoldingsCategoryValue,
               FK_CalculationSheetItemColumn,
               FK_AccountPeriod,
               FK_Fund,
               FK_Currency
        FROM #CalcSheetSecurityCategorization t
        WHERE NOT EXISTS
        (
            -- Security Categorized more than once per item Detail
            SELECT *
            FROM
            (
                SELECT DISTINCT
                       csid.PK_CalculationSheetItemDetail AS PK_CalculationSheetItemDetail,
                       COUNT(Detail.FK_CategoryLibrary) AS CategoryLibraryCount
                FROM #CalcSheetItemFormulaDetails csifd
                    JOIN dbo.CalculationSheetItemDetail csid
                        ON csid.PK_CalculationSheetItemDetail = csifd.PK_CalculationSheetItemDetail
                    JOIN dbo.CalculationSheetItemHoldingsCategoryDetail Detail
                        ON csid.PK_CalculationSheetItemDetail = Detail.FK_CalculationSheetItemDetail
                WHERE csid.ItemType = 'HoldingsCategory'
                      AND Detail.Operator = '='
                GROUP BY csid.PK_CalculationSheetItemDetail,
                         FK_Fund,
                         PK_Currency
            ) categoryLibraries
                JOIN
                (
                    SELECT PK_CalculationSheetItemDetail,
                           FK_SecurityMaster,
                           COUNT(FK_CategoryLibrary) AS CategoryLibraryCount
                    FROM #CalcSheetSecurityCategorization
                    GROUP BY PK_CalculationSheetItemDetail,
                             FK_SecurityMaster,
                             FK_Fund,
                             FK_Currency
                ) categorization
                    ON categorization.PK_CalculationSheetItemDetail = categoryLibraries.PK_CalculationSheetItemDetail
                       AND categorization.CategoryLibraryCount <> categoryLibraries.CategoryLibraryCount
            WHERE categorization.FK_SecurityMaster = t.FK_SecurityMaster
                  AND categorization.PK_CalculationSheetItemDetail = t.PK_CalculationSheetItemDetail
        );

        DROP TABLE #CalcSheetSecurityCategorization;


        -- Add rows for calculation sheet item details that are not in list yet
        -- this happens when a calc sheet detail is pulling in holdings categories that have no securities categorized
        -- in the specified category for this fund and period.
        INSERT INTO #CalcSheetSecuritiesToSum
        (
            PK_CalculationSheetItemDetail,
            FK_SecurityMaster,
            HoldingsCategoryValue,
            FK_CalculationSheetItemColumn,
            FK_AccountPeriod,
            FK_Fund,
            FK_Currency
        )
        SELECT DISTINCT
               csid.PK_CalculationSheetItemDetail,
               NULL AS FK_SecurityMaster,
               csid.HoldingsCategoryValue,
               csifd.FK_CalculationSheetItemColumn,
               securitiesToSum.FK_AccountPeriod,
               securitiesToSum.FK_Fund,
               securitiesToSum.FK_Currency
        FROM #CalcSheetItemFormulaDetails csifd
            JOIN dbo.CalculationSheetItemDetail csid
                ON csid.PK_CalculationSheetItemDetail = csifd.PK_CalculationSheetItemDetail
            LEFT JOIN
            (
                SELECT DISTINCT
                       PK_CalculationSheetItemDetail,
                       FK_AccountPeriod,
                       FK_Fund,
                       FK_Currency
                FROM #CalcSheetSecuritiesToSum
            ) securitiesToSum
                ON securitiesToSum.PK_CalculationSheetItemDetail = csid.PK_CalculationSheetItemDetail
        WHERE csid.ItemType = 'HoldingsCategory'
              AND securitiesToSum.PK_CalculationSheetItemDetail IS NULL;

        INSERT INTO #PortfolioResultTable
        (
            FK_CalculationSheetItemDetail,
            FK_Currency,
            ValueFooted
        )
        SELECT securitiesToSum.PK_CalculationSheetItemDetail,
               securitiesToSum.FK_Currency,
               SUM(ISNULL(   CASE securitiesToSum.HoldingsCategoryValue
                                 WHEN 'AccruedInterest' THEN
                                     psv.AccruedInterestFooted
                                 WHEN 'BaseCurrencyBought' THEN
                                     psv.BaseCurrencyBoughtFooted
                                 WHEN 'BaseCurrencySold' THEN
                                     psv.BaseCurrencySoldFooted
                                 WHEN 'BaseUnitPrice' THEN
                                     psv.BaseUnitPriceFooted
                                 WHEN 'BidAskSpreadPercentCalculated' THEN
                                     psv.BidAskSpreadPercentCalculatedFooted
                                 WHEN 'BidAskSpreadValueCalculated' THEN
                                     psv.BidAskSpreadValueCalculatedFooted
                                 WHEN 'Bought' THEN
                                     psv.BoughtFooted
                                 WHEN 'BidAskSpreadValueCalculated' THEN
                                     psv.BidAskSpreadValueCalculatedFooted
                                 WHEN 'Commitments' THEN
                                     psv.CommitmentsFooted
                                 WHEN 'ContractRate' THEN
                                     psv.ContractRateFooted
                                 WHEN 'Cost' THEN
                                     psv.CostFooted
                                 WHEN 'CostCalculated' THEN
                                     psv.CostCalculatedFooted
                                 WHEN 'CouponRate' THEN
                                     psv.CouponRateFooted
                                 WHEN 'ExchangeRate' THEN
                                     psv.ExchangeRateFooted
                                 WHEN 'ExcludeCapitalSupportValue' THEN
                                     psv.ExcludeCapitalSupportValueFooted
                                 WHEN 'IncludeCapitalSupportValue' THEN
                                     psv.IncludeCapitalSupportValueFooted
                                 WHEN 'LocalCrossTrade' THEN
                                     psv.LocalCrossTradeFooted
                                 WHEN 'LocalCurrencyBought' THEN
                                     psv.LocalCurrencyBoughtFooted
                                 WHEN 'LocalCurrencySold' THEN
                                     psv.LocalCurrencySoldFooted
                                 WHEN 'MarketValue' THEN
                                     psv.MarketValueFooted
                                 WHEN 'MarketValueAsk' THEN
                                     psv.MarketValueAskFooted
                                 WHEN 'MarketValueLevelNAV' THEN
                                     psv.MarketValueLevelNAVFooted
                                 WHEN 'MarketValueLevel1' THEN
                                     psv.MarketValueLevel1Footed
                                 WHEN 'MarketValueLevel2' THEN
                                     psv.MarketValueLevel2Footed
                                 WHEN 'MarketValueLevel3' THEN
                                     psv.MarketValueLevel3Footed
                                 WHEN 'MarketValueAskCalculated' THEN
                                     psv.MarketValueAskCalculatedFooted
                                 WHEN 'MarketValueBid' THEN
                                     psv.MarketValueBidFooted
                                 WHEN 'MarketValueBidCalculated' THEN
                                     psv.MarketValueBidCalculatedFooted
                                 WHEN 'Multiplier' THEN
                                     psv.MultiplierFooted
                                 WHEN 'NotionalAmount' THEN
                                     psv.NotionalAmountFooted
                                 WHEN 'OptionPremium' THEN
                                     psv.OptionPremiumFooted
                                 WHEN 'PercentOfNetAssets' THEN
                                     psv.PercentOfNetAssetsFooted
                                 WHEN 'PercentageOfPar' THEN
                                     psv.PercentOfParFooted
                                 WHEN 'PercentOfTotalInvestments' THEN
                                     psv.PercentOfTotalInvestmentsFooted
                                 WHEN 'PriceAsk' THEN
                                     psv.PriceAskFooted
                                 WHEN 'PriceBid' THEN
                                     psv.PriceBidFooted
                                 WHEN 'Proceeds' THEN
                                     psv.ProceedsFooted
                                 WHEN 'PurchaseAmountBase' THEN
                                     psv.PurchaseAmountBaseFooted
                                 WHEN 'PurchaseAmountLocal' THEN
                                     psv.PurchaseAmountLocalFooted
                                 WHEN 'PurchaseCost' THEN
                                     psv.PurchaseCostFooted
                                 WHEN 'Shares' THEN
                                     psv.SharesFooted
                                 WHEN 'Sold' THEN
                                     psv.SoldFooted
                                 WHEN 'SoldAmountBase' THEN
                                     psv.SoldAmountBaseFooted
                                 WHEN 'SoldAmountLocal' THEN
                                     psv.SoldAmountLocalFooted
                                 WHEN 'UnrealizedValue' THEN
                                     psv.UnrealizedValueFooted
                                 WHEN 'UnrealizedValueCalculated' THEN
                                     psv.UnrealizedValueCalculatedFooted
                                 WHEN 'UnrealizedValueAskCalculated' THEN
                                     psv.UnrealizedValueAskCalculatedFooted
                                 WHEN 'UnrealizedValueBidCalculated' THEN
                                     psv.UnrealizedValueBidCalculatedFooted
                                 WHEN 'Yield' THEN
                                     psv.YieldFooted
                                 WHEN N'AccruedDiscountsPremiums' THEN
                                     psv.AccruedDiscountsPremiumsFooted
                                 WHEN N'CapitalGainDistributions' THEN
                                     psv.CapitalGainDistributionsFooted
                                 WHEN N'CashCollateralSecurityValue' THEN
                                     psv.CashCollateralSecurityValueFooted
                                 WHEN N'ChangeinUnrealizedValue' THEN
                                     psv.ChangeinUnrealizedValueFooted
                                 WHEN N'ChangeinUnrealizedValueCalculated' THEN
                                     psv.ChangeinUnrealizedValueCalculatedFooted
                                 WHEN N'CommittedCapital' THEN
                                     psv.CommittedCapitalFooted
                                 WHEN N'ConversionRatio' THEN
                                     psv.ConversionRatioFooted
                                 WHEN N'CumulativeContributedCapital' THEN
                                     psv.CumulativeContributedCapitalFooted
                                 WHEN N'CurrencyDescriptionBought' THEN
                                     psv.CurrencyDescriptionBoughtFooted
                                 WHEN N'CurrencyDescriptionSold' THEN
                                     psv.CurrencyDescriptionSoldFooted
                                 WHEN N'Delta' THEN
                                     psv.DeltaFooted
                                 WHEN N'DividendsAffiliatedIssuers' THEN
                                     psv.DividendsAffiliatedIssuersFooted
                                 WHEN N'ExercisePrice' THEN
                                     psv.ExercisePriceFooted
                                 WHEN N'Gamma' THEN
                                     psv.GammaFooted
                                 WHEN N'Income' THEN
                                     psv.IncomeFooted
                                 WHEN N'MarketValueofSharesPurchased' THEN
                                     psv.MarketValueofSharesPurchasedFooted
                                 WHEN N'MarketValueofSharesSold' THEN
                                     psv.MarketValueofSharesSoldFooted
                                 WHEN N'NetMarketValueofSharesActivityCalculated' THEN
                                     psv.NetMarketValueOfSharesActivityCalculatedFooted
                                 WHEN N'NetMarketValueofSharesSoldCalculated' THEN
                                     psv.NetMarketValueOfSharesSoldCalculatedFooted
                                 WHEN N'NetSharesActivityCalculated' THEN
                                     psv.NetSharesActivityCalculatedFooted
                                 WHEN N'NetSharesSoldcalculated' THEN
                                     psv.NetSharesSoldCalculatedFooted
                                 WHEN N'MarketValueTransferLevel1From2BeginOfPeriod' THEN
                                     psv.MarketValueTransferLevel1From2BeginOfPeriodFooted
                                 WHEN N'MarketValueTransferLevel1From2EndOfPeriod' THEN
                                     psv.MarketValueTransferLevel1From2EndOfPeriodFooted
                                 WHEN N'MarketValueTransferLevel2From1BeginOfPeriod' THEN
                                     psv.MarketValueTransferLevel2From1BeginOfPeriodFooted
                                 WHEN N'MarketValueTransferLevel2From1EndOfPeriod' THEN
                                     psv.MarketValueTransferLevel2From1EndOfPeriodFooted
                                 WHEN N'MarketValueTransferLevel2From3BeginOfPeriod' THEN
                                     psv.MarketValueTransferLevel2From3BeginOfPeriodFooted
                                 WHEN N'MarketValueTransferLevel2From3EndOfPeriod' THEN
                                     psv.MarketValueTransferLevel2From3EndOfPeriodFooted
                                 WHEN N'MarketValueTransferLevel3From2BeginOfPeriod' THEN
                                     psv.MarketValueTransferLevel3From2BeginOfPeriodFooted
                                 WHEN N'MarketValueTransferLevel3From2EndOfPeriod' THEN
                                     psv.MarketValueTransferLevel3From2EndOfPeriodFooted
                                 WHEN N'MarketValueLevel3TransferInBeginOfPeriod' THEN
                                     psv.MarketValueLevel3TransferInBeginOfPeriodFooted
                                 WHEN N'MarketValueLevel3TransferOutBeginOfPeriod' THEN
                                     psv.MarketValueLevel3TransferOutBeginOfPeriodFooted
                                 WHEN N'MarketValueLevel3TransferInEndOfPeriod' THEN
                                     psv.MarketValueLevel3TransferInEndOfPeriodFooted
                                 WHEN N'MarketValueLevel3TransferOutEndOfPeriod' THEN
                                     psv.MarketValueLevel3TransferOutEndOfPeriodFooted
                                 WHEN N'NonCashCollateralSecurityValue' THEN
                                     psv.NonCashCollateralSecurityValueFooted
                                 WHEN N'NumberofContracts' THEN
                                     psv.NumberOfContractsFooted
                                 WHEN N'RealizedValue' THEN
                                     psv.RealizedValueFooted
                                 WHEN N'RemainingCommitment' THEN
                                     psv.RemainingCommitmentFooted
                                 WHEN N'RepurchaseRate' THEN
                                     psv.RepurchaseRateFooted
                                 WHEN N'SharesPurchased' THEN
                                     psv.SharesPurchasedFooted
                                 WHEN N'SharesSold' THEN
                                     psv.SharesSoldFooted
                                 WHEN N'StrikePrice' THEN
                                     psv.StrikePriceFooted
                                 WHEN N'TotalDistributions' THEN
                                     psv.TotalDistributionsFooted
                                 WHEN N'UnrealizedAppreciationDepreciation' THEN
                                     psv.UnrealizedAppreciationDepreciationFooted
                                 WHEN N'UnrealizedValueCalculated' THEN
                                     psv.UnrealizedValueCalculatedFooted
                                 WHEN N'UpfrontPaymentsReceipts' THEN
                                     psv.UpfrontPaymentsReceiptsFooted
                                 WHEN N'Vega' THEN
                                     psv.VegaFooted
                                 ELSE
                                     psv.MarketValueFooted
                             END,
                             0
                         )
                  ) AS ValueFooted
        FROM #CalcSheetSecuritiesToSum securitiesToSum
            LEFT OUTER JOIN dbo.SecurityBalance sb
                ON sb.FK_SecurityMaster = securitiesToSum.FK_SecurityMaster
                   AND sb.FK_Fund = securitiesToSum.FK_Fund
                   AND sb.FK_AccountPeriod = securitiesToSum.FK_AccountPeriod
                   AND sb.FK_BalanceType = @BalanceTypeKey
            LEFT OUTER JOIN dbo.PortfolioStatementValueStatus psvs
                ON psvs.FK_PortfolioStatementTemplate = @PortfolioStatementTemplate
                   AND psvs.FK_AccountPeriod = securitiesToSum.FK_AccountPeriod
                   AND psvs.FK_BalanceType = @BalanceTypeKey
                   AND psvs.FK_Fund = @FundKey
            LEFT OUTER JOIN dbo.PortfolioStatementValue psv
                ON psv.FK_SecurityBalance = sb.PK_SecurityBalance
                   AND psv.FK_PortfolioStatementValueStatus = psvs.PK_PortfolioStatementValueStatus
        GROUP BY securitiesToSum.PK_CalculationSheetItemDetail,
                 securitiesToSum.HoldingsCategoryValue,
                 securitiesToSum.FK_Currency;


        DROP TABLE #CalcSheetSecuritiesToSum;


        EXEC dbo.gp_WriteToCalculationLog 'Financial',
                                          @FundKey,
                                          @AccountPeriodKey,
                                          @BalanceTypeKey,
                                          NULL,
                                          'PortfolioHoldingsCategory data retrieval complete for calc sheet calculation engine.',
                                          'GetPortfolioHoldingsCategoryInputValuesForCalculationEngine',
                                          NULL,
                                          NULL,
                                          @CalculationBatchKey;

    END; -- EXISTS (SELECT 1 FROM #CalcSheetItemFormulaDetails WHERE ItemType = 'HoldingsCategory')

    IF EXISTS
    (
        SELECT 1
        FROM #CalcSheetItemFormulaDetails
        WHERE ItemType = 'PortfolioStatementDefinition'
    )
    BEGIN
        -- This procedure is quite simple (only one SELECT and one UPDATE) and likely already perfect so we'll save it for last.
        INSERT INTO #PortfolioResultTable
        (
            FK_CalculationSheetItemDetail,
            ValueFooted
        )
        EXEC dbo.gp_GetPortfolioStatementDefinitionInputValuesForCalculationEngine @FundKey,
                                                                                   @AccountPeriodKey,
                                                                                   @BalanceTypeKey,
                                                                                   @CalculationBatchKey;
    END;


    DECLARE @LanguageKey INT;
    SELECT @LanguageKey = FK_Language
    FROM dbo.Complex
    WHERE PK_Complex =
    (
        SELECT FK_Complex
        FROM dbo.TrialBalanceDefinition
        WHERE PK_TrialBalanceDefinition =
        (
            SELECT TOP 1 FK_TrialBalanceDefinition FROM #CalcSheetItemFormulaDetails
        )
    );

    DECLARE @SecurityCaptionLibraryLanguageKey INT;
    SET @SecurityCaptionLibraryLanguageKey
        = ISNULL(dbo.gf_GetSecurityCaptionLibraryLanaguageKeyByCriteria(@SecurityCaptionLibraryKey, @LanguageKey), 0);

    IF EXISTS
    (
        SELECT 1
        FROM #CalcSheetItemFormulaDetails
        WHERE ItemType = 'HoldingsCategoryMaturityRange'
    )
    BEGIN
        --INSERT INTO #PortfolioResultTable (FK_CalculationSheetItemDetail, FK_Currency, RoundingLevel, RoundToThousandsDecimalPlaces, ValueFooted)
        --EXEC dbo.gp_GetPortfolioHoldingsCategoryMaturityrangeInputValuesForCalculationEngine @FundKey, @AccountPeriodKey, @BalanceTypeKey, @FundRoundingLevel, @CalculationBatchKey;


        CREATE TABLE #CalcSheetSecurityCategorization2
        (
            PK_CalculationSheetItemDetail INT NOT NULL,
            FK_SecurityMaster INT,
            FK_CategoryLibrary INT,
            FK_Category INT,
            HoldingsCategoryValue NVARCHAR(256),
            FK_CalculationSheetItemColumn INT,
            FK_AccountPeriod INT,
            FK_Fund INT,
            FK_Currency INT NULL
        );

        CREATE TABLE #CalcSheetSecuritiesToSum2
        (
            PK_CalculationSheetItemDetail INT,
            FK_SecurityMaster INT NULL,
            HoldingsCategoryValue NVARCHAR(256),
            FK_CalculationSheetItemColumn INT,
            FK_AccountPeriod INT,
            FK_Fund INT,
            FK_Currency INT
        );

        -- insert inclusions into table variable
        INSERT INTO #CalcSheetSecurityCategorization2
        (
            PK_CalculationSheetItemDetail,
            FK_SecurityMaster,
            FK_CategoryLibrary,
            FK_Category,
            HoldingsCategoryValue,
            FK_CalculationSheetItemColumn,
            FK_AccountPeriod,
            FK_Fund,
            FK_Currency
        )
        SELECT DISTINCT
               csid.PK_CalculationSheetItemDetail,
               ISNULL(scException.FK_SecurityMaster, sc.FK_SecurityMaster) AS FK_SecurityMaster,
               szInclusionLib.FK_CategoryLibrary,
               szInclusionLib.FK_Category,
               csid.HoldingsCategoryValue,
               csifd.FK_CalculationSheetItemColumn,
               sc.FK_AccountPeriod,
               f.FK_Fund,
               CASE
                   WHEN csifd.PK_Currency IS NOT NULL THEN
                       sb.FK_Currency
               END AS FK_Currency
        FROM #CalcSheetItemFormulaDetails csifd
            JOIN dbo.CalculationSheetItemDetail csid
                ON csid.PK_CalculationSheetItemDetail = csifd.PK_CalculationSheetItemDetail
            JOIN dbo.CalculationSheetItemHoldingsCategoryDetail Detail
                ON csid.PK_CalculationSheetItemDetail = Detail.FK_CalculationSheetItemDetail
            CROSS JOIN #FUNDS f
            JOIN dbo.SecurityCaption sc
                ON sc.FK_AccountPeriod = csifd.FK_AccountPeriod
                   AND
                   (
                       sc.FK_SecurityCaptionLibraryLanguage = @SecurityCaptionLibraryLanguageKey
                       OR sc.FK_SecurityCaptionLibraryLanguage IS NULL
                   )
                   AND ISNULL(sc.FK_Fund_SecurityException, 0) = ISNULL(
                                                                 (
                                                                     SELECT FK_Fund_SecurityException
                                                                     FROM dbo.SecurityCaption
                                                                     WHERE FK_AccountPeriod = sc.FK_AccountPeriod
                                                                           AND FK_SecurityCaptionLibrary = sc.FK_SecurityCaptionLibrary
                                                                           AND FK_SecurityMaster = sc.FK_SecurityMaster
                                                                           AND ISNULL(
                                                                                         FK_SecurityCaptionLibraryLanguage,
                                                                                         0
                                                                                     ) = ISNULL(
                                                                                                   sc.FK_SecurityCaptionLibraryLanguage,
                                                                                                   0
                                                                                               )
                                                                           AND ISNULL(FK_Fund_SecurityException, 0) = ISNULL(
                                                                                                                                f.FK_Fund,
                                                                                                                                0
                                                                                                                            )
                                                                 ),
                                                                 0
                                                                       )
                   AND sc.MaturityDate
                   BETWEEN DATEADD(   DAY,
                                      csid.HoldingsMaturityFromDay,
                           (
                               SELECT AccountPeriodEnd
                               FROM dbo.AccountPeriod
                               WHERE PK_AccountPeriod = sc.FK_AccountPeriod
                           )
                                  ) AND DATEADD(   DAY,
                                                   csid.HoldingsMaturityToDay,
                                        (
                                            SELECT AccountPeriodEnd
                                            FROM dbo.AccountPeriod
                                            WHERE PK_AccountPeriod = sc.FK_AccountPeriod
                                        )
                                               )
            LEFT OUTER JOIN dbo.SecurityCaption scException
                ON sc.FK_AccountPeriod = csifd.FK_AccountPeriod
                   AND scException.FK_SecurityCaptionLibrary = sc.FK_SecurityCaptionLibrary
                   AND scException.FK_Fund_SecurityException = f.FK_Fund
                   AND scException.PK_SecurityCaption IS NULL
                   AND scException.MaturityDate
                   BETWEEN DATEADD(   DAY,
                                      csid.HoldingsMaturityFromDay,
                           (
                               SELECT AccountPeriodEnd
                               FROM dbo.AccountPeriod
                               WHERE PK_AccountPeriod = sc.FK_AccountPeriod
                           )
                                  ) AND DATEADD(   DAY,
                                                   csid.HoldingsMaturityToDay,
                                        (
                                            SELECT AccountPeriodEnd
                                            FROM dbo.AccountPeriod
                                            WHERE PK_AccountPeriod = sc.FK_AccountPeriod
                                        )
                                               )
            LEFT OUTER JOIN dbo.SecurityBalance sb
                ON sb.FK_SecurityMaster = ISNULL(scException.FK_SecurityMaster, sc.FK_SecurityMaster)
                   AND sb.FK_Fund = f.FK_Fund
                   AND sb.FK_AccountPeriod = csifd.FK_AccountPeriod
                   AND sb.FK_BalanceType = @BalanceTypeKey
            LEFT OUTER JOIN #SecurityCategorizationTable szInclusionLib
                ON szInclusionLib.FK_SecurityMaster = ISNULL(scException.FK_SecurityMaster, sc.FK_SecurityMaster)
                   AND szInclusionLib.FK_Accountperiod = csifd.FK_AccountPeriod
                   AND szInclusionLib.FK_CategoryLibrary = Detail.FK_CategoryLibrary
                   AND Detail.Operator = '='
            LEFT OUTER JOIN #SecurityCategorizationTable szExclusionLib
                ON szExclusionLib.FK_SecurityMaster = ISNULL(scException.FK_SecurityMaster, sc.FK_SecurityMaster)
                   AND szExclusionLib.FK_Accountperiod = csifd.FK_AccountPeriod
                   AND szExclusionLib.FK_CategoryLibrary = Detail.FK_CategoryLibrary
                   AND Detail.Operator = '!='
            JOIN dbo.CalculationSheetItemHoldingsCategoryDetailCategory DetailCategory
                ON Detail.PK_CalculationSheetItemHoldingsCategoryDetail = DetailCategory.FK_CalculationSheetItemHoldingsCategoryDetail
                   AND
                   (
                       (
                           Detail.Operator = '='
                           AND szInclusionLib.PK_SecurityCategorization IS NOT NULL
                           AND DetailCategory.FK_Category = ISNULL(szInclusionLib.FK_Category, 0)
                       )
                       OR
                       (
                           Detail.Operator = '!='
                           AND szExclusionLib.PK_SecurityCategorization IS NOT NULL
                           AND DetailCategory.FK_Category != ISNULL(szExclusionLib.FK_Category, 0)
                       )
                   )
        WHERE csifd.ItemType = 'HoldingsCategoryMaturityRange'
              AND Detail.Operator IN ( '=', '!=' )
              AND sc.FK_SecurityCaptionLibrary = @SecurityCaptionLibraryKey
              AND
              (
                  csifd.PK_Currency IS NULL
                  OR csifd.PK_Currency = 0
                  OR csifd.PK_Currency = ISNULL(sb.FK_Currency, 0)
              );


        CREATE CLUSTERED INDEX IX_PK_CalculationSheetItemDetail_FK_SecurityMaster_FK_Fund_FK_Currency
        ON #CalcSheetSecurityCategorization2 (
                                                 PK_CalculationSheetItemDetail,
                                                 FK_SecurityMaster,
                                                 FK_Fund,
                                                 FK_Currency
                                             ); -- match column order in GROUP BY below 


        --Delete if Security Categorized more than once per itemDetail
        DELETE calcSheetSecurityCategorization
        FROM #CalcSheetSecurityCategorization2 calcSheetSecurityCategorization
            JOIN
            (
                SELECT DISTINCT
                       csid.PK_CalculationSheetItemDetail,
                       COUNT(Detail.FK_CategoryLibrary) AS CategoryLibraryCount
                FROM #CalcSheetItemFormulaDetails csifd
                    JOIN dbo.CalculationSheetItemDetail csid
                        ON csid.PK_CalculationSheetItemDetail = csifd.PK_CalculationSheetItemDetail
                    JOIN dbo.CalculationSheetItemHoldingsCategoryDetail Detail
                        ON csid.PK_CalculationSheetItemDetail = Detail.FK_CalculationSheetItemDetail
                WHERE csifd.ItemType = 'HoldingsCategoryMaturityRange'
                      AND Detail.Operator = '='
                GROUP BY csid.PK_CalculationSheetItemDetail,
                         FK_Fund,
                         PK_Currency
            ) categoryLibraries
                ON categoryLibraries.PK_CalculationSheetItemDetail = calcSheetSecurityCategorization.PK_CalculationSheetItemDetail
            JOIN
            (
                SELECT DISTINCT
                       PK_CalculationSheetItemDetail,
                       FK_SecurityMaster,
                       COUNT(FK_CategoryLibrary) AS CategoryLibraryCount
                FROM #CalcSheetSecurityCategorization2
                GROUP BY PK_CalculationSheetItemDetail,
                         FK_SecurityMaster,
                         FK_Fund,
                         FK_Currency
            ) categorization
                ON categorization.PK_CalculationSheetItemDetail = calcSheetSecurityCategorization.PK_CalculationSheetItemDetail
                   AND categorization.FK_SecurityMaster = calcSheetSecurityCategorization.FK_SecurityMaster
                   AND categorization.CategoryLibraryCount <> categoryLibraries.CategoryLibraryCount;


        DELETE calcSheetSecurityCategorization
        FROM #CalcSheetSecurityCategorization2 calcSheetSecurityCategorization
            JOIN dbo.CalculationSheetItemHoldingsCategoryDetail Detail
                ON calcSheetSecurityCategorization.PK_CalculationSheetItemDetail = Detail.FK_CalculationSheetItemDetail
            LEFT JOIN #SecurityCategorizationTable szExclusionLib
                ON szExclusionLib.FK_SecurityMaster = calcSheetSecurityCategorization.FK_SecurityMaster
                   AND Detail.FK_CategoryLibrary = szExclusionLib.FK_CategoryLibrary
            JOIN dbo.CalculationSheetItemHoldingsCategoryDetailCategory DetailCategory
                ON Detail.PK_CalculationSheetItemHoldingsCategoryDetail = DetailCategory.FK_CalculationSheetItemHoldingsCategoryDetail
                   AND DetailCategory.FK_Category = ISNULL(szExclusionLib.FK_Category, 0)
        WHERE Detail.Operator = '!=';


        INSERT INTO #CalcSheetSecuritiesToSum2
        (
            PK_CalculationSheetItemDetail,
            FK_SecurityMaster,
            HoldingsCategoryValue,
            FK_CalculationSheetItemColumn,
            FK_AccountPeriod,
            FK_Fund,
            FK_Currency
        )
        SELECT DISTINCT
               PK_CalculationSheetItemDetail,
               FK_SecurityMaster,
               HoldingsCategoryValue,
               FK_CalculationSheetItemColumn,
               FK_AccountPeriod,
               FK_Fund,
               FK_Currency
        FROM #CalcSheetSecurityCategorization2;

        DROP TABLE #CalcSheetSecurityCategorization2;


        -- Add rows for calculation sheet item details that are not in list yet
        -- this happens when a calc sheet detail is pulling in holdings categories that have no securities categorized
        -- in the specified category for this fund and period.
        INSERT INTO #CalcSheetSecuritiesToSum2
        (
            PK_CalculationSheetItemDetail,
            FK_SecurityMaster,
            HoldingsCategoryValue,
            FK_CalculationSheetItemColumn,
            FK_AccountPeriod,
            FK_Fund,
            FK_Currency
        )
        SELECT DISTINCT
               csid.PK_CalculationSheetItemDetail,
               NULL AS FK_SecurityMaster,
               csid.HoldingsCategoryValue,
               csifd.FK_CalculationSheetItemColumn,
               securitiesToSum.FK_AccountPeriod,
               securitiesToSum.FK_Fund,
               securitiesToSum.FK_Currency
        FROM #CalcSheetItemFormulaDetails csifd
            JOIN dbo.CalculationSheetItemDetail csid
                ON csid.PK_CalculationSheetItemDetail = csifd.PK_CalculationSheetItemDetail
            LEFT JOIN #CalcSheetSecuritiesToSum2 securitiesToSum
                ON securitiesToSum.PK_CalculationSheetItemDetail = csid.PK_CalculationSheetItemDetail
        WHERE csifd.ItemType = 'HoldingsCategoryMaturityRange'
              AND securitiesToSum.PK_CalculationSheetItemDetail IS NULL;

        CREATE CLUSTERED INDEX IX_PK_CalculationSheetItemDetail_HoldingsCategoryValue_FK_Currency
        ON #CalcSheetSecuritiesToSum2 (
                                          PK_CalculationSheetItemDetail,
                                          HoldingsCategoryValue,
                                          FK_Currency
                                      )
        WITH (FILLFACTOR = 100);
        -- Tested and confirmed optimal column sort order matching GROUP BY clause below to avoid costly Sort in execution plan that joins to SecurityBalance


        INSERT INTO #PortfolioResultTable
        (
            FK_CalculationSheetItemDetail,
            FK_Currency,
            ValueFooted
        )
        SELECT securitiesToSum.PK_CalculationSheetItemDetail,
               securitiesToSum.FK_Currency,
               SUM(ISNULL(   CASE securitiesToSum.HoldingsCategoryValue
                                 WHEN 'AccruedInterest' THEN
                                     psv.AccruedInterestFooted
                                 WHEN 'BaseCurrencyBought' THEN
                                     psv.BaseCurrencyBoughtFooted
                                 WHEN 'BaseCurrencySold' THEN
                                     psv.BaseCurrencySoldFooted
                                 WHEN 'BaseUnitPrice' THEN
                                     psv.BaseUnitPriceFooted
                                 WHEN 'BidAskSpreadPercentCalculated' THEN
                                     psv.BidAskSpreadPercentCalculatedFooted
                                 WHEN 'BidAskSpreadValueCalculated' THEN
                                     psv.BidAskSpreadValueCalculatedFooted
                                 WHEN 'Bought' THEN
                                     psv.BoughtFooted
                                 WHEN 'BidAskSpreadValueCalculated' THEN
                                     psv.BidAskSpreadValueCalculatedFooted
                                 WHEN 'Commitments' THEN
                                     psv.CommitmentsFooted
                                 WHEN 'ContractRate' THEN
                                     psv.ContractRateFooted
                                 WHEN 'Cost' THEN
                                     psv.CostFooted
                                 WHEN 'CostCalculated' THEN
                                     psv.CostCalculatedFooted
                                 WHEN 'CouponRate' THEN
                                     psv.CouponRateFooted
                                 WHEN 'ExchangeRate' THEN
                                     psv.ExchangeRateFooted
                                 WHEN 'ExcludeCapitalSupportValue' THEN
                                     psv.ExcludeCapitalSupportValueFooted
                                 WHEN 'IncludeCapitalSupportValue' THEN
                                     psv.IncludeCapitalSupportValueFooted
                                 WHEN 'LocalCrossTrade' THEN
                                     psv.LocalCrossTradeFooted
                                 WHEN 'LocalCurrencyBought' THEN
                                     psv.LocalCurrencyBoughtFooted
                                 WHEN 'LocalCurrencySold' THEN
                                     psv.LocalCurrencySoldFooted
                                 WHEN 'MarketValue' THEN
                                     psv.MarketValueFooted
                                 WHEN 'MarketValueAsk' THEN
                                     psv.MarketValueAskFooted
                                 WHEN 'MarketValueLevelNAV' THEN
                                     psv.MarketValueLevelNAVFooted
                                 WHEN 'MarketValueLevel1' THEN
                                     psv.MarketValueLevel1Footed
                                 WHEN 'MarketValueLevel2' THEN
                                     psv.MarketValueLevel2Footed
                                 WHEN 'MarketValueLevel3' THEN
                                     psv.MarketValueLevel3Footed
                                 WHEN 'MarketValueAskCalculated' THEN
                                     psv.MarketValueAskCalculatedFooted
                                 WHEN 'MarketValueBid' THEN
                                     psv.MarketValueBidFooted
                                 WHEN 'MarketValueBidCalculated' THEN
                                     psv.MarketValueBidCalculatedFooted
                                 WHEN 'Multiplier' THEN
                                     psv.MultiplierFooted
                                 WHEN 'NotionalAmount' THEN
                                     psv.NotionalAmountFooted
                                 WHEN 'OptionPremium' THEN
                                     psv.OptionPremiumFooted
                                 WHEN 'PercentOfNetAssets' THEN
                                     psv.PercentOfNetAssetsFooted
                                 WHEN 'PercentageOfPar' THEN
                                     psv.PercentOfParFooted
                                 WHEN 'PercentOfTotalInvestments' THEN
                                     psv.PercentOfTotalInvestmentsFooted
                                 WHEN 'PriceAsk' THEN
                                     psv.PriceAskFooted
                                 WHEN 'PriceBid' THEN
                                     psv.PriceBidFooted
                                 WHEN 'Proceeds' THEN
                                     psv.ProceedsFooted
                                 WHEN 'PurchaseAmountBase' THEN
                                     psv.PurchaseAmountBaseFooted
                                 WHEN 'PurchaseAmountLocal' THEN
                                     psv.PurchaseAmountLocalFooted
                                 WHEN 'PurchaseCost' THEN
                                     psv.PurchaseCostFooted
                                 WHEN 'Shares' THEN
                                     psv.SharesFooted
                                 WHEN 'Sold' THEN
                                     psv.SoldFooted
                                 WHEN 'SoldAmountBase' THEN
                                     psv.SoldAmountBaseFooted
                                 WHEN 'SoldAmountLocal' THEN
                                     psv.SoldAmountLocalFooted
                                 WHEN 'UnrealizedValue' THEN
                                     psv.UnrealizedValueFooted
                                 WHEN 'UnrealizedValueCalculated' THEN
                                     psv.UnrealizedValueCalculatedFooted
                                 WHEN 'UnrealizedValueAskCalculated' THEN
                                     psv.UnrealizedValueAskCalculatedFooted
                                 WHEN 'UnrealizedValueBidCalculated' THEN
                                     psv.UnrealizedValueBidCalculatedFooted
                                 WHEN 'Yield' THEN
                                     psv.YieldFooted
                                 WHEN N'AccruedDiscountsPremiums' THEN
                                     psv.AccruedDiscountsPremiumsFooted
                                 WHEN N'CapitalGainDistributions' THEN
                                     psv.CapitalGainDistributionsFooted
                                 WHEN N'CashCollateralSecurityValue' THEN
                                     psv.CashCollateralSecurityValueFooted
                                 WHEN N'ChangeinUnrealizedValue' THEN
                                     psv.ChangeinUnrealizedValueFooted
                                 WHEN N'ChangeinUnrealizedValueCalculated' THEN
                                     psv.ChangeinUnrealizedValueCalculatedFooted
                                 WHEN N'CommittedCapital' THEN
                                     psv.CommittedCapitalFooted
                                 WHEN N'ConversionRatio' THEN
                                     psv.ConversionRatioFooted
                                 WHEN N'CumulativeContributedCapital' THEN
                                     psv.CumulativeContributedCapitalFooted
                                 WHEN N'CurrencyDescriptionBought' THEN
                                     psv.CurrencyDescriptionBoughtFooted
                                 WHEN N'CurrencyDescriptionSold' THEN
                                     psv.CurrencyDescriptionSoldFooted
                                 WHEN N'Delta' THEN
                                     psv.DeltaFooted
                                 WHEN N'DividendsAffiliatedIssuers' THEN
                                     psv.DividendsAffiliatedIssuersFooted
                                 WHEN N'ExercisePrice' THEN
                                     psv.ExercisePriceFooted
                                 WHEN N'Gamma' THEN
                                     psv.GammaFooted
                                 WHEN N'Income' THEN
                                     psv.IncomeFooted
                                 WHEN N'MarketValueofSharesPurchased' THEN
                                     psv.MarketValueofSharesPurchasedFooted
                                 WHEN N'MarketValueofSharesSold' THEN
                                     psv.MarketValueofSharesSoldFooted
                                 WHEN N'NetMarketValueofSharesActivityCalculated' THEN
                                     psv.NetMarketValueOfSharesActivityCalculatedFooted
                                 WHEN N'NetMarketValueofSharesSoldCalculated' THEN
                                     psv.NetMarketValueOfSharesSoldCalculatedFooted
                                 WHEN N'NetSharesActivityCalculated' THEN
                                     psv.NetSharesActivityCalculatedFooted
                                 WHEN N'NetSharesSoldcalculated' THEN
                                     psv.NetSharesSoldCalculatedFooted
                                 WHEN N'MarketValueTransferLevel1From2BeginOfPeriod' THEN
                                     psv.MarketValueTransferLevel1From2BeginOfPeriodFooted
                                 WHEN N'MarketValueTransferLevel1From2EndOfPeriod' THEN
                                     psv.MarketValueTransferLevel1From2EndOfPeriodFooted
                                 WHEN N'MarketValueTransferLevel2From1BeginOfPeriod' THEN
                                     psv.MarketValueTransferLevel2From1BeginOfPeriodFooted
                                 WHEN N'MarketValueTransferLevel2From1EndOfPeriod' THEN
                                     psv.MarketValueTransferLevel2From1EndOfPeriodFooted
                                 WHEN N'MarketValueTransferLevel2From3BeginOfPeriod' THEN
                                     psv.MarketValueTransferLevel2From3BeginOfPeriodFooted
                                 WHEN N'MarketValueTransferLevel2From3EndOfPeriod' THEN
                                     psv.MarketValueTransferLevel2From3EndOfPeriodFooted
                                 WHEN N'MarketValueTransferLevel3From2BeginOfPeriod' THEN
                                     psv.MarketValueTransferLevel3From2BeginOfPeriodFooted
                                 WHEN N'MarketValueTransferLevel3From2EndOfPeriod' THEN
                                     psv.MarketValueTransferLevel3From2EndOfPeriodFooted
                                 WHEN N'MarketValueLevel3TransferInBeginOfPeriod' THEN
                                     psv.MarketValueLevel3TransferInBeginOfPeriodFooted
                                 WHEN N'MarketValueLevel3TransferOutBeginOfPeriod' THEN
                                     psv.MarketValueLevel3TransferOutBeginOfPeriodFooted
                                 WHEN N'MarketValueLevel3TransferInEndOfPeriod' THEN
                                     psv.MarketValueLevel3TransferInEndOfPeriodFooted
                                 WHEN N'MarketValueLevel3TransferOutEndOfPeriod' THEN
                                     psv.MarketValueLevel3TransferOutEndOfPeriodFooted
                                 WHEN N'NonCashCollateralSecurityValue' THEN
                                     psv.NonCashCollateralSecurityValueFooted
                                 WHEN N'NumberofContracts' THEN
                                     psv.NumberOfContractsFooted
                                 WHEN N'RealizedValue' THEN
                                     psv.RealizedValueFooted
                                 WHEN N'RemainingCommitment' THEN
                                     psv.RemainingCommitmentFooted
                                 WHEN N'RepurchaseRate' THEN
                                     psv.RepurchaseRateFooted
                                 WHEN N'SharesPurchased' THEN
                                     psv.SharesPurchasedFooted
                                 WHEN N'SharesSold' THEN
                                     psv.SharesSoldFooted
                                 WHEN N'StrikePrice' THEN
                                     psv.StrikePriceFooted
                                 WHEN N'TotalDistributions' THEN
                                     psv.TotalDistributionsFooted
                                 WHEN N'UnrealizedAppreciationDepreciation' THEN
                                     psv.UnrealizedAppreciationDepreciationFooted
                                 WHEN N'UnrealizedValueCalculated' THEN
                                     psv.UnrealizedValueCalculatedFooted
                                 WHEN N'UpfrontPaymentsReceipts' THEN
                                     psv.UpfrontPaymentsReceiptsFooted
                                 WHEN N'Vega' THEN
                                     psv.VegaFooted
                                 ELSE
                                     psv.MarketValueFooted
                             END,
                             0
                         )
                  ) AS ValueFooted
        FROM #CalcSheetSecuritiesToSum2 securitiesToSum
            LEFT OUTER JOIN dbo.SecurityBalance sb
                ON sb.FK_SecurityMaster = securitiesToSum.FK_SecurityMaster
                   AND sb.FK_Fund = securitiesToSum.FK_Fund
                   AND sb.FK_AccountPeriod = securitiesToSum.FK_AccountPeriod
                   AND sb.FK_BalanceType = @BalanceTypeKey
            LEFT OUTER JOIN dbo.PortfolioStatementValueStatus psvs
                ON psvs.FK_PortfolioStatementTemplate = @PortfolioStatementTemplate
                   AND psvs.FK_AccountPeriod = securitiesToSum.FK_AccountPeriod
                   AND psvs.FK_BalanceType = @BalanceTypeKey
                   AND psvs.FK_Fund = @FundKey
            LEFT OUTER JOIN dbo.PortfolioStatementValue psv
                ON psv.FK_SecurityBalance = sb.PK_SecurityBalance
                   AND psv.FK_PortfolioStatementValueStatus = psvs.PK_PortfolioStatementValueStatus
        GROUP BY securitiesToSum.PK_CalculationSheetItemDetail,
                 securitiesToSum.HoldingsCategoryValue,
                 securitiesToSum.FK_Currency;


        DROP TABLE #CalcSheetSecuritiesToSum2;


        EXEC dbo.gp_WriteToCalculationLog 'Financial',
                                          @FundKey,
                                          @AccountPeriodKey,
                                          @BalanceTypeKey,
                                          NULL,
                                          'PortfolioHoldingsCategoryMaturityrange data retrieval complete for calc sheet calculation engine.',
                                          'GetPortfolioHoldingsCategoryMaturityrangeInputValuesForCalculationEngine',
                                          NULL,
                                          NULL,
                                          @CalculationBatchKey;

    END;

    IF EXISTS
    (
        SELECT 1
        FROM #CalcSheetItemFormulaDetails
        WHERE ItemType = 'HoldingsCategorySubtotal'
    )
    BEGIN
        --INSERT INTO #PortfolioResultTable (FK_CalculationSheetItemDetail, FK_Currency, RoundingLevel, RoundToThousandsDecimalPlaces, ValueFooted)
        --EXEC dbo.gp_GetPortfolioHoldingsCategorySubtotalInputValuesForCalculationEngine @FundKey, @AccountPeriodKey, @BalanceTypeKey, @FundRoundingLevel, @CalculationBatchKey;


        CREATE TABLE #CalcSheetSecurityCategorization3
        (
            PK_CalculationSheetItemDetail INT NOT NULL,
            FK_SecurityMaster INT NOT NULL,
            FK_CategoryLibrary INT NULL,
            FK_Category INT NULL,
            HoldingsCategoryValue NVARCHAR(256),
            HoldingsSubtotalTypePositive BIT NULL,
            FK_CalculationSheetItemColumn INT,
            FK_AccountPeriod INT,
            FK_Fund INT,
            FK_Currency INT
        );

        CREATE CLUSTERED INDEX IX_PK_CalculationSheetItemDetail_FK_SecurityMaster_FK_Fund_FK_Currency
        ON #CalcSheetSecurityCategorization3 (
                                                 PK_CalculationSheetItemDetail,
                                                 FK_SecurityMaster,
                                                 FK_Fund,
                                                 FK_Currency
                                             );

        -- insert inclusions into table variable
        INSERT INTO #CalcSheetSecurityCategorization3
        (
            PK_CalculationSheetItemDetail,
            FK_SecurityMaster,
            FK_CategoryLibrary,
            FK_Category,
            HoldingsCategoryValue,
            HoldingsSubtotalTypePositive,
            FK_CalculationSheetItemColumn,
            FK_AccountPeriod,
            FK_Fund,
            FK_Currency
        )
        SELECT DISTINCT
               csid.PK_CalculationSheetItemDetail,
               sb.FK_SecurityMaster,
               CASE Detail.Operator
                   WHEN '=' THEN
                       szInclusionLib.FK_CategoryLibrary
               END AS FK_CategoryLibrary,
               CASE Detail.Operator
                   WHEN '=' THEN
                       szInclusionLib.FK_Category
               END AS FK_Category,
               csid.HoldingsCategoryValue,
               CASE csid.HoldingsSubtotalType
                   WHEN 'positive' THEN
                       1
                   WHEN 'negative' THEN
                       0
               END AS HoldingsSubtotalTypePositive,
               csifd.FK_CalculationSheetItemColumn,
               sb.FK_AccountPeriod,
               sb.FK_Fund,
               CASE
                   WHEN csifd.PK_Currency IS NOT NULL THEN
                       sb.FK_Currency
               END AS FK_Currency
        FROM #CalcSheetItemFormulaDetails csifd
            JOIN dbo.CalculationSheetItemDetail csid
                ON csid.PK_CalculationSheetItemDetail = csifd.PK_CalculationSheetItemDetail
            JOIN dbo.CalculationSheetItemHoldingsCategoryDetail Detail
                ON csid.PK_CalculationSheetItemDetail = Detail.FK_CalculationSheetItemDetail
            JOIN dbo.SecurityBalance sb
                ON sb.FK_AccountPeriod = csifd.FK_AccountPeriod
            JOIN #FUNDS f
                ON f.FK_Fund = sb.FK_Fund
            JOIN #SecurityCategorizationTable szInclusionLib
                ON szInclusionLib.FK_SecurityMaster = sb.FK_SecurityMaster
                   AND szInclusionLib.FK_Accountperiod = csifd.FK_AccountPeriod
                   AND szInclusionLib.FK_CategoryLibrary = Detail.FK_CategoryLibrary
            JOIN dbo.CalculationSheetItemHoldingsCategoryDetailCategory DetailCategory
                ON Detail.PK_CalculationSheetItemHoldingsCategoryDetail = DetailCategory.FK_CalculationSheetItemHoldingsCategoryDetail
                   AND
                   (
                       (
                           Detail.Operator = '='
                           AND DetailCategory.FK_Category = szInclusionLib.FK_Category
                       )
                       OR
                       (
                           Detail.Operator = '!='
                           AND DetailCategory.FK_Category <> ISNULL(szInclusionLib.FK_Category, 0)
                       )
                   )
        WHERE csifd.ItemType = 'HoldingsCategorySubtotal'
              AND Detail.Operator IN ( '=', '!=' )
              AND sb.FK_BalanceType = @BalanceTypeKey
              AND ISNULL(sb.FK_Currency, 0) IN (   CASE ISNULL(csifd.PK_Currency, 0)
                                                       WHEN 0 THEN
                                                           ISNULL(sb.FK_Currency, 0)
                                                       ELSE
                                                           ISNULL(csifd.PK_Currency, 0)
                                                   END, CASE ISNULL(csifd.PK_Currency, 0)
                                                            WHEN ISNULL(f.BaseCurrencyKey, 0) THEN
                                                                NULL
                                                            ELSE
                                                                ISNULL(csifd.PK_Currency, 0)
                                                        END
                                               )
              AND NOT EXISTS
        (
            SELECT *
            FROM dbo.CalculationSheetItemHoldingsCategoryDetail Detail2
                JOIN #SecurityCategorizationTable szExclusionLib2
                    ON szExclusionLib2.FK_CategoryLibrary = Detail2.FK_CategoryLibrary
                JOIN dbo.CalculationSheetItemHoldingsCategoryDetailCategory DetailCategory2
                    ON DetailCategory2.FK_CalculationSheetItemHoldingsCategoryDetail = Detail2.PK_CalculationSheetItemHoldingsCategoryDetail
                       AND DetailCategory2.FK_Category = ISNULL(szExclusionLib2.FK_Category, 0)
            WHERE Detail2.Operator = '!='
                  AND Detail2.FK_CalculationSheetItemDetail = csid.PK_CalculationSheetItemDetail
                  AND szExclusionLib2.FK_SecurityMaster = sb.FK_SecurityMaster
        );


        CREATE TABLE #CalcSheetSecuritiesToSum3
        (
            PK_CalculationSheetItemDetail INT NOT NULL,
            FK_SecurityMaster INT NULL,
            HoldingsCategoryValue NVARCHAR(256),
            HoldingsSubtotalTypePositive BIT NULL,
            FK_CalculationSheetItemColumn INT,
            FK_AccountPeriod INT,
            FK_Fund INT,
            FK_Currency INT
        );

        CREATE CLUSTERED INDEX IX_PK_CalculationSheetItemDetail_HoldingsCategoryValue_FK_Currency
        ON #CalcSheetSecuritiesToSum3 (
                                          PK_CalculationSheetItemDetail,
                                          HoldingsCategoryValue,
                                          FK_Currency,
                                          FK_SecurityMaster,
                                          HoldingsSubtotalTypePositive,
                                          FK_CalculationSheetItemColumn,
                                          FK_AccountPeriod,
                                          FK_Fund
                                      ); -- match column order in GROUP BY clause below to prevent Sort in execution plan

        -- insert distinct securities
        INSERT INTO #CalcSheetSecuritiesToSum3
        (
            PK_CalculationSheetItemDetail,
            FK_SecurityMaster,
            HoldingsCategoryValue,
            HoldingsSubtotalTypePositive,
            FK_CalculationSheetItemColumn,
            FK_AccountPeriod,
            FK_Fund,
            FK_Currency
        )
        SELECT DISTINCT
               PK_CalculationSheetItemDetail,
               FK_SecurityMaster,
               HoldingsCategoryValue,
               HoldingsSubtotalTypePositive,
               FK_CalculationSheetItemColumn,
               FK_AccountPeriod,
               FK_Fund,
               FK_Currency
        FROM #CalcSheetSecurityCategorization3 calcSheetSecurityCategorization
        WHERE NOT EXISTS
        (
            SELECT *
            FROM
            (
                SELECT DISTINCT
                       csid.PK_CalculationSheetItemDetail,
                       COUNT(Detail.FK_CategoryLibrary) AS CategoryLibraryCount
                FROM #CalcSheetItemFormulaDetails csifd
                    JOIN dbo.CalculationSheetItemDetail csid
                        ON csid.PK_CalculationSheetItemDetail = csifd.PK_CalculationSheetItemDetail
                    JOIN dbo.CalculationSheetItemHoldingsCategoryDetail Detail
                        ON csid.PK_CalculationSheetItemDetail = Detail.FK_CalculationSheetItemDetail
                WHERE Detail.Operator = '='
                      AND csifd.ItemType = 'HoldingsCategorySubtotal'
                GROUP BY csid.PK_CalculationSheetItemDetail,
                         FK_Fund,
                         PK_Currency
            ) categoryLibraries
                JOIN
                (
                    SELECT PK_CalculationSheetItemDetail,
                           FK_SecurityMaster,
                           COUNT(FK_CategoryLibrary) AS CategoryLibraryCount
                    FROM #CalcSheetSecurityCategorization3
                    GROUP BY PK_CalculationSheetItemDetail,
                             FK_SecurityMaster,
                             FK_Fund,
                             FK_Currency
                ) categorization
                    ON categorization.PK_CalculationSheetItemDetail = categoryLibraries.PK_CalculationSheetItemDetail
                       AND categorization.CategoryLibraryCount <> categoryLibraries.CategoryLibraryCount
            WHERE categoryLibraries.PK_CalculationSheetItemDetail = calcSheetSecurityCategorization.PK_CalculationSheetItemDetail
                  AND categorization.FK_SecurityMaster = calcSheetSecurityCategorization.FK_SecurityMaster
        );

        DROP TABLE #CalcSheetSecurityCategorization3;



        -- Add rows for calculation sheet item details that are not in list yet
        -- this happens when a calc sheet detail is pulling in holdings categories that have no securities categorized
        -- in the specified category for this fund and period.
        INSERT INTO #CalcSheetSecuritiesToSum3
        (
            PK_CalculationSheetItemDetail,
            HoldingsCategoryValue,
            HoldingsSubtotalTypePositive,
            FK_CalculationSheetItemColumn
        )
        SELECT csid.PK_CalculationSheetItemDetail,
               csid.HoldingsCategoryValue,
               CASE csid.HoldingsSubtotalType
                   WHEN 'positive' THEN
                       1
                   WHEN 'negative' THEN
                       0
               END AS HoldingsSubtotalTypePositive,
               csifd.FK_CalculationSheetItemColumn
        FROM #CalcSheetItemFormulaDetails csifd
            JOIN dbo.CalculationSheetItemDetail csid
                ON csid.PK_CalculationSheetItemDetail = csifd.PK_CalculationSheetItemDetail
        WHERE csifd.ItemType = 'HoldingsCategorySubtotal'
              AND NOT EXISTS
        (
            SELECT *
            FROM #CalcSheetSecuritiesToSum3
            WHERE PK_CalculationSheetItemDetail = csid.PK_CalculationSheetItemDetail
        );


        INSERT INTO #PortfolioResultTable
        (
            FK_CalculationSheetItemDetail,
            FK_Currency,
            ValueFooted
        )
        SELECT securitiesToSum.PK_CalculationSheetItemDetail,
               securitiesToSum.FK_Currency,
               SUM(ISNULL(   CASE securitiesToSum.HoldingsCategoryValue
                                 WHEN N'AccruedInterest' THEN
                                     psv.AccruedInterestFooted
                                 WHEN N'BaseCurrencyBought' THEN
                                     psv.BaseCurrencyBoughtFooted
                                 WHEN N'BaseCurrencySold' THEN
                                     psv.BaseCurrencySoldFooted
                                 WHEN N'BaseUnitPrice' THEN
                                     psv.BaseUnitPriceFooted
                                 WHEN N'BidAskSpreadPercentCalculated' THEN
                                     psv.BidAskSpreadPercentCalculatedFooted
                                 WHEN N'BidAskSpreadValueCalculated' THEN
                                     psv.BidAskSpreadValueCalculatedFooted
                                 WHEN N'Bought' THEN
                                     psv.BoughtFooted
                                 WHEN N'BidAskSpreadValueCalculated' THEN
                                     psv.BidAskSpreadValueCalculatedFooted
                                 WHEN N'Commitments' THEN
                                     psv.CommitmentsFooted
                                 WHEN N'ContractRate' THEN
                                     psv.ContractRateFooted
                                 WHEN N'Cost' THEN
                                     psv.CostFooted
                                 WHEN N'CostCalculated' THEN
                                     psv.CostCalculatedFooted
                                 WHEN N'CouponRate' THEN
                                     psv.CouponRateFooted
                                 WHEN N'ExchangeRate' THEN
                                     psv.ExchangeRateFooted
                                 WHEN N'ExcludeCapitalSupportValue' THEN
                                     psv.ExcludeCapitalSupportValueFooted
                                 WHEN N'IncludeCapitalSupportValue' THEN
                                     psv.IncludeCapitalSupportValueFooted
                                 WHEN N'LocalCrossTrade' THEN
                                     psv.LocalCrossTradeFooted
                                 WHEN N'LocalCurrencyBought' THEN
                                     psv.LocalCurrencyBoughtFooted
                                 WHEN N'LocalCurrencySold' THEN
                                     psv.LocalCurrencySoldFooted
                                 WHEN N'MarketValue' THEN
                                     psv.MarketValueFooted
                                 WHEN N'MarketValueAsk' THEN
                                     psv.MarketValueAskFooted
                                 WHEN 'MarketValueLevelNAV' THEN
                                     psv.MarketValueLevelNAVFooted
                                 WHEN 'MarketValueLevel1' THEN
                                     psv.MarketValueLevel1Footed
                                 WHEN 'MarketValueLevel2' THEN
                                     psv.MarketValueLevel2Footed
                                 WHEN 'MarketValueLevel3' THEN
                                     psv.MarketValueLevel3Footed
                                 WHEN N'MarketValueAskCalculated' THEN
                                     psv.MarketValueAskCalculatedFooted
                                 WHEN N'MarketValueBid' THEN
                                     psv.MarketValueBidFooted
                                 WHEN N'MarketValueBidCalculated' THEN
                                     psv.MarketValueBidCalculatedFooted
                                 WHEN N'Multiplier' THEN
                                     psv.MultiplierFooted
                                 WHEN N'NotionalAmount' THEN
                                     psv.NotionalAmountFooted
                                 WHEN N'OptionPremium' THEN
                                     psv.OptionPremiumFooted
                                 WHEN N'PercentOfNetAssets' THEN
                                     psv.PercentOfNetAssetsFooted
                                 WHEN N'PercentageOfPar' THEN
                                     psv.PercentOfParFooted
                                 WHEN N'PercentOfTotalInvestments' THEN
                                     psv.PercentOfTotalInvestmentsFooted
                                 WHEN N'PriceAsk' THEN
                                     psv.PriceAskFooted
                                 WHEN N'PriceBid' THEN
                                     psv.PriceBidFooted
                                 WHEN N'Proceeds' THEN
                                     psv.ProceedsFooted
                                 WHEN N'PurchaseAmountBase' THEN
                                     psv.PurchaseAmountBaseFooted
                                 WHEN N'PurchaseAmountLocal' THEN
                                     psv.PurchaseAmountLocalFooted
                                 WHEN N'PurchaseCost' THEN
                                     psv.PurchaseCostFooted
                                 WHEN N'Shares' THEN
                                     psv.SharesFooted
                                 WHEN N'Sold' THEN
                                     psv.SoldFooted
                                 WHEN N'SoldAmountBase' THEN
                                     psv.SoldAmountBaseFooted
                                 WHEN N'SoldAmountLocal' THEN
                                     psv.SoldAmountLocalFooted
                                 WHEN N'UnrealizedValue' THEN
                                     psv.UnrealizedValueFooted
                                 WHEN N'UnrealizedValueCalculated' THEN
                                     psv.UnrealizedValueCalculatedFooted
                                 WHEN N'UnrealizedValueAskCalculated' THEN
                                     psv.UnrealizedValueAskCalculatedFooted
                                 WHEN N'UnrealizedValueBidCalculated' THEN
                                     psv.UnrealizedValueBidCalculatedFooted
                                 WHEN N'Yield' THEN
                                     psv.YieldFooted
                                 WHEN N'AccruedDiscountsPremiums' THEN
                                     psv.AccruedDiscountsPremiumsFooted
                                 WHEN N'CapitalGainDistributions' THEN
                                     psv.CapitalGainDistributionsFooted
                                 WHEN N'CashCollateralSecurityValue' THEN
                                     psv.CashCollateralSecurityValueFooted
                                 WHEN N'ChangeinUnrealizedValue' THEN
                                     psv.ChangeinUnrealizedValueFooted
                                 WHEN N'ChangeinUnrealizedValueCalculated' THEN
                                     psv.ChangeinUnrealizedValueCalculatedFooted
                                 WHEN N'CommittedCapital' THEN
                                     psv.CommittedCapitalFooted
                                 WHEN N'ConversionRatio' THEN
                                     psv.ConversionRatioFooted
                                 WHEN N'CumulativeContributedCapital' THEN
                                     psv.CumulativeContributedCapitalFooted
                                 WHEN N'CurrencyDescriptionBought' THEN
                                     psv.CurrencyDescriptionBoughtFooted
                                 WHEN N'CurrencyDescriptionSold' THEN
                                     psv.CurrencyDescriptionSoldFooted
                                 WHEN N'Delta' THEN
                                     psv.DeltaFooted
                                 WHEN N'DividendsAffiliatedIssuers' THEN
                                     psv.DividendsAffiliatedIssuersFooted
                                 WHEN N'ExercisePrice' THEN
                                     psv.ExercisePriceFooted
                                 WHEN N'Gamma' THEN
                                     psv.GammaFooted
                                 WHEN N'Income' THEN
                                     psv.IncomeFooted
                                 WHEN N'MarketValueofSharesPurchased' THEN
                                     psv.MarketValueofSharesPurchasedFooted
                                 WHEN N'MarketValueofSharesSold' THEN
                                     psv.MarketValueofSharesSoldFooted
                                 WHEN N'NetMarketValueofSharesActivityCalculated' THEN
                                     psv.NetMarketValueOfSharesActivityCalculatedFooted
                                 WHEN N'NetMarketValueofSharesSoldCalculated' THEN
                                     psv.NetMarketValueOfSharesSoldCalculatedFooted
                                 WHEN N'NetSharesActivityCalculated' THEN
                                     psv.NetSharesActivityCalculatedFooted
                                 WHEN N'NetSharesSoldcalculated' THEN
                                     psv.NetSharesSoldCalculatedFooted
                                 WHEN N'MarketValueTransferLevel1From2BeginOfPeriod' THEN
                                     psv.MarketValueTransferLevel1From2BeginOfPeriodFooted
                                 WHEN N'MarketValueTransferLevel1From2EndOfPeriod' THEN
                                     psv.MarketValueTransferLevel1From2EndOfPeriodFooted
                                 WHEN N'MarketValueTransferLevel2From1BeginOfPeriod' THEN
                                     psv.MarketValueTransferLevel2From1BeginOfPeriodFooted
                                 WHEN N'MarketValueTransferLevel2From1EndOfPeriod' THEN
                                     psv.MarketValueTransferLevel2From1EndOfPeriodFooted
                                 WHEN N'MarketValueTransferLevel2From3BeginOfPeriod' THEN
                                     psv.MarketValueTransferLevel2From3BeginOfPeriodFooted
                                 WHEN N'MarketValueTransferLevel2From3EndOfPeriod' THEN
                                     psv.MarketValueTransferLevel2From3EndOfPeriodFooted
                                 WHEN N'MarketValueTransferLevel3From2BeginOfPeriod' THEN
                                     psv.MarketValueTransferLevel3From2BeginOfPeriodFooted
                                 WHEN N'MarketValueTransferLevel3From2EndOfPeriod' THEN
                                     psv.MarketValueTransferLevel3From2EndOfPeriodFooted
                                 WHEN N'MarketValueLevel3TransferInBeginOfPeriod' THEN
                                     psv.MarketValueLevel3TransferInBeginOfPeriodFooted
                                 WHEN N'MarketValueLevel3TransferOutBeginOfPeriod' THEN
                                     psv.MarketValueLevel3TransferOutBeginOfPeriodFooted
                                 WHEN N'MarketValueLevel3TransferInEndOfPeriod' THEN
                                     psv.MarketValueLevel3TransferInEndOfPeriodFooted
                                 WHEN N'MarketValueLevel3TransferOutEndOfPeriod' THEN
                                     psv.MarketValueLevel3TransferOutEndOfPeriodFooted
                                 WHEN N'NonCashCollateralSecurityValue' THEN
                                     psv.NonCashCollateralSecurityValueFooted
                                 WHEN N'NumberofContracts' THEN
                                     psv.NumberOfContractsFooted
                                 WHEN N'RealizedValue' THEN
                                     psv.RealizedValueFooted
                                 WHEN N'RemainingCommitment' THEN
                                     psv.RemainingCommitmentFooted
                                 WHEN N'RepurchaseRate' THEN
                                     psv.RepurchaseRateFooted
                                 WHEN N'SharesPurchased' THEN
                                     psv.SharesPurchasedFooted
                                 WHEN N'SharesSold' THEN
                                     psv.SharesSoldFooted
                                 WHEN N'StrikePrice' THEN
                                     psv.StrikePriceFooted
                                 WHEN N'TotalDistributions' THEN
                                     psv.TotalDistributionsFooted
                                 WHEN N'UnrealizedAppreciationDepreciation' THEN
                                     psv.UnrealizedAppreciationDepreciationFooted
                                 WHEN N'UnrealizedValueCalculated' THEN
                                     psv.UnrealizedValueCalculatedFooted
                                 WHEN N'UpfrontPaymentsReceipts' THEN
                                     psv.UpfrontPaymentsReceiptsFooted
                                 WHEN N'Vega' THEN
                                     psv.VegaFooted
                                 ELSE
                                     psv.MarketValueFooted
                             END,
                             0
                         )
                  ) AS ValueFooted
        FROM #CalcSheetSecuritiesToSum3 securitiesToSum
            LEFT OUTER JOIN dbo.SecurityBalance sb -- must be OUTER JOIN!
                ON sb.FK_SecurityMaster = securitiesToSum.FK_SecurityMaster
                   AND sb.FK_Fund = securitiesToSum.FK_Fund
                   AND sb.FK_AccountPeriod = securitiesToSum.FK_AccountPeriod
                   AND sb.FK_BalanceType = @BalanceTypeKey
            LEFT OUTER JOIN dbo.PortfolioStatementValueStatus psvs
                ON psvs.FK_PortfolioStatementTemplate = @PortfolioStatementTemplate
                   AND psvs.FK_AccountPeriod = securitiesToSum.FK_AccountPeriod
                   AND psvs.FK_BalanceType = @BalanceTypeKey
                   AND psvs.FK_Fund = @FundKey
            LEFT OUTER JOIN dbo.PortfolioStatementValue psv
                ON psv.FK_SecurityBalance = sb.PK_SecurityBalance
                   AND psv.FK_PortfolioStatementValueStatus = psvs.PK_PortfolioStatementValueStatus
                   AND
                   (
                       (
                           securitiesToSum.HoldingsSubtotalTypePositive = 1
                           AND CASE securitiesToSum.HoldingsCategoryValue
                                   WHEN N'AccruedInterest' THEN
                                       psv.AccruedInterestFooted
                                   WHEN N'BaseCurrencyBought' THEN
                                       psv.BaseCurrencyBoughtFooted
                                   WHEN N'BaseCurrencySold' THEN
                                       psv.BaseCurrencySoldFooted
                                   WHEN N'BaseUnitPrice' THEN
                                       psv.BaseUnitPriceFooted
                                   WHEN N'BidAskSpreadPercentCalculated' THEN
                                       psv.BidAskSpreadPercentCalculatedFooted
                                   WHEN N'BidAskSpreadValueCalculated' THEN
                                       psv.BidAskSpreadValueCalculatedFooted
                                   WHEN N'Bought' THEN
                                       psv.BoughtFooted
                                   WHEN N'BidAskSpreadValueCalculated' THEN
                                       psv.BidAskSpreadValueCalculatedFooted
                                   WHEN N'Commitments' THEN
                                       psv.CommitmentsFooted
                                   WHEN N'ContractRate' THEN
                                       psv.ContractRateFooted
                                   WHEN N'Cost' THEN
                                       psv.CostFooted
                                   WHEN N'CostCalculated' THEN
                                       psv.CostCalculatedFooted
                                   WHEN N'CouponRate' THEN
                                       psv.CouponRateFooted
                                   WHEN N'ExchangeRate' THEN
                                       psv.ExchangeRateFooted
                                   WHEN N'ExcludeCapitalSupportValue' THEN
                                       psv.ExcludeCapitalSupportValueFooted
                                   WHEN N'IncludeCapitalSupportValue' THEN
                                       psv.IncludeCapitalSupportValueFooted
                                   WHEN N'LocalCrossTrade' THEN
                                       psv.LocalCrossTradeFooted
                                   WHEN N'LocalCurrencyBought' THEN
                                       psv.LocalCurrencyBoughtFooted
                                   WHEN N'LocalCurrencySold' THEN
                                       psv.LocalCurrencySoldFooted
                                   WHEN N'MarketValue' THEN
                                       psv.MarketValueFooted
                                   WHEN N'MarketValueAsk' THEN
                                       psv.MarketValueAskFooted
                                   WHEN 'MarketValueLevelNAV' THEN
                                       psv.MarketValueLevelNAVFooted
                                   WHEN 'MarketValueLevel1' THEN
                                       psv.MarketValueLevel1Footed
                                   WHEN 'MarketValueLevel2' THEN
                                       psv.MarketValueLevel2Footed
                                   WHEN 'MarketValueLevel3' THEN
                                       psv.MarketValueLevel3Footed
                                   WHEN N'MarketValueAskCalculated' THEN
                                       psv.MarketValueAskCalculatedFooted
                                   WHEN N'MarketValueBid' THEN
                                       psv.MarketValueBidFooted
                                   WHEN N'MarketValueBidCalculated' THEN
                                       psv.MarketValueBidCalculatedFooted
                                   WHEN N'Multiplier' THEN
                                       psv.MultiplierFooted
                                   WHEN N'NotionalAmount' THEN
                                       psv.NotionalAmountFooted
                                   WHEN N'OptionPremium' THEN
                                       psv.OptionPremiumFooted
                                   WHEN N'PercentOfNetAssets' THEN
                                       psv.PercentOfNetAssetsFooted
                                   WHEN N'PercentageOfPar' THEN
                                       psv.PercentOfParFooted
                                   WHEN N'PercentOfTotalInvestments' THEN
                                       psv.PercentOfTotalInvestmentsFooted
                                   WHEN N'PriceAsk' THEN
                                       psv.PriceAskFooted
                                   WHEN N'PriceBid' THEN
                                       psv.PriceBidFooted
                                   WHEN N'Proceeds' THEN
                                       psv.ProceedsFooted
                                   WHEN N'PurchaseAmountBase' THEN
                                       psv.PurchaseAmountBaseFooted
                                   WHEN N'PurchaseAmountLocal' THEN
                                       psv.PurchaseAmountLocalFooted
                                   WHEN N'PurchaseCost' THEN
                                       psv.PurchaseCostFooted
                                   WHEN N'Shares' THEN
                                       psv.SharesFooted
                                   WHEN N'Sold' THEN
                                       psv.SoldFooted
                                   WHEN N'SoldAmountBase' THEN
                                       psv.SoldAmountBaseFooted
                                   WHEN N'SoldAmountLocal' THEN
                                       psv.SoldAmountLocalFooted
                                   WHEN N'UnrealizedValue' THEN
                                       psv.UnrealizedValueFooted
                                   WHEN N'UnrealizedValueCalculated' THEN
                                       psv.UnrealizedValueCalculatedFooted
                                   WHEN N'UnrealizedValueAskCalculated' THEN
                                       psv.UnrealizedValueAskCalculatedFooted
                                   WHEN N'UnrealizedValueBidCalculated' THEN
                                       psv.UnrealizedValueBidCalculatedFooted
                                   WHEN N'Yield' THEN
                                       psv.YieldFooted
                                   WHEN N'AccruedDiscountsPremiums' THEN
                                       psv.AccruedDiscountsPremiumsFooted
                                   WHEN N'CapitalGainDistributions' THEN
                                       psv.CapitalGainDistributionsFooted
                                   WHEN N'CashCollateralSecurityValue' THEN
                                       psv.CashCollateralSecurityValueFooted
                                   WHEN N'ChangeinUnrealizedValue' THEN
                                       psv.ChangeinUnrealizedValueFooted
                                   WHEN N'ChangeinUnrealizedValueCalculated' THEN
                                       psv.ChangeinUnrealizedValueCalculatedFooted
                                   WHEN N'CommittedCapital' THEN
                                       psv.CommittedCapitalFooted
                                   WHEN N'ConversionRatio' THEN
                                       psv.ConversionRatioFooted
                                   WHEN N'CumulativeContributedCapital' THEN
                                       psv.CumulativeContributedCapitalFooted
                                   WHEN N'CurrencyDescriptionBought' THEN
                                       psv.CurrencyDescriptionBoughtFooted
                                   WHEN N'CurrencyDescriptionSold' THEN
                                       psv.CurrencyDescriptionSoldFooted
                                   WHEN N'Delta' THEN
                                       psv.DeltaFooted
                                   WHEN N'DividendsAffiliatedIssuers' THEN
                                       psv.DividendsAffiliatedIssuersFooted
                                   WHEN N'ExercisePrice' THEN
                                       psv.ExercisePriceFooted
                                   WHEN N'Gamma' THEN
                                       psv.GammaFooted
                                   WHEN N'Income' THEN
                                       psv.IncomeFooted
                                   WHEN N'MarketValueofSharesPurchased' THEN
                                       psv.MarketValueofSharesPurchasedFooted
                                   WHEN N'MarketValueofSharesSold' THEN
                                       psv.MarketValueofSharesSoldFooted
                                   WHEN N'NetMarketValueofSharesActivityCalculated' THEN
                                       psv.NetMarketValueOfSharesActivityCalculatedFooted
                                   WHEN N'NetMarketValueofSharesSoldCalculated' THEN
                                       psv.NetMarketValueOfSharesSoldCalculatedFooted
                                   WHEN N'NetSharesActivityCalculated' THEN
                                       psv.NetSharesActivityCalculatedFooted
                                   WHEN N'NetSharesSoldcalculated' THEN
                                       psv.NetSharesSoldCalculatedFooted
                                   WHEN N'MarketValueTransferLevel1From2BeginOfPeriod' THEN
                                       psv.MarketValueTransferLevel1From2BeginOfPeriodFooted
                                   WHEN N'MarketValueTransferLevel1From2EndOfPeriod' THEN
                                       psv.MarketValueTransferLevel1From2EndOfPeriodFooted
                                   WHEN N'MarketValueTransferLevel2From1BeginOfPeriod' THEN
                                       psv.MarketValueTransferLevel2From1BeginOfPeriodFooted
                                   WHEN N'MarketValueTransferLevel2From1EndOfPeriod' THEN
                                       psv.MarketValueTransferLevel2From1EndOfPeriodFooted
                                   WHEN N'MarketValueTransferLevel2From3BeginOfPeriod' THEN
                                       psv.MarketValueTransferLevel2From3BeginOfPeriodFooted
                                   WHEN N'MarketValueTransferLevel2From3EndOfPeriod' THEN
                                       psv.MarketValueTransferLevel2From3EndOfPeriodFooted
                                   WHEN N'MarketValueTransferLevel3From2BeginOfPeriod' THEN
                                       psv.MarketValueTransferLevel3From2BeginOfPeriodFooted
                                   WHEN N'MarketValueTransferLevel3From2EndOfPeriod' THEN
                                       psv.MarketValueTransferLevel3From2EndOfPeriodFooted
                                   WHEN N'MarketValueLevel3TransferInBeginOfPeriod' THEN
                                       psv.MarketValueLevel3TransferInBeginOfPeriodFooted
                                   WHEN N'MarketValueLevel3TransferOutBeginOfPeriod' THEN
                                       psv.MarketValueLevel3TransferOutBeginOfPeriodFooted
                                   WHEN N'MarketValueLevel3TransferInEndOfPeriod' THEN
                                       psv.MarketValueLevel3TransferInEndOfPeriodFooted
                                   WHEN N'MarketValueLevel3TransferOutEndOfPeriod' THEN
                                       psv.MarketValueLevel3TransferOutEndOfPeriodFooted
                                   WHEN N'NonCashCollateralSecurityValue' THEN
                                       psv.NonCashCollateralSecurityValueFooted
                                   WHEN N'NumberofContracts' THEN
                                       psv.NumberOfContractsFooted
                                   WHEN N'RealizedValue' THEN
                                       psv.RealizedValueFooted
                                   WHEN N'RemainingCommitment' THEN
                                       psv.RemainingCommitmentFooted
                                   WHEN N'RepurchaseRate' THEN
                                       psv.RepurchaseRateFooted
                                   WHEN N'SharesPurchased' THEN
                                       psv.SharesPurchasedFooted
                                   WHEN N'SharesSold' THEN
                                       psv.SharesSoldFooted
                                   WHEN N'StrikePrice' THEN
                                       psv.StrikePriceFooted
                                   WHEN N'TotalDistributions' THEN
                                       psv.TotalDistributionsFooted
                                   WHEN N'UnrealizedAppreciationDepreciation' THEN
                                       psv.UnrealizedAppreciationDepreciationFooted
                                   WHEN N'UnrealizedValueCalculated' THEN
                                       psv.UnrealizedValueCalculatedFooted
                                   WHEN N'UpfrontPaymentsReceipts' THEN
                                       psv.UpfrontPaymentsReceiptsFooted
                                   WHEN N'Vega' THEN
                                       psv.VegaFooted
                                   ELSE
                                       psv.MarketValueFooted
                               END > 0
                       )
                       OR
                       (
                           securitiesToSum.HoldingsSubtotalTypePositive = 0
                           AND CASE securitiesToSum.HoldingsCategoryValue
                                   WHEN N'AccruedInterest' THEN
                                       psv.AccruedInterestFooted
                                   WHEN N'BaseCurrencyBought' THEN
                                       psv.BaseCurrencyBoughtFooted
                                   WHEN N'BaseCurrencySold' THEN
                                       psv.BaseCurrencySoldFooted
                                   WHEN N'BaseUnitPrice' THEN
                                       psv.BaseUnitPriceFooted
                                   WHEN N'BidAskSpreadPercentCalculated' THEN
                                       psv.BidAskSpreadPercentCalculatedFooted
                                   WHEN N'BidAskSpreadValueCalculated' THEN
                                       psv.BidAskSpreadValueCalculatedFooted
                                   WHEN N'Bought' THEN
                                       psv.BoughtFooted
                                   WHEN N'BidAskSpreadValueCalculated' THEN
                                       psv.BidAskSpreadValueCalculatedFooted
                                   WHEN N'Commitments' THEN
                                       psv.CommitmentsFooted
                                   WHEN N'ContractRate' THEN
                                       psv.ContractRateFooted
                                   WHEN N'Cost' THEN
                                       psv.CostFooted
                                   WHEN N'CostCalculated' THEN
                                       psv.CostCalculatedFooted
                                   WHEN N'CouponRate' THEN
                                       psv.CouponRateFooted
                                   WHEN N'ExchangeRate' THEN
                                       psv.ExchangeRateFooted
                                   WHEN N'ExcludeCapitalSupportValue' THEN
                                       psv.ExcludeCapitalSupportValueFooted
                                   WHEN N'IncludeCapitalSupportValue' THEN
                                       psv.IncludeCapitalSupportValueFooted
                                   WHEN N'LocalCrossTrade' THEN
                                       psv.LocalCrossTradeFooted
                                   WHEN N'LocalCurrencyBought' THEN
                                       psv.LocalCurrencyBoughtFooted
                                   WHEN N'LocalCurrencySold' THEN
                                       psv.LocalCurrencySoldFooted
                                   WHEN N'MarketValue' THEN
                                       psv.MarketValueFooted
                                   WHEN N'MarketValueAsk' THEN
                                       psv.MarketValueAskFooted
                                   WHEN 'MarketValueLevelNAV' THEN
                                       psv.MarketValueLevelNAVFooted
                                   WHEN 'MarketValueLevel1' THEN
                                       psv.MarketValueLevel1Footed
                                   WHEN 'MarketValueLevel2' THEN
                                       psv.MarketValueLevel2Footed
                                   WHEN 'MarketValueLevel3' THEN
                                       psv.MarketValueLevel3Footed
                                   WHEN N'MarketValueAskCalculated' THEN
                                       psv.MarketValueAskCalculatedFooted
                                   WHEN N'MarketValueBid' THEN
                                       psv.MarketValueBidFooted
                                   WHEN N'MarketValueBidCalculated' THEN
                                       psv.MarketValueBidCalculatedFooted
                                   WHEN N'Multiplier' THEN
                                       psv.MultiplierFooted
                                   WHEN N'NotionalAmount' THEN
                                       psv.NotionalAmountFooted
                                   WHEN N'OptionPremium' THEN
                                       psv.OptionPremiumFooted
                                   WHEN N'PercentOfNetAssets' THEN
                                       psv.PercentOfNetAssetsFooted
                                   WHEN N'PercentageOfPar' THEN
                                       psv.PercentOfParFooted
                                   WHEN N'PercentOfTotalInvestments' THEN
                                       psv.PercentOfTotalInvestmentsFooted
                                   WHEN N'PriceAsk' THEN
                                       psv.PriceAskFooted
                                   WHEN N'PriceBid' THEN
                                       psv.PriceBidFooted
                                   WHEN N'Proceeds' THEN
                                       psv.ProceedsFooted
                                   WHEN N'PurchaseAmountBase' THEN
                                       psv.PurchaseAmountBaseFooted
                                   WHEN N'PurchaseAmountLocal' THEN
                                       psv.PurchaseAmountLocalFooted
                                   WHEN N'PurchaseCost' THEN
                                       psv.PurchaseCostFooted
                                   WHEN N'Shares' THEN
                                       psv.SharesFooted
                                   WHEN N'Sold' THEN
                                       psv.SoldFooted
                                   WHEN N'SoldAmountBase' THEN
                                       psv.SoldAmountBaseFooted
                                   WHEN N'SoldAmountLocal' THEN
                                       psv.SoldAmountLocalFooted
                                   WHEN N'UnrealizedValue' THEN
                                       psv.UnrealizedValueFooted
                                   WHEN N'UnrealizedValueCalculated' THEN
                                       psv.UnrealizedValueCalculatedFooted
                                   WHEN N'UnrealizedValueAskCalculated' THEN
                                       psv.UnrealizedValueAskCalculatedFooted
                                   WHEN N'UnrealizedValueBidCalculated' THEN
                                       psv.UnrealizedValueBidCalculatedFooted
                                   WHEN N'Yield' THEN
                                       psv.YieldFooted
                                   WHEN N'AccruedDiscountsPremiums' THEN
                                       psv.AccruedDiscountsPremiumsFooted
                                   WHEN N'CapitalGainDistributions' THEN
                                       psv.CapitalGainDistributionsFooted
                                   WHEN N'CashCollateralSecurityValue' THEN
                                       psv.CashCollateralSecurityValueFooted
                                   WHEN N'ChangeinUnrealizedValue' THEN
                                       psv.ChangeinUnrealizedValueFooted
                                   WHEN N'ChangeinUnrealizedValueCalculated' THEN
                                       psv.ChangeinUnrealizedValueCalculatedFooted
                                   WHEN N'CommittedCapital' THEN
                                       psv.CommittedCapitalFooted
                                   WHEN N'ConversionRatio' THEN
                                       psv.ConversionRatioFooted
                                   WHEN N'CumulativeContributedCapital' THEN
                                       psv.CumulativeContributedCapitalFooted
                                   WHEN N'CurrencyDescriptionBought' THEN
                                       psv.CurrencyDescriptionBoughtFooted
                                   WHEN N'CurrencyDescriptionSold' THEN
                                       psv.CurrencyDescriptionSoldFooted
                                   WHEN N'Delta' THEN
                                       psv.DeltaFooted
                                   WHEN N'DividendsAffiliatedIssuers' THEN
                                       psv.DividendsAffiliatedIssuersFooted
                                   WHEN N'ExercisePrice' THEN
                                       psv.ExercisePriceFooted
                                   WHEN N'Gamma' THEN
                                       psv.GammaFooted
                                   WHEN N'Income' THEN
                                       psv.IncomeFooted
                                   WHEN N'MarketValueofSharesPurchased' THEN
                                       psv.MarketValueofSharesPurchasedFooted
                                   WHEN N'MarketValueofSharesSold' THEN
                                       psv.MarketValueofSharesSoldFooted
                                   WHEN N'NetMarketValueofSharesActivityCalculated' THEN
                                       psv.NetMarketValueOfSharesActivityCalculatedFooted
                                   WHEN N'NetMarketValueofSharesSoldCalculated' THEN
                                       psv.NetMarketValueOfSharesSoldCalculatedFooted
                                   WHEN N'NetSharesActivityCalculated' THEN
                                       psv.NetSharesActivityCalculatedFooted
                                   WHEN N'NetSharesSoldcalculated' THEN
                                       psv.NetSharesSoldCalculatedFooted
                                   WHEN N'MarketValueTransferLevel1From2BeginOfPeriod' THEN
                                       psv.MarketValueTransferLevel1From2BeginOfPeriodFooted
                                   WHEN N'MarketValueTransferLevel1From2EndOfPeriod' THEN
                                       psv.MarketValueTransferLevel1From2EndOfPeriodFooted
                                   WHEN N'MarketValueTransferLevel2From1BeginOfPeriod' THEN
                                       psv.MarketValueTransferLevel2From1BeginOfPeriodFooted
                                   WHEN N'MarketValueTransferLevel2From1EndOfPeriod' THEN
                                       psv.MarketValueTransferLevel2From1EndOfPeriodFooted
                                   WHEN N'MarketValueTransferLevel2From3BeginOfPeriod' THEN
                                       psv.MarketValueTransferLevel2From3BeginOfPeriodFooted
                                   WHEN N'MarketValueTransferLevel2From3EndOfPeriod' THEN
                                       psv.MarketValueTransferLevel2From3EndOfPeriodFooted
                                   WHEN N'MarketValueTransferLevel3From2BeginOfPeriod' THEN
                                       psv.MarketValueTransferLevel3From2BeginOfPeriodFooted
                                   WHEN N'MarketValueTransferLevel3From2EndOfPeriod' THEN
                                       psv.MarketValueTransferLevel3From2EndOfPeriodFooted
                                   WHEN N'MarketValueLevel3TransferInBeginOfPeriod' THEN
                                       psv.MarketValueLevel3TransferInBeginOfPeriodFooted
                                   WHEN N'MarketValueLevel3TransferOutBeginOfPeriod' THEN
                                       psv.MarketValueLevel3TransferOutBeginOfPeriodFooted
                                   WHEN N'MarketValueLevel3TransferInEndOfPeriod' THEN
                                       psv.MarketValueLevel3TransferInEndOfPeriodFooted
                                   WHEN N'MarketValueLevel3TransferOutEndOfPeriod' THEN
                                       psv.MarketValueLevel3TransferOutEndOfPeriodFooted
                                   WHEN N'NonCashCollateralSecurityValue' THEN
                                       psv.NonCashCollateralSecurityValueFooted
                                   WHEN N'NumberofContracts' THEN
                                       psv.NumberOfContractsFooted
                                   WHEN N'RealizedValue' THEN
                                       psv.RealizedValueFooted
                                   WHEN N'RemainingCommitment' THEN
                                       psv.RemainingCommitmentFooted
                                   WHEN N'RepurchaseRate' THEN
                                       psv.RepurchaseRateFooted
                                   WHEN N'SharesPurchased' THEN
                                       psv.SharesPurchasedFooted
                                   WHEN N'SharesSold' THEN
                                       psv.SharesSoldFooted
                                   WHEN N'StrikePrice' THEN
                                       psv.StrikePriceFooted
                                   WHEN N'TotalDistributions' THEN
                                       psv.TotalDistributionsFooted
                                   WHEN N'UnrealizedAppreciationDepreciation' THEN
                                       psv.UnrealizedAppreciationDepreciationFooted
                                   WHEN N'UnrealizedValueCalculated' THEN
                                       psv.UnrealizedValueCalculatedFooted
                                   WHEN N'UpfrontPaymentsReceipts' THEN
                                       psv.UpfrontPaymentsReceiptsFooted
                                   WHEN N'Vega' THEN
                                       psv.VegaFooted
                                   ELSE
                                       psv.MarketValueFooted
                               END < 0
                       )
                   )
        GROUP BY securitiesToSum.PK_CalculationSheetItemDetail,
                 securitiesToSum.HoldingsCategoryValue,
                 securitiesToSum.FK_Currency;


        DROP TABLE #CalcSheetSecuritiesToSum3;

        EXEC dbo.gp_WriteToCalculationLog 'Financial',
                                          @FundKey,
                                          @AccountPeriodKey,
                                          @BalanceTypeKey,
                                          NULL,
                                          'PortfolioHoldingsCategorySubtotal data retrieval complete for calc sheet calculation engine.',
                                          'GetPortfolioHoldingsCategorySubtotalInputValuesForCalculationEngine',
                                          NULL,
                                          NULL,
                                          @CalculationBatchKey;
    END;




    CREATE TABLE #CalculationSheetItemDetail_Criteria
    (
        HoldingsDetailConditionDataType NVARCHAR(32) NULL,
        FK_CalculationSheetItemDetail INT NOT NULL,
        Criteria NVARCHAR(864) NOT NULL
    );

    CREATE UNIQUE CLUSTERED INDEX PK_CalculationSheetItemDetail_Criteria
    ON #CalculationSheetItemDetail_Criteria (
                                                HoldingsDetailConditionDataType,
                                                FK_CalculationSheetItemDetail,
                                                Criteria
                                            );

    IF EXISTS
    (
        SELECT 1
        FROM #CalcSheetItemFormulaDetails
        WHERE ItemType = 'HoldingsDetail'
    )
    BEGIN
        
		SELECT DISTINCT FK_AccountPeriod
		INTO #AccountPeriodsForHoldingsDetail
		FROM #CalcSheetItemFormulaDetails
        WHERE ItemType = 'HoldingsDetail'

        DECLARE @sql NVARCHAR(MAX),
                @sql1 NVARCHAR(MAX),
                @sql2 NVARCHAR(MAX);

        CREATE TABLE #CalcSheetSecuritiesToSum4
        (
            PK_CalculationSheetItemDetail INT,
            FK_SecurityMaster INT,
            HoldingsCategoryValue NVARCHAR(256),
            FK_CalculationSheetItemColumn INT,
            FK_AccountPeriod INT,
            FK_Fund INT,
            FK_Currency INT
        );


        INSERT #CalculationSheetItemDetail_Criteria
        (
            HoldingsDetailConditionDataType,
            FK_CalculationSheetItemDetail,
            Criteria
        )
        SELECT DISTINCT
               h.HoldingsDetailConditionDataType,
               h.FK_CalculationSheetItemDetail,
               CASE
                   WHEN h.HoldingsDetailField = 'Caption' THEN
                       N'CASE WHEN scEx.SecurityCaption IS NOT NULL THEN scEx.SecurityCaption ELSE sc.SecurityCaption END'
                   WHEN h.HoldingsDetailField = 'DBRSCreditRating' THEN
                       N'CASE WHEN scEx.AMBestCreditRating IS NOT NULL THEN scEx.AMBestCreditRating ELSE sc.AMBestCreditRating END'
                   WHEN h.HoldingsDetailField = 'SecurityCurrencyCode' THEN
                       'c.CurrencyCode'
                   WHEN h.HoldingsDetailField IN ( 'SecurityCurrencyCaption', 'SecurityCurrencySymbol' ) THEN
                       REPLACE(h.HoldingsDetailField, 'Security', '')
                   WHEN h.HoldingsDetailField = 'Issuer' THEN
                       'SecurityIssuerName'
                   WHEN h.HoldingsDetailField = 'IssuerCIK' THEN
                       'CIK'
                   WHEN h.HoldingsDetailField = 'PercentageOfPar' THEN
                       'PercentOfParFooted'
                   WHEN h.HoldingsDetailField = 'PercentOfNetAssets' THEN
                       'PercentOfNetAssetsFooted'
                   WHEN h.HoldingsDetailField = 'PercentOfTotalInvestments' THEN
                       'PercentOfTotalInvestmentsFooted'
                   WHEN h.HoldingsDetailField = 'NetSharesActivityCalculated' THEN
                       'NetSharesActivityCalculatedFooted'
                   WHEN h.HoldingsDetailField = 'NetSharesSoldCalculated' THEN
                       'NetSharesSoldCalculatedFooted'
                   WHEN h.HoldingsDetailField = 'NetMarketValueOfSharesActivityCalculated' THEN
                       'NetMarketValueOfSharesActivityCalculatedFooted'
                   WHEN h.HoldingsDetailField = 'NetMarketValueOfSharesSoldCalculated' THEN
                       'NetMarketValueOfSharesSoldCalculatedFooted'
                   WHEN h.HoldingsDetailField = 'CostCalculated' THEN
                       'CostCalculatedFooted'
                   WHEN h.HoldingsDetailField = 'UnrealizedValueCalculated' THEN
                       'UnrealizedValueCalculatedFooted'
                   WHEN h.HoldingsDetailField = 'BidAskSpreadPercentCalculated' THEN
                       'BidAskSpreadPercentCalculatedFooted'
                   WHEN h.HoldingsDetailField = 'ChangeinUnrealizedValueCalculated' THEN
                       'ChangeinUnrealizedValueCalculatedFooted'
                   WHEN h.HoldingsDetailField = 'BidAskSpreadValueCalculated' THEN
                       'BidAskSpreadValueCalculatedFooted'
                   WHEN h.HoldingsDetailField = 'UnrealizedValueBidCalculated' THEN
                       'UnrealizedValueBidCalculatedFooted'
                   WHEN h.HoldingsDetailField = 'UnrealizedValueAskCalculated' THEN
                       'UnrealizedValueAskCalculatedFooted'
                   WHEN h.HoldingsDetailField = 'MarketValueBidCalculated' THEN
                       'MarketValueBidCalculatedFooted'
                   WHEN h.HoldingsDetailField = 'MarketValueAskCalculated' THEN
                       'MarketValueAskCalculatedFooted'
                   WHEN h.HoldingsDetailField = 'CaptionCustomSort' THEN
                       N'CASE WHEN scEx.SecurityCaptionCustomSort IS NOT NULL THEN scEx.SecurityCaptionCustomSort ELSE sc.SecurityCaptionCustomSort END'
                   WHEN h.HoldingsDetailField = 'OtherCredit  Rating6' THEN
                       N'CASE WHEN scEx.OtherCreditRating6 IS NOT NULL THEN scEx.OtherCreditRating6 ELSE sc.OtherCreditRating6 END'
                   WHEN h.HoldingsDetailField IN
                        (
                            SELECT [name]
                            FROM sys.columns
                            WHERE [object_id] = OBJECT_ID('dbo.SecurityCaption', 'U')
                        ) THEN
                       N'CASE WHEN scEx.' + h.HoldingsDetailField + N' IS NOT NULL THEN scEx.' + h.HoldingsDetailField
                       + N' ELSE sc.' + h.HoldingsDetailField + N' END'
                   ELSE
                       h.HoldingsDetailField
               END + N' ' + h.HoldingsDetailOperator + N' '
               + CASE
                     WHEN h.HoldingsDetailConditionDataType = N'String' THEN
                         N'''' + REPLACE(h.HoldingsDetailConditionValue, '''', '''''') + N''''
                     WHEN h.HoldingsDetailConditionDataType IN ( N'Decimal', N'Int' ) THEN
                         h.HoldingsDetailConditionValue
                     WHEN h.HoldingsDetailConditionDataType = N'Datetime' THEN
                         N'''' + CONVERT(NVARCHAR,
                                         DATEADD(   DAY,
                                                    CAST(CASE ISNUMERIC(h.HoldingsDetailConditionValue)
                                                             WHEN 1 THEN
                                                                 h.HoldingsDetailConditionValue
                                                         END AS INT),
                                                    @AccountPeriodEnd
                                                ),
                                         126
                                        ) + N''''
                     WHEN h.HoldingsDetailConditionDataType = N'Boolean' THEN
                         CAST(CAST(h.HoldingsDetailConditionValue AS BIT) AS NVARCHAR(1))
                 END AS Criteria
        FROM dbo.CalculationSheetItemDetailHoldingsDetail h
            JOIN #CalcSheetItemFormulaDetails f
                ON f.PK_CalculationSheetItemDetail = h.FK_CalculationSheetItemDetail
        WHERE h.HoldingsDetailField NOT LIKE 'Category Caption%'
              AND h.HoldingsDetailField NOT IN ( 'CategoryNotes', 'ExplanatoryNotes', 'InvestmentType', 'Language',
                                                 'ReferenceFundCode', 'RelatedFundCurrency', 'SecurityBalanceSource',
                                                 'Valueexcludinganycapitalsupportagreements',
                                                 'Valueincludinganycapitalsupportagreements'
                                               )
              AND h.HoldingsDetailField IS NOT NULL
              AND h.HoldingsDetailOperator IS NOT NULL
              AND h.HoldingsDetailConditionValue IS NOT NULL
              AND h.HoldingsDetailConditionDataType IN ( N'String', N'Decimal', N'Int', N'Datetime', N'Boolean' );

        SET @sql1
            = N'INSERT #CalcSheetSecuritiesToSum4 (PK_CalculationSheetItemDetail, FK_SecurityMaster, HoldingsCategoryValue, FK_CalculationSheetItemColumn, FK_AccountPeriod, FK_Fund, FK_Currency)
		SELECT DISTINCT
		csid.PK_CalculationSheetItemDetail
		,sb.FK_SecurityMaster
		,csid.HoldingsDetailValue
		,csifd.FK_CalculationSheetItemColumn
		,sb.FK_AccountPeriod
		,sb.FK_Fund
		,CASE WHEN csifd.PK_Currency IS NOT NULL THEN sb.FK_Currency END AS FK_Currency
		FROM #CalcSheetItemFormulaDetails csifd
		JOIN #AccountPeriodsForHoldingsDetail aphd ON aphd.FK_AccountPeriod = ISNULL(csifd.FK_AccountPeriod,0)
		JOIN dbo.CalculationSheetItemDetail csid ON csid.PK_CalculationSheetItemDetail = csifd.PK_CalculationSheetItemDetail
		LEFT JOIN dbo.CalculationSheetItemDetailHoldingsDetail csidhd ON csidhd.FK_CalculationSheetItemDetail = csid.PK_CalculationSheetItemDetail
		CROSS JOIN #FUNDS f
		LEFT JOIN dbo.SecurityBalance sb
			ON sb.FK_AccountPeriod = csifd.FK_AccountPeriod
			AND sb.FK_Fund = f.FK_Fund
			AND sb.FK_BalanceType = @BalanceTypeKey
		LEFT JOIN dbo.Currency c ON c.PK_Currency = sb.FK_Currency
		LEFT JOIN dbo.CurrencyCaption cc ON cc.FK_CurrencyCaptionLibrary = @CurrencyCaptionLibraryKey AND cc.FK_Currency = c.PK_Currency
		LEFT JOIN dbo.SecurityCaption sc ON sc.FK_AccountPeriod = sb.FK_AccountPeriod
													AND sc.FK_SecurityCaptionLibrary = @SecurityCaptionLibraryKey
													AND sc.FK_SecurityMaster = sb.FK_SecurityMaster
													AND (sc.FK_SecurityCaptionLibraryLanguage = ISNULL(@SecurityCaptionLibraryLanguageKey, 0) OR sc.FK_SecurityCaptionLibraryLanguage IS NULL)
													AND sc.FK_Fund_SecurityException IS NULL
		LEFT JOIN dbo.SecurityCaption scEx ON scEx.FK_AccountPeriod = sb.FK_AccountPeriod
													AND scEx.FK_SecurityCaptionLibrary = @SecurityCaptionLibraryKey
													AND scEx.FK_SecurityMaster = sb.FK_SecurityMaster
													AND (scEx.FK_SecurityCaptionLibraryLanguage = ISNULL(@SecurityCaptionLibraryLanguageKey, 0) OR scEx.FK_SecurityCaptionLibraryLanguage IS NULL)
													AND scEx.FK_Fund_SecurityException = sb.FK_Fund
		JOIN dbo.SecurityMaster sm ON sm.PK_SecurityMaster = sb.FK_SecurityMaster
		LEFT JOIN dbo.SecurityIssuer si ON si.PK_SecurityIssuer = ISNULL(scEx.FK_SecurityIssuer, sc.FK_SecurityIssuer)
		LEFT JOIN dbo.PortfolioStatementValueStatus psvs ON psvs.FK_PortfolioStatementTemplate = @PortfolioStatementTemplate
													AND psvs.FK_AccountPeriod = sb.FK_AccountPeriod
													AND psvs.FK_BalanceType = @BalanceTypeKey
													AND psvs.FK_Fund = @FundKey
		LEFT JOIN dbo.PortfolioStatementValue psv ON psv.FK_SecurityBalance = sb.PK_SecurityBalance
													AND psv.FK_PortfolioStatementValueStatus = psvs.PK_PortfolioStatementValueStatus
		WHERE csid.ItemType = N''HoldingsDetail''
		AND csifd.FK_AccountPeriod IS NOT NULL
		AND ISNULL(sb.FK_Currency, 0) IN
			(
			CASE ISNULL(csifd.PK_Currency, 0)
				WHEN 0 THEN ISNULL(sb.FK_Currency, 0)
				ELSE ISNULL(csifd.PK_Currency, 0)
			END
			,
			CASE ISNULL(csifd.PK_Currency, 0)
				WHEN ISNULL(f.BaseCurrencyKey, 0) THEN NULL
				ELSE ISNULL(csifd.PK_Currency, 0)
			END
			)';

        SET @sql2 =
        (
            SELECT t.FK_CalculationSheetItemDetail AS [*],
                   (
                       SELECT Criteria AS [*]
                       FROM #CalculationSheetItemDetail_Criteria
                       WHERE FK_CalculationSheetItemDetail = t.FK_CalculationSheetItemDetail
                             AND HoldingsDetailConditionDataType IN ( N'String', N'Decimal', N'Int', N'Datetime',
                                                                      N'Boolean'
                                                                    )
                       FOR XML PATH('criterion'), TYPE
                   )
            FROM
            (
                SELECT DISTINCT
                       FK_CalculationSheetItemDetail
                FROM #CalculationSheetItemDetail_Criteria
                WHERE HoldingsDetailConditionDataType IN ( N'String', N'Decimal', N'Int', N'Datetime', N'Boolean' )
            ) t
            FOR XML PATH('FK_CalculationSheetItemDetail')
        );

        SET @sql2
            = N' AND (csidhd.FK_CalculationSheetItemDetail = -1'
              + REPLACE(
                           REPLACE(
                                      REPLACE(
                                                 REPLACE(
                                                            REPLACE(
                                                                       REPLACE(
                                                                                  REPLACE(
                                                                                             @sql2,
                                                                                             N'</FK_CalculationSheetItemDetail>',
                                                                                             ''
                                                                                         ),
                                                                                  N'<FK_CalculationSheetItemDetail>',
                                                                                  N' OR (csidhd.FK_CalculationSheetItemDetail = '
                                                                              ),
                                                                       N'</criterion><criterion>',
                                                                       N' AND '
                                                                   ),
                                                            N'<criterion>',
                                                            N' AND ('
                                                        ),
                                                 N'</criterion>',
                                                 N'))'
                                             ),
                                      N'&gt;',
                                      '>'
                                  ),
                           N'&lt;',
                           N'<'
                       ) + N')';

        SET @sql = @sql1 + @sql2;

        EXEC sp_executesql @sql,
                           N'@FundRoundingLevel INT, @SecurityCaptionLibraryKey INT, @SecurityCaptionLibraryLanguageKey INT, @PortfolioStatementTemplate INT, @BalanceTypeKey INT, @CurrencyCaptionLibraryKey INT, @FundKey INT',
                           @FundRoundingLevel,
                           @SecurityCaptionLibraryKey,
                           @SecurityCaptionLibraryLanguageKey,
                           @PortfolioStatementTemplate,
                           @BalanceTypeKey,
                           @CurrencyCaptionLibraryKey,
                           @FundKey;

        CREATE CLUSTERED INDEX IX_PK_CalculationSheetItemDetail_HoldingsCategoryValue_FK_Currency
        ON #CalcSheetSecuritiesToSum4 (
                                          PK_CalculationSheetItemDetail,
                                          HoldingsCategoryValue,
                                          FK_Currency
                                      )
        WITH (FILLFACTOR = 100); -- match column order in GROUP BY clause below to prevent Sort in query plan

        -- Add rows for calculation sheet item details that are not in list yet
        INSERT INTO #CalcSheetSecuritiesToSum4
        (
            PK_CalculationSheetItemDetail,
            HoldingsCategoryValue,
            FK_CalculationSheetItemColumn
        )
        SELECT DISTINCT
               csid.PK_CalculationSheetItemDetail,
               csid.HoldingsDetailValue,
               csifd.FK_CalculationSheetItemColumn
        FROM #CalcSheetItemFormulaDetails csifd
            JOIN dbo.CalculationSheetItemDetail csid
                ON csid.PK_CalculationSheetItemDetail = csifd.PK_CalculationSheetItemDetail
        WHERE csid.ItemType = 'HoldingsDetail'
              AND csid.PK_CalculationSheetItemDetail NOT IN
                  (
                      SELECT PK_CalculationSheetItemDetail FROM #CalcSheetSecuritiesToSum4
                  );


        INSERT INTO #PortfolioResultTable
        (
            FK_CalculationSheetItemDetail,
            FK_Currency,
            ValueFooted
        )
        SELECT securitiesToSum.PK_CalculationSheetItemDetail,
               securitiesToSum.FK_Currency,
               SUM(ISNULL(   CASE securitiesToSum.HoldingsCategoryValue
                                 WHEN 'AccruedInterest' THEN
                                     psv.AccruedInterestFooted
                                 WHEN 'BaseCurrencyBought' THEN
                                     psv.BaseCurrencyBoughtFooted
                                 WHEN 'BaseCurrencySold' THEN
                                     psv.BaseCurrencySoldFooted
                                 WHEN 'BaseUnitPrice' THEN
                                     psv.BaseUnitPriceFooted
                                 WHEN 'Bought' THEN
                                     psv.BoughtFooted
                                 WHEN 'ContractRate' THEN
                                     psv.ContractRateFooted
                                 WHEN 'Cost' THEN
                                     psv.CostFooted
                                 WHEN 'CouponRate' THEN
                                     psv.CouponRateFooted
                                 WHEN 'ExcludeCapitalSupportValue' THEN
                                     psv.ExcludeCapitalSupportValueFooted
                                 WHEN 'IncludeCapitalSupportValue' THEN
                                     psv.IncludeCapitalSupportValueFooted
                                 WHEN 'LocalCrossTrade' THEN
                                     psv.LocalCrossTradeFooted
                                 WHEN 'LocalCurrencyBought' THEN
                                     psv.LocalCurrencyBoughtFooted
                                 WHEN 'LocalCurrencySold' THEN
                                     psv.LocalCurrencySoldFooted
                                 WHEN 'MarketValue' THEN
                                     psv.MarketValueFooted
                                 WHEN 'MarketValueBid' THEN
                                     psv.MarketValueBidFooted
                                 WHEN 'MarketValueAsk' THEN
                                     psv.MarketValueAskFooted
                                 WHEN 'MarketValueLevelNAV' THEN
                                     psv.MarketValueLevelNAVFooted
                                 WHEN 'MarketValueLevel1' THEN
                                     psv.MarketValueLevel1Footed
                                 WHEN 'MarketValueLevel2' THEN
                                     psv.MarketValueLevel2Footed
                                 WHEN 'MarketValueLevel3' THEN
                                     psv.MarketValueLevel3Footed
                                 WHEN 'NotionalAmount' THEN
                                     psv.NotionalAmountFooted
                                 WHEN N'NetMarketValueofSharesActivityCalculated' THEN
                                     psv.NetMarketValueOfSharesActivityCalculatedFooted
                                 WHEN N'NetMarketValueofSharesSoldCalculated' THEN
                                     psv.NetMarketValueOfSharesSoldCalculatedFooted
                                 WHEN N'NetSharesActivityCalculated' THEN
                                     psv.NetSharesActivityCalculatedFooted
                                 WHEN N'NetSharesSoldcalculated' THEN
                                     psv.NetSharesSoldCalculatedFooted
                                 WHEN N'MarketValueTransferLevel1From2BeginOfPeriod' THEN
                                     psv.MarketValueTransferLevel1From2BeginOfPeriodFooted
                                 WHEN N'MarketValueTransferLevel1From2EndOfPeriod' THEN
                                     psv.MarketValueTransferLevel1From2EndOfPeriodFooted
                                 WHEN N'MarketValueTransferLevel2From1BeginOfPeriod' THEN
                                     psv.MarketValueTransferLevel2From1BeginOfPeriodFooted
                                 WHEN N'MarketValueTransferLevel2From1EndOfPeriod' THEN
                                     psv.MarketValueTransferLevel2From1EndOfPeriodFooted
                                 WHEN N'MarketValueTransferLevel2From3BeginOfPeriod' THEN
                                     psv.MarketValueTransferLevel2From3BeginOfPeriodFooted
                                 WHEN N'MarketValueTransferLevel2From3EndOfPeriod' THEN
                                     psv.MarketValueTransferLevel2From3EndOfPeriodFooted
                                 WHEN N'MarketValueTransferLevel3From2BeginOfPeriod' THEN
                                     psv.MarketValueTransferLevel3From2BeginOfPeriodFooted
                                 WHEN N'MarketValueTransferLevel3From2EndOfPeriod' THEN
                                     psv.MarketValueTransferLevel3From2EndOfPeriodFooted
                                 WHEN N'MarketValueLevel3TransferInBeginOfPeriod' THEN
                                     psv.MarketValueLevel3TransferInBeginOfPeriodFooted
                                 WHEN N'MarketValueLevel3TransferOutBeginOfPeriod' THEN
                                     psv.MarketValueLevel3TransferOutBeginOfPeriodFooted
                                 WHEN N'MarketValueLevel3TransferInEndOfPeriod' THEN
                                     psv.MarketValueLevel3TransferInEndOfPeriodFooted
                                 WHEN N'MarketValueLevel3TransferOutEndOfPeriod' THEN
                                     psv.MarketValueLevel3TransferOutEndOfPeriodFooted
                                 WHEN 'OptionPremium' THEN
                                     psv.OptionPremiumFooted
                                 WHEN 'PercentOfNetAssets' THEN
                                     psv.PercentOfNetAssetsFooted
                                 WHEN 'PercentageOfPar' THEN
                                     psv.PercentOfParFooted
                                 WHEN 'PercentOfTotalInvestments' THEN
                                     psv.PercentOfTotalInvestmentsFooted
                                 WHEN 'Proceeds' THEN
                                     psv.ProceedsFooted
                                 WHEN 'PurchaseAmountBase' THEN
                                     psv.PurchaseAmountBaseFooted
                                 WHEN 'PurchaseAmountLocal' THEN
                                     psv.PurchaseAmountLocalFooted
                                 WHEN 'PurchaseCost' THEN
                                     psv.PurchaseCostFooted
                                 WHEN 'Shares' THEN
                                     psv.SharesFooted
                                 WHEN 'Sold' THEN
                                     psv.SoldFooted
                                 WHEN 'SoldAmountBase' THEN
                                     psv.SoldAmountBaseFooted
                                 WHEN 'SoldAmountLocal' THEN
                                     psv.SoldAmountLocalFooted
                                 WHEN 'StrikePrice' THEN
                                     psv.StrikePriceFooted
                                 WHEN 'UnrealizedValue' THEN
                                     psv.UnrealizedValueFooted
                                 WHEN 'Yield' THEN
                                     psv.YieldFooted
                                 WHEN N'AccruedDiscountsPremiums' THEN
                                     psv.AccruedDiscountsPremiumsFooted
                                 WHEN N'CapitalGainDistributions' THEN
                                     psv.CapitalGainDistributionsFooted
                                 WHEN N'CashCollateralSecurityValue' THEN
                                     psv.CashCollateralSecurityValueFooted
                                 WHEN N'ChangeinUnrealizedValue' THEN
                                     psv.ChangeinUnrealizedValueFooted
                                 WHEN N'ChangeinUnrealizedValueCalculated' THEN
                                     psv.ChangeinUnrealizedValueCalculatedFooted
                                 WHEN N'CommittedCapital' THEN
                                     psv.CommittedCapitalFooted
                                 WHEN N'ConversionRatio' THEN
                                     psv.ConversionRatioFooted
                                 WHEN N'CumulativeContributedCapital' THEN
                                     psv.CumulativeContributedCapitalFooted
                                 WHEN N'CurrencyDescriptionBought' THEN
                                     psv.CurrencyDescriptionBoughtFooted
                                 WHEN N'CurrencyDescriptionSold' THEN
                                     psv.CurrencyDescriptionSoldFooted
                                 WHEN N'Delta' THEN
                                     psv.DeltaFooted
                                 WHEN N'DividendsAffiliatedIssuers' THEN
                                     psv.DividendsAffiliatedIssuersFooted
                                 WHEN N'ExercisePrice' THEN
                                     psv.ExercisePriceFooted
                                 WHEN N'Gamma' THEN
                                     psv.GammaFooted
                                 WHEN N'Income' THEN
                                     psv.IncomeFooted
                                 WHEN N'MarketValueofSharesPurchased' THEN
                                     psv.MarketValueofSharesPurchasedFooted
                                 WHEN N'MarketValueofSharesSold' THEN
                                     psv.MarketValueofSharesSoldFooted
                                 WHEN N'NonCashCollateralSecurityValue' THEN
                                     psv.NonCashCollateralSecurityValueFooted
                                 WHEN N'NumberofContracts' THEN
                                     psv.NumberOfContractsFooted
                                 WHEN N'RemainingCommitment' THEN
                                     psv.RemainingCommitmentFooted
                                 WHEN N'RepurchaseRate' THEN
                                     psv.RepurchaseRateFooted
                                 WHEN N'RealizedValue' THEN
                                     psv.RealizedValueFooted
                                 WHEN N'SharesPurchased' THEN
                                     psv.SharesPurchasedFooted
                                 WHEN N'SharesSold' THEN
                                     psv.SharesSoldFooted
                                 WHEN N'TotalDistributions' THEN
                                     psv.TotalDistributionsFooted
                                 WHEN N'UnrealizedAppreciationDepreciation' THEN
                                     psv.UnrealizedAppreciationDepreciationFooted
                                 WHEN N'UnrealizedValueCalculated' THEN
                                     psv.UnrealizedValueCalculatedFooted
                                 WHEN N'UpfrontPaymentsReceipts' THEN
                                     psv.UpfrontPaymentsReceiptsFooted
                                 WHEN N'Vega' THEN
                                     psv.VegaFooted
                                 ELSE
                                     psv.MarketValueFooted
                             END,
                             0
                         )
                  ) AS ValueFooted
        FROM #CalcSheetSecuritiesToSum4 securitiesToSum
            LEFT OUTER JOIN dbo.SecurityBalance sb
                ON sb.FK_SecurityMaster = securitiesToSum.FK_SecurityMaster
                   AND sb.FK_Fund = securitiesToSum.FK_Fund
                   AND sb.FK_AccountPeriod = securitiesToSum.FK_AccountPeriod
                   AND sb.FK_BalanceType = @BalanceTypeKey
            LEFT OUTER JOIN dbo.PortfolioStatementValueStatus psvs
                ON psvs.FK_PortfolioStatementTemplate = @PortfolioStatementTemplate
                   AND psvs.FK_AccountPeriod = securitiesToSum.FK_AccountPeriod
                   AND psvs.FK_BalanceType = @BalanceTypeKey
                   AND psvs.FK_Fund = @FundKey
            LEFT OUTER JOIN dbo.PortfolioStatementValue psv
                ON psv.FK_SecurityBalance = sb.PK_SecurityBalance
                   AND psv.FK_PortfolioStatementValueStatus = psvs.PK_PortfolioStatementValueStatus
        GROUP BY securitiesToSum.PK_CalculationSheetItemDetail,
                 securitiesToSum.HoldingsCategoryValue,
                 securitiesToSum.FK_Currency;

        DROP TABLE #CalcSheetSecuritiesToSum4;


        EXEC dbo.gp_WriteToCalculationLog 'Financial',
                                          @FundKey,
                                          @AccountPeriodKey,
                                          @BalanceTypeKey,
                                          NULL,
                                          'PortfolioHoldingsDetail data retrieval complete for calc sheet calculation engine.',
                                          'GetPortfolioHoldingsDetailInputValuesForCalculationEngine',
                                          NULL,
                                          NULL,
                                          @CalculationBatchKey;
    END;
    DROP TABLE #CalculationSheetItemDetail_Criteria;
    DROP TABLE #FUNDS;


    EXEC dbo.gp_WriteToCalculationLog 'Financial',
                                      @FundKey,
                                      @AccountPeriodKey,
                                      @BalanceTypeKey,
                                      NULL,
                                      'Portfolio data retrieval complete for calc sheet calculation engine.',
                                      'GetInputValuesForCalculationEngine',
                                      NULL,
                                      NULL,
                                      @CalculationBatchKey;
END;
CREATE TABLE #ClassBalanceDataPointTable
(
    PK_CalculationSheetItemDetail INT NOT NULL,
    PK_Class INT NOT NULL,
    PK_Currency INT NOT NULL,
    ValueFooted DECIMAL(28, 6) NOT NULL
);

INSERT #ClassBalanceDataPointTable
(
    PK_CalculationSheetItemDetail,
    PK_Class,
    PK_Currency,
    ValueFooted
)
SELECT DISTINCT
       fd.PK_CalculationSheetItemDetail,
       ISNULL(fd.PK_Class, 0) AS PK_Class,
       ISNULL(fd.PK_Currency, 0) AS PK_Currency,
       ISNULL(   CASE fd.ItemType
                     WHEN 'ClassBalanceDataPoint' THEN
                         CASE fd.ClassDataPoint
                             WHEN 'NetAssets' THEN
                                 cb.NetAssets
                             WHEN 'NAV' THEN
                                 cb.NAV
                             WHEN 'NetShareholder' THEN
                                 cb.NetShareholder
                             WHEN 'GrossSubscriptions' THEN
                                 cb.GrossSubscriptions
                             WHEN 'GrossRedemptions' THEN
                                 cb.GrossRedemptions
                             WHEN 'SevenDayNetYield' THEN
                                 cb.SevenDayNetYield
                             WHEN 'NAVIncludingCapitalSupport' THEN
                                 cb.NAVIncludingCapitalSupport
                             WHEN 'NAVExcludingCapitalSupport' THEN
                                 cb.NAVExcludingCapitalSupport
                             WHEN 'SharesOutstanding' THEN
                                 cb.SharesOutstanding
                             WHEN 'PublicOfferingPrice' THEN
                                 cb.PublicOfferingPrice
                             WHEN 'TurnoverPct' THEN
                                 cb.TurnoverPct
                             WHEN 'NetInvestmentIncomeDistPerShare' THEN
                                 cb.NetInvestmentIncomeDistPerShare
                             WHEN 'RealizedGainsDistPerShare' THEN
                                 cb.RealizedGainsDistPerShare
                             WHEN 'DistInExcessOfNetInvestIncome' THEN
                                 cb.DistInExcessOfNetInvestIncome
                             WHEN 'TotalReturn1Month' THEN
                                 cb.TotalReturn1Month
                             WHEN 'TotalReturn3Months' THEN
                                 cb.TotalReturn3Months
                             WHEN 'TotalReturn6Months' THEN
                                 cb.TotalReturn6Months
                             WHEN 'TotalReturn9Months' THEN
                                 cb.TotalReturn9Months
                             WHEN 'TotalReturn1Year' THEN
                                 cb.TotalReturn1Year
                             WHEN 'TotalReturn2YearCumulative' THEN
                                 cb.TotalReturn2YearCumulative
                             WHEN 'TotalReturn3YearCumulative' THEN
                                 cb.TotalReturn3YearCumulative
                             WHEN 'TotalReturn4YearCumulative' THEN
                                 cb.TotalReturn4YearCumulative
                             WHEN 'TotalReturn5YearCumulative' THEN
                                 cb.TotalReturn5YearCumulative
                             WHEN 'TotalReturn6YearCumulative' THEN
                                 cb.TotalReturn6YearCumulative
                             WHEN 'TotalReturn7YearCumulative' THEN
                                 cb.TotalReturn7YearCumulative
                             WHEN 'TotalReturn8YearCumulative' THEN
                                 cb.TotalReturn8YearCumulative
                             WHEN 'TotalReturn9YearCumulative' THEN
                                 cb.TotalReturn9YearCumulative
                             WHEN 'TotalReturn10YearCumulative' THEN
                                 cb.TotalReturn10YearCumulative
                             WHEN 'TotalReturnSinceInceptionCumulative' THEN
                                 cb.TotalReturnSinceInceptionCumulative
                             WHEN 'TotalReturn2YearAnnualized' THEN
                                 cb.TotalReturn2YearAnnualized
                             WHEN 'TotalReturn3YearAnnualized' THEN
                                 cb.TotalReturn3YearAnnualized
                             WHEN 'TotalReturn4YearAnnualized' THEN
                                 cb.TotalReturn4YearAnnualized
                             WHEN 'TotalReturn5YearAnnualized' THEN
                                 cb.TotalReturn5YearAnnualized
                             WHEN 'TotalReturn6YearAnnualized' THEN
                                 cb.TotalReturn6YearAnnualized
                             WHEN 'TotalReturn7YearAnnualized' THEN
                                 cb.TotalReturn7YearAnnualized
                             WHEN 'TotalReturn8YearAnnualized' THEN
                                 cb.TotalReturn8YearAnnualized
                             WHEN 'TotalReturn9YearAnnualized' THEN
                                 cb.TotalReturn9YearAnnualized
                             WHEN 'TotalReturn10YearAnnualized' THEN
                                 cb.TotalReturn10YearAnnualized
                             WHEN 'TotalReturnSinceInceptionAnnualized' THEN
                                 cb.TotalReturnSinceInceptionAnnualized
                             WHEN 'Subscriptions' THEN
                                 cb.Subscriptions
                             WHEN 'SubscriptionExchanges' THEN
                                 cb.SubscriptionExchanges
                             WHEN 'SubscriptionShares' THEN
                                 cb.SubscriptionShares
                             WHEN 'SubscriptionExchangesShares' THEN
                                 cb.SubscriptionExchangesShares
                             WHEN 'Redemptions' THEN
                                 cb.Redemptions
                             WHEN 'RedemptionsExchanges' THEN
                                 cb.RedemptionsExchanges
                             WHEN 'RedemptionsShares' THEN
                                 cb.RedemptionsShares
                             WHEN 'RedemptionsExchangesShares' THEN
                                 cb.RedemptionsExchangesShares
                             WHEN 'DividendsReinvested' THEN
                                 cb.DividendsReinvested
                             WHEN 'DividendsReinvestedShares' THEN
                                 cb.DividendsReinvestedShares
                             WHEN 'SixMonthExpenseRatio' THEN
                                 cb.SixMonthExpenseRatio
                             WHEN 'OneYearExpenseRatio' THEN
                                 cb.OneYearExpenseRatio
                             WHEN 'AvgNetAssets1Year' THEN
                                 cb.AvgNetAssets1Year
                             WHEN 'AvgNetAssets6Months' THEN
                                 cb.AvgNetAssets6Months
                             WHEN 'AverageSharesOutstanding' THEN
                                 cb.AvgSharesOutstanding
                             WHEN 'HighNAV' THEN
                                 cb.HighNAV
                             WHEN 'LowNAV' THEN
                                 cb.LowNAV
                             WHEN 'NetInvestmentIncomePerShare' THEN
                                 cb.NetInvestmentIncomePerShare
                             WHEN 'RealizedGainsDistributionPerShare' THEN
                                 cb.RealizedGainsDistPerShareShortTerm
                             WHEN 'RedemptionFeesPerShare' THEN
                                 cb.RedemptionFeesPerShare
                             WHEN 'BidPrice' THEN
                                 cb.BidPrice
                             WHEN 'SharePrice' THEN
                                 cb.SharePrice
                             WHEN 'BillableAccounts' THEN
                                 cb.BillableAccounts
                             WHEN 'TotalReturn1MonthIncludeSalesCharge' THEN
                                 cb.TotalReturn1MonthIncludeSalesCharge
                             WHEN 'TotalReturn3MonthIncludeSalesCharge' THEN
                                 cb.TotalReturn3MonthIncludeSalesCharge
                             WHEN 'TotalReturn6MonthIncludeSalesCharge' THEN
                                 cb.TotalReturn6MonthIncludeSalesCharge
                             WHEN 'TotalReturn9MonthIncludeSalesCharge' THEN
                                 cb.TotalReturn9MonthIncludeSalesCharge
                             WHEN 'TotalReturn1YearAnnualizedIncludeSalesCharge' THEN
                                 cb.TotalReturn1YearAnnualizedIncludeSalesCharge
                             WHEN 'TotalReturn2YearAnnualizedIncludeSalesCharge' THEN
                                 cb.TotalReturn2YearAnnualizedIncludeSalesCharge
                             WHEN 'TotalReturn3YearAnnualizedIncludeSalesCharge' THEN
                                 cb.TotalReturn3YearAnnualizedIncludeSalesCharge
                             WHEN 'TotalReturn4YearAnnualizedIncludeSalesCharge' THEN
                                 cb.TotalReturn4YearAnnualizedIncludeSalesCharge
                             WHEN 'TotalReturn5YearAnnualizedIncludeSalesCharge' THEN
                                 cb.TotalReturn5YearAnnualizedIncludeSalesCharge
                             WHEN 'TotalReturn6YearAnnualizedIncludeSalesCharge' THEN
                                 cb.TotalReturn6YearAnnualizedIncludeSalesCharge
                             WHEN 'TotalReturn7YearAnnualizedIncludeSalesCharge' THEN
                                 cb.TotalReturn7YearAnnualizedIncludeSalesCharge
                             WHEN 'TotalReturn8YearAnnualizedIncludeSalesCharge' THEN
                                 cb.TotalReturn8YearAnnualizedIncludeSalesCharge
                             WHEN 'TotalReturn9YearAnnualizedIncludeSalesCharge' THEN
                                 cb.TotalReturn9YearAnnualizedIncludeSalesCharge
                             WHEN 'TotalReturn10YearAnnualizedIncludeSalesCharge' THEN
                                 cb.TotalReturn10YearAnnualizedIncludeSalesCharge
                             WHEN 'TotalReturnSinceInceptionAnnualizedIncludeSalesCharge' THEN
                                 cb.TotalReturnSinceInceptionAnnualizedIncludeSalesCharge
                             WHEN 'TaxRate' THEN
                                 cb.TaxRate
                             WHEN 'ThirtyDayYield' THEN
                                 cb.ThirtyDayYield
                             WHEN 'TaxableYield' THEN
                                 cb.TaxableYield
                             WHEN 'SevenDayNetAnnualizedYield' THEN
                                 cb.SevenDayNetAnnualizedYield
                             WHEN 'TaxableRate' THEN
                                 cb.TaxableRate
                             WHEN 'DistributionRate' THEN
                                 cb.DistributionRate
                             WHEN 'DistributionsQ1Value' THEN
                                 cb.DistributionsQ1Value
                             WHEN 'DistributionsQ2Value' THEN
                                 cb.DistributionsQ2Value
                             WHEN 'DistributionsQ3Value' THEN
                                 cb.DistributionsQ3Value
                             WHEN 'DistributionsQ4Value' THEN
                                 cb.DistributionsQ4Value
                             WHEN 'YearEndDistributionValue' THEN
                                 cb.YearEndDistributionValue
                             WHEN 'DistributionsQ1CPU' THEN
                                 cb.DistributionsQ1CPU
                             WHEN 'DistributionsQ2CPU' THEN
                                 cb.DistributionsQ2CPU
                             WHEN 'DistributionsQ3CPU' THEN
                                 cb.DistributionsQ3CPU
                             WHEN 'DistributionsQ4CPU' THEN
                                 cb.DistributionsQ4CPU
                             WHEN 'YearEndDistributionCPU' THEN
                                 cb.YearEndDistributionCPU
                             WHEN 'ReinvestmentsQ1' THEN
                                 cb.ReinvestmentsQ1
                             WHEN 'ReinvestmentsQ2' THEN
                                 cb.ReinvestmentsQ2
                             WHEN 'ReinvestmentsQ3' THEN
                                 cb.ReinvestmentsQ3
                             WHEN 'ReinvestmentsQ4' THEN
                                 cb.ReinvestmentsQ4
                             WHEN 'YearEndReinvestment' THEN
                                 cb.YearEndReinvestment
                             WHEN 'ClassField1' THEN
                                 cb.ClassField1
                             WHEN 'ClassField2' THEN
                                 cb.ClassField2
                             WHEN 'ClassField3' THEN
                                 cb.ClassField3
                             WHEN 'ClassField4' THEN
                                 cb.ClassField4
                             WHEN 'ClassField5' THEN
                                 cb.ClassField5
                             WHEN 'ClassField6' THEN
                                 cb.ClassField6
                             WHEN 'ClassField7' THEN
                                 cb.ClassField7
                             WHEN 'ClassField8' THEN
                                 cb.ClassField8
                             WHEN 'ClassField9' THEN
                                 cb.ClassField9
                             WHEN 'ClassField10' THEN
                                 cb.ClassField10
                             WHEN 'ManagementFeeRate' THEN
                                 cb.ManagementFeeRate
                             WHEN 'CustodyFeeRate' THEN
                                 cb.CustodyFeeRate
                             WHEN 'ManagementFees' THEN
                                 cb.ManagementFees
                             WHEN 'OtherExpensesexcludingManagementFees' THEN
                                 cb.OtherExpenses
                             WHEN 'DistributionCharged' THEN
                                 cb.DistributionCharged
                             WHEN 'DistributionPaid' THEN
                                 cb.DistributionPaid
                             WHEN 'AvgNAV' THEN
                                 cb.AvgNAV
                             WHEN 'ExpenseRatio2' THEN
                                 cb.ExpenseRatio2
                             WHEN 'ExpenseCap' THEN
                                 cb.ExpenseCap
                             ELSE
                                 0
                         END
                     ELSE
                 (
                     SELECT CASE fd.ClassDataPoint
                                WHEN 'ExpenseCapPercentage' THEN
                                    ExpenseCapPercentage
                                WHEN 'ProspectusRatio' THEN
                                    ProspectusRatio
                                WHEN 'MinInitialInvestment' THEN
                                    MinInitialInvestment
                                WHEN 'ParValue' THEN
                                    ParValue
                                WHEN 'MaximumFrontEndLoad' THEN
                                    MaximumFrontEndLoad
                                WHEN 'MaximumBackEndLoad' THEN
                                    MaximumBackEndLoad
                                WHEN 'RedemptionFee' THEN
                                    RedemptionFee
                                ELSE
                                    0
                            END
                     FROM dbo.Class
                     WHERE PK_Class = fd.PK_Class
                 )
                 END,
                 0
             ) AS ValueFooted
FROM #CalcSheetItemFormulaDetails fd
    LEFT OUTER JOIN dbo.GLBalanceSet bs
        ON bs.PK_GLBalanceSet = fd.FK_GLBalanceSet
    LEFT OUTER JOIN dbo.Class c
        ON c.FK_Fund = bs.FK_Fund
           AND c.FK_BaseClass = fd.FK_BaseClass
    --when set to "Footed" pull value from new ComponentValue table (will only exist if item was added to a trial balance)
    LEFT OUTER JOIN dbo.TrialBalanceItemComponentValue cv
        ON cv.FK_Fund = bs.FK_Fund
           AND cv.FK_AccountPeriod = bs.FK_AccountPeriod
           AND cv.FK_BalanceType = bs.FK_BalanceType
           AND cv.ClassDataPointName = fd.ClassDataPoint
           AND ISNULL(cv.FK_Class, 0) = ISNULL(c.PK_Class, 0)
           AND cv.FK_Currency IS NULL
           AND fd.TrialBalanceValueType <> 'Raw Value'
           AND cv.RoundingType = CASE fd.TrialBalanceValueType
                                     WHEN 'Footed - Primary Rounding Level' THEN
                                         'Primary'
                                     WHEN 'Footed - Secondary Rounding Level' THEN
                                         'Secondary'
                                 END
    LEFT OUTER JOIN dbo.ClassBalance cb
        ON cb.FK_AccountPeriod = bs.FK_AccountPeriod
           AND cb.FK_Class = c.PK_Class
           AND cb.FK_BalanceType = bs.FK_BalanceType
WHERE fd.ClassDataPoint <> '';

CREATE CLUSTERED INDEX IX_PK_CalculationSheetItemDetail_PK_Class_PK_Currency
ON #ClassBalanceDataPointTable (
                                   PK_CalculationSheetItemDetail,
                                   PK_Class,
                                   PK_Currency
                               )
WITH (FILLFACTOR = 100);

-- Previous code:
--INSERT @SupplementalDataItemTable (PK_CalculationSheetItemDetail, PK_Class, PK_Currency, ValueFooted, SupplementalDataItemLevel)
--EXEC dbo.gp_GetSupplementalDataInputValuesForCalculationEngine @BalanceSetKey, @TrialBalanceDefinitionKey, @FinancialWorkbookRoundingLevel, @FinancialWorkbookSecondaryRoundingLevel, @FundRoundingLevel;


CREATE TABLE #SupplementalDataItemTable
(
    PK_CalculationSheetItemDetail INT NOT NULL,
    PK_Class INT NOT NULL,
    PK_Currency INT NOT NULL,
    ValueFooted DECIMAL(28, 6) NOT NULL,
    SupplementalDataItemLevelClass BIT NOT NULL
);

INSERT #SupplementalDataItemTable
(
    PK_CalculationSheetItemDetail,
    PK_Class,
    PK_Currency,
    ValueFooted,
    SupplementalDataItemLevelClass
)
SELECT DISTINCT
       fd.PK_CalculationSheetItemDetail,
       fd.PK_Class,
       ISNULL(fd.PK_Currency, 0) AS PK_Currency,
       COALESCE(cv.FootedValue, svClassLevel.[Value], 0) AS ValueFooted,
       1 AS SupplementalDataItemLevelClass
FROM #CalcSheetItemFormulaDetails fd
    JOIN dbo.SupplementalDataItem sdi
        ON sdi.PK_SupplementalDataItem = fd.FK_SupplementalDataItem
    LEFT JOIN dbo.GLBalanceSet bs
        ON bs.PK_GLBalanceSet = fd.FK_GLBalanceSet
    LEFT JOIN dbo.Class c
        ON c.FK_Fund = bs.FK_Fund
           AND c.FK_BaseClass = fd.FK_BaseClass
    --when set to "Footed" pull value from new componentvalue table (will only exist if item was added to a trial balance)
    LEFT JOIN dbo.TrialBalanceItemComponentValue cv
        ON cv.FK_Fund = bs.FK_Fund
           AND cv.FK_AccountPeriod = bs.FK_AccountPeriod
           AND cv.FK_BalanceType = bs.FK_BalanceType
           AND cv.FK_SupplementalDataItem = fd.FK_SupplementalDataItem
           AND cv.FK_Class = c.PK_Class
           AND cv.FK_Currency IS NULL
           AND fd.TrialBalanceValueType <> 'Raw Value'
           AND cv.RoundingType = CASE fd.TrialBalanceValueType
                                     WHEN 'Footed - Primary Rounding Level' THEN
                                         'Primary'
                                     WHEN 'Footed - Secondary Rounding Level' THEN
                                         'Secondary'
                                 END
    --when set to raw (actually if not found in component value table) then pull from raw supplementaldataitemvalue table
    LEFT JOIN dbo.SupplementalDataItemValue svClassLevel
        ON svClassLevel.FK_SupplementalDataItem = fd.FK_SupplementalDataItem
           AND svClassLevel.FK_GLBalanceSet = bs.PK_GLBalanceSet
           AND svClassLevel.FK_Class = c.PK_Class
           AND cv.PK_TrialBalanceItemComponentValue IS NULL
WHERE fd.ItemType = 'SupplementalDataItem'
      AND sdi.[Level] = 'Class'
      AND fd.PK_Class IS NOT NULL
UNION ALL
--To pull Fund Level Supplemental Datapoint values
SELECT DISTINCT
       fd.PK_CalculationSheetItemDetail,
       ISNULL(fd.PK_Class, 0) AS PK_Class,
       ISNULL(fd.PK_Currency, 0) AS PK_Currency,
       COALESCE(cv.FootedValue, svFundLevel.[Value], 0) AS ValueFooted,
       0 AS SupplementalDataItemLevelClass
FROM #CalcSheetItemFormulaDetails fd
    JOIN dbo.SupplementalDataItem sdi
        ON sdi.PK_SupplementalDataItem = fd.FK_SupplementalDataItem
    LEFT JOIN dbo.GLBalanceSet bs
        ON bs.PK_GLBalanceSet = fd.FK_GLBalanceSet
    --when set to "Footed" pull value from new componentvalue table (will only exist if item was added to a trial balance)
    LEFT JOIN dbo.TrialBalanceItemComponentValue cv
        ON cv.FK_Fund = bs.FK_Fund
           AND cv.FK_AccountPeriod = bs.FK_AccountPeriod
           AND cv.FK_BalanceType = bs.FK_BalanceType
           AND cv.FK_SupplementalDataItem = fd.FK_SupplementalDataItem
           AND cv.FK_Class IS NULL
           AND cv.FK_Currency IS NULL
           AND fd.TrialBalanceValueType <> 'Raw Value'
           AND cv.RoundingType = CASE fd.TrialBalanceValueType
                                     WHEN 'Footed - Primary Rounding Level' THEN
                                         'Primary'
                                     WHEN 'Footed - Secondary Rounding Level' THEN
                                         'Secondary'
                                 END
    --when set to raw (actually if not found in component value table) then pull from raw supplementaldataitemvalue table
    LEFT JOIN dbo.SupplementalDataItemValue svFundLevel
        ON svFundLevel.FK_SupplementalDataItem = fd.FK_SupplementalDataItem
           AND svFundLevel.FK_GLBalanceSet = bs.PK_GLBalanceSet
           AND cv.PK_TrialBalanceItemComponentValue IS NULL
WHERE fd.ItemType = 'SupplementalDataItem'
      AND sdi.[Level] = 'Fund'
      AND svFundLevel.FK_Class IS NULL;

CREATE CLUSTERED INDEX IX_PK_CalculationSheetItemDetail_PK_Class_PK_Currency
ON #SupplementalDataItemTable (
                                  PK_CalculationSheetItemDetail,
                                  PK_Class,
                                  PK_Currency
                              )
WITH (FILLFACTOR = 100);


-- Previous code
--INSERT @FundBalanceDataPointTable (PK_CalculationSheetItemDetail, PK_Class, PK_Currency, ValueFooted)
--EXEC dbo.gp_GetFundBalanceInputValuesForCalculationEngine @BalanceSetKey, @TrialBalanceDefinitionKey, @FinancialWorkbookRoundingLevel, @FinancialWorkbookSecondaryRoundingLevel, @FundRoundingLevel;


CREATE TABLE #FundBalanceDataPointTable
(
    PK_CalculationSheetItemDetail INT NOT NULL,
    PK_Class INT NOT NULL,
    PK_Currency INT NOT NULL,
    ValueFooted DECIMAL(28, 6) NOT NULL
);

INSERT #FundBalanceDataPointTable
(
    PK_CalculationSheetItemDetail,
    PK_Class,
    PK_Currency,
    ValueFooted
)
--EXEC dbo.gp_GetFundBalanceInputValuesForCalculationEngine @BalanceSetKey, @TrialBalanceDefinitionKey, @FinancialWorkbookRoundingLevel, @FinancialWorkbookSecondaryRoundingLevel, @FundRoundingLevel;
SELECT fd.PK_CalculationSheetItemDetail,
       ISNULL(fd.PK_Class, 0) AS PK_Class,
       ISNULL(fd.PK_Currency, 0) AS PK_Currency,
       COALESCE(   cv.FootedValue,
                   CASE fd.FundDataPoint
                       WHEN 'WAM' THEN
                           ISNULL(fb.WAM, 0)
                       WHEN 'WALM' THEN
                           ISNULL(fb.WALM, 0)
                       WHEN 'TotalValueAmortized' THEN
                           ISNULL(fb.TotalValueAmortized, 0)
                       WHEN 'NetValueOtherAssets' THEN
                           ISNULL(fb.NetValueOtherAssets, 0)
                       WHEN 'NetValueOtherLiabilities' THEN
                           ISNULL(fb.NetValueOtherLiabilities, 0)
                       WHEN 'NetAssetsOfSeries' THEN
                           ISNULL(fb.NetAssetsOfSeries, 0)
                       WHEN 'SevenDayGrossYield' THEN
                           ISNULL(fb.SevenDayGrossYield, 0)
                       WHEN 'NAVIncludingAgreements' THEN
                           ISNULL(fb.NAVIncludingAgreements, 0)
                       WHEN 'NAVExcludingAgreements' THEN
                           ISNULL(fb.NAVExcludingAgreements, 0)
                       WHEN 'Cash' THEN
                           ISNULL(fb.Cash, 0)
                       WHEN 'TVDLAFridayWeek1' THEN
                           ISNULL(fb.TVDLAFridayWeek1, 0)
                       WHEN 'TVDLAFridayWeek2' THEN
                           ISNULL(fb.TVDLAFridayWeek2, 0)
                       WHEN 'TVDLAFridayWeek3' THEN
                           ISNULL(fb.TVDLAFridayWeek3, 0)
                       WHEN 'TVDLAFridayWeek4' THEN
                           ISNULL(fb.TVDLAFridayWeek4, 0)
                       WHEN 'TVDLAFridayWeek5' THEN
                           ISNULL(fb.TVDLAFridayWeek5, 0)
                       WHEN 'TVWLAFridayWeek1' THEN
                           ISNULL(fb.TVWLAFridayWeek1, 0)
                       WHEN 'TVWLAFridayWeek2' THEN
                           ISNULL(fb.TVWLAFridayWeek2, 0)
                       WHEN 'TVWLAFridayWeek3' THEN
                           ISNULL(fb.TVWLAFridayWeek3, 0)
                       WHEN 'TVWLAFridayWeek4' THEN
                           ISNULL(fb.TVWLAFridayWeek4, 0)
                       WHEN 'TVWLAFridayWeek5' THEN
                           ISNULL(fb.TVWLAFridayWeek5, 0)
                       WHEN 'NAVPSFridayWeek1' THEN
                           ISNULL(fb.NAVPSFridayWeek1, 0)
                       WHEN 'NAVPSFridayWeek2' THEN
                           ISNULL(fb.NAVPSFridayWeek2, 0)
                       WHEN 'NAVPSFridayWeek3' THEN
                           ISNULL(fb.NAVPSFridayWeek3, 0)
                       WHEN 'NAVPSFridayWeek4' THEN
                           ISNULL(fb.NAVPSFridayWeek4, 0)
                       WHEN 'NAVPSFridayWeek5' THEN
                           ISNULL(fb.NAVPSFridayWeek5, 0)
                       WHEN 'PDLAFridayWeek1' THEN
                           ISNULL(fb.PDLAFridayWeek1, 0)
                       WHEN 'PDLAFridayWeek2' THEN
                           ISNULL(fb.PDLAFridayWeek2, 0)
                       WHEN 'PDLAFridayWeek3' THEN
                           ISNULL(fb.PDLAFridayWeek3, 0)
                       WHEN 'PDLAFridayWeek4' THEN
                           ISNULL(fb.PDLAFridayWeek4, 0)
                       WHEN 'PDLAFridayWeek5' THEN
                           ISNULL(fb.PDLAFridayWeek5, 0)
                       WHEN 'PWLAFridayWeek1' THEN
                           ISNULL(fb.PWLAFridayWeek1, 0)
                       WHEN 'PWLAFridayWeek2' THEN
                           ISNULL(fb.PWLAFridayWeek2, 0)
                       WHEN 'PWLAFridayWeek3' THEN
                           ISNULL(fb.PWLAFridayWeek3, 0)
                       WHEN 'PWLAFridayWeek4' THEN
                           ISNULL(fb.PWLAFridayWeek4, 0)
                       WHEN 'PWLAFridayWeek5' THEN
                           ISNULL(fb.PWLAFridayWeek5, 0)
                       WHEN 'NumberOfSharesOutstanding' THEN
                           ISNULL(fb.NumberOfSharesOutstanding, 0)
                       WHEN 'TotalValuePortfolioSecurities' THEN
                           ISNULL(fb.TotalValuePortfolioSecurities, 0)
                       ELSE
                           0
                   END,
                   0
               ) AS ValueFooted
FROM #CalcSheetItemFormulaDetails fd
    LEFT JOIN dbo.GLBalanceSet bs
        ON bs.PK_GLBalanceSet = fd.FK_GLBalanceSet

    --when set to "Footed" pull value from new ComponentValue table (will only exist if item was added to a trial balance)
    LEFT JOIN dbo.TrialBalanceItemComponentValue cv
        ON cv.FK_Fund = bs.FK_Fund
           AND cv.FK_AccountPeriod = bs.FK_AccountPeriod
           AND cv.FK_BalanceType = bs.FK_BalanceType
           AND cv.FundDataPointName = fd.FundDataPoint
           AND cv.FK_Class IS NULL
           AND cv.FK_Currency IS NULL
           AND fd.TrialBalanceValueType <> 'Raw Value'
           AND cv.RoundingType = CASE fd.TrialBalanceValueType
                                     WHEN 'Footed - Primary Rounding Level' THEN
                                         'Primary'
                                     WHEN 'Footed - Secondary Rounding Level' THEN
                                         'Secondary'
                                 END
    --when set to raw (actually if not found in component value table) then pull from raw fundbalance table
    LEFT JOIN dbo.FundBalance fb
        ON fb.FK_AccountPeriod = bs.FK_AccountPeriod
           AND fb.FK_Fund = bs.FK_Fund
           AND fb.FK_BalanceType = bs.FK_BalanceType
           AND cv.PK_TrialBalanceItemComponentValue IS NULL
WHERE fd.ItemType = 'FundDataPoint';

CREATE CLUSTERED INDEX IX_PK_CalculationSheetItemDetail_PK_Class_PK_Currency
ON #FundBalanceDataPointTable (
                                  PK_CalculationSheetItemDetail,
                                  PK_Class,
                                  PK_Currency
                              )
WITH (FILLFACTOR = 100);



CREATE TABLE #DaysInPeriodTable
(
    PK_CalculationSheetItemDetail INT NOT NULL,
    PK_Class INT NOT NULL,
    PK_Currency INT NOT NULL,
    ValueFooted DECIMAL(28, 6) NOT NULL
);

INSERT #DaysInPeriodTable
(
    PK_CalculationSheetItemDetail,
    PK_Class,
    PK_Currency,
    ValueFooted
)
SELECT fd.PK_CalculationSheetItemDetail,
       ISNULL(fd.PK_Class, 0) AS PK_Class,
       ISNULL(fd.PK_Currency, 0) AS PK_Currency,
       ISNULL(
                 dbo.gf_GetNumberOfDays(
                                           @TrialBalanceDefinitionKey,
                                           bs.FK_Fund,
                                           bs.FK_AccountPeriod,
                                           fd.PK_Class,
                                           fd.DaysinPeriod
                                       ),
                 0
             ) AS ValueFooted
FROM #CalcSheetItemFormulaDetails fd
    LEFT JOIN dbo.GLBalanceSet bs
        ON bs.PK_GLBalanceSet = fd.FK_GLBalanceSet
WHERE fd.ItemType = 'DaysInPeriod';

CREATE CLUSTERED INDEX IX_PK_CalculationSheetItemDetail_PK_Class_PK_Currency
ON #DaysInPeriodTable (
                          PK_CalculationSheetItemDetail,
                          PK_Class,
                          PK_Currency
                      )
WITH (FILLFACTOR = 100);



CREATE TABLE #OtherCalcSheetItemTable
(
    PK_CalculationSheetItemDetail INT NOT NULL,
    PK_Class INT NOT NULL,
    PK_Currency INT NOT NULL,
    ValueFooted DECIMAL(28, 6) NOT NULL
);

INSERT #OtherCalcSheetItemTable
(
    PK_CalculationSheetItemDetail,
    PK_Class,
    PK_Currency,
    ValueFooted
)
SELECT fd.PK_CalculationSheetItemDetail,
       ISNULL(fd.PK_Class, 0) AS PK_Class,
       ISNULL(fd.PK_Currency, 0) AS PK_Currency,
       0 AS ValueFooted
FROM #CalcSheetItemFormulaDetails fd
WHERE fd.ItemType IN ( 'CalcSheetSectionItem', 'CalcSheetSectionTotal' )
      AND fd.AccountPeriodCycle = 'Current Account Period'
      AND fd.FK_GLBalanceSet = @BalanceSetKey
UNION ALL
-- Second set is for prior period calc sheet items - need to retrieve the previously calculated value
SELECT fd.PK_CalculationSheetItemDetail,
       ISNULL(fd.PK_Class, 0) AS PK_Class,
       ISNULL(fd.PK_Currency, 0) AS PK_Currency,
       ISNULL(csv.ValueFooted, 0) AS ValueFooted
FROM #CalcSheetItemFormulaDetails fd
    LEFT OUTER JOIN dbo.CalculationSheetItemColumn csic
        ON csic.PK_CalculationSheetItemColumn = fd.FK_CalculationSheetItemColumn_Other
    LEFT OUTER JOIN dbo.CalculationSheetItem csiOther
        ON csiOther.PK_CalculationSheetItem = csic.FK_CalculationSheetItem
    LEFT OUTER JOIN dbo.CalculationSheetItem csiOtherSection
        ON csiOtherSection.PK_CalculationSheetItem = csiOther.FK_CalculationSheetItem
    LEFT OUTER JOIN dbo.CalculationSheet csOther
        ON csOther.PK_CalculationSheet IN ( ISNULL(csiOther.FK_CalculationSheet, 0),
                                            ISNULL(csiOtherSection.FK_CalculationSheet, 0)
                                          )
    LEFT OUTER JOIN dbo.GLBalanceSet bs
        ON ISNULL(bs.PK_GLBalanceSet, 0) = ISNULL(fd.FK_GLBalanceSet, 0)
    LEFT JOIN dbo.Class c
        ON c.FK_Fund = bs.FK_Fund
           AND c.FK_BaseClass = fd.FK_BaseClass
    LEFT OUTER JOIN dbo.CalculationSheetValue csv
        ON csv.FK_GLBalanceSet = bs.PK_GLBalanceSet
           AND csv.FK_CalculationSheetItem = csic.FK_CalculationSheetItem
           AND csv.FK_CalculationSheetItemColumn = csic.PK_CalculationSheetItemColumn
           AND ISNULL(csv.FK_Class, 0) = ISNULL(c.PK_Class, 0)
           AND ISNULL(csv.FK_Currency, 0) = ISNULL(fd.PK_Currency, 0)
WHERE fd.ItemType IN ( 'CalcSheetSectionItem', 'CalcSheetSectionTotal' )
      AND
      (
          fd.AccountPeriodCycle <> 'Current Account Period'
          OR fd.FK_GLBalanceSet <> @BalanceSetKey
      );

CREATE CLUSTERED INDEX IX_PK_CalculationSheetItemDetail_PK_Class_PK_Currency
ON #OtherCalcSheetItemTable (
                                PK_CalculationSheetItemDetail,
                                PK_Class,
                                PK_Currency
                            );


CREATE TABLE #ConsolidatedResultTable
(
    PK_CalculationSheetItemDetail INT NOT NULL,
    PK_Class INT NOT NULL,
    PK_Currency INT NOT NULL,
    ValueRaw DECIMAL(28, 6),
    ValueRounded DECIMAL(28, 6),
    ValueFooted DECIMAL(28, 6),
    TrialBalanceLevel NVARCHAR(64)
);

IF @ConsolidatedWorkbook = 1
BEGIN

    --Take the summed values and join back into temp table to get the rest of the calc sheet item detail columns
    INSERT #ConsolidatedResultTable
    (
        PK_CalculationSheetItemDetail,
        PK_Class,
        PK_Currency,
        ValueRaw,
        ValueRounded,
        ValueFooted,
        TrialBalanceLevel
    )
    SELECT mfv.PK_CalculationSheetItemDetail,
           ISNULL(mfv.PK_Class, 0) AS PK_Class,
           ISNULL(mfv.PK_Currency, 0) AS PK_Currency,
           ISNULL(mfv.ValueRaw, 0) AS ValueRaw,
           ISNULL(fd2.ValueRounded, 0) AS ValueRounded,
           ISNULL(mfv.ValueFooted, 0) AS ValueFooted,
           ISNULL(mfv.TrialBalanceLevel, 0) AS TrialBalanceLevel
    FROM #CalcSheetItemFormulaDetails fd2
        JOIN
        (
            -----------------------------------------------------------
            --2 sets: parent fund and children funds
            -----------------------------------------------------------

            --Outer select is to facilitate the group by and sum of the two inner unions
            SELECT MultiFundValues.PK_CalculationSheetItemDetail,
                   MIN(MultiFundValues.PK_Class) AS PK_Class,
                   MultiFundValues.ClassName,
                   MultiFundValues.FK_BaseClass,
                   MIN(MultiFundValues.PK_Currency) AS PK_Currency,
                   MultiFundValues.CurrencyCode,
                   ISNULL(SUM(MultiFundValues.ValueRaw), 0) AS ValueRaw,
                   ISNULL(SUM(MultiFundValues.ValueFooted), 0) AS ValueFooted,
                   MultiFundValues.TrialBalanceLevel
            FROM
            (
                --CURRENT FUND UNION (parent fund) - Applies to Consolidation Source = "FundBalance" or "FundAndChildren" - just a copy of the standard single fund trial balance script
                SELECT fd.PK_CalculationSheetItemDetail,
                       CASE
                           WHEN ISNULL(tbi.[Level], '') <> 'Currency' THEN
                               fd.PK_Class
                       END AS PK_Class,
                       CASE
                           WHEN ISNULL(tbi.[Level], '') <> 'Currency' THEN
                               fd.FK_BaseClass
                       END AS FK_BaseClass,
                       CASE
                           WHEN ISNULL(tbi.[Level], '') <> 'Currency' THEN
                               fd.ClassName
                       END AS ClassName,
                       CASE
                           WHEN ISNULL(tbi.[Level], '') <> 'Class' THEN
                               fd.PK_Currency
                       END AS PK_Currency,
                       CASE
                           WHEN ISNULL(tbi.[Level], '') <> 'Class' THEN
                               fd.CurrencyCode
                       END AS CurrencyCode,
                       fd.FK_GLBalanceSet,
                       ISNULL(wtbv.ValueRaw, 0) AS ValueRaw,
                       ISNULL(   CASE fd.TrialBalanceValueType
                                     WHEN 'Raw Value' THEN
                                         wtbv.ValueRaw
                                     ELSE
                                         wtbv.ValueFooted
                                 END,
                                 0
                             ) AS ValueFooted,
                       ISNULL(tbi.[Level], '') AS TrialBalanceLevel
                FROM #CalcSheetItemFormulaDetails fd
                    LEFT JOIN dbo.TrialBalanceItem tbi
                        ON tbi.PK_TrialBalanceItem = fd.FK_TrialBalanceItem
                    LEFT JOIN dbo.WorkingTrialBalanceValue wtbv
                        ON wtbv.FK_GLBalanceSet = fd.FK_GLBalanceSet
                           AND ISNULL(wtbv.FK_TrialBalanceSection, 0) = ISNULL(fd.FK_TrialBalanceSection, 0)
                           AND ISNULL(wtbv.FK_TrialBalanceItem, 0) = ISNULL(fd.FK_TrialBalanceItem, 0)
                           AND
                           (
                               ISNULL(wtbv.FK_Currency, 0) = ISNULL(fd.PK_Currency, 0)
                               OR
                               (
                                   tbi.[Level] = 'Class'
                                   AND wtbv.FK_Currency IS NULL
                               )
                           )
                           AND
                           (
                               ISNULL(wtbv.FK_Class, 0) = ISNULL(fd.PK_Class, 0)
                               OR
                               (
                                   tbi.[Level] = 'Currency'
                                   AND wtbv.FK_Class IS NULL
                               )
                           )
                           AND wtbv.RoundingType = CASE fd.TrialBalanceValueType
                                                       WHEN 'Footed - Secondary Rounding Level' THEN
                                                           'Secondary'
                                                       ELSE
                                                           'Primary'
                                                   END
                WHERE fd.ItemType IN ( 'SubSectionTotal', 'Item', 'SectionTotal', 'SubSectionItem' )
                      AND fd.ConsolidationSource IN ( 'FundBalance', 'FundAndChildren' )

                --CHILDREN FUNDS UNION - Applies to Consolidation Source = "Children" or "FundAndChildren"
                UNION
                SELECT fd.PK_CalculationSheetItemDetail,
                       fd.PK_Class AS PK_Class,
                       fd.FK_BaseClass AS FK_BaseClass,
                       fd.ClassName AS ClassName,
                       fd.PK_Currency AS PK_Currency,
                       fd.CurrencyCode AS CurrencyCode,
                       bs.PK_GLBalanceSet,
                       ISNULL(wtbv.ValueRaw, 0) * cFunds.Percentage_Child * cFunds.Rate AS ValueRaw,
                       ISNULL(   CASE fd.TrialBalanceValueType
                                     WHEN 'Raw Value' THEN
                                         wtbv.ValueRaw
                                     ELSE
                                         wtbv.ValueFooted
                                 END,
                                 0.00
                             ) * cFunds.Percentage_Child * cFunds.Rate AS ValueFooted,
                       ISNULL(tbi.[Level], '') AS TrialBalanceLevel
                FROM #CalcSheetItemFormulaDetails fd
                    CROSS JOIN #ChildFunds cFunds
                    LEFT JOIN dbo.Class c
                        ON c.FK_Fund = cFunds.ChildFundKey
                           AND c.FK_BaseClass = fd.FK_BaseClass
                           AND c.ClassName = fd.ClassName
                    LEFT JOIN dbo.GLBalanceSet bs
                        ON bs.FK_Fund = cFunds.ChildFundKey
                           AND bs.FK_AccountPeriod = fd.FK_AccountPeriod
                           AND bs.FK_BalanceType = @BalanceTypeKey
                    LEFT JOIN dbo.TrialBalanceItem tbi
                        ON tbi.PK_TrialBalanceItem = fd.FK_TrialBalanceItem
                    LEFT JOIN dbo.WorkingTrialBalanceValue wtbv
                        ON wtbv.FK_GLBalanceSet = bs.PK_GLBalanceSet
                           AND
                           (
                               fd.FK_TrialBalanceSection = wtbv.FK_TrialBalanceSection
                               OR fd.FK_TrialBalanceItem = wtbv.FK_TrialBalanceItem
                           )
                           AND
                           (
                               ISNULL(wtbv.FK_Currency, 0) = ISNULL(fd.PK_Currency, 0)
                               OR
                               (
                                   tbi.[Level] = 'Class'
                                   AND wtbv.FK_Currency IS NULL
                               )
                           )
                           AND
                           (
                               (
                                   wtbv.FK_Class = c.PK_Class
                                   OR
                                   (
                                       fd.PK_Class IS NULL
                                       AND wtbv.FK_Class IS NULL
                                   )
                               )
                               OR
                               (
                                   tbi.[Level] = 'Currency'
                                   AND wtbv.FK_Class IS NULL
                               )
                           )
                           AND wtbv.RoundingType = CASE fd.TrialBalanceValueType
                                                       WHEN 'Footed - Secondary Rounding Level' THEN
                                                           'Secondary'
                                                       ELSE
                                                           'Primary'
                                                   END
                WHERE fd.ItemType IN ( 'SubSectionTotal', 'Item', 'SectionTotal', 'SubSectionItem' )
                      AND fd.ConsolidationSource IN ( 'Children', 'FundAndChildren' )
            ) AS MultiFundValues
            GROUP BY MultiFundValues.PK_CalculationSheetItemDetail,
                     MultiFundValues.FK_BaseClass,
                     MultiFundValues.ClassName,
                     MultiFundValues.PK_Currency,
                     MultiFundValues.CurrencyCode,
                     MultiFundValues.TrialBalanceLevel --per requirements, match on the same base class and class name
        ) mfv
            ON mfv.PK_CalculationSheetItemDetail = fd2.PK_CalculationSheetItemDetail
               AND ISNULL(mfv.PK_Class, 0) = ISNULL(fd2.PK_Class, 0)
               AND ISNULL(mfv.PK_Currency, 0) = ISNULL(fd2.PK_Currency, 0);

END;

CREATE CLUSTERED INDEX IX_PK_CalculationSheetItemDetail_PK_Class_PK_Currency
ON #ConsolidatedResultTable (
                                PK_CalculationSheetItemDetail,
                                PK_Class,
                                PK_Currency
                            );


DECLARE @BaseCurrencyKey INT;
SELECT @BaseCurrencyKey = FK_Currency
FROM dbo.Fund
WHERE PK_Fund = @FundKey;

SELECT fd.PK_CalculationSheet,
       fd.CalculationSheetName,
       fd.ClassDisplay,
       fd.PK_CalculationSheetItem,
       fd.FK_CalculationSheetItem,
       fd.ClassMode,
       fd.FK_BaseClass,
       fd.ItemSortOrder,
       ISNULL(fd.RoundingLevel, 6) AS RoundingLevel,
       ISNULL(fd.RoundToThousandsDecimalPlaces, 0) AS RoundToThousandsDecimalPlaces,
       fd.SectionRoundingLevel,
       fd.CalculateTotal,
       fd.ClassOrFundLevel,
       fd.PK_CalculationSheetItemDetail,
       fd.ItemType,
       fd.FK_TrialBalanceSection,
       fd.FK_TrialBalanceItem,
       fd.FK_SupplementalDataItem,
       fd.Operator,
       fd.ParenthesisLeft,
       fd.ParenthesisRight,
       fd.AccountPeriodCycle,
       fd.DetailsSortOrder,
       fd.FundDataPoint,
       fd.ClassDataPoint,
       fd.PK_Class,
       fd.ClassName,
       fd.PK_Currency,
       fd.CurrencyCode,
       ISNULL(   CASE @ConsolidatedWorkbook
                     WHEN 0 THEN
                         wtbv.ValueRaw
                     ELSE
                         crt.ValueRaw
                 END,
                 0.00
             ) AS ValueRaw,
       ISNULL(fd.ValueRounded, 0.00) AS ValueRounded,
       ISNULL(
                 CASE
                     --WHEN fd.SuppressBaseCurrency = 1 AND fd.PK_Currency = @BaseCurrencyKey THEN 0 --Suppress base currency from repeat and total if it is checked
                     WHEN fd.ItemType = 'ConstantValue' THEN
                         fd.ConstantValue
                     WHEN fd.ItemType = 'DaysinPeriod' THEN
                         dt.ValueFooted
                     WHEN fd.ItemType = 'SupplementalDataItem' THEN
                         sdit.ValueFooted
                     WHEN fd.ItemType IN ( 'ClassDataPoint', 'ClassBalanceDataPoint' ) THEN
                         cdpt.ValueFooted -- Loc Le refator balanceSetMissing FundKey
                     WHEN fd.ItemType = 'FundDataPoint' THEN
                         fdpt.ValueFooted

                                          --Total calcSheet Section value for Prior Period/ Fund Selection Behavior = Specify Fund
                     WHEN fd.ItemType IN ( 'CalcSheetSectionTotal', 'CalcSheetSectionItem' )
                          AND
                          (
                              fd.AccountPeriodCycle <> 'Current Account Period'
                              OR fd.FK_GLBalanceSet <> @BalanceSetKey
                          )
                          AND fd.FK_CalculationSheetItemColumn_Other IS NOT NULL THEN
                         ocst.ValueFooted

                                          --Trial balance values
                     WHEN @ConsolidatedWorkbook IN ( 0, 1 )
                          AND fd.ItemType IN ( 'SubSectionTotal', 'Item', 'SectionTotal', 'SubSectionItem' ) THEN
                         CASE
                             WHEN fd.FK_BaseClass IS NOT NULL
                                  AND fd.PK_Class IS NULL THEN
                                 0 -- no class for the fund -- RMA 2013.04.08 TFS#: 8369
                             ELSE
                                 CASE @ConsolidatedWorkbook
                                     WHEN 0 THEN
                                         CASE fd.TrialBalanceValueType
                                             WHEN 'Raw Value' THEN
                                                 wtbv.ValueRaw
                                             ELSE
                                                 wtbv.ValueFooted
                                         END
                                     ELSE
                                         CASE fd.TrialBalanceValueType
                                             WHEN 'Raw Value' THEN
                                                 crt.ValueRaw
                                             ELSE
                                                 crt.ValueFooted
                                         END
                                 END
                         END
                     WHEN fd.ItemType IN ( 'HoldingsCategory', 'HoldingsCategoryMaturityRange',
                                           'HoldingsCategorySubtotal', 'HoldingsDetail', 'PortfolioStatementDefinition'
                                         ) THEN
                         prt.ValueFooted
                     ELSE
                         0
                 END,
                 0
             ) AS ValueFooted,
       @BalanceSetKey AS FK_GLBalanceSet,
       fd.IsCircularReferenceCheck,
       fd.UseAbsoluteValue,
       fd.TrialBalanceValueType,
       fd.DaysinPeriod,
       fd.ConsolidationSource,
       CASE @ConsolidatedWorkbook
           WHEN 0 THEN
               ISNULL(tbi.[Level], '')
           ELSE
               crt.TrialBalanceLevel
       END AS TrialBalanceLevel,
       CASE sdit.SupplementalDataItemLevelClass
           WHEN 1 THEN
               N'Class'
           WHEN 0 THEN
               N'Fund'
           ELSE
               N''
       END AS SupplementalDataItemLevel,
       fd.FK_ConditionalFormula,
       fd.ConditionalValueReturned,
       fd.ConditionalValueReturnSourceSubType,
       CAST(fd.ConditionalValueReturnSourceKey AS INT) AS ConditionalValueReturnSourceKey, -- CAST AS INT to conform to old #temp table
       fd.PK_CalculationSheetColumn AS FK_CalculationSheetColumn,
       fd.FK_CalculationSheetItemColumn,
       fd.FK_CalculationSheetItemColumn_Section,
       fd.FK_CalculationsheetItem_Other,
       CASE
           WHEN fd.FK_CalculationSheetItemColumn_Other IS NOT NULL
                AND
                (
                    fd.AccountPeriodCycle <> 'Current Account Period'
                    OR fd.FK_GLBalanceSet <> @BalanceSetKey
                ) --Pull previous Calculated values when FundSelection Behavior is Specify Fund
       THEN
               NULL --Prevent CalSheet engine to call other to get value, use this value already determined by the procedure for the prior period
           ELSE
               fd.FK_CalculationSheetItemColumn_Other
       END AS FK_CalculationSheetItemColumn_Other,
       fd.FK_CalculationSheetValue_Other,
       CAST(0 AS BIT) AS SuppressBaseCurrency
FROM #CalcSheetItemFormulaDetails fd
    LEFT JOIN dbo.TrialBalanceItem tbi
        ON tbi.PK_TrialBalanceItem = fd.FK_TrialBalanceItem
    LEFT JOIN dbo.WorkingTrialBalanceValue wtbv
        ON wtbv.FK_GLBalanceSet = fd.FK_GLBalanceSet
           AND ISNULL(fd.FK_TrialBalanceSection, 0) = ISNULL(wtbv.FK_TrialBalanceSection, 0)
           AND ISNULL(fd.FK_TrialBalanceItem, 0) = ISNULL(wtbv.FK_TrialBalanceItem, 0)
           AND
           (
               ISNULL(fd.PK_Class, 0) = ISNULL(wtbv.FK_Class, 0)
               OR
               (
                   tbi.[Level] = 'Currency'
                   AND wtbv.FK_Class IS NULL
               )
           )
           AND 0 = ISNULL(wtbv.FK_Currency, 0)
           AND wtbv.RoundingType = CASE fd.TrialBalanceValueType
                                       WHEN 'Footed - Secondary Rounding Level' THEN
                                           'Secondary'
                                       ELSE
                                           'Primary'
                                   END
    LEFT JOIN #PortfolioResultTable prt
        ON prt.FK_CalculationSheetItemDetail = fd.PK_CalculationSheetItemDetail
           AND ISNULL(prt.FK_Currency, 0) = 0
    LEFT JOIN #ClassBalanceDataPointTable cdpt
        ON cdpt.PK_CalculationSheetItemDetail = fd.PK_CalculationSheetItemDetail
           AND cdpt.PK_Class = ISNULL(fd.PK_Class, 0)
           AND cdpt.PK_Currency = 0
    LEFT JOIN #SupplementalDataItemTable sdit
        ON sdit.PK_CalculationSheetItemDetail = fd.PK_CalculationSheetItemDetail
           AND sdit.PK_Class = ISNULL(fd.PK_Class, 0)
           AND sdit.PK_Currency = 0
    LEFT JOIN #FundBalanceDataPointTable fdpt
        ON fdpt.PK_CalculationSheetItemDetail = fd.PK_CalculationSheetItemDetail
           AND fdpt.PK_Class = ISNULL(fd.PK_Class, 0)
           AND fdpt.PK_Currency = 0
    LEFT JOIN #DaysInPeriodTable dt
        ON dt.PK_CalculationSheetItemDetail = fd.PK_CalculationSheetItemDetail
           AND dt.PK_Class = ISNULL(fd.PK_Class, 0)
           AND dt.PK_Currency = 0
    LEFT JOIN #OtherCalcSheetItemTable ocst
        ON ocst.PK_CalculationSheetItemDetail = fd.PK_CalculationSheetItemDetail
           AND ocst.PK_Class = ISNULL(fd.PK_Class, 0)
           AND ocst.PK_Currency = 0
    LEFT JOIN #ConsolidatedResultTable crt
        ON crt.PK_CalculationSheetItemDetail = fd.PK_CalculationSheetItemDetail
           AND crt.PK_Class = ISNULL(fd.PK_Class, 0)
           AND crt.PK_Currency = 0
WHERE fd.PK_Currency IS NULL
UNION ALL
SELECT fd.PK_CalculationSheet,
       fd.CalculationSheetName,
       fd.ClassDisplay,
       fd.PK_CalculationSheetItem,
       fd.FK_CalculationSheetItem,
       fd.ClassMode,
       fd.FK_BaseClass,
       fd.ItemSortOrder,
       ISNULL(fd.RoundingLevel, 6) AS RoundingLevel,
       ISNULL(fd.RoundToThousandsDecimalPlaces, 0) AS RoundToThousandsDecimalPlaces,
       fd.SectionRoundingLevel,
       fd.CalculateTotal,
       fd.ClassOrFundLevel,
       fd.PK_CalculationSheetItemDetail,
       fd.ItemType,
       fd.FK_TrialBalanceSection,
       fd.FK_TrialBalanceItem,
       fd.FK_SupplementalDataItem,
       fd.Operator,
       fd.ParenthesisLeft,
       fd.ParenthesisRight,
       fd.AccountPeriodCycle,
       fd.DetailsSortOrder,
       fd.FundDataPoint,
       fd.ClassDataPoint,
       fd.PK_Class,
       fd.ClassName,
       fd.PK_Currency,
       fd.CurrencyCode,
       CASE
           WHEN fd.SuppressBaseCurrency = 1
                AND fd.PK_Currency = @BaseCurrencyKey THEN
               0 -- Suppress base currency from repeat and total if it is checked
           ELSE
               ISNULL(   CASE @ConsolidatedWorkbook
                             WHEN 0 THEN
                                 wtbv.ValueRaw
                             ELSE
                                 crt.ValueRaw
                         END,
                         0.00
                     )
       END AS ValueRaw,
       ISNULL(fd.ValueRounded, 0.00) AS ValueRounded,
       ISNULL(
                 CASE
                     WHEN fd.SuppressBaseCurrency = 1
                          AND fd.PK_Currency = @BaseCurrencyKey THEN
                         0                --Suppress base currency from repeat and total if it is checked
                     WHEN fd.ItemType = 'ConstantValue' THEN
                         fd.ConstantValue
                     WHEN fd.ItemType = 'DaysinPeriod' THEN
                         dt.ValueFooted
                     WHEN fd.ItemType = 'SupplementalDataItem' THEN
                         sdit.ValueFooted
                     WHEN fd.ItemType IN ( 'ClassDataPoint', 'ClassBalanceDataPoint' ) THEN
                         cdpt.ValueFooted -- Loc Le refator balanceSetMissing FundKey
                     WHEN fd.ItemType = 'FundDataPoint' THEN
                         fdpt.ValueFooted

                                          --Total calcSheet Section value for Prior Period/ Fund Selection Behavior = Specify Fund
                     WHEN fd.ItemType IN ( 'CalcSheetSectionTotal', 'CalcSheetSectionItem' )
                          AND
                          (
                              fd.AccountPeriodCycle <> 'Current Account Period'
                              OR fd.FK_GLBalanceSet <> @BalanceSetKey
                          )
                          AND fd.FK_CalculationSheetItemColumn_Other IS NOT NULL THEN
                         ocst.ValueFooted

                                          --Trial balance values
                     WHEN @ConsolidatedWorkbook IN ( 0, 1 )
                          AND fd.ItemType IN ( 'SubSectionTotal', 'Item', 'SectionTotal', 'SubSectionItem' ) THEN
                         CASE
                             WHEN fd.FK_BaseClass IS NOT NULL
                                  AND fd.PK_Class IS NULL THEN
                                 0 -- no class for the fund -- RMA 2013.04.08 TFS#: 8369
                             ELSE
                                 CASE @ConsolidatedWorkbook
                                     WHEN 0 THEN
                                         CASE fd.TrialBalanceValueType
                                             WHEN 'Raw Value' THEN
                                                 wtbv.ValueRaw
                                             ELSE
                                                 wtbv.ValueFooted
                                         END
                                     ELSE
                                         CASE fd.TrialBalanceValueType
                                             WHEN 'Raw Value' THEN
                                                 crt.ValueRaw
                                             ELSE
                                                 crt.ValueFooted
                                         END
                                 END
                         END
                     WHEN fd.ItemType IN ( 'HoldingsCategory', 'HoldingsCategoryMaturityRange',
                                           'HoldingsCategorySubtotal', 'HoldingsDetail', 'PortfolioStatementDefinition'
                                         ) THEN
                         prt.ValueFooted
                     ELSE
                         0
                 END,
                 0
             ) AS ValueFooted,
       @BalanceSetKey AS FK_GLBalanceSet,
       fd.IsCircularReferenceCheck,
       fd.UseAbsoluteValue,
       fd.TrialBalanceValueType,
       fd.DaysinPeriod,
       fd.ConsolidationSource,
       CASE @ConsolidatedWorkbook
           WHEN 0 THEN
               ISNULL(tbi.[Level], '')
           ELSE
               crt.TrialBalanceLevel
       END AS TrialBalanceLevel,
       CASE sdit.SupplementalDataItemLevelClass
           WHEN 1 THEN
               N'Class'
           WHEN 0 THEN
               N'Fund'
           ELSE
               N''
       END AS SupplementalDataItemLevel,
       fd.FK_ConditionalFormula,
       fd.ConditionalValueReturned,
       fd.ConditionalValueReturnSourceSubType,
       CAST(fd.ConditionalValueReturnSourceKey AS INT) AS ConditionalValueReturnSourceKey, -- CAST AS INT to conform to old #temp table
       fd.PK_CalculationSheetColumn AS FK_CalculationSheetColumn,
       fd.FK_CalculationSheetItemColumn,
       fd.FK_CalculationSheetItemColumn_Section,
       fd.FK_CalculationsheetItem_Other,
       CASE
           WHEN fd.FK_CalculationSheetItemColumn_Other IS NOT NULL
                AND
                (
                    fd.AccountPeriodCycle <> 'Current Account Period'
                    OR fd.FK_GLBalanceSet <> @BalanceSetKey
                ) --Pull previous Calculated values when FundSelection Behavior is Specify Fund
       THEN
               NULL --Prevent CalSheet engine to call other to get value, use this value already determined by the procedure for the prior period
           ELSE
               fd.FK_CalculationSheetItemColumn_Other
       END AS FK_CalculationSheetItemColumn_Other,
       fd.FK_CalculationSheetValue_Other,
       CAST(CASE
                WHEN fd.SuppressBaseCurrency = 1
                     AND fd.PK_Currency = @BaseCurrencyKey THEN
                    1
                ELSE
                    0
            END AS BIT) AS SuppressBaseCurrency
FROM #CalcSheetItemFormulaDetails fd
    LEFT JOIN dbo.TrialBalanceItem tbi
        ON tbi.PK_TrialBalanceItem = fd.FK_TrialBalanceItem
    LEFT JOIN dbo.WorkingTrialBalanceValue wtbv
        ON wtbv.FK_GLBalanceSet = fd.FK_GLBalanceSet
           AND ISNULL(fd.FK_TrialBalanceSection, 0) = ISNULL(wtbv.FK_TrialBalanceSection, 0)
           AND ISNULL(fd.FK_TrialBalanceItem, 0) = ISNULL(wtbv.FK_TrialBalanceItem, 0)
           AND
           (
               ISNULL(fd.PK_Class, 0) = ISNULL(wtbv.FK_Class, 0)
               OR
               (
                   tbi.[Level] = 'Currency'
                   AND wtbv.FK_Class IS NULL
               )
           )
           AND fd.PK_Currency = ISNULL(wtbv.FK_Currency, 0)
           AND wtbv.RoundingType = CASE fd.TrialBalanceValueType
                                       WHEN 'Footed - Secondary Rounding Level' THEN
                                           'Secondary'
                                       ELSE
                                           'Primary'
                                   END
    LEFT JOIN #PortfolioResultTable prt
        ON prt.FK_CalculationSheetItemDetail = fd.PK_CalculationSheetItemDetail
           AND prt.FK_Currency = fd.PK_Currency
    LEFT JOIN #ClassBalanceDataPointTable cdpt
        ON cdpt.PK_CalculationSheetItemDetail = fd.PK_CalculationSheetItemDetail
           AND cdpt.PK_Class = ISNULL(fd.PK_Class, 0)
           AND cdpt.PK_Currency = fd.PK_Currency
    LEFT JOIN #SupplementalDataItemTable sdit
        ON sdit.PK_CalculationSheetItemDetail = fd.PK_CalculationSheetItemDetail
           AND sdit.PK_Class = ISNULL(fd.PK_Class, 0)
           AND sdit.PK_Currency = fd.PK_Currency
    LEFT JOIN #FundBalanceDataPointTable fdpt
        ON fdpt.PK_CalculationSheetItemDetail = fd.PK_CalculationSheetItemDetail
           AND fdpt.PK_Class = ISNULL(fd.PK_Class, 0)
           AND fdpt.PK_Currency = fd.PK_Currency
    LEFT JOIN #DaysInPeriodTable dt
        ON dt.PK_CalculationSheetItemDetail = fd.PK_CalculationSheetItemDetail
           AND dt.PK_Class = ISNULL(fd.PK_Class, 0)
           AND dt.PK_Currency = fd.PK_Currency
    LEFT JOIN #OtherCalcSheetItemTable ocst
        ON ocst.PK_CalculationSheetItemDetail = fd.PK_CalculationSheetItemDetail
           AND ocst.PK_Class = ISNULL(fd.PK_Class, 0)
           AND ocst.PK_Currency = fd.PK_Currency
    LEFT JOIN #ConsolidatedResultTable crt
        ON crt.PK_CalculationSheetItemDetail = fd.PK_CalculationSheetItemDetail
           AND crt.PK_Class = ISNULL(fd.PK_Class, 0)
           AND crt.PK_Currency = fd.PK_Currency
WHERE fd.PK_Currency IS NOT NULL
OPTION (RECOMPILE);

DROP TABLE #PortfolioResultTable;
DROP TABLE #ClassBalanceDataPointTable;
DROP TABLE #SupplementalDataItemTable;
DROP TABLE #FundBalanceDataPointTable;
DROP TABLE #DaysInPeriodTable;
DROP TABLE #OtherCalcSheetItemTable;
DROP TABLE #ConsolidatedResultTable;
DROP TABLE #Class;
DROP TABLE #Currency;
DROP TABLE #SecurityCategorizationTable;
DROP TABLE #CalcSheetItemFormulaDetails;
DROP TABLE #AccountPeriodCycle;
DROP TABLE #APCForCurrency;
DROP TABLE #ChildFunds;
DROP TABLE #AccountPeriodsForHoldingsDetail;

EXEC dbo.gp_WriteToCalculationLog 'Financial',
                                  @FundKey,
                                  @AccountPeriodKey,
                                  @BalanceTypeKey,
                                  NULL,
                                  'Financial data retrieval complete for calc sheet calculation engine.',
                                  'GetInputValuesForCalculationEngine',
                                  NULL,
                                  NULL,
                                  @CalculationBatchKey;

GO