USE [SMART]
GO
/****** Object:  UserDefinedFunction [dbo].[nSpecificYearToDateSalesAmtOrQty]    Script Date: 10/18/2010 12:58:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
If the passed in Fiscal Year is equal to the Target Year and 
the Fiscal Period is within the range of the MIN and MAX month
then return the passed in SalesAmtOrQty. If this is not the 
case, return a ZERO.
*/
alter Procedure [dbo].[Sp_nSpecificYearToDateSalesAmtOrQty] (
					@FISCAL_YEAR as varchar(4) , 
					@FISCAL_PERIOD as varchar (2), 
					@SalesAmtOrQty as numeric (36,6),
					@MIN_MONTH as varchar (2), 
					@MAX_MONTH as varchar (2), 
					@TARGET_YEAR as varchar(4))
as 
begin
	Declare @rtnAmt as numeric (36,6)
	set @rtnAmt = 0 
	insert into trace (Msg) values ('Sp_nSpecificYearToDateSalesAmtOrQty 01')
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