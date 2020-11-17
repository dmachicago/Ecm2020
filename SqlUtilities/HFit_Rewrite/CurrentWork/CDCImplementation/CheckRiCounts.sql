
--create procedure CheckRiCounts(@FromTbl as nvarchar(100), @FromCol as nvarchar(100),@ToTbl as nvarchar(100), @ToCol as nvarchar(100))
--as

declare @FromTbl as nvarchar(max) = 'BASE_HFit_HealthAssesmentUserRiskCategory' ;
declare @FromCol as nvarchar(max) = 'ItemID, SVR, DBNAME' ;
declare @ToTbl as nvarchar(max) = 'BASE_HFit_HealthAssesmentUserQuestion' ;
declare @ToCol as nvarchar(max) = 'HARiskAreaItemID, SVR, DBNAME' ;

declare @MySql as nvarchar(max) = '' ;
declare @Msg as nvarchar(max) = '' ;
declare @iCnt as bigint = 0 ;
declare @rowcount as bigint = 0 ;

set @MySql = 'select @rowcount=count(*) from ' + @FromTbl
exec sp_executesql @MySql , 
                    N'@rowcount int output', @rowcount output;
print 'Total records in ' + @FromTbl + ' : '  + CONVERT(varchar, CAST(@rowcount AS money), 1) 

set @MySql = 'select @rowcount=count(*) from ' + @ToTbl
exec sp_executesql @MySql, 
                    N'@rowcount int output', @rowcount output;
print 'Total records in ' + @MySql + ' : '  + CONVERT(varchar, CAST(@rowcount AS money), 1) 

--************************************************************
-- drop table #TempBdups
set @MySql = 'SELECT COUNT(*) TotalCount into #TempBdups FROM '+@FromTbl+' GROUP BY '+@FromCol+' HAVING COUNT(*) > 1 ORDER BY COUNT(*) DESC ' ; 
exec (@MySql) ;

Select count(*) from #TempBdups
Select max(TotalCount) from #TempBdups

-- drop table #TempANoDups
set @MySql = 'SELECT COUNT(*) TotalCount into #TempBNoDups FROM '+@ToTbl+' GROUP BY '+@ToCol+' HAVING COUNT(*) = 1 ' ;
Select count(*) from #TempBNoDups
--************************************************************

--52624804
set @MySql = 'select @rowcount=count(*) from BASE_HFit_HealthAssesmentUserRiskCategory A	   ' ;
set @MySql = @MySql + 'inner join BASE_HFit_HealthAssesmentUserQuestion B	   ' ;
set @MySql = @MySql + 'on A.ItemID = B.HARiskAreaItemID ' ;
exec sp_executesql @MySql, 
                    N'@rowcount int output', @rowcount output;
print 'Total records in ' + @MySql + ' : '  + CONVERT(varchar, CAST(@rowcount AS money), 1) 

--52624804
select count(*) from BASE_HFit_HealthAssesmentUserQuestion B    
inner join BASE_HFit_HealthAssesmentUserRiskCategory A
on A.ItemID = B.HARiskAreaItemID ;

--8050
select count(*) from BASE_HFit_HealthAssesmentUserRiskCategory	   
where ItemID  not in (
select HARiskAreaItemID from BASE_HFit_HealthAssesmentUserQuestion
)

--5662410
select count(*) from BASE_HFit_HealthAssesmentUserQuestion		   
where HARiskAreaItemID  not in (
select ItemID from BASE_HFit_HealthAssesmentUserRiskCategory
)