CREATE FUNCTION dbo.f_celsiustofahrenheit(@celcius real)
RETURNS real
AS 
BEGIN
	
	RETURN  @celcius*1.8+32
END
go
select dbo.f_celsiustofahrenheit(0) as fahrenheit
 
