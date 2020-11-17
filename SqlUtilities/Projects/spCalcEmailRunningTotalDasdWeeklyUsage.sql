-- exec spCalcEmailRunningTotalDasdWeeklyUsage
create procedure spCalcEmailRunningTotalDasdWeeklyUsage
as
begin

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'#EmailRunningTotal') AND type in (N'U'))
begin
	DROP TABLE #EmailRunningTotal
end		

CREATE TABLE #EmailRunningTotal(
	[Ord] [int] IDENTITY(1,1) NOT NULL,
	[YR] [int] NULL,
	[Period] [varchar](50) NULL,
	[PeriodVal] [float] NULL,
	[Total] [float] NULL,
	[RunningTotal] [float] NULL
) ;


CREATE UNIQUE CLUSTERED INDEX [PK_RunningTotal] ON #EmailRunningTotal 
(
	[Ord] ASC
);

CREATE UNIQUE NONCLUSTERED INDEX [UK_RunningTotal] ON #EmailRunningTotal 
(
	[YR] ASC,
	[PeriodVal] ASC
);


--insert #EmailRunningTotal (ord, YR, Period, PeriodVal, total, RunningTotal)  values (2,20) 

/************** BY WEEK *******************/
INSERT INTO #EmailRunningTotal (YR, Period, PeriodVal, total, RunningTotal)
SELECT      DATEPART(YEAR, Email.CreationDate) AS YR, 
			'WEEK' as Period,
			DATEPART(WEEK, Email.CreationDate) AS WK,
			SUM(CAST(DATALENGTH(EmailAttachment.Attachment) AS float)) + 
            SUM(CAST(DATALENGTH(Email.Body) AS float)) +
            SUM(CAST(DATALENGTH(Email.SUBJECT) AS float)) AS Total,
            0
FROM        EmailAttachment RIGHT OUTER JOIN
                      Email ON EmailAttachment.EmailGuid = Email.EmailGuid                      
GROUP BY DATEPART(YEAR, Email.CreationDate), DATEPART(WEEK, Email.CreationDate)
order by DATEPART(YEAR, Email.CreationDate), DATEPART(WEEK, Email.CreationDate);
 
update  #EmailRunningTotal set Total = 0 where Total is null;

update  #EmailRunningTotal set RunningTotal = 0 where RunningTotal is null;
 
declare @total float  ;
set @total = 0 ;
update #EmailRunningTotal set RunningTotal = @total, @total = @total + total  ;
 
select * from #EmailRunningTotal 
order by ord  ;

DROP TABLE #EmailRunningTotal;
end