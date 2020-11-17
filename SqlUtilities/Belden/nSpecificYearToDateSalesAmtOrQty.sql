USE [SMART]
GO
/****** Object:  UserDefinedFunction [dbo].[nSpecificYearToDateSalesAmtOrQty]    Script Date: 09/23/2010 14:04:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER Function [dbo].[nSpecificYearToDateSalesAmtOrQty] (
					@FISCAL_YEAR as varchar(4) , 
					@FISCAL_PERIOD as varchar (2), 
					@SalesAmtOrQty as numeric (38,6),
					@MIN_MONTH as varchar (2), 
					@MAX_MONTH as varchar (2), 
					@TARGET_YEAR as varchar(4))
RETURNS numeric
as 
begin
	Declare @rtnAmt as numeric (38,6)
	set @rtnAmt = 0 
	SET @rtnAmt = (case WHEN @FISCAL_YEAR = @TARGET_YEAR
							and @FISCAL_PERIOD >= @MIN_MONTH 
							and @FISCAL_PERIOD <= @MAX_MONTH
					THEN
						@SalesAmtOrQty
					ELSE 
						0
					END )
	return @rtnAmt
end