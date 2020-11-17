USE [SMART]
GO
/****** Object:  UserDefinedFunction [dbo].[sReportEndingCalendarYear]    Script Date: 10/04/2010 14:33:25 ******/
/* Modified the date to return as VARCHAR(4) 10/4/2010 SDM*/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--CASE WHEN (P.SRC_SYS_ID_POS = 'AXT_V2') THEN TRD1.Year ELSE TRD.Year END REPORT_ENDING_CALENDAR_Year,
ALTER Function [dbo].[sReportEndingCalendarYear](@SRC_SYS_ID_POS as varchar(6), @Trd1Year1 as varchar(4),  @TrdYear1 as varchar(4))
RETURNS varchar(4)
as 
begin
	return (
	select CASE WHEN (@SRC_SYS_ID_POS = 'AXT_V2') 
		THEN 
			@Trd1Year1 
		ELSE 
			@TrdYear1 
		END REPORT_ENDING_CALENDAR_Year
	)
end


--select dbo.sReportEndingCalendarYear ('AXT_V3', '2009', '2010')