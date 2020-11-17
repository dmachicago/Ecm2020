-- Pivot Table by year and month
--exec spEmailPivotOfGrowthByMonth
create procedure spEmailPivotOfGrowthByMonth
as
select  *
from
(
  SELECT	DATEPART(YEAR, Email.CreationDate) AS YR, 
			DATEPART(MONTH, Email.CreationDate) AS MO, 		
		SUM(CAST(DATALENGTH(EmailAttachment.Attachment) AS float)) AS QTY
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