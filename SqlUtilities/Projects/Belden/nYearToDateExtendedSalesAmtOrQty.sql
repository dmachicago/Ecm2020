USE [SMART]
GO
/****** Object:  UserDefinedFunction [dbo].[nYearToDateExtendedSalesAmtOrQty]    Script Date: 09/23/2010 14:05:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--drop Function nCurrentMoSalesAmt
--go
ALTER Function [dbo].[nYearToDateExtendedSalesAmtOrQty](@FISCAL_YEAR as varchar(4), @SalesAmtOrQty as numeric (38,6))
RETURNS numeric
as 
begin
	Declare @rtnAmt as numeric (38,6)
	set @rtnAmt = 0 
	declare @FISCAL_PERIOD  as varchar(2)
	declare @MAX_MONTH  as varchar(2)
	declare @MIN_MONTH  as varchar(2)
	declare @TARGET_YEAR as varchar(4)
    set @TARGET_YEAR = cast (year(getdate()) as varchar(4))
	set @MIN_MONTH = '01'
	set @MAX_MONTH = dbo.sCurrentPeriod()
	set @rtnAmt = 0 
	SET @rtnAmt = dbo.nSpecificYearToDateSalesAmtOrQty (
					@FISCAL_YEAR, 
					@FISCAL_PERIOD, 
					@SalesAmtOrQty,
					@MIN_MONTH, 
					@MAX_MONTH, 
					@TARGET_YEAR)
	return @rtnAmt
end