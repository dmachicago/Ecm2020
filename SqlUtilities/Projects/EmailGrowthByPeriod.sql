/************** BY WEEK *******************/
SELECT      DATEPART(YEAR, Email.CreationDate) AS YR, 
			DATEPART(MONTH, Email.CreationDate) AS MO, 
			DATEPART(WEEK, Email.CreationDate) AS WK,
			COUNT(*) as NbrEmails,
			SUM (isnull(NbrAttachments,0)) as NbrAttachments,
			SUM(CAST(isnull(DATALENGTH(EmailAttachment.Attachment),0) AS float)) AS Attachments, 
            SUM(CAST(isnull(DATALENGTH(Email.Body),0) AS float)) AS Msg, 
            SUM(CAST(isnull(DATALENGTH(Email.SUBJECT),0) AS float)) AS Subj
FROM        EmailAttachment RIGHT OUTER JOIN
                      Email ON EmailAttachment.EmailGuid = Email.EmailGuid                      
GROUP BY DATEPART(YEAR, Email.CreationDate),DATEPART(MONTH, Email.CreationDate), DATEPART(WEEK, Email.CreationDate)
order by DATEPART(YEAR, Email.CreationDate),DATEPART(MONTH, Email.CreationDate), DATEPART(WEEK, Email.CreationDate)

/************** BY MONTH *******************/
SELECT      DATEPART(YEAR, Email.CreationDate) AS YR, 
			DATEPART(MONTH, Email.CreationDate) AS MO, 
			COUNT(*) as NbrEmails,
			SUM (NbrAttachments) as NbrAttachments,
			SUM(CAST(isnull(DATALENGTH(EmailAttachment.Attachment),0) AS float)) AS Attachments, 
            SUM(CAST(isnull(DATALENGTH(Email.Body),0) AS float)) AS Msg, 
            SUM(CAST(isnull(DATALENGTH(Email.SUBJECT),0) AS float)) AS Subj
FROM        EmailAttachment RIGHT OUTER JOIN
                      Email ON EmailAttachment.EmailGuid = Email.EmailGuid                      
GROUP BY DATEPART(YEAR, Email.CreationDate),DATEPART(MONTH, Email.CreationDate)
order by DATEPART(YEAR, Email.CreationDate),DATEPART(MONTH, Email.CreationDate)