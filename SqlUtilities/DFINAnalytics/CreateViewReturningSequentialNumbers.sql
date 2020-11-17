-- CreateViewReturningSequentialNumbers
CREATE VIEW vSequence AS
WITH cteNumber AS
 (SELECT Nbr=ROW_NUMBER() OVER(ORDER BY (SELECT 1))
  FROM dbo.spt_values a CROSS JOIN dbo.spt_values b)
SELECT SeqNo=Nbr FROM cteNumber
GO
go
--Drop view vSequence

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016

