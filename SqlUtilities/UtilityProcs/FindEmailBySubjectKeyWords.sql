
/*
Get the informaiton form the user's email and substitute 
it into the qrys below.
*/

select SUBJECT, BODY from Email where 
SUBJECT like '%Helmsdale%'
and SUBJECT like '%690327%'
AND SUBJECT LIKE '%Advent Enrolment%'

--RE: Helmsdale Bank Corp #690327 - RBC Dexia Custodial Feed
--RE: Advent Enrolment For client <Helmsdale  > copy 690327

select SentOn, SenderName, SUBJECT, BODY, RowID, RowCreationDate 
FROM EMAIL
	WHERE
	CONTAINS(*, ' helmsdale AND 690327 AND "Advent Enrolment"')  

WITH xContent AS
(
SELECT  [SentOn]
	,[ShortSubj]
	,[SenderEmailAddress]
	,[SenderName]
	,[SentTO]
	,[Body]
	,[CC]
	,[Bcc]
	,[CreationTime]
	,[AllRecipients]
	,[ReceivedByName]
	,[ReceivedTime]
	,[MsgSize]
	,[SUBJECT]
	,[OriginalFolder]
	,[EmailGuid], RetentionExpirationDate, isPublic, UserID, SourceTypeCode, NbrAttachments, ' ' as RID, RepoSvrName
	,ROW_NUMBER() OVER (ORDER BY SentOn ASC) AS ROWID
FROM EMAIL
	WHERE
	CONTAINS(*, ' helmsdale AND 690327 AND "Advent Enrolment"')     /*XX04*/
	/* This is where the library search would go - you have global rights, think about it.*/		 /*KEEP*/
	AND (UserID IS NOT NULL)		 /*KEEP*/
--order by [ShortSubj]
)
Select * 
FROM xContent
WHERE ROWID BETWEEN 1 AND 100