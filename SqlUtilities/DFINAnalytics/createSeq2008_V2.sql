-- W. Dale Miller
--Have a table with an identity column. Set the seed and step to whatever is appropriate:
--Migrated 1/18/2019

create table dbo.SequenceGenerator(ID int identity(1, 1), dummy int);
--Then insert values from the numbers table and capture the newly-generated identity values:

declare @HowMany int = 3;  -- This determines how large a sequence you receive
 -- at each itteration
declare @NewSequenceValue table (ID int);
declare @number int ;
insert dbo.SequenceGenerator(dummy)
output INSERTED.ID 
    into @NewSequenceValue
select Number from dbo.Numbers
where Number <= @HowMany;

select * from @NewSequenceValue;
--Be sure to DELETE .. dbo.SequenceGenerator from time to time, else it will get big 
--for no additional value. Do not TRUNCATE it - that will reset the IDENTITY column 
--to its initally-declared seed value.