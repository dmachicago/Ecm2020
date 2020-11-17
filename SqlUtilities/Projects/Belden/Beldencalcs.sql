
drop procedure sCurrentPeriod
go
create Function sCurrentPeriod()
RETURNS varchar(2)
as 
begin
	return (select FISCAL_PERIOD from dm_d_calendar where time_key = convert(int, convert( varchar(8), getdate(), 112)))
end

select dbo.sCurrentPeriod()

drop procedure sCurrentPeriod
go
create Function sCurrentPeriod()
RETURNS varchar(2)
as 
begin
	return (select FISCAL_PERIOD from dm_d_calendar where time_key = convert(int, convert( varchar(8), getdate(), 112)))
end