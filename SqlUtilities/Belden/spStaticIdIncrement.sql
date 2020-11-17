create procedure spStaticIdIncrement
as 
	insert into StaticRunId (RunDate) values (getdate())

