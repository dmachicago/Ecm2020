USE [SMART]
GO
/****** Object:  UserDefinedFunction [dbo].[nCurrentMoSalesAmtOrQty]    Script Date: 09/23/2010 14:01:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--drop Function nCurrentMoSalesAmt
--go
ALTER Function [dbo].[nCurrentMoSalesAmtOrQty](@FISCAL_YEAR as varchar(4) , @FISCAL_PERIOD as varchar (2), @SalesAmtOrQty as numeric (38,6))
RETURNS numeric
as 
begin
	declare @MAX_MONTH  as varchar(2)
	declare @MIN_MONTH  as varchar(2)
	declare @TARGET_YEAR as varchar(4)
    set @TARGET_YEAR = cast (year(getdate()) as varchar(4))
	Declare @rtnAmt as numeric (38,6)
	set @MIN_MONTH = dbo.sCurrentPeriod()
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

