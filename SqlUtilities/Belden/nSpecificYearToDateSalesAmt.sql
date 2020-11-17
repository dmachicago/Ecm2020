alter Function dbo.nSpecificYearToDateSalesAmt (@FISCAL_YEAR as varchar(4) , 
					@FISCAL_PERIOD as varchar (2), 
					@NetBillingAmt as numeric,
					@MIN_MONTH as varchar (2), 
					@MAX_MONTH as varchar (2), 
					@TARGET_YEAR as varchar(4))
RETURNS numeric
as 
begin
	Declare @rtnAmt as numeric
	set @rtnAmt = 0 
	SET @rtnAmt = (case WHEN @FISCAL_YEAR = @TARGET_YEAR
							and @FISCAL_PERIOD >= @MIN_MONTH 
							and @FISCAL_PERIOD <= @MAX_MONTH
					THEN
						@NetBillingAmt
					ELSE 
						0
					END )
	return @rtnAmt
end