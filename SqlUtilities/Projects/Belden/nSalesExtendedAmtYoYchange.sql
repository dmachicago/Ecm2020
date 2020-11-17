USE [SMART]
GO
/****** Object:  UserDefinedFunction [dbo].[nSalesExtendedAmtYoYchange]    Script Date: 09/23/2010 14:04:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER Function [dbo].[nSalesExtendedAmtYoYchange](@FISCAL_YEAR as varchar(4) , @FISCAL_PERIOD as varchar (2), @NetBillingAmt as numeric (38,6))
RETURNS numeric
as 
begin
	Declare @rtnAmt as numeric (38,6)
	set @rtnAmt = dbo.nYearToDateExtendedSalesAmtOrQty(@FISCAL_YEAR,@NetBillingAmt) - 
					dbo.nPrevYearToDateSalesAmtOrQty(@FISCAL_YEAR,@FISCAL_PERIOD, @NetBillingAmt)
	return @rtnAmt
end

