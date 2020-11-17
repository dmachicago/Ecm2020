SELECT      DATEPART(YEAR, Email.CreationDate) AS YR, 
			DATEPART(MONTH, Email.CreationDate) AS MO, 
			DATEPART(WEEK, Email.CreationDate) AS WK,
			COUNT(*) as NbrEmails,
			SUM (NbrAttachments) as NbrAttachments,
			SUM(CAST(DATALENGTH(EmailAttachment.Attachment) AS float)) AS Attachments, 
            SUM(CAST(DATALENGTH(Email.Body) AS float)) AS Msg, SUM(CAST(DATALENGTH(Email.SUBJECT) AS float)) AS Subj
FROM        EmailAttachment RIGHT OUTER JOIN
                      Email ON EmailAttachment.EmailGuid = Email.EmailGuid                      
GROUP BY DATEPART(YEAR, Email.CreationDate),DATEPART(MONTH, Email.CreationDate), DATEPART(WEEK, Email.CreationDate)
order by DATEPART(YEAR, Email.CreationDate),DATEPART(MONTH, Email.CreationDate), DATEPART(WEEK, Email.CreationDate)

