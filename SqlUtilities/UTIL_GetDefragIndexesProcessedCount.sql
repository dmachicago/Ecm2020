-- W. Dale Miller
-- wdalemiller@gmail.com


SELECT distinct [DBName], count(*) as FragmentedIdxCnt
  FROM [master].[dbo].[DFS_IndexFragHist]
  group by  [DBName]
  order by [DBName]
