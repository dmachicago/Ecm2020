USE [EmailAddr]
GO

/****** Object:  Index [PI_EADDR]    Script Date: 6/21/2014 4:05:40 PM ******/
DROP INDEX [PI_EADDR] ON [dbo].[EmailAddress] WITH ( ONLINE = OFF )
GO

/****** Object:  Index [PI_EADDR]    Script Date: 6/21/2014 4:05:40 PM ******/
CREATE CLUSTERED INDEX [PI_EADDR] ON [dbo].[EmailAddress]
(
	[ADDRESS] ASC,
	[CITY] asc,
	[state] asc
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO


  --  
  --  
GO 
print('***** FROM: X1.sql'); 
GO 
