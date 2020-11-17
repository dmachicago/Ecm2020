DECLARE @DepartmentName VARCHAR(1000) 

SELECT @DepartmentName = COALESCE(@DepartmentName,'') + Name + ';'  
FROM HumanResources.Department 
WHERE (GroupName = 'Executive General and Administration') 

SELECT @DepartmentName AS DepartmentNames

SELECT distinct STUFF((SELECT [email] + '; '
		FROM TestTable
		WHERE [ADDRESS] = PA_ALL_Tags.PrimaryAddress1 
		and EmailAddress.[state] = PA_ALL_Tags.PrimaryState
		ORDER BY [email]
		FOR XML PATH('')), 1, 1, '')  --  
  --  
GO 
print('***** FROM: X3.sql'); 
GO 
