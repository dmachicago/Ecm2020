select COUNT(*) from DataSource
go
select (COUNT(*)/100) as Iterations from DataSource
go
WITH DataSourceRows AS
(
SELECT SourceGuid, ROW_NUMBER() OVER (ORDER BY SourceGuid DESC) AS RowNum FROM DataSource
)
SELECT * FROM DataSourceRows WHERE RowNum BETWEEN 381900 AND 381990

 

 

/*Displays Top two employees who are getting highest salary in each department*/ 

          

          WITH EmpDetails AS

          (

          SELECT *, ROW_NUMBER() OVER (PARTITION BY Dept_id ORDER BY Salary DESC) AS RowNum FROM Employee

          )

          SELECT * FROM EmpDetails WHERE RowNum BETWEEN 1 AND 2

