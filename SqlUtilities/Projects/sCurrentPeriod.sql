USE [SMART]
GO
/****** Object:  UserDefinedFunction [dbo].[sCurrentPeriod]    Script Date: 10/19/2010 15:11:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER Function [dbo].[sCurrentPeriod]()
RETURNS varchar(2)
as 
begin
	return (
			SELECT FISCAL_PERIOD 
			FROM dm_d_calendar 
			WHERE time_key = convert(int, convert( varchar(8), (select FISCAL_PER_START_DT from dm_d_calendar where time_key = convert(int, convert( varchar(8), getdate(), 112)))-1, 112)))
end
