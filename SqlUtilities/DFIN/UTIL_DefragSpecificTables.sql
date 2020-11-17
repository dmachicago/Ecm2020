-- W. Dale Miller
-- wdalemiller@gmail.com

declare @MaxPct decimal (6,2) = 25;
declare @PreviewOnly as int = 0 ;
declare @ReorgIndexes as int = 0 ;
DECLARE @RunID BIGINT;
exec @RunID = sp_UTIL_GetSeq ;
print @RunID;
exec DFINAnalytics.dbo.UTIL_DefragAllIndexes NULL, NULL, @MaxPct,@PreviewOnly, @ReorgIndexes , @RunID ;


exec DFINAnalytics.dbo.UTIL_DefragAllIndexes 'AP_ProductionAF_Data', 'BIM_Production_Port', @MaxPct,@PreviewOnly, @ReorgIndexes , @RunID ;
exec DFINAnalytics.dbo.UTIL_DefragAllIndexes 'BNY_Production_NMFP_Data', 'BNYUK_ProductionAR_Port', @MaxPct,@PreviewOnly, @ReorgIndexes , @RunID ;
exec DFINAnalytics.dbo.UTIL_DefragAllIndexes 'Bowne_Product_Data', 'CG_ProductionAR_Port', @MaxPct,@PreviewOnly, @ReorgIndexes , @RunID ;
exec DFINAnalytics.dbo.UTIL_DefragAllIndexes 'DataIngestion', 'Davis_ProductionAF_Port', @MaxPct,@PreviewOnly, @ReorgIndexes , @RunID ;
exec DFINAnalytics.dbo.UTIL_DefragAllIndexes 'DC_ProductionAR_Data', 'DITool_Production3_Port', @MaxPct,@PreviewOnly, @ReorgIndexes , @RunID ;
exec DFINAnalytics.dbo.UTIL_DefragAllIndexes 'DoranMinehane_ProductionAR_Data', 'DoranMinehane_ProductionAR_Port', @MaxPct,@PreviewOnly, @ReorgIndexes , @RunID ;
exec DFINAnalytics.dbo.UTIL_DefragAllIndexes 'Federated_ProductionAR_Data', 'Federated_ProductionAR_Port', @MaxPct,@PreviewOnly, @ReorgIndexes , @RunID ;
exec DFINAnalytics.dbo.UTIL_DefragAllIndexes 'FMR_ProductionAR_Data', 'FMR_ProductionAR_Port', @MaxPct,@PreviewOnly, @ReorgIndexes , @RunID ;
exec DFINAnalytics.dbo.UTIL_DefragAllIndexes 'FT_ProductionAF_Data', 'GW_ProductionAR_Port', @MaxPct,@PreviewOnly, @ReorgIndexes , @RunID ;
exec DFINAnalytics.dbo.UTIL_DefragAllIndexes 'Homestead_ProductionAR_Data', 'Homestead_ProductionAR_Port', @MaxPct,@PreviewOnly, @ReorgIndexes , @RunID ;
exec DFINAnalytics.dbo.UTIL_DefragAllIndexes 'HSIRE_ProductionAR_Data', 'Invesco_ProductionAF_Port', @MaxPct,@PreviewOnly, @ReorgIndexes , @RunID ;
exec DFINAnalytics.dbo.UTIL_DefragAllIndexes 'JH_Prod_Data', 'MA_ProductionAF_Port', @MaxPct,@PreviewOnly, @ReorgIndexes , @RunID ;
exec DFINAnalytics.dbo.UTIL_DefragAllIndexes 'MS_ProductionAR_Data', 'OT_Production_Port', @MaxPct,@PreviewOnly, @ReorgIndexes , @RunID ;
exec DFINAnalytics.dbo.UTIL_DefragAllIndexes 'RBC_Production_Data', 'RRD_Development_Port', @MaxPct,@PreviewOnly, @ReorgIndexes , @RunID ;
exec DFINAnalytics.dbo.UTIL_DefragAllIndexes 'SEI_ProductionAF_Data', 'SSC_UBS_AF_Port', @MaxPct,@PreviewOnly, @ReorgIndexes , @RunID ;
exec DFINAnalytics.dbo.UTIL_DefragAllIndexes 'SSCAI_ProductionAR_Data', 'SSC_Production3_Data', @MaxPct,@PreviewOnly, @ReorgIndexes , @RunID ;
exec DFINAnalytics.dbo.UTIL_DefragAllIndexes 'SSC_Production3_Port', 'SSCZurich_Production_Port', @MaxPct,@PreviewOnly, @ReorgIndexes , @RunID ;
exec DFINAnalytics.dbo.UTIL_DefragAllIndexes 'Sun_ProductionAF_Data', 'TS_PSCAR_Port', @MaxPct,@PreviewOnly, @ReorgIndexes , @RunID ;
exec DFINAnalytics.dbo.UTIL_DefragAllIndexes 'UMB_ProductionAF_Data', 'USB_ProductionAR_Port', @MaxPct,@PreviewOnly, @ReorgIndexes , @RunID ;
exec DFINAnalytics.dbo.UTIL_DefragAllIndexes 'Vanguard_ProductionAF_Data', 'WF_ProductionAR_Port', @MaxPct,@PreviewOnly, @ReorgIndexes , @RunID ;

