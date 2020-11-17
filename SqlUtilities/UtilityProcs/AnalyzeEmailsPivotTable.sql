-- Pivot Table by year and month
select  *
from
(
  SELECT	DATEPART(YEAR, Email.CreationDate) AS YR, 
			DATEPART(MONTH, Email.CreationDate) AS MO, 		
		SUM(CAST(isnull(DATALENGTH(EmailAttachment.Attachment),0) AS float)) AS QTY
FROM    EmailAttachment RIGHT OUTER JOIN
        Email ON EmailAttachment.EmailGuid = Email.EmailGuid 
GROUP BY DATEPART(YEAR, Email.CreationDate),DATEPART(MONTH, Email.CreationDate)        
) DataTable
PIVOT
(
  SUM(QTY)
  FOR MO
  IN ([1],[2],[3],[4],[5],[6],[7],[8],[9],[10],[11],[12])
) PivotTable

-- Pivot Table by year and week
select  *
from
(
  SELECT	DATEPART(YEAR, Email.CreationDate) AS YR, 
			DATEPART(week, Email.CreationDate) AS WK, 		
		SUM(CAST(isnull(DATALENGTH(EmailAttachment.Attachment),0) AS float)) AS QTY
FROM    EmailAttachment RIGHT OUTER JOIN
        Email ON EmailAttachment.EmailGuid = Email.EmailGuid 
GROUP BY DATEPART(YEAR, Email.CreationDate),DATEPART(week, Email.CreationDate)        
) DataTable
PIVOT
(
  SUM(QTY)
  FOR WK
  IN (
  [1],[2],[3],[4],[5],[6],[7],[8],[9],[10],
  [11],[12],[13],[14],[15],[16],[17],[18],[19],[20],
  [21],[22],[23],[24],[25],[26],[27],[28],[29],[30],
  [31],[32],[33],[34],[35],[36],[37],[38],[39],[40],
  [41],[42],[43],[44],[45],[46],[47],[48],[49],[50],
  [51],[52]
  )
) PivotTable