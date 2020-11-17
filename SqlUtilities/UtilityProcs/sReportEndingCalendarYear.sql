USE [SMART]
GO

/****** Object:  UserDefinedFunction [dbo].[sReportEndingCalendarYear]    Script Date: 09/23/2010 16:34:41 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

--CASE WHEN (P.SRC_SYS_ID_POS = 'AXT_V2') THEN TRD1.Year ELSE TRD.Year END REPORT_ENDING_CALENDAR_Year,
create Function [dbo].[sReportEndingCalendarYear](@SRC_SYS_ID_POS as varchar(6), @Trd1Year1 as varchar(2),  @TrdYear1 as varchar(2))
RETURNS varchar(2)
as 
begin
	return (select CASE WHEN (@SRC_SYS_ID_POS = 'AXT_V2') THEN @Trd1Year1 ELSE @TrdYear1 END REPORT_ENDING_CALENDAR_Year)
end


GO


