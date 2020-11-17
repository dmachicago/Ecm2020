

go 
print 'executing create_BASE_MART_EDW_HealthAssesment_VerHist.sql'
go

if exists (select name from sys.tables where name = 'BASE_MART_EDW_HealthAssesment_VerHist')
begin
    print 'BASE_MART_EDW_HealthAssesment_VerHist already exists, skipping'
    goto SKIP_BASE_MART_EDW_HealthAssesment_VerHist ;
end 

CREATE TABLE [dbo].[BASE_MART_EDW_HealthAssesment_VerHist](
	[DBNAME] [nvarchar](50) NULL,
	[VerNo] [bigint] NOT NULL,
	[CreateDate] [datetime] NULL DEFAULT (getdate())
) ON [PRIMARY]

CREATE NONCLUSTERED INDEX [IDX_BASE_MART_EDW_HealthAssesment_VerHist] ON [dbo].[BASE_MART_EDW_HealthAssesment_VerHist]
(
	[DBNAME] ASC,
	[VerNo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

print 'Created BASE_MART_EDW_HealthAssesment_VerHist.'

SKIP_BASE_MART_EDW_HealthAssesment_VerHist:

GO
print 'executed create_BASE_MART_EDW_HealthAssesment_VerHist.sql'
go