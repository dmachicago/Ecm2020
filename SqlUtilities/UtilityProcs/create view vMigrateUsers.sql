create view vMigrateUsers as
Select UserName, 
		UserID, 
		UserPassword, 
		'xx' as GroupName, 
		'LL' as Library, 
		'U' as Authority from Users