
USE KEnticoCMS_Datamart_2
go
-- Pages Analysis
SELECT
      cast ( A.Avg - B.Avg AS DECIMAL (6 , 2)) AS AvgGain
     ,cast ( A.Median - B.Median AS DECIMAL (6 , 2)) AS MedianGain
     ,cast ( A.Max - B.Max AS DECIMAL (6 , 2)) AS MaxGain
     ,B.Scenario
     ,B.Test
FROM [Pages-Before] AS B
     JOIN [Pages-After] AS A
     ON
        B.Page = A.Page AND
       B.Scenario = A.Scenario AND
        B.Test = A.Test;



USE KEnticoCMS_Datamart_2
go
-- Response Time Analysis
SELECT
       B.Scenario
     ,B.Test
     ,A.[Resp Time] AS A_RespTime
     ,B.[Resp Time] AS B_RespTime
     ,cast ( A.[Resp Time] - B.[Resp Time] AS DECIMAL (6 , 2)) AS RespTimeGain
FROM [requests-after] AS A
     JOIN [requests-before] AS B
     ON
       B.Scenario = A.Scenario AND
       B.Test = A.Test AND
       B.Request = A.Request;



USE KEnticoCMS_Datamart_2
go
-- select * from Tran750_After
-- Transactions Analysis
SELECT
       A.Scenario as Tran70_Scenario
     ,A.Test as Tran70_Test     
     ,A.[Transaction]  as Tran70_TRansaction
     ,A.total
     ,CAST (A.[Avg trans time] - B.[Avg trans time] AS DECIMAL (6 , 2)) AS AvgTransTimeGain
     ,CAST (A.[Avg Resp Time] - B.[Avg Resp Time] AS DECIMAL (6 , 2)) AS AvgRespTimeGain
     ,CAST (A.[Min Resp Time] - B.[Min Resp Time] AS DECIMAL (6 , 2)) AS MinRespTimeGain
     ,CAST (A.[Max Resp Time] - B.[Max Resp Time] AS DECIMAL (6 , 2)) AS MaxRespTimeGain
     ,CAST (A.Median - B.Median AS DECIMAL (6 , 2)) AS MedianTimeGain
     ,CAST (A.[90% Resp Time] - B.[90% Resp Time] AS DECIMAL (6 , 2)) AS [90%Gain]
     ,CAST (A.[95% Resp Time] - B.[95% Resp Time] AS DECIMAL (6 , 2)) AS [95%Gain]
     ,CAST (A.[99% Resp Time] - B.[99% Resp Time] AS DECIMAL (6 , 2)) AS [99%Gain]
     ,CAST (A.[Std Dev Resp Time] - B.[Std Dev Resp Time] AS DECIMAL (6 , 2)) AS StdDevGain
FROM Tran750_After AS A
     JOIN Tran750_BEFORE AS B
     ON
       B.Scenario = A.Scenario AND
       B.Test = A.Test AND
       B.[TRansaction] = A.[TRansaction];
