--CASE WHEN (P.SRC_SYS_ID_POS = 'AXT_V2') THEN TRD1.MONTH ELSE TRD.MONTH END REPORT_ENDING_CALENDAR_MONTH,
create Function sReportEndingcalendarMonth(@SRC_SYS_ID_POS as varchar(6), @Trd1Month1 as varchar(2),  @TrdMonth1 as varchar(2))
RETURNS varchar(2)
as 
begin
	return (select CASE WHEN (@SRC_SYS_ID_POS = 'AXT_V2') THEN @Trd1Month1 ELSE @TrdMonth1 END REPORT_ENDING_CALENDAR_MONTH)
end

GO


