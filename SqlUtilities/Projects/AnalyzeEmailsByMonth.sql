SELECT      DATEPART(YEAR, Email.CreationDate) AS YR, 
			COUNT(*) as NbrEmails,
			SUM (NbrAttachments) as NbrAttachments,
			SUM(CAST(DATALENGTH(EmailAttachment.Attachment) AS float)) AS Attachments, 
            SUM(CAST(DATALENGTH(Email.Body) AS float)) AS Msg, SUM(CAST(DATALENGTH(Email.SUBJECT) AS float)) AS Subj
FROM        EmailAttachment RIGHT OUTER JOIN
                      Email ON EmailAttachment.EmailGuid = Email.EmailGuid                      
GROUP BY DATEPART(YEAR, Email.CreationDate)
order by DATEPART(YEAR, Email.CreationDate)


SELECT      DATEPART(YEAR, Email.CreationDate) AS YR, 
			DATEPART(MONTH, Email.CreationDate) AS MO, 
			COUNT(*) as NbrEmails,
			SUM (NbrAttachments) as NbrAttachments,
			SUM(CAST(DATALENGTH(EmailAttachment.Attachment) AS float)) AS Attachments, 
            SUM(CAST(DATALENGTH(Email.Body) AS float)) AS Msg, SUM(CAST(DATALENGTH(Email.SUBJECT) AS float)) AS Subj
FROM        EmailAttachment RIGHT OUTER JOIN
                      Email ON EmailAttachment.EmailGuid = Email.EmailGuid                      
GROUP BY DATEPART(YEAR, Email.CreationDate),DATEPART(MONTH, Email.CreationDate)
order by DATEPART(YEAR, Email.CreationDate),DATEPART(MONTH, Email.CreationDate)

SELECT      DATEPART(YEAR, Email.CreationDate) AS YR, 
			DATEPART(QUARTER, Email.CreationDate) AS QTR, 
			COUNT(*) as NbrEmails,
			SUM (NbrAttachments) as NbrAttachments,
			SUM(CAST(DATALENGTH(EmailAttachment.Attachment) AS float)) AS Attachments, 
            SUM(CAST(DATALENGTH(Email.Body) AS float)) AS Msg, SUM(CAST(DATALENGTH(Email.SUBJECT) AS float)) AS Subj
FROM        EmailAttachment RIGHT OUTER JOIN
                      Email ON EmailAttachment.EmailGuid = Email.EmailGuid                      
GROUP BY DATEPART(YEAR, Email.CreationDate),DATEPART(QUARTER, Email.CreationDate)
order by DATEPART(YEAR, Email.CreationDate),DATEPART(QUARTER, Email.CreationDate)


SELECT      DATEPART(YEAR, Email.CreationDate) AS YR, 
			DATEPART(week, Email.CreationDate) AS WK, 
			COUNT(*) as NbrEmails,
			SUM (NbrAttachments) as NbrAttachments,
			SUM(CAST(DATALENGTH(EmailAttachment.Attachment) AS float)) AS Attachments, 
            SUM(CAST(DATALENGTH(Email.Body) AS float)) AS Msg, SUM(CAST(DATALENGTH(Email.SUBJECT) AS float)) AS Subj
FROM        EmailAttachment RIGHT OUTER JOIN
                      Email ON EmailAttachment.EmailGuid = Email.EmailGuid                      
GROUP BY DATEPART(YEAR, Email.CreationDate),DATEPART(week, Email.CreationDate)
order by DATEPART(YEAR, Email.CreationDate),DATEPART(week, Email.CreationDate)


SELECT      cast (DATEPART(YEAR, Email.CreationDate) as varchar) + '\' + cast (DATEPART(MONTH, Email.CreationDate) AS varchar ) as YR_MO,
			SUM(CAST(DATALENGTH(EmailAttachment.Attachment) AS float)) +
            SUM(CAST(DATALENGTH(Email.Body) AS float)) +
            SUM(CAST(DATALENGTH(Email.SUBJECT) AS float)) as DataSize
FROM        EmailAttachment RIGHT OUTER JOIN
                      Email ON EmailAttachment.EmailGuid = Email.EmailGuid                      
GROUP BY cast (DATEPART(YEAR, Email.CreationDate) as varchar) + '\' + cast (DATEPART(MONTH, Email.CreationDate) AS varchar )
order by cast (DATEPART(YEAR, Email.CreationDate) as varchar) + '\' + cast (DATEPART(MONTH, Email.CreationDate) AS varchar )

