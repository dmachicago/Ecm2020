
ALTER Function dbo.nPrevYearToDateSalesAmt (@FISCAL_YEAR as varchar(4) , 
					@FISCAL_PERIOD as varchar (2), 
					@SalesAmtOrQty as numeric)
RETURNS numeric
as 
begin
	declare @MAX_MONTH  as varchar(2)
	declare @MIN_MONTH  as varchar(2)
	declare @TARGET_YEAR as varchar(4)
    set @TARGET_YEAR = cast (year(getdate())-1 as varchar(4))
	Declare @rtnAmt as numeric
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

